unit ULogin;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, cxGraphics, cxControls, cxLookAndFeels, cxLookAndFeelPainters,
  cxContainer, cxEdit, dxSkinsCore, dxSkinBlack, dxSkinBlue, dxSkinBlueprint,
  dxSkinCaramel, dxSkinCoffee, dxSkinDarkRoom, dxSkinDarkSide,
  dxSkinDevExpressDarkStyle, dxSkinDevExpressStyle, dxSkinFoggy,
  dxSkinGlassOceans, dxSkinHighContrast, dxSkiniMaginary, dxSkinLilian,
  dxSkinLiquidSky, dxSkinLondonLiquidSky, dxSkinMcSkin, dxSkinMetropolis,
  dxSkinMetropolisDark, dxSkinMoneyTwins, dxSkinOffice2007Black,
  dxSkinOffice2007Blue, dxSkinOffice2007Green, dxSkinOffice2007Pink,
  dxSkinOffice2007Silver, dxSkinOffice2010Black, dxSkinOffice2010Blue,
  dxSkinOffice2010Silver, dxSkinOffice2013DarkGray, dxSkinOffice2013LightGray,
  dxSkinOffice2013White, dxSkinPumpkin, dxSkinSeven, dxSkinSevenClassic,
  dxSkinSharp, dxSkinSharpPlus, dxSkinSilver, dxSkinSpringTime, dxSkinStardust,
  dxSkinSummer2008, dxSkinTheAsphaltWorld, dxSkinsDefaultPainters,
  dxSkinValentine, dxSkinVS2010, dxSkinWhiteprint, dxSkinXmas2008Blue, cxLabel,
  cxTextEdit, cxMaskEdit, cxDropDownEdit, cxLookupEdit, cxDBLookupEdit,
  cxDBLookupComboBox, dxdbtrel, DB, ZAbstractRODataset, ZAbstractDataset,
  ZDataset, Menus, StdCtrls, cxButtons, UConection;

type
  TFrmLogin = class(TForm)
    cxlbl1: TcxLabel;
    cxlbl2: TcxLabel;
    cxlbl3: TcxLabel;
    cbbBaseDatos: TcxLookupComboBox;
    cxlbl4: TcxLabel;
    cxTextUsuario: TcxTextEdit;
    cxTextContrasena: TcxTextEdit;
    cbbDireccionesIP: TcxComboBox;
    dxLookUpEmpresas: TdxLookupTreeView;
    zBaseDatos: TZQuery;
    zEmpresas: TZQuery;
    cxlbl5: TcxLabel;
    btnLogin: TcxButton;
    btnCancelar: TcxButton;
    dsBaseDatos: TDataSource;
    procedure cbbDireccionesIPExit(Sender: TObject);
    procedure btnLoginClick(Sender: TObject);
  private
    function VerificarUsuario: Boolean;

    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation

{$R *.dfm}

procedure TFrmLogin.btnLoginClick(Sender: TObject);
begin
  try
    if Length(Trim(cbbDireccionesIP.Text)) = 0 then
      raise eWarning.Create('Escribe la direcci�n IP donde se ubica tu base de datos.');

    if Length(Trim(cxTextUsuario.Text)) = 0 then
      raise eWarning.Create('Escribe el nombre del usuario.');

    if Length(Trim(cbbBaseDatos.Text)) = 0 then
      raise eWarning.Create('Selecciona la base de datos con la que deseas trabajar.');

    with varGlobal do
    begin
      SetValue('HostName', cbbDireccionesIP.Text);
      SetValue('Usuario', cxTextUsuario.Text);
      SetValue('Contrasena', cxTextContrasena.Text);
      SetValue('BaseDatos', cbbBaseDatos.Text);
      SetValue('IDImpresa', -1);
      SetValue('NombreEmpresa', 'SIN EMPRESA');
    end;

    if UDMConection.conBD.Connected then
      UDMConection.conBD.Disconnect;

    with UDMConection.conBD do
    begin
      Database := '';
      HostName := cbbDireccionesIP.Text;
      Database := cbbBaseDatos.Text;
      Connect;
    end;

    RecargarConsultasSQL;

    if Not VerificarUsuario then
      raise eWarning.Create('El nombre de usuario o contrase�a es incorrecto. Por favor intentalo nuevamente.');

    Self.Close;
  except
    on e: eWarning do
    begin
      MessageDlg(e.Message, mtWarning, [mbOK], 0);
    end;

    on e: Exception do
    begin
      MessageDlg(pMensajeError +  e.Message , mtError, [mbOK], 0)
    end;
  end;
end;

procedure TFrmLogin.cbbDireccionesIPExit(Sender: TObject);
var
  Cursor : TCursor;
begin
  try
    Cursor := Screen.Cursor;
    try
      Screen.Cursor := crAppStart;

      if UDMConection.conBD.Connected then
        UDMConection.conBD.Disconnect;

      with UDMConection.conBD do
      begin
        Database := '';
        HostName := cbbDireccionesIP.Text;
        Connect;
      end;

      zBaseDatos.Active := False;
      zBaseDatos.Connection := UDMConection.conBD;
      zBaseDatos.SQL.Text := 'Show Databases;';
      zBaseDatos.Open;
    finally
      Screen.Cursor := Cursor;
    end;
  except
    on e: exception do
      MessageDlg(pMensajeError + e.Message, mtError, [mbOK], 0);
  end;

end;

function TFrmLogin.VerificarUsuario: Boolean;
var
  zUsuario: TZQuery;
begin
  try
    Result := False;
    zUsuario := TZQuery.Create(Self);


    if not AsignarSQL(zUsuario, 'master_usuarios', pReadOnly) then
      raise Exception.Create('No se encuentra la Consulta [Master_Usuarios] en la base de datos seleccionada');

    if not FiltrarDataset(zUsuario, 'Usuario', [cxTextUsuario.Text]) then
      raise Exception.Create('No se pudo filtrar el Dataset usando la consulta [Master_Usuarios]');

    if zUsuario.Active then
      zUsuario.Refresh
    else
      zUsuario.Open;

    if zUsuario.FieldByName('Contrasena').AsString = cxTextContrasena.Text then
      Result := True;
  finally
    zUsuario.Free;
  end;
end;

end.
