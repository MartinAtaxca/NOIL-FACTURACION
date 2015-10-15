program NoilFacturacion;

uses
  Forms,
  UFrmInicioFacturacion in 'UFrmInicioFacturacion.pas' {FrmInicioFacturacion},
  UConection in 'UConection.pas' {UDMConection: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TFrmInicioFacturacion, FrmInicioFacturacion);
  Application.CreateForm(TUDMConection, UDMConection);
  Application.Run;
end.
