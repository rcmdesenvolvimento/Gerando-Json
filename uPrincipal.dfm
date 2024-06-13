object Form1: TForm1
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Gerando Arquivos Json'
  ClientHeight = 604
  ClientWidth = 956
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 24
    Width = 233
    Height = 47
    Caption = 'Gerando Json'
    Color = clRed
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -35
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
  end
  object Memo1: TMemo
    Left = 288
    Top = 0
    Width = 668
    Height = 568
    Align = alRight
    Lines.Strings = (
      'Memo1')
    ReadOnly = True
    ScrollBars = ssVertical
    TabOrder = 3
    ExplicitHeight = 604
  end
  object btnListaPedidos: TButton
    Left = 8
    Top = 117
    Width = 177
    Height = 25
    Caption = 'Lista de Pedidos'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 1
    OnClick = btnListaPedidosClick
  end
  object btnPedido: TButton
    Left = 8
    Top = 77
    Width = 177
    Height = 25
    Caption = 'Pedido'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 0
    OnClick = btnPedidoClick
  end
  object btnPedidoItens: TButton
    Left = 8
    Top = 156
    Width = 177
    Height = 25
    Caption = 'Pedidos e Itens'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 2
    OnClick = btnPedidoItensClick
  end
  object Button1: TButton
    Left = 8
    Top = 200
    Width = 177
    Height = 25
    Caption = 'Pedidos/Itens/Detalhes'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
    OnClick = Button1Click
  end
  object Panel1: TPanel
    Left = 0
    Top = 568
    Width = 956
    Height = 36
    Align = alBottom
    TabOrder = 5
    object btnFinalizar: TButton
      Left = 826
      Top = 1
      Width = 129
      Height = 34
      Align = alRight
      Caption = 'Finalizar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Segoe UI'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      OnClick = btnFinalizarClick
      ExplicitLeft = 0
      ExplicitHeight = 33
    end
  end
  object conn: TFDConnection
    Params.Strings = (
      'Database=D:\Projetos Delphi\99 Coders\Json\estoque.db'
      'DriverID=SQLite')
    LoginPrompt = False
    Left = 352
    Top = 40
  end
  object FDPhysSQLiteDriverLink1: TFDPhysSQLiteDriverLink
    Left = 344
    Top = 112
  end
  object qry: TFDQuery
    Connection = conn
    Left = 464
    Top = 112
  end
  object qryDetalhe: TFDQuery
    Connection = conn
    Left = 464
    Top = 48
  end
end
