program NoilFacturacion;

uses
  Forms,
  UFrmInicioFacturacion in 'UFrmInicioFacturacion.pas' {FrmInicioFacturacion},
  UConection in 'UConection.pas' {UDMConection: TDataModule},
  ULogin in 'Generales\ULogin.pas' {FrmLogin};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmInicioFacturacion, FrmInicioFacturacion);
  Application.CreateForm(TUDMConection, UDMConection);
  Application.CreateForm(TFrmLogin, FrmLogin);
  Application.Run;
end.
