program NoilFacturacion;

uses
  Forms,
  UFrmInicioFacturacion in 'UFrmInicioFacturacion.pas' {Form1},
  UConection in 'UConection.pas' {UDMConection: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TUDMConection, UDMConection);
  Application.Run;
end.
