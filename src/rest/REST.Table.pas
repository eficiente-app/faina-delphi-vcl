// Eduardo - 06/12/2020
unit REST.Table;

interface

uses
  System.SysUtils,
  System.JSON,
  Data.DB,
  FireDAC.Comp.Client,
  FireDAC.Comp.DataSet;

type
  TRESTTable = class
  private
    FTable: TFDMemTable;
    FMethodGet: TFunc<TJSONArray>;
    FMethodPut: TProc<TJSONArray>;
    FMethodPost: TProc<TJSONArray>;
    FMethodDelete: TProc<TJSONArray>;
    function DataSetToJSON(Source: TFDMemTable): TJSONArray;
  public
    constructor Create(Source: TFDMemTable);
    procedure RESTGet(pProc: TFunc<TJSONArray>);
    procedure RESTPut(pProc: TProc<TJSONArray>);
    procedure RESTPost(pProc: TProc<TJSONArray>);
    procedure RESTDelete(pProc: TProc<TJSONArray>);
    procedure Read;
    procedure Write;
  end;

implementation

uses
  System.RTTI,
  System.Generics.Collections,
  System.DateUtils;

{ TRESTManager }

constructor TRESTTable.Create(Source: TFDMemTable);
begin
  FTable := Source;
  FTable.CreateDataSet;
  FTable.CachedUpdates := True;
end;

procedure TRESTTable.RESTGet(pProc: TFunc<TJSONArray>);
begin
  FMethodGet := pProc;
end;

procedure TRESTTable.RESTPut(pProc: TProc<TJSONArray>);
begin
  FMethodPut := pProc;
end;

procedure TRESTTable.RESTPost(pProc: TProc<TJSONArray>);
begin
  FMethodPost := pProc;
end;

procedure TRESTTable.RESTDelete(pProc: TProc<TJSONArray>);
begin
  FMethodDelete := pProc;
end;

function TRESTTable.DataSetToJSON(Source: TFDMemTable): TJSONArray;
var
  I: Integer;
  oJSON: TJSONObject;
begin
  Result := TJSONArray.Create;
  Source.First;
  while not Source.Eof do
  begin
    oJSON := TJSONObject.Create;
    Result.AddElement(oJSON);
    for I := 0 to Pred(Source.FieldCount) do
    begin
      if Source.Fields[I].IsNull then
        oJSON.AddPair(Source.Fields[I].FieldName, TJSONNull.Create)
      else
      if Source.Fields[I] is TBooleanField then
        oJSON.AddPair(Source.Fields[I].FieldName, TJSONBool.Create(Source.Fields[I].AsBoolean))
      else
      if Source.Fields[I] is TStringField then
        oJSON.AddPair(Source.Fields[I].FieldName, Source.Fields[I].AsString)
      else
      if Source.Fields[I] is TNumericField then
        oJSON.AddPair(Source.Fields[I].FieldName, TJSONNumber.Create(Source.Fields[I].AsFloat))
      else
      if (Source.Fields[I] is TDateTimeField) or (Source.Fields[I] is TSQLTimeStampField) then
        oJSON.AddPair(Source.Fields[I].FieldName, DateToISO8601(Source.Fields[I].AsDateTime))
      else
        raise Exception.Create(Source.Name +': Tipo do campo não esperado!'+ sLineBreak +'Campo: '+ Source.Fields[I].FieldName +' - Tipo: '+ TRTTIEnumerationType.GetName(Source.Fields[I].DataType));
    end;
    Source.Next;
  end;
end;

procedure TRESTTable.Read;
var
  I,J          : Integer;
  DField       : TField;
  aJSONTBL     : TJSONArray;
  oJSONROW     : TJSONObject;
  oJSONCEL     : TJSONPair;
  RBeforePost  : TDataSetNotifyEvent;
  ROnNewRecord : TDataSetNotifyEvent;
  ROnPosError  : TDataSetErrorEvent;
  aOnChange    : Array of TFieldNotifyEvent;
  aOnSetText   : Array of TFieldSetTextEvent;
  aOnValidate  : Array of TFieldNotifyEvent;
begin
  FTable.EmptyDataSet;

  if not Assigned(FMethodGet) then
    raise Exception.Create('Metodo Get não definido!');

  // Executa chamada e obtem o retorno
  aJSONTBL := FMethodGet;
  try
    // Remove eventos do dataset
    RBeforePost  := FTable.BeforePost;
    ROnNewRecord := FTable.OnNewRecord;
    ROnPosError  := FTable.OnPostError;
    FTable.BeforePost  := nil;
    FTable.OnNewRecord := nil;
    FTable.OnPostError := nil;
    try
      // Cria arrays para armazenar os eventos dos fields
      SetLength(aOnChange,   FTable.FieldCount);
      SetLength(aOnSetText,  FTable.FieldCount);
      SetLength(aOnValidate, FTable.FieldCount);

      // Sobrescreve eventos dos fields
      for I := 0 to Pred(FTable.FieldCount) do
      begin
        DField            := FTable.Fields[I];
        aOnChange[I]      := DField.OnChange;
        aOnSetText[I]     := DField.OnSetText;
        aOnValidate[I]    := DField.OnValidate;
        DField.OnChange   := nil;
        DField.OnSetText  := nil;
        DField.OnValidate := nil;
      end;

      // Desativa os controles para não executar os eventos do DataSource
      FTable.DisableControls;
      try
        // Passar por todas as linhas da tabela
        for I := 0 to Pred(aJSONTBL.Count) do
        begin
          // Insere no dataset
          FTable.Append;

          // Obtem a linha
          oJSONROW := TJSONObject(aJSONTBL.Items[I]);

          // Passa por todas as colunas
          for J := 0 to Pred(oJSONROW.Count) do
          begin
            // Obtem a célula
            oJSONCEL := oJSONROW.Pairs[J];

            // Obtem o field do dataset correspondente ao nome do par JSON
            DField := FTable.FindField(oJSONCEL.JsonString.Value);

            // Se existe o field
            if DField <> nil then
            begin
              // Veifica se não é nulo
              if not (oJSONCEL.JsonValue is TJSONNull) then
              begin
                // Formata o valor de acordo com o tipo do field
                if DField is TNumericField then
                  DField.AsFloat := StrToFloat(oJSONCEL.JsonValue.Value)
                else
                if not(DField is TTimeField) and
                  ((DField is TDateTimeField) or (DField is TSQLTimeStampField)) then
                  DField.Value := ISO8601ToDate(oJSONCEL.JsonValue.Value)
                else
                  DField.AsString := oJSONCEL.JsonValue.Value;
              end;
            end;
          end;
          // Posta os dados inseridos
          FTable.Post;
        end;
      finally
        // Reinsere evento original dos fields
        for I := 0 to Pred(FTable.FieldCount) do
        begin
          DField            := FTable.Fields[I];
          DField.OnChange   := aOnChange[I];
          DField.OnSetText  := aOnSetText[I];
          DField.OnValidate := aOnValidate[I];
        end;

        // Ativa os controles
        FTable.EnableControls;

        // Passa pelo StateChange do DataSource
        FTable.First;
      end;
    finally
      // Reatribui eventos do dataset
      FTable.BeforePost  := RBeforePost;
      FTable.OnNewRecord := ROnNewRecord;
      FTable.OnPostError := ROnPosError;
    end;
  finally
    FreeAndNil(aJSONTBL);
  end;

  // Informa que os dados no dataset estão iguais ao servidor
  FTable.CommitUpdates;
end;

procedure TRESTTable.Write;
begin
  FTable.DisableControls;
  try
    // Se foi informado o metodo de inserção
    if Assigned(FMethodPost) then
    begin
      // Filtra os registros inseridos
      FTable.FilterChanges := [rtInserted];

      // Se tem algum registro, envia ao metodo
      if FTable.RecordCount > 0 then
        FMethodPost(DataSetToJSON(FTable));
    end;

    // Se foi informado o metodo de alteração
    if Assigned(FMethodPut) then
    begin
      // Filtra os registros alterados
      FTable.FilterChanges := [rtModified];

      // Se tem algum registro, envia ao metodo
      if FTable.RecordCount > 0 then
        FMethodPut(DataSetToJSON(FTable));
    end;

    // Se foi informado o metodo de deleção
    if Assigned(FMethodPost) then
    begin
      // Filtra os registros alterados
      FTable.FilterChanges := [rtDeleted];

      // Se tem algum registro, envia ao metodo
      if FTable.RecordCount > 0 then
        FMethodDelete(DataSetToJSON(FTable));
    end;
  finally
    if FTable.UpdatesPending then
      FTable.CommitUpdates;
    FTable.EnableControls;
    FTable.FilterChanges := [rtInserted, rtModified, rtUnmodified];
  end;
end;

{$WARN GARBAGE OFF}

end.
(*
Controle - Versões.
--------------------------------------------------------------------------------
[ - ]
--------------------------------------------------------------------------------
*)
