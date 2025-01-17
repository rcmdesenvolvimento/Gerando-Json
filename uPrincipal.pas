unit uPrincipal;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants,
  System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, FireDAC.Stan.Intf,
  FireDAC.Stan.Option, FireDAC.Stan.Error, FireDAC.UI.Intf, FireDAC.Phys.Intf,
  FireDAC.Stan.Def, FireDAC.Stan.Pool, FireDAC.Stan.Async, FireDAC.Phys,
  FireDAC.VCLUI.Wait, FireDAC.Stan.ExprFuncs, FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef, FireDAC.Stan.Param, FireDAC.DatS, FireDAC.DApt.Intf,
  FireDAC.DApt, Data.DB, FireDAC.Comp.DataSet, FireDAC.Comp.Client,
  FireDAC.Phys.SQLite,

  DataSet.Serialize.Config, DataSet.Serialize, System.JSON, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    Memo1: TMemo;
    btnListaPedidos: TButton;
    conn: TFDConnection;
    FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink;
    qry: TFDQuery;
    qryDetalhe: TFDQuery;
    btnPedido: TButton;
    btnPedidoItens: TButton;
    Button1: TButton;
    Panel1: TPanel;
    btnFinalizar: TButton;
    procedure btnFinalizarClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnListaPedidosClick(Sender: TObject);
    procedure btnPedidoClick(Sender: TObject);
    procedure btnPedidoItensClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}

procedure TForm1.btnFinalizarClick(Sender: TObject);
begin
  Close;
end;

procedure TForm1.btnListaPedidosClick(Sender: TObject);
var
  arr: TJSONArray;
begin
  with qry do
  begin
    sql.Clear;
    sql.Add('select * from tab_pedido');
    Open;
  end;

  arr := qry.ToJSONArray();

  Memo1.Clear;
  Memo1.Lines.Add(arr.ToJSON());

  arr.DisposeOf;

end;

procedure TForm1.btnPedidoClick(Sender: TObject);
var
  JSON: TJSONObject;
begin

  JSON := TJSONObject.Create;

  JSON.AddPair('pedido', TJSONNumber.Create('52148'));
  JSON.AddPair('cliente', 'Afr�nio de Melo Franco');
  JSON.AddPair('ativo', TJSONBool.Create(true));

  Memo1.Clear;
  Memo1.Lines.Add(JSON.ToJSON());

  JSON.DisposeOf;

end;

procedure TForm1.btnPedidoItensClick(Sender: TObject);
var
  JSON: TJSONObject;
  arr: TJSONArray;
begin

  with qry do
  begin
    sql.Clear;
    sql.Add('select id, descricao, qtd, total from tab_pedido_item where pedido = 52148');
    Open;
  end;

  JSON := TJSONObject.Create;

  arr := qry.ToJSONArray();

  JSON.AddPair('pedido', TJSONNumber.Create('52148'));
  JSON.AddPair('cliente', 'Afr�nio de Melo Franco');
  JSON.AddPair('itens', qry.ToJSONArray());

  Memo1.Clear;
  Memo1.Lines.Add(JSON.ToJSON());

  JSON.DisposeOf;

end;

procedure TForm1.Button1Click(Sender: TObject);
var
  JSON: TJSONObject;
  arrItem, arrDetalhe: TJSONArray;
  i: integer;
begin
  // Itens...
  qry.sql.Clear;
  qry.sql.Add
    ('select id, descricao, qtd, total from tab_pedido_item where pedido = 52148');
  qry.Active := true;

  arrItem := qry.ToJSONArray;

  for i := 0 to arrItem.Count - 1 do
  begin
    // Detalhes...
    qryDetalhe.Active := false;
    qryDetalhe.sql.Clear;
    qryDetalhe.sql.Add
      ('select id_detalhe, detalhe from tab_pedido_item_detalhe where id = :id');
    qryDetalhe.ParamByName('id').Value := arrItem[i].GetValue<integer>('id');
    qryDetalhe.Active := true;

    arrDetalhe := qryDetalhe.ToJSONArray;

    TJSONObject(arrItem[i]).AddPair('detalhes', arrDetalhe);
  end;

  JSON := TJSONObject.Create;

  JSON.AddPair('pedido', TJSONNumber.Create(52148));
  JSON.AddPair('cliente', '99 Coders');
  JSON.AddPair('itens', arrItem);

  Memo1.Clear;
  Memo1.Lines.Add(JSON.ToJSON());

  JSON.DisposeOf;

end;

procedure TForm1.FormCreate(Sender: TObject);
begin

  conn.Params.Values['DriverID'] := 'SQLite';
  conn.Params.Values['Database'] := 'D:\Projetos Delphi\99 Coders\Json\DB\banco.db';

  try
    conn.Connected := true;
  except
    on e: exception do
      raise exception.Create('Error de conex�o com a base de dados ' +
        e.Message);
  end;

  Memo1.Clear;
  TDataSetSerializeConfig.GetInstance.CaseNameDefinition      := cndLower;
  TDataSetSerializeConfig.GetInstance.Import.DecimalSeparator := '.';

end;

end.
