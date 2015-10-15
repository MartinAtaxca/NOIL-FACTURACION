unit UConection;

interface

uses
  SysUtils, Classes, ZAbstractConnection, ZConnection, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, Variants;

type
  TUDMConection = class(TDataModule)
    conBD: TZConnection;
    zConsultasSQL: TZQuery;
    procedure DataModuleCreate(Sender: TObject);
    procedure DataModuleDestroy(Sender: TObject);
  private
    { Private declarations }
  public
    Function setSQL(var Dataset: TZQuery; QueryName: String; Option: string): Boolean;
    function setParams(var Dataset: TZQuery; params: string; Values: array of Variant): Boolean;
    { Public declarations }
  end;

var
  UDMConection: TUDMConection;
const
  pReadOnly: string = 'READONLY';
  pUpdate: string = 'UPDATE';

  function AsignarSQL(var Dataset: TZQuery; QueryName: String; Option: string): Boolean;
  function FiltrarDataset(var Dataset: TZQuery; params: string; Values: array of Variant): Boolean;
implementation

{$R *.dfm}

{ TDataModule2 }

procedure TUDMConection.DataModuleCreate(Sender: TObject);
begin
  zConsultasSQL.Active := False;
  zConsultasSQL.SQL.Text := 'Select * from master_consultassql';
  zConsultasSQL.Open;
end;

procedure TUDMConection.DataModuleDestroy(Sender: TObject);
begin
  if conBD.Connected then
    conBD.Connected := False;
end;

function TUDMConection.setParams(var Dataset: TZQuery; params: string;
  Values: array of Variant): Boolean;
var
  i,j: Integer;
  ParamList: TStringList;
begin
  try
    Result := False;

    ParamList := TStringList.Create;
    ParamList.Delimiter := ',';
    ParamList.DelimitedText := params;

    if (Length(Trim(Dataset.SQL.Text)) <> 0) and (Dataset.Params.Count > 0) then
    begin
      for i := 0 to Dataset.Params.Count - 1 do
      begin
        for j := 0 to ParamList.Count-1 do
        begin
          if Dataset.Params.Items[i].Name = ParamList[j]  then
            Dataset.ParamByName(Dataset.Params.Items[i].Name).AsString := Values[j]
          else
            Dataset.ParamByName(Dataset.Params.Items[i].Name).AsString := Values[j];
        end;
      end;
    end;
    Result := True;
  except
    raise;
  end;
end;

function TUDMConection.setSQL(var Dataset: TZQuery; QueryName,
  Option: string): Boolean;
begin
  try
    Result := False;
    if Not Assigned(Dataset) then
      raise Exception.Create('El componente se encuentra creado.');

    if (Not zConsultasSQL.Active) or (zConsultasSQL.Active and (zConsultasSQL.RecordCount = 0)) then
      raise Exception.Create('No se encuentra consultas SQL definidas dentro de la tabla master_ConsultasSql');

    if zConsultasSQL.Locate('NombreConsulta;Tipo', varArrayOf([QueryName,Option]), []) then
    begin
      if Dataset.Active then
        Dataset.Close;

      Dataset.SQL.Text := zConsultasSQL.FieldByName('SQL').AsString;
      Dataset.Connection := conBD;
      Result := True;
    end;
  except
    raise; //Que el programador lo atrape y haga lo que se le antoje
  end;
end;

function AsignarSQL(var Dataset: TZQuery; QueryName: String; Option: string): Boolean;
begin
  Result := UDMConection.setSQL(Dataset,QueryName,Option);
end;

function FiltrarDataset(var Dataset: TZQuery; params: string; Values: array of Variant): Boolean;
begin
  Result := UDMConection.setParams(Dataset,params,Values);
end;

end.