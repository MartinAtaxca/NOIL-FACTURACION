object FrmLogin: TFrmLogin
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsDialog
  Caption = 'Iniciar Sesi'#243'n'
  ClientHeight = 227
  ClientWidth = 417
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object cxlbl1: TcxLabel
    Left = 31
    Top = 24
    Caption = 'Ubicaci'#243'n:'
  end
  object cxlbl2: TcxLabel
    Left = 32
    Top = 79
    Caption = 'Usuario:'
  end
  object cxlbl3: TcxLabel
    Left = 32
    Top = 103
    Caption = 'Constrase'#241'a:'
  end
  object cbbBaseDatos: TcxLookupComboBox
    Left = 139
    Top = 126
    Properties.KeyFieldNames = 'Database'
    Properties.ListColumns = <
      item
        FieldName = 'DataBase'
      end>
    Properties.ListSource = dsBaseDatos
    TabOrder = 3
    Width = 238
  end
  object cxlbl4: TcxLabel
    Left = 32
    Top = 127
    Caption = 'Base de Datos:'
  end
  object cxTextUsuario: TcxTextEdit
    Left = 139
    Top = 78
    TabOrder = 1
    Width = 238
  end
  object cxTextContrasena: TcxTextEdit
    Left = 139
    Top = 102
    Properties.EchoMode = eemPassword
    TabOrder = 2
    Width = 238
  end
  object cbbDireccionesIP: TcxComboBox
    Left = 139
    Top = 23
    TabOrder = 0
    Text = 'Localhost'
    OnExit = cbbDireccionesIPExit
    Width = 238
  end
  object dxLookUpEmpresas: TdxLookupTreeView
    Left = 138
    Top = 150
    Width = 238
    Height = 19
    CanSelectParents = True
    Ctl3D = False
    ParentColor = False
    ParentCtl3D = False
    TabOrder = 4
    TabStop = True
    TreeViewColor = clWindow
    TreeViewCursor = crDefault
    TreeViewFont.Charset = DEFAULT_CHARSET
    TreeViewFont.Color = clWindowText
    TreeViewFont.Height = -11
    TreeViewFont.Name = 'Tahoma'
    TreeViewFont.Style = []
    TreeViewIndent = 19
    TreeViewReadOnly = False
    TreeViewShowButtons = True
    TreeViewShowHint = False
    TreeViewShowLines = True
    TreeViewShowRoot = True
    TreeViewSortType = stNone
    DividedChar = '.'
    Options = [trCanDBNavigate, trSmartRecordCopy, trCheckHasChildren]
    RootValue = Null
    TextStyle = tvtsShort
    Alignment = taLeftJustify
  end
  object cxlbl5: TcxLabel
    Left = 32
    Top = 150
    Caption = 'Empresas:'
  end
  object btnLogin: TcxButton
    Left = 221
    Top = 184
    Width = 75
    Height = 25
    Caption = '&Iniciar Sesi'#243'n'
    TabOrder = 5
    OnClick = btnLoginClick
  end
  object btnCancelar: TcxButton
    Left = 302
    Top = 184
    Width = 75
    Height = 25
    Caption = '&Cancelar'
    ModalResult = 3
    TabOrder = 6
  end
  object zBaseDatos: TZQuery
    Params = <>
    Left = 104
    Top = 176
  end
  object zEmpresas: TZQuery
    Params = <>
    Left = 32
    Top = 176
  end
  object dsBaseDatos: TDataSource
    DataSet = zBaseDatos
    Left = 168
    Top = 176
  end
end
