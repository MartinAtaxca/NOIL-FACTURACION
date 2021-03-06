unit UConection;

interface

uses
  SysUtils, Classes, ZAbstractConnection, ZConnection, DB, ZAbstractRODataset,
  ZAbstractDataset, ZDataset, Variants, Windows, Messages;

type

  TVarGlobal = Class
    sNombre: String;
    sTipo: String;
    Private
      vValor: Variant;
    Public
      function AsString: String;
      function AsInteger: Integer;
      function AsFloat: Extended;
      function AsDate: TDate;
      function AsDateTime: TDateTime;
      function AsVariant: Variant;
  End;

  TGlobales = Class
    private
      ListaGlobal: TStringList;
    public
      Constructor Create;
    Destructor Destroy;

    function Elemento(Nombre: String): TVarGlobal;
    procedure SetValue(Nombre: String; Valor: Variant);
  End;

  eWarning = class(Exception);
  eException = class(Exception);

  TUDMConection = class(TDataModule)
    conBD: TZConnection;
    zConsultasSQL: TZQuery;
    procedure DataModuleDestroy(Sender: TObject);
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    function ReloadQuerys: Boolean;
    Function setSQL(var Dataset: TZQuery; QueryName: String; Option: string): Boolean;
    function setParams(var Dataset: TZQuery; params: string; Values: array of Variant): Boolean;
    { Public declarations }
  end;

var
  UDMConection: TUDMConection;
  varGlobal: TGlobales;
const
  pReadOnly: string = 'READONLY';
  pUpdate: string = 'UPDATE';
  pMensajeError: String = 'Ha ocurrido un error, informe a su administrador de sistema de lo siguiente: ';

  function AsignarSQL(var Dataset: TZQuery; QueryName: String; Option: string): Boolean;
  function FiltrarDataset(var Dataset: TZQuery; params: string; Values: array of Variant): Boolean;
  function RecargarConsultasSQL: Boolean;
implementation

{$R *.dfm}

Uses
  UFrmInicioFacturacion;
{ TDataModule2 }

procedure TUDMConection.DataModuleCreate(Sender: TObject);
begin
  ReloadQuerys;
end;

procedure TUDMConection.DataModuleDestroy(Sender: TObject);
begin
  if conBD.Connected then
    conBD.Disconnect;
end;

function TUDMConection.ReloadQuerys: Boolean;
begin
  try
    Result := False;
    zConsultasSQL.Active := False;
    zConsultasSQL.SQL.Text := 'Select * from master_consultassql';
    zConsultasSQL.Open;
    Result := True;
  except
    on e: Exception do
    begin
      raise Exception.Create('No se pudo recargar el conjunto de consultas SQL debido al siguiente error:  ' + e.Message);
    end;
  end;
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

function RecargarConsultasSQL: Boolean;
begin
  try
    Result := UDMConection.ReloadQuerys;
  except
    raise;
  end;
end;


function TVarGlobal.AsString: String;
begin
  if vValor = Null then
    Result := ''
  else
    Result := vValor;
end;

function TVarGlobal.AsInteger: Integer;
begin
  if vValor = Null then
    Result := 0
  else
    Try
      Result := vValor;
    Except
      Result := 0;
    End;
end;

function TVarGlobal.AsFloat: Extended;
begin
  if vValor = Null then
    Result := 0
  else
    Try
      Result := vValor;
    Except
      Result := 0;
    End;
end;

function TVarGlobal.AsDate: TDate;
begin
  if vValor = Null then
    Result := 0
  else
    Try
      Result := Trunc(vValor);
    Except
      Result := 0;
    End;
end;

function TVarGlobal.AsDateTime: TDateTime;
begin
  if vValor = Null then
    Result := 0
  else
    Try
      Result := vValor;
    Except
      Result := 0;
    End;
end;

function TVarGlobal.AsVariant: Variant;
begin
  Result := vValor;
end;

function ObtenerElemento(Numero: Integer; Cadena: String): String;
var
  Cuenta, Cta: Integer;
  Found: Boolean;
  Valor, Resultado: String;
begin
  Cuenta := 0;
  Valor := '';
  Cta := 0;
  Cadena := Cadena + '|';
  Resultado := '';
  Found := False;
  while (Cuenta < Length(Cadena)) and Not Found do
  begin
    Inc(Cuenta);
    if Cadena[Cuenta] = '|' then
    begin
      inc(Cta);
      if Cta = Numero then
      begin
        Found := True;
        Resultado := Valor;
      end
      else
        Valor := '';
    end
    else
      Valor := Valor + Cadena[Cuenta];
  end;
  Result := Resultado;
end;

constructor TGlobales.Create;
begin
  ListaGlobal := TStringList.Create;
  ListaGlobal.Clear;
end;

destructor TGlobales.Destroy;
begin
  ListaGlobal.Free;
end;

function TGlobales.Elemento(Nombre: string): TVarGlobal;
var
  Indice: Integer;
  Variable: String;
  Elem: TVarGlobal;
begin
  Indice := ListaGlobal.IndexOf(Nombre);
  if Indice >= 0 then
  begin
    if ((TVarGlobal(ListaGlobal.Objects[Indice]).sTipo = 'INTEGER') or
        (TVarGlobal(ListaGlobal.Objects[Indice]).sTipo = 'FLOAT')) and (String(TVarGlobal(ListaGlobal.Objects[Indice]).vValor) = '') then
      TVarGlobal(ListaGlobal.Objects[Indice]).vValor := 0;

    Result := TVarGlobal(ListaGlobal.Objects[Indice]);
  end
  else
  begin
      Elem := TVarGlobal.Create;
      if Variable <> '' then
      begin
        // Descomponer la variable en sus elementos basicos
        Elem.sNombre := ObtenerElemento(1, Variable);
        Elem.sTipo   := ObtenerElemento(2, Variable);
        Elem.vValor  := ObtenerElemento(2, Variable);

        varGlobal.ListaGlobal.AddObject(ObtenerElemento(1, Variable), Elem);
      end
      else
      begin
        // Descomponer la variable en sus elementos basicos
        Elem.sNombre := '';
        Elem.sTipo   := '';
        Elem.vValor  := '';
      end;
    Result := Elem;
  end;
end;

procedure TGlobales.SetValue(Nombre: String; Valor: Variant);
var
  Indice: Integer;
begin
  // Modificar el valor de la variable de memoria especificada
  Indice := ListaGlobal.IndexOf(Nombre);
  if Indice < 0 then
  begin
    ListaGlobal.AddObject(Nombre, TVarGlobal.Create);
    Indice := ListaGlobal.IndexOf(Nombre);
  end;
  TVarGlobal(ListaGlobal.Objects[Indice]).vValor := Valor;
end;



end.
