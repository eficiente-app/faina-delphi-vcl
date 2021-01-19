(*------------------------------------------------------------------------------
Autor: Eduardo Rodrigues Pêgo; Daniel de Araujo Costa
------------------------------------------------------------------------------*)

unit Extend.DBGrids;

interface

uses
  Winapi.Messages,
  WinApi.Windows,
  WinApi.ActiveX,
  Winapi.GDIPAPI,
  Winapi.GDIPOBJ,
  Winapi.GDIPUTIL,
  System.Classes,
  System.Generics.Defaults,
  System.Generics.Collections,
  System.Math,
  System.SysUtils,
  System.Types,
  System.RTTI,

  System.DateUtils,

  Data.DB,
  Datasnap.DBClient,
  Vcl.AppEvnts,
  Vcl.Buttons,
  Vcl.Controls,
  Vcl.DBGrids,
  Vcl.ExtCtrls,
  Vcl.Forms,
  Vcl.Graphics,
  Vcl.GraphUtil,
  Vcl.Grids,
  Vcl.Imaging.pngimage,
  Vcl.StdCtrls,
  Vcl.Themes,
  System.UITypes;

type
  TDBGrid = class;
  TColumnKind = (ckNone, ckData, ckSemaforo, ckCheck, ckProgress);
  TColumnOrdering = (coNone, coAsc, coDesc);
  TGroupButtons = (btExpand, btRetract);
  TMovingKind = (mkNone, mkStarting, mkColumn, mkGroup);
  TMovingDirection = (mdNone, mdLeft, mdRight);
  TCustomGridCanvas = record
  private
    FDBGrid: TDBGrid;
    FDataSet: TDataSet;
    FColumn: TColumn;
    FState: TGridDrawState;
    FColumnKind: TColumnKind;
    FRect: TRect;
    FCellDisplayText: String;
    FFieldDisplayText: String;
    FFieldName: String;
    FReticenciasTexto: Boolean;
    FLinhaSelecionada: Boolean;
    FLinhaPar: Boolean;
    FLinha: TColor;
    FBorda: TColor;
    FFont: TFont;
    FBordaLinha: Boolean;
    FDataSetRecord: Integer;
    FHighlight: Boolean;
  public
    property DBGrid: TDBGrid read FDBGrid;
    property DataSet: TDataSet read FDataSet;
    property Column: TColumn read FColumn;
    property State: TGridDrawState read FState;
    property Rect: TRect read FRect;
    property ColumnKind: TColumnKind read FColumnKind;
    property DataSetRecord: Integer read FDataSetRecord;
    property ReticenciasTexto: Boolean read FReticenciasTexto;
    property CellDisplayText: string read FCellDisplayText write FCellDisplayText;
    property FieldDisplayText: string read FFieldDisplayText write FFieldDisplayText;
    property FieldName: string read FFieldName;
    property LinhaSelecionada: Boolean read FLinhaSelecionada;
    property LinhaPar: Boolean read FLinhaPar;
    property Linha: TColor read FLinha write FLinha;
    property Borda: TColor read FBorda write FBorda;
    property Font: TFont read FFont write FFont;
    property BordaLinha: Boolean read FBordaLinha write FBordaLinha;
    property Highlight: Boolean read FHighlight;
  end;

  TCustomDrawCell = procedure (var Custom: TCustomGridCanvas) of object;
  TMethodRules = procedure(var Value: Variant) of object;

  TDBGrid = class(Vcl.DBGrids.TDBGrid)
  private type
    IHighlight = interface
      ['{E527FEA6-2B65-4643-92C2-319A7F4F7410}']
    end;
    THighlightObject = class(TInterfacedObject, IHighlight)
    private
      FGrid: TDBGrid;
    public
      class function New(AGrid: TDBGrid): IHighlight;
      destructor Destroy; override;
    end;

    TSemaforo = class
    private
      Grid       : TDBGrid;
      Caption    : string;
      FieldName  : String;
      Cores      : TArray<TBitmap>;
      Valores    : TArray<String>;
      Descricoes : TArray<String>;
      FMethodRules: TMethodRules;
      function CriarImagem(GPColor: TGPColor): TBitmap;
      procedure PrepareBMP(var bmp: TBitmap; Width, Height: Integer);
    public
      destructor Destroy; override;
      property DBGrid : TDBGrid read Grid;
      function Add(clsColor: TColor; aValue: TArray<Variant>; aDescricao: TArray<String>): TSemaforo; overload;
      function Add(bmpImage: TBitmap; aValue: TArray<Variant>; aDescricao: TArray<String>): TSemaforo; overload;
      function Add(clsColor: TColor; Value: Variant; sDescricao: String): TSemaforo; overload;
      function Add(bmpImage: TBitmap; Value: Variant; sDescricao: String): TSemaforo; overload;
      function Add(Source: TSemaforo): TSemaforo; overload;
      function SetMethodRules(AMethod: TMethodRules): TSemaforo;
    end;

    TProgresso = record
    private
      FieldName: String;
      aCores: TArray<TColor>;
    end;

    TSemaforoView = class(TForm)
    private
      FSemaforos : Array of TSemaforo;
      procedure PrepararSemaforo;
      procedure OnKeyDownForm(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure OnCloseForm(Sender: TObject; var Action: System.UITypes.TCloseAction);
      procedure OnDeactivateForm(Sender: TObject);
    public
      class procedure ShowSemaforo(Semaforos: Array of TSemaforo);
    end;

    TOnBeforeCheck = procedure(const CheckAll: Boolean; var CanCheck: Boolean) of object;
    TOnAfterCheck = procedure of object;
    TCheck = class
    private
      Grid      : TDBGrid;
      FieldName : String;
      FOnBeforeCheck : TOnBeforeCheck;
      FOnAfterCheck  : TOnAfterCheck;
      procedure Check;
      procedure CheckAll(Column: TColumn);
    public
      property DBGrid : TDBGrid read Grid;
      function OnBeforeCheck(Check: TOnBeforeCheck): TCheck;
      function OnAfterCheck(Check: TOnAfterCheck): TCheck;
    end;

    TLocateText = class(TForm)
      pnlClient: TPanel;
      Bevel: TBevel;
      lbContador: TLabel;
      edtText: TEdit;
      btnClose: TImage;
      btnDown: TImage;
      btnUp: TImage;
      procedure FormClose(Sender: TObject; var Action: TCloseAction);
      procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
      procedure FormKeyPress(Sender: TObject; var Key: Char);
      procedure edtTextChange(Sender: TObject);
      procedure WMLButtonDown(var Message: TWMLButtonDown); message WM_LBUTTONDOWN;
      procedure WMMouseMove(var Message: TWMMouseMove); message WM_MOUSEMOVE;
      procedure WMLButtonUp(var Message: TWMLButtonUp); message WM_LBUTTONUP;
    private type
      TLocateButtonType = (btUp, btDown, btClose);
    private
      FGrid: TDBGrid;
      FMovendo: Boolean;
      FMouseOffSet: TPoint;
      procedure CreateControls;
      function CreateButton(EClick: TNotifyEvent; png: TPngImage): TImage;
      function GetButtonImage(btType: TLocateButtonType): TPngImage;
      procedure LocateText(bReverse: Boolean = False);
      function PosReverse(sSubStr, sText: string): Integer;
      procedure UpdatePosition;
      procedure OnUpClick(Sender: TObject);
      procedure OnDownClick(Sender: TObject);
      procedure OnCloseClick(Sender: TObject);
    protected
      procedure Paint; override;
      procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    public
      FormPosOffSet: TPoint;
      TextPos: Integer;
      CellPos: TGridCoord;
      class function BeginLocate(var Grid: TDBGrid): TLocateText;
    end;

    TGridGroupTitle = class;

    {$SCOPEDENUMS ON} // Controla como os valores do tipo de enumeração serão usados
    TGridGroupTitleMouseHit = (None, Hover, OwnerHover, SubGroupHover);
    TGridGroupTitleState = (None, InvalidateDraw, InvalidateRect, InvalidateTextRect);
    TGridGroupTitleStates = set of TGridGroupTitleState;
    TGridGroupTitleDrawState = (None, NeedDraw, Hot, OwnerHot, SubGroupHot);
    TGridGroupTitleDrawStates = set of TGridGroupTitleDrawState;
    TGridGroupTitleListStatus = (NeedCalcRect, NeedCalcMaxGroupHeight);
    TGridGroupTitleListStates = set of TGridGroupTitleListStatus;
    TGridGroupTitleListDrawState = (None, NeedDraw);
    TGridGroupTitleListDrawStates = set of TGridGroupTitleListDrawState;

    TGridGroupTitleList = class(TList<TGridGroupTitle>)
    private
      FGrid: TDBGrid;
      FOwnerGroup: TGridGroupTitle;
      FDrawState: TGridGroupTitleListDrawStates;
      FState: TGridGroupTitleListStates;
      FMaxGroupHeight: Integer;
      FClientRect: TRect;
      function GetOwnerList: TGridGroupTitleList;
    protected
      FComparer: IComparer<TGridGroupTitle>;
      FComparasion: TComparison<TGridGroupTitle>;
      constructor Create(AOwner: TDBGrid); reintroduce; overload;
      constructor Create(AOwner: TGridGroupTitle); reintroduce; overload;
      procedure DrawGroups; virtual;
      function GetMaxGroupHeight: Integer;
      procedure DoMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      procedure DoMouseMove(Shift: TShiftState; X, Y: Integer);
      procedure DoMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
      function ContainsState(Status: TGridGroupTitleListStatus): Boolean;
      procedure AddState(Status: TGridGroupTitleListStatus);
      function GetClientRect: TRect;

      procedure AddDrawState(State: TGridGroupTitleListDrawState);
      procedure RemoveDrawState(State: TGridGroupTitleListDrawState);
      function ContainsDrawState(State: TGridGroupTitleListDrawState): Boolean;
    public
      destructor Destroy; override;
      function AddAndGet(sCaption: String; cStartColumn, cEndColumn: TColumn): TGridGroupTitle; overload;
      function AddAndGet(sCaption: String; sStartField, sEndFiled: String): TGridGroupTitle; overload;
      function AddAndGet(sCaption: String; iStartColumn, iEndColumn: Integer): TGridGroupTitle; overload;
      function Add(sCaption: String; cStartColumn, cEndColumn: TColumn): TGridGroupTitleList; overload;
      function Add(sCaption: String; sStartField, sEndFiled: String): TGridGroupTitleList; overload;
      function Add(sCaption: String; iStartColumn, iEndColumn: Integer): TGridGroupTitleList; overload;
      function GetGroup(sCaption: String; bIncludeSubGroups: Boolean = True): TGridGroupTitle; overload;
      function GetGroup(ptMouse: TPoint; bIncludeSubGroups: Boolean = True): TGridGroupTitle; overload;
      function GetGroup(cColumn: TColumn; bIncludeSubGroups: Boolean = True): TGridGroupTitle; overload;
      function TryGet(sCaption: String; var gtOut: TGridGroupTitle; bIncludeSubGroups: Boolean = True): Boolean; overload;
      function TryGet(ptMouse: TPoint; var gtOut: TGridGroupTitle; bIncludeSubGroups: Boolean = True): Boolean; overload;
      function TryGet(cColumn: TColumn; var gtOut: TGridGroupTitle; bIncludeSubGroups: Boolean = True): Boolean; overload;
      function GroupInPt(ptMouse: TPoint; bIncludeSubGroups: Boolean = True): Boolean;
      function Contains(sCaption: String; bIncludeSubGroups: Boolean = True): Boolean;
      property Owner: TGridGroupTitle read FOwnerGroup;
      property OwnerList: TGridGroupTitleList read GetOwnerList;
      function SetStateAllGroups(State: TGridGroupTitleState): TGridGroupTitleList;
    end;

    TGridGroupTitle = class
    private type
      TGridGroupTitleMargins = record
        Left: Integer;
        Top: Integer;
        Right: Integer;
        Bottom: Integer;
      end;
    private
      //FRect: TRect;
      //FRectVisible: TRect;
      //FDrawStatus: TGridGroupTitleDrawStates;


      FState: TGridGroupTitleStates;
      FOwner: TGridGroupTitleList; // Lista de Grupos à qual o grupo pertence
      FCaption: string; // Caption do Grupo
      FGroupTitles: TGridGroupTitleList; // Lista de Sub-Grupos
      FStartColumn: TColumn;
      FEndColumn: TColumn;
      FDefaultHeight: Integer;
      FFont: TFont;
      FTextMargins: TGridGroupTitleMargins;

      FGroupRect: TRect;
      FGroupVisibleRect: TRect;

      FRectTextCaption: TRect;
      function GetDrawStatus: TGridGroupTitleDrawStates;
      function GetTextAreaRect: TRect;
      procedure SetEndColumn(const Value: TColumn);
      procedure SetStartColumn(const Value: TColumn);
      procedure SetCaption(const Value: string);
      procedure CalcRectTextCaption;
    protected
      constructor Create(AOwner: TGridGroupTitleList; sCaption: String; cStartColumn, cEndColumn: TColumn); overload;
      function GetOwner: TGridGroupTitle;
      function GetDBGrid: TDBGrid;
      function GetCountRows: Integer;
      function GetRect: TRect;
      function GetVisibleRect: TRect;
      procedure DrawGroup;
      procedure MoveGroup(iToColumnIndex: Integer; bMoveColumn: Boolean); overload;
      function GetStartIndex: Integer;
      function GetEndIndex: Integer;
      function CalcStartIndex(iTOColumnIndex: Integer): Integer;
      function CalcEndIndex(iTOColumnIndex: Integer): Integer;
      function MouseIsHover(ptMouse: TPoint): Boolean;
      function MouseHit(ptMouse: TPoint): TGridGroupTitleMouseHit;
      procedure DoMouseMove(Shift: TShiftState; X, Y: Integer);
      procedure Invalidate;
    public
      destructor Destroy; override;
      // Acesso rápido
      function AddAndGet(sCaption: String; cStartColumn, cEndColumn: TColumn): TGridGroupTitle; overload;
      function AddAndGet(sCaption: String; sStartField, sEndFiled: String): TGridGroupTitle; overload;
      function AddAndGet(sCaption: String; iStartColumn, iEndColumn: Integer): TGridGroupTitle; overload;
      function Add(sCaption: String; cStartColumn, cEndColumn: TColumn): TGridGroupTitleList; overload;
      function Add(sCaption: String; sStartField, sEndFiled: String): TGridGroupTitleList; overload;
      function Add(sCaption: String; iStartColumn, iEndColumn: Integer): TGridGroupTitleList; overload;

      function AddState(State: TGridGroupTitleState): TGridGroupTitle;
      function RemoveState(State: TGridGroupTitleState): TGridGroupTitle;
      function ContainsState(State: TGridGroupTitleState): Boolean;

      property Owner: TGridGroupTitleList read FOwner;
      property OwnerGroup: TGridGroupTitle read GetOwner;
      property DBGrid: TDBGrid read GetDBGrid;
      property GroupTitles: TGridGroupTitleList read FGroupTitles write FGroupTitles;
      property Caption: string read FCaption write SetCaption;
      property StartColumn: TColumn read FStartColumn write SetStartColumn;
      property EndColumn: TColumn read FEndColumn write SetEndColumn;
      property StartIndex: Integer read GetStartIndex;
      property EndIndex: Integer read GetEndIndex;
      function IsVisible: Boolean;
    end;

  private
    FINITIAL_ORDER: String;
    AppEvents: TApplicationEvents;
    FDrawingCell: TGridCoord;
    FTemEdicao: Boolean;
    FOnCustomDrawCell: TCustomDrawCell;
    FSemaforos : Array of TSemaforo;
    FCheck : TCheck;
    FProgress : Array of TProgresso;
    FResizeColumn: Boolean;
    FResizeColumnIndex: Integer;
    FTimerID: Cardinal;
    FTimerMoveID: Cardinal;
    FTimerLocateID: Cardinal;
    FBitmap: TBitmap;
    FMovingKind: TMovingKind; { Define se está movimentando: nada/coluna/grupo }
    FMovingDirection: TMovingDirection; { Define qual a direção da movimentação }
    FMoveColumn: TGridCoord; { Coordenadas da coluna que está sendo movimentada }
    FMoveColumnPos: TGridCoord; { Coordenadas da coluna que o mouse está posicionado }
    FMoveColumnGroup: TGridGroupTitle; { Grupo da Coluna que está sendo movida }
    FMoveColumnGroupPos: TGridGroupTitle; { Grupo onde o mouse está posicionado ao mo}
    FMoveGroup: TGridGroupTitle; { Grupo que está sendo movimentado }
    FMoveGroupOwner: TGridGroupTitle; { Grupo Raiz do Grupo que está sendo movido (FMoveGroup) }
    FMoveGroupPos: TGridGroupTitle; { Grupo onde o mouse está posicionado (Irmão de FMoveGroup) }
    FMoveGroupColumnPos: TGridCoord; { Coordenadas da coluna que o mouse está posicionado }
    FClickOffset: Integer; { Left do Click do Mouse sobre uma coluna e/ou grupo }
    FIndexDef: String;
    FUltIndex: String;
    FIndexCount: Integer;
    FLocateText: TLocateText;
    FAscIndicator: TPngImage;
    FDescIndicator: TPngImage;
    FSelectedCellDisplayText: String;
    FLocateActive: Boolean;
    FSelStartRow: Integer;
    FIsHighlight: Boolean;
    FIsGroupRow: Boolean;
    FGroupTitles: TGridGroupTitleList;
    FMousePoint: TPoint;
    procedure OnActivateApplication(Sender: TObject);
    procedure OnDeactivateApplication(Sender: TObject);
    procedure ExibirLegenda;
    function AcquireFocus: Boolean;
    procedure DrawText(CustomCanvas: TCustomGridCanvas);
    procedure DrawFocusBorder(const CustomCanvas: TCustomGridCanvas);
    procedure RemoveFocusRect(const CustomCanvas: TCustomGridCanvas);
    procedure ResizeColumn; overload;
    function Reticencias(var sText: string; const iMaxWidth: Integer; const GridState: TGridDrawState): Boolean;
    procedure DrawProgresso(const CustomCanvas: TCustomGridCanvas);
    procedure DrawCheck(const CustomCanvas: TCustomGridCanvas);
    procedure DrawSemaforo(const CustomCanvas: TCustomGridCanvas);
    function CalcCoordFromPoint(X, Y: Integer; const DrawInfo: TGridDrawInfo): TGridCoord;
    procedure GetCanvasBitmap;
    function GetColumnKind(Column: TColumn): TColumnKind;
    function DoEGBeginMove(CellHit: TGridCoord; X, Y: Integer): Boolean;
    procedure DoEGMove(X, Y: Integer);
    function DoEGMoveScrollH(var gcCellHit: TGridCoord; var DrawInfo: TGridDrawInfo): Boolean;
    procedure DoEGMoveDraw(X, Y: Integer);
    procedure DoEGEndMove(bMove: Boolean = True);
    function EGBeginMoveColumn(CellHit: TGridCoord; X, Y: Integer): Boolean;
    procedure EGMoveColumn(X, Y: Integer);
    procedure EGMoveColumnDraw(X, Y: Integer);
    procedure EGEndMoveColumn(bMove: Boolean = True);
    function EGBeginMoveGroupTitle(CellHit: TGridCoord; X, Y: Integer): Boolean;
    procedure EGMoveGroupTitle(X, Y: Integer);
    procedure EGMoveGroupTitleDraw(X, Y: Integer);
    procedure EGEndMoveGroupTitle(bMove: Boolean = True);
    procedure DrawTitleCell(ARect: TRect; ACol, ARow: Integer; Column: TColumn; var AState: TGridDrawState);
    function GetColumnOrdering(Column: TColumn): TColumnOrdering;
    function ColumnInOrderStr(sField, sList: String): Boolean;
    procedure BeginLocate;
    procedure HighlightLocate(rText: TRect; const CustomCanvas: TCustomGridCanvas);
    procedure EndLocate;
    function GetOrderingIndicator(Ordering: TColumnOrdering): TPngImage;
    function GetColumnByFieldName(sFieldName: String): TColumn;
    function CalculaCorProgresso(corInicial, corFinal: TColor): TArray<TColor>;
    procedure FieldColumnExists(CustomCanvas: TCustomGridCanvas);
    procedure GroupCellClick(Column: TColumn);
    procedure GroupMethodRules(var Value: Variant);
    function GetGroupButtons(btType: TGroupButtons): TBitmap;
    function MouseInGroup: Boolean; overload;
    function GetColumnGroupTitle(cColumn: TColumn; gtGroupList: TList<TGridGroupTitle> = nil; bSubGroups: Boolean = True): TGridGroupTitle;
    procedure EGCalcGroupTitleRect;
    function EGBoxRect(ALeft, ATop, ARight, ABottom: Longint): TRect;
    procedure EGGridRectToScreenRect(GridRect: TGridRect; var ScreenRect: TRect; IncludeLine: Boolean);
  protected
    class function MakeGDIPColor(C: TColor; Alpha: Byte): Cardinal;
    procedure Paint; override;
    procedure DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState); override;
    procedure DrawColumnCell(const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState); override;
    procedure TitleClick(Column: TColumn); override;
    procedure CalcSizingState(X, Y: Integer; var State: TGridState; var Index: Longint; var SizingPos, SizingOfs: Integer; var FixedInfo: TGridDrawInfo); override;
    procedure MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure MouseMove(Shift: TShiftState; X, Y: Integer); override;
    procedure MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer); override;
    procedure WMKeyDown(var Message: TWMKeyDown); message WM_KEYDOWN;
    procedure WMKeyUp(var Message: TWMKeyUp); message WM_KEYUP;
    procedure WMCancelMode(var Msg: TWMCancelMode); message WM_CANCELMODE;
    procedure WMTimer(var Msg: TWMTimer); message WM_TIMER;
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
    procedure WMSetCursor(var Msg: TWMSetCursor); message WM_SETCURSOR;
    procedure DoEnter; override;
    procedure DoExit; override;
    procedure WMWindowPosChanged(var Message: TWMWindowPosChanged); message WM_WINDOWPOSCHANGED;
    function GetColumnWidth(Column: TColumn): Integer;
    procedure SetColumnWidth(Column: TColumn; iWidth: Integer = 0);
    procedure UpdateScrollBar; override;
    procedure RaiseGrid(sMessage: String);
    procedure CMMouseEnter(var Message: TMessage); message CM_MOUSEENTER;
    procedure CMMouseLeave(var Message: TMessage); message CM_MOUSELEAVE;
    function EGCellRect(iStartCol, iStartRow: LongInt; iEndCol: LongInt = -1; iEndRow: LongInt = -1): TRect;
//    procedure WMVScroll(var Message: TWMVScroll); message WM_VSCROLL;
//    procedure WMHScroll(var Msg: TWMHScroll); message WM_HSCROLL;
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure SetFocus; override;
    function CanFocus: Boolean; override;
    function Semaforo(FieldName: String; Caption: String = ''): TSemaforo;
    function Check(FieldName: String): TCheck;
    function Progresso(FieldName: String; corInicial: TColor = $00C8C864; corFinal: TColor = $00C8C864): TDBGrid;
    function Group(sOrderField: String = ''): TDBGrid;
    function CustomDrawCell(Method: TCustomDrawCell): TDBGrid;
    function SetScrollBars(Style : TScrollStyle): TDBGrid;
    function SetLocate(bActive: Boolean): TDBGrid;
    function RedrawIn(MilliSecond: Cardinal): TDBGrid;
    function SetCol(sCol: string; bVisible: Boolean; iWidth: Integer = -1): TDBGrid;
    property Col;
    property Row;
    property FixedCols;
    property FixedRows;
    function ResizeColumn(arrColumns: Array of Integer): TDBGrid; overload;
    function OrderBy(sFieldsExp: String): TDBGrid;
    property GroupTitles: TGridGroupTitleList read FGroupTitles;
    function GroupTitle(sCaption: String; cStartColumn, cEndColumn: TColumn): TDBGrid; overload;
    function GroupTitle(sCaption: String; sStartField, sEndField: String): TDBGrid; overload;
    function GroupTitle(sCaption: String; iStartColumn, iEndColumn: Integer): TDBGrid; overload;
    procedure EGUpdateData;
    function Highlight: IHighlight;
  end;

implementation

uses
  System.StrUtils,
  Vcl.Dialogs,
  Clipbrd,
  Datasnap.DSIntf;

{ TDBGrid }

constructor TDBGrid.Create(AOwner: TComponent);
begin
  inherited;
  AppEvents := TApplicationEvents.Create(Self);
  AppEvents.OnActivate   := OnActivateApplication;
  AppEvents.OnDeactivate := OnDeactivateApplication;

  FGroupTitles := TGridGroupTitleList.Create(Self);

  // Inicializa
  FIndexCount   := 0;
  FLocateActive := True;
  FSelStartRow  := -1;
  FIsGroupRow   := False;

  FMousePoint := Point(-1, -1);
end;

destructor TDBGrid.Destroy;
var
  I: Integer;
begin
  for I := 0 to High(FSemaforos) do
    FreeAndNil(FSemaforos[I]);
  if Assigned(FCheck) then
    FreeAndNil(FCheck);
  if Assigned(FBitmap) then
    FreeAndNil(FBitmap);
  if Assigned(FAscIndicator) then
    FreeAndNil(FAscIndicator);
  if Assigned(FDescIndicator) then
    FreeAndNil(FDescIndicator);
  if Assigned(FLocateText) then
    EndLocate;
  if Assigned(Self.DataSource) and Assigned(Self.DataSource.DataSet) and Self.DataSource.DataSet.InheritsFrom(TClientDataSet) then
    if not FINITIAL_ORDER.IsEmpty then
      TClientDataSet(Self.DataSource.DataSet).IndexName := FINITIAL_ORDER;

  FreeAndNil(FGroupTitles);

  FreeAndNil(AppEvents);
  inherited;
end;

procedure TDBGrid.DoEnter;
begin
  if Row > -1 then
    InvalidateRow(Row);
  inherited;
end;

procedure TDBGrid.DoExit;
begin
  DoEGEndMove(False);
  Invalidate;
  inherited;
end;

function TDBGrid.CanFocus: Boolean;
var
  Control: TWinControl;
  Form: TCustomForm;
begin
  Result := False;
  Form   := GetParentForm(Self);
  if Form <> nil then
  begin
    Control := Self;
    while Control <> Form do
    begin
      if not (Control.Visible and Control.Enabled and Control.Showing) then
        Exit;
      Control := Control.Parent;
    end;
    Result := True;
  end;
end;

procedure TDBGrid.SetFocus;
begin
  if CanFocus then
    inherited;
end;

function TDBGrid.Semaforo(FieldName: String; Caption: String = ''): TSemaforo;
var
  oSemaforo: TSemaforo;
begin
  if FieldName.Trim.IsEmpty then
    RaiseGrid('Informe um Campo!');

  Result := nil;

  // Verifica se já existe um semáforo para o campo informado
  for oSemaforo in FSemaforos do
    if oSemaforo.FieldName.Equals(FieldName) then
      Exit(oSemaforo);

  // Se ainda não criou, cria a classe semaforo
  if not Assigned(Result) then
  begin
    SetLength(FSemaforos, Succ(Length(FSemaforos)));
    Result := TSemaforo.Create;
    FSemaforos[High(FSemaforos)] := Result;
  end;

  // Se informado o field do semaforo
  if not FieldName.IsEmpty then
  begin
    // Localiza o field no data set
    Result.Caption := Caption;
    // Localiza o field no data set
    Result.FieldName := FieldName;

    // Atribui a dbgrid ao semaforo
    Result.Grid := Self;
  end;

  // Verifica se tem o field
  if Result.FieldName.Trim.IsEmpty then
    RaiseGrid('Field não informado!');
end;

function TDBGrid.Check(FieldName: String): TCheck;
begin
  // Valida
  if Assigned(FCheck) then
    RaiseGrid('Check já informado!');

  // Valida o field
  if FieldName.Trim.IsEmpty then
    RaiseGrid('Necessário informar o field do check!');

  // Cria classe check
  FCheck := TCheck.Create;

  // Define o field do check
  FCheck.FieldName := FieldName;

  // Armazena dbgrid atual
  FCheck.Grid := Self;

  // Retorna a classe check
  Result := FCheck;
end;

function TDBGrid.Progresso(FieldName: String; corInicial: TColor = $00C8C864; corFinal: TColor = $00C8C864): TDBGrid;
begin
  // Valida o field
  if FieldName.Trim.IsEmpty then
    RaiseGrid('Necessário informar o field do progresso!');

  // Localiza o field no data set
  SetLength(FProgress, Succ(Length(FProgress)));
  FProgress[Pred(Length(FProgress))].FieldName  := FieldName;
  FProgress[Pred(Length(FProgress))].aCores     := CalculaCorProgresso(corInicial, corFinal);
  Result := Self;
end;

function TDBGrid.CustomDrawCell(Method: TCustomDrawCell): TDBGrid;
begin
  Result := Self;
  FOnCustomDrawCell := Method;
end;

function TDBGrid.SetScrollBars(Style: TScrollStyle): TDBGrid;
begin
  Self.ScrollBars := Style;
  Result := Self;
end;

function TDBGrid.SetCol(sCol: string; bVisible: Boolean; iWidth: Integer = -1): TDBGrid;
var
  iQtdCols: Integer;
  iCol : Integer;
begin
  Result := Self;

  iQtdCols := (Self.Columns.Count -1);
  for iCol := 0 to iQtdCols do
  begin
     if (Self.Columns[iCol].Field <> Nil) and (CompareText(UpperCase(Self.Columns[iCol].FieldName), UpperCase(sCol)) = 0) then
     begin
       Self.Columns[iCol].Visible := bVisible;

       if iWidth >= 0 then
         Self.Columns[iCol].Width   := iWidth;

       Exit;
     end;
  end;
end;

function TDBGrid.SetLocate(bActive: Boolean): TDBGrid;
begin
  Result := Self;
  FLocateActive := bActive;
end;

function TDBGrid.RedrawIn(MilliSecond: Cardinal): TDBGrid;
begin
  // Define o retorno
  Result := Self;

  // Evita executar varias vezes
  if FTimerID <> 0 then
    Exit;

  // Obtem um novo ID para o timer
  FTimerID := RandomRange(100, 200);

  // Cria um Timer para Atualizar a Pintura após a contagem de tempo finalizar
  SetTimer(Self.Handle, FTimerID, MilliSecond, nil);
end;

procedure TDBGrid.EGUpdateData;
begin
  DataLink.UpdateRecord;
end;

function TDBGrid.GroupTitle(sCaption: String; cStartColumn, cEndColumn: TColumn): TDBGrid;
begin
  Result := Self;
  FGroupTitles.Add(sCaption, cStartColumn, cEndColumn);
end;

function TDBGrid.GroupTitle(sCaption, sStartField, sEndField: String): TDBGrid;
begin
  Result := Self;
  FGroupTitles.Add(sCaption, sStartField, sEndField);
end;

function TDBGrid.GroupTitle(sCaption: String; iStartColumn, iEndColumn: Integer): TDBGrid;
begin
  Result := Self;
  FGroupTitles.Add(sCaption, iStartColumn, iEndColumn);
end;

procedure TDBGrid.Paint;
begin
  EGCalcGroupTitleRect;
  inherited;
  FGroupTitles.DrawGroups;
end;

procedure TDBGrid.DrawCell(ACol, ARow: Longint; ARect: TRect; AState: TGridDrawState);
begin
  FDrawingCell.X := ACol;
  FDrawingCell.Y := ARow;

  // Verifica se está pintando o Título
  if (dgTitles in Options) and ((ARow - 1) < 0) and (not((gdFixed in AState) and ((ACol - 1) < 0))) then
  begin
    if (FMovingKind = TMovingKind.mkNone) and MouseInGroup and FGroupTitles.ContainsDrawState(TGridGroupTitleListDrawState.NeedDraw) then
    begin
      Exclude(AState, gdHotTrack);
      Exclude(AState, gdPressed);
      ARect.Top := ARect.Bottom - DefaultRowHeight;
      InvalidateTitles;
    end;
    DrawTitleCell(ARect, ACol, ARow + 1{FTitleOffset}, Columns[ACol - IndicatorOffset]{DrawColumn}, AState);
  end
  else
  begin
    if ((ACol > 0) and (ACol <= Columns.Count)) then
      SetColumnWidth(Columns[Pred(ACol)]);

    inherited;
  end;
end;

procedure TDBGrid.DrawTitleCell(ARect: TRect; ACol, ARow: Integer; Column: TColumn; var AState: TGridDrawState);
const
  ScrollArrows: array [Boolean, Boolean] of Integer =
    ((DFCS_SCROLLRIGHT, DFCS_SCROLLLEFT), (DFCS_SCROLLLEFT, DFCS_SCROLLRIGHT));
var
  MasterCol: TColumn;
  TitleRect, TextRect, ButtonRect: TRect;
  I: Integer;
  InBiDiMode: Boolean;
  LFrameOffs: Byte;
  FrameOffs: Byte;
  aAlignment: TAlignment;
  iTextWidth: Integer;
  sCaption : string;
  cOrder   : TColumnOrdering;
  pngOrder : TPngImage;
  iWOrder  : Integer;
  bColumnHasGroup: Boolean;
begin
  FrameOffs := 2;
  if (gdFixed in AState) and (([dgRowLines, dgColLines] * Options) = [dgRowLines, dgColLines]) then
  begin
    InflateRect(ARect, -1, -1);
    FrameOffs := 1;
  end;
  // Rect do Titulo, obtém MasterCol
  TitleRect := CalcTitleRect(Column, ARow, MasterCol);
  if MasterCol = nil then
  begin
    Canvas.FillRect(ARect);
    Exit;
  end;

  Canvas.Font := MasterCol.Title.Font;
  Canvas.Brush.Color := MasterCol.Title.Color;

  if [dgRowLines, dgColLines] * Options = [dgRowLines, dgColLines] then
    InflateRect(TitleRect, -1, -1);

  bColumnHasGroup := (FGroupTitles.Count > 0) and Assigned(GetColumnGroupTitle(Column));

  TextRect := TitleRect;
  I := GetSystemMetrics(SM_CXHSCROLL);
  if ((TextRect.Right - TextRect.Left) > I) and MasterCol.Expandable then
  begin
    Dec(TextRect.Right, I);
    ButtonRect := TitleRect;
    ButtonRect.Left := TextRect.Right;
    I := SaveDC(Canvas.Handle);
    try
      Canvas.FillRect(ButtonRect);
      InflateRect(ButtonRect, -1, -1);
      IntersectClipRect(Canvas.Handle, ButtonRect.Left, ButtonRect.Top, ButtonRect.Right, ButtonRect.Bottom);
      InflateRect(ButtonRect, 1, 1);
      { DrawFrameControl doesn't draw properly when orienatation has changed.
        It draws as ExtTextOut does. }
      InBiDiMode := Canvas.CanvasOrientation = coRightToLeft;
      if InBiDiMode then { stretch the arrows box }
        Inc(ButtonRect.Right, GetSystemMetrics(SM_CXHSCROLL) + 4);
      DrawFrameControl(Canvas.Handle, ButtonRect, DFC_SCROLL, ScrollArrows[InBiDiMode, MasterCol.Expanded] or DFCS_FLAT);
    finally
      RestoreDC(Canvas.Handle, I);
    end;
  end;

  DrawCellBackground(TitleRect, MasterCol.Title.Color, AState, ACol, ARow - 1{FTitleOffset});

  LFrameOffs := FrameOffs;
  if (gdPressed in AState) then
    Inc(LFrameOffs); // Offset text when fixed cell is pressed

  pngOrder := nil;
  iWOrder  := 0;
  with MasterCol.Title do
  begin
    // Obtem a ordem da cluna atual
    cOrder := GetColumnOrdering(MasterCol);

    // Se a grid não ordena, não exibe o indicador
    if not (dgTitleClick in Options) then
      cOrder := coNone;

    // Se é uma coluna ordenada, obtém o bmp Indicador
    if cOrder <> coNone then
    begin
      pngOrder := GetOrderingIndicator(cOrder);
      // Obtém a largura do indicador
      if Assigned(pngOrder) then
        iWOrder := pngOrder.Width;
    end;
    if iWOrder <> 0 then
      Inc(iWOrder, 3);

    // Aplica alinhamento
    aAlignment := Alignment;
    if (Canvas.CanvasOrientation = coRightToLeft) and (not IsRightToLeft) then
      ChangeBiDiModeAlignment(aAlignment);

    // Adiciona reticências no texto do título
    sCaption := Caption;
    Reticencias(sCaption, TitleRect.Width - iWOrder, AState);

    // Obtem a area da Celula
    Self.Canvas.FillRect(TitleRect);
    if bColumnHasGroup then
      TitleRect.Top := TitleRect.Bottom - DefaultRowHeight;
    TextRect := TitleRect;

    // Se é título de um check
    if GetColumnKind(Column) = ckCheck then
    begin
      // Define as novas configurações
      Canvas.Font.Name := 'Wingdings 2';
      Canvas.Font.Size := 11;
      aAlignment       := taCenter;

      // Se não foi informado o caption, define
      if sCaption.Trim.IsEmpty then
        sCaption := 'R';
    end;

    // Define o alinhamento do texto
    iTextWidth := Canvas.TextWidth(sCaption);
    // Corrige alinhamento ao centro com ordenação
    if (iWOrder > 0) and (aAlignment = taCenter) then
    begin
      if ((TextRect.Left + ((TextRect.Width - iTextWidth) div 2)) + iTextWidth) < (TextRect.Right - iWOrder) then
        iWOrder := 0
      else
        iWOrder := Max(1, (iWOrder div 2));
    end;

    case aAlignment of
      taLeftJustify  : TextRect.Left := TitleRect.Left + LFrameOffs;
      taRightJustify : TextRect.Left := Max(TitleRect.Left, TitleRect.Right - iTextWidth - 3 - iWOrder);
      taCenter       : TextRect.Left := Max(TitleRect.Left, TitleRect.Left + (TitleRect.Right - TitleRect.Left) div 2 - (iTextWidth div 2) - iWOrder);
    end;

    // Calcula o Rect do Texto
    Self.Canvas.TextRect(TextRect, sCaption, [tfCalcRect, tfWordBreak]);
    if bColumnHasGroup then
    begin
      // Alinha abaixo do grupo
      TextRect.Top    := TitleRect.Bottom - TextRect.Height;
      TextRect.Bottom := TitleRect.Bottom;
    end
    else
    begin
      // Alinha abaixo do grupo
      TextRect.Top    := TitleRect.Top + (TitleRect.Height - TextRect.Height) div 2;//.Bottom - TextRect.Height;
      TextRect.Bottom := TitleRect.Bottom;
    end;
    // Desenha o Texto
    Winapi.Windows.DrawText(Canvas.Handle, PChar(sCaption), Length(sCaption), TextRect, DT_WORDBREAK);

    // Se tem ordenação na coluna, insere indicador
    if (cOrder <> coNone) and Assigned(pngOrder) then
    begin
      TextRect := TitleRect;
      TextRect.Top  := Max(TitleRect.Top,  TitleRect.Top + ((TitleRect.Height - pngOrder.Height) div 2));
      TextRect.Left := Max(TitleRect.Left, TitleRect.Right - pngOrder.Width - 3);
      Self.Canvas.Draw(TextRect.Left, TextRect.Top, pngOrder);
      FreeAndNil(pngOrder);
    end;
  end;

  if (([dgRowLines, dgColLines] * Options) = [dgRowLines, dgColLines]) and
     (FInternalDrawingStyle = gdsClassic) and
     (not (gdPressed in AState)) then
  begin
    InflateRect(TitleRect, 1, 1);
    if not TStyleManager.IsCustomStyleActive then
    begin
      DrawEdge(Canvas.Handle, TitleRect, BDR_RAISEDINNER, BF_BOTTOMRIGHT);
      DrawEdge(Canvas.Handle, TitleRect, BDR_RAISEDINNER, BF_TOPLEFT);
    end;
  end;

  AState := AState - [gdFixed];  // prevent box drawing later
end;

procedure TDBGrid.DrawColumnCell(const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
var
  CustomCanvas: TCustomGridCanvas;
begin
  // Se tem evento no OnDrawColumnCell
  if Assigned(OnDrawColumnCell) then
  begin
    // Executa e sai da função
    OnDrawColumnCell(Self, Rect, DataCol, Column, State);
    Exit;
  end;

  // Inicializa com configuração padrão
  CustomCanvas.FDBGrid           := Self;
  CustomCanvas.FDataSet          := Self.DataSource.DataSet;
  CustomCanvas.FColumn           := TColumn(Column);
  CustomCanvas.FState            := State;
  CustomCanvas.FRect             := Rect;
  CustomCanvas.FColumnKind       := GetColumnKind(CustomCanvas.FColumn);
  CustomCanvas.FDataSetRecord    := Self.DataSource.DataSet.RecNo;
  CustomCanvas.FLinhaSelecionada := CellRect(DataCol, Row).Top = Rect.Top;
  CustomCanvas.FLinhaPar         := not Odd(DataSource.DataSet.RecNo);
  CustomCanvas.FHighlight        := FIsHighlight;

  // Texto que será exibido
  if Assigned(Column.Field) then
  begin
    CustomCanvas.FFieldDisplayText := Column.Field.DisplayText;
    CustomCanvas.FCellDisplayText  := Column.Field.DisplayText;
    CustomCanvas.FFieldName        := Column.FieldName;
  end;

  CustomCanvas.Linha      := Canvas.Brush.Color;
  CustomCanvas.BordaLinha := False;
  CustomCanvas.Borda      := RGB(0, 128, 255);
  CustomCanvas.Font       := Canvas.Font;
  // Cor padrão do Texto (Preto)
  // Windows XP estava colocando Branco quando a celula estava selecionada
  CustomCanvas.Font.Color := Column.Font.Color;

  // Se tem grupo, datasource, dataset, field e é o cabeçalho
  if FIsGroupRow and
     Assigned(Self.DataSource) and
     Assigned(Self.DataSource.DataSet) and
     Assigned(Self.DataSource.DataSet.FindField('TIPO')) and
     Self.DataSource.DataSet.FieldByName('TIPO').AsString.Equals('0') then
    CustomCanvas.Font.Style := CustomCanvas.Font.Style + [fsBold];

  // Se a linha é par, define cor diferente
  if CustomCanvas.LinhaPar then
    CustomCanvas.Linha := RGB(244, 247, 252);

  // Se a linha está selecionada, define cor diferente
  if CustomCanvas.LinhaSelecionada then
    CustomCanvas.Linha := RGB(184, 220, 250);

  // Se a celula está selecionada, define cor diferente
  if (gdSelected in State) and Focused then
    CustomCanvas.Linha := RGB(223, 239, 253);

  // Se tem evento de costumização, executa
  if Assigned(FOnCustomDrawCell) then
    FOnCustomDrawCell(CustomCanvas);

  // Define a cor do pincel e da fonte
  Canvas.Brush.Color := CustomCanvas.Linha;
  Canvas.Font        := CustomCanvas.Font;

  // Reticências em texto maior que a largura da coluna
  CustomCanvas.FReticenciasTexto :=
    Reticencias(CustomCanvas.FCellDisplayText, GetColumnWidth(CustomCanvas.Column) - 4, CustomCanvas.State);

  // Verifica se o Campo Existe
  FieldColumnExists(CustomCanvas);

  // Desenha a celula e pinta o Texto
  DrawText(CustomCanvas);

  // Progresso
  DrawProgresso(CustomCanvas);

  // Desenha a borda
  DrawFocusBorder(CustomCanvas);

  // Semaforo
  DrawSemaforo(CustomCanvas);

  // Check
  DrawCheck(CustomCanvas);
end;

function TDBGrid.Reticencias(var sText: string; const iMaxWidth: Integer; const GridState: TGridDrawState): Boolean;
var
  RTH: TRect;
begin
  RTH := Rect(0, 0, 1000, 1000);
  // Verifica se será nescessário adicionar Reticências
  Self.Canvas.TextRect(RTH, sText, [tfCalcRect, tfWordBreak]){ > iMaxWidth };
  Result := RTH.Width > iMaxWidth;

  // Corta o texto
  while (sText.Length > 1) and (RTH.Width > iMaxWidth) do
  begin
    sText := LeftStr(sText, Pred(Length(sText)));
    RTH := Rect(0, 0, 1000, 1000);
    Self.Canvas.TextRect(RTH, sText, [tfCalcRect, tfWordBreak]);
  end;

  // Se precisar de Reticencias
  if Result then
  begin
    // Se estiver selecionada a celula, remove um caractere a mais
    if gdSelected in GridState then
      sText := LeftStr(sText, Length(sText) - 3)
    else
      sText := LeftStr(sText, Length(sText) - 2);
    // Adiciona reticencias
    sText := sText +'...';
  end;
end;

procedure TDBGrid.FieldColumnExists(CustomCanvas: TCustomGridCanvas);
begin
  if not CustomCanvas.FieldName.Trim.IsEmpty and not Assigned(CustomCanvas.Column.Field) then
  begin
    CustomCanvas.FCellDisplayText := 'Campo "'+ CustomCanvas.FieldName +'" não encontrado!';
    CustomCanvas.Linha      := clRed;
    CustomCanvas.Font.Color := clWhite;
    Canvas.Brush.Color      := CustomCanvas.Linha;
    Canvas.Font             := CustomCanvas.Font;
  end;
end;

procedure TDBGrid.DrawText(CustomCanvas: TCustomGridCanvas);
var
  rCellRect: TRect;
  bRightToLeft: Boolean;
  aAlignment: TAlignment;
  DX: Integer;
  DY: Integer;
  iTextWidth: Integer;
  bsCanvas: TBrushStyle;
begin
  // Não desenhar o texto
  if CustomCanvas.ColumnKind in [ckSemaforo, ckCheck] then
    CustomCanvas.FCellDisplayText := EmptyStr;

  // Padrão da DBGrid
  DX := 3;
  DY := 2;

  // Se tem o field, obtem o alinha mento do texto a partir dele
  if Assigned(CustomCanvas.Column.Field) then
    aAlignment := CustomCanvas.Column.Field.Alignment
  else
    aAlignment := CustomCanvas.Column.Alignment;

  // Obtem sentido de leitura do field
  bRightToLeft := UseRightToLeftAlignmentForField(CustomCanvas.Column.Field, CustomCanvas.Column.Alignment);

  // Aplica alinhamento
  if (Canvas.CanvasOrientation = coRightToLeft) and (not bRightToLeft) then
    ChangeBiDiModeAlignment(aAlignment);

  // Obtem a area da Celula
  rCellRect := CustomCanvas.Rect;
  Self.Canvas.FillRect(rCellRect);

  // Define o alinhamento do texto
  iTextWidth := Canvas.TextWidth(CustomCanvas.FCellDisplayText);
  case aAlignment of
    taLeftJustify  : rCellRect.Left := rCellRect.Left + DX;
    taRightJustify : rCellRect.Left := Max(rCellRect.Left, rCellRect.Right - iTextWidth - 3);
    taCenter       : rCellRect.Left := Max(rCellRect.Left, rCellRect.Left + (rCellRect.Right - rCellRect.Left) div 2 - (iTextWidth div 2));
  end;

  // Desenha o texto na grid
  rCellRect.Top := rCellRect.Top + DY;
  HighlightLocate(rCellRect, CustomCanvas);
  bsCanvas := Self.Canvas.Brush.Style;

  Self.Canvas.Brush.Style := bsClear;
  Self.Canvas.TextOut(rCellRect.Left, rCellRect.Top, CustomCanvas.FCellDisplayText);
  Self.Canvas.Brush.Style := bsCanvas;
end;

procedure TDBGrid.DrawFocusBorder(const CustomCanvas: TCustomGridCanvas);
var
  rLinha: TRect;
begin
  // Não desenhar borda no Semaforo
  if CustomCanvas.ColumnKind in [ckSemaforo, ckCheck] then
    Exit;

  if ((gdSelected in CustomCanvas.State) or (CustomCanvas.LinhaSelecionada and CustomCanvas.BordaLinha)) and
     ((dgAlwaysShowSelection in Options) or Focused) and
     (not (csDesigning in ComponentState)) and
     (not (dgRowSelect in Options)) and
     (ValidParentForm(Self).ActiveControl = Self) then
  begin
    // Armazena o texto selecionado
    FSelectedCellDisplayText := CustomCanvas.CellDisplayText;

    rLinha := CustomCanvas.Rect;
    // Calcula o Rect Visivel da Linha
    if CustomCanvas.BordaLinha then
    begin
      rLinha.Left   := CellRect(0, Row).Right + 1;
      rLinha.Top    := rLinha.Top;
      rLinha.Right  := GetGridWidth; { Width da Linha }
      rLinha.Bottom := rLinha.Bottom;
    end;
    // Diminui o Rect 1 pixel
    InflateRect(rLinha, -1, -1);

    // Pinta a borda
    Canvas.Pen.Style   := psSolid;
    Canvas.Pen.Color   := CustomCanvas.Borda;
    Canvas.Pen.Width   := 1;
    Canvas.Brush.Style := bsClear;
    // Desenha a Borda
    Canvas.Rectangle(rLinha);
    Canvas.Brush.Style := bsSolid;

    // Remove Foco do Windows {Winapi.Windows.DrawFocusRect}
    RemoveFocusRect(CustomCanvas);
  end;
end;

procedure TDBGrid.RemoveFocusRect(const CustomCanvas: TCustomGridCanvas);
var
  rLinha: TRect;
begin
  if (gdSelected in CustomCanvas.State) and
     (not TStyleManager.IsCustomStyleActive) and
     ((dgAlwaysShowSelection in Options) or Self.Focused) and
     (not (csDesigning in ComponentState)) and
     (not (dgRowSelect in Options)) {and}
     {(ValidParentForm(Self).ActiveControl = Self) }then
  begin
    // Winapi.Windows.DrawFocusRect
    //   Como Winapi.Windows.DrawFocusRect é uma função XOR, chamá-lo uma segunda vez com o mesmo retângulo
    //   remove o retângulo da tela; Então, como o DBGrid irá "adicionar" o Winapi.Windows.DrawFocusRect,
    //   adicionamos primeiro para que o DBGrid execute a função uma segunda vez, removendo o Efeito de foco;
    rLinha := CustomCanvas.Rect;
    if (FInternalDrawingStyle = gdsThemed) and (Win32MajorVersion >= 6) then
      InflateRect(rLinha, -1, -1);

    Winapi.Windows.DrawFocusRect(Canvas.Handle, rLinha);
  end;
end;

function TDBGrid.CalculaCorProgresso(corInicial, corFinal: TColor): TArray<TColor>;
var
  I: Integer;
begin
  // Prepara o Array de Cores
  SetLength(Result, 101);
  // Cria tonalidade RGB
  for I := 0 to 100 do
    Result[I] := ColorBlendRGB(corInicial, corFinal, I / 100);
end;

procedure TDBGrid.DrawProgresso(const CustomCanvas: TCustomGridCanvas);
var
  iValue: Integer;
  cAtualPen, cAtualBrush, cAtalFont: TColor;
  DrawRect: TRect;
  iWidth, iLeft: Integer;
  sValue: string;
  pProgress: TProgresso;
  I: Integer;
begin
  // Verifica se tem field
  if not (CustomCanvas.ColumnKind = ckProgress) then
    Exit;

  if Length(FProgress) = 0 then
    Exit;

  // Obtem as configurações de progresso da coluna
  for I := 0 to High(FProgress) do
  begin
    pProgress := FProgress[I];
    if CustomCanvas.Column.FieldName.Equals(pProgress.FieldName) then
      Break;
  end;

  // Verifica se o field é o progresso atual
  if not CustomCanvas.Column.FieldName.Equals(pProgress.FieldName) then
    Exit;

  // Se o dataset estiver vazio então sai fora
  if Self.DataSource.DataSet.IsEmpty then
    Exit;

  if CustomCanvas.Column.Field.IsNull then
  begin
    iValue := -1;
    sValue := EmptyStr;
  end
  else
  begin
    iValue := CustomCanvas.Column.Field.AsInteger;
    sValue := IntToStr(iValue) +'%';
  end;

  // Evita sair do intervalo de cores
  iValue := Min(Max(iValue, 0), 100);

  DrawRect := CustomCanvas.Rect;
  InflateRect(DrawRect, -1, -1);

  iWidth := (((DrawRect.Right - DrawRect.Left) * iValue) div 100);

  // Armazena cores atuais
  cAtualPen   := Self.Canvas.Pen.Color;
  cAtualBrush := Self.Canvas.Brush.Color;
  cAtalFont  := Self.Canvas.Font.Color;

  // Define cor da pintura
  Self.Canvas.Pen.Color := pProgress.aCores[iValue];

  // Nova cor do fundo ca célula
  Self.Canvas.Brush.Color := clWhite;
  Self.Canvas.Rectangle(DrawRect);
  Self.Canvas.Font.Color  := clBlack;

  if iValue > 0 then
  begin
    Self.Canvas.Pen.Color   := pProgress.aCores[iValue];
    Self.Canvas.Brush.Color := pProgress.aCores[iValue];
    DrawRect.Right := DrawRect.Left + iWidth;
    InflateRect(DrawRect, -1, -1);
    Self.Canvas.Rectangle(DrawRect);
  end;

  DrawRect := CustomCanvas.Rect;
  InflateRect(DrawRect, -2, -2);
  Self.Canvas.Brush.Style := bsClear;
  iLeft := DrawRect.Left + (DrawRect.Right - DrawRect.Left) shr 1 - (Self.Canvas.TextWidth(sValue) shr 1);
  Self.Canvas.TextRect(DrawRect, iLeft, DrawRect.Top + 1, sValue);

  // Volta a configurações anteriores
  Self.Canvas.Pen.Color   := cAtualPen;
  Self.Canvas.Brush.Color := cAtualBrush;
  Self.Canvas.Font.Color  := cAtalFont;
end;

procedure TDBGrid.DrawSemaforo(const CustomCanvas: TCustomGridCanvas);
var
  Semaforo: TSemaforo;
  iIndex  : Integer;
  bmpCor  : TBitmap;
  Value   : Variant;
begin
  // Verifica se tem field e se é semáforo
  if not Assigned(CustomCanvas.Column.Field) or (CustomCanvas.ColumnKind <> ckSemaforo) then
    Exit;

  // Verifica se já existe um semáforo para o campo informado
  for Semaforo in FSemaforos do
  begin
    if not Semaforo.FieldName.Equals(CustomCanvas.Column.FieldName) then
      Continue;

    // Inicializa
    Value := CustomCanvas.Column.Field.AsString;

    // Verifica se tem o method
    if Assigned(Semaforo.FMethodRules) then
      Semaforo.FMethodRules(Value);

    // Localiza o valor na lista de valores
    iIndex := IndexStr(Value, Semaforo.Valores);

    // Se não encontrou, vai para o proximo
    if iIndex >= 0 then
    begin
      // Obtem a imagem do semaforo
      bmpCor := Semaforo.Cores[iIndex];

      // Desenha o semaforo na DBGrid
      Self.Canvas.Draw(
        CustomCanvas.Rect.Left + ((CustomCanvas.Rect.Width  - bmpCor.Width)  div 2),
        CustomCanvas.Rect.Top  + ((CustomCanvas.Rect.Height - bmpCor.Height) div 2),
        bmpCor
      );
    end;

    // Remove o foco do Windows {Winapi.Windows.DrawFocusRect}
    RemoveFocusRect(CustomCanvas);
  end;
end;

procedure TDBGrid.DrawCheck(const CustomCanvas: TCustomGridCanvas);
var
  Check: Integer;
  RectCel: TRect;
begin
  // Se não tem check não executa
  if not Assigned(FCheck) or (CustomCanvas.ColumnKind <> ckCheck) then
    Exit;

  // Verifica se tem field
  if not Assigned(CustomCanvas.Column.Field) then
    Exit;

  // Inicializa
  Check := 0;

  // Dimensões da celula
  RectCel := CustomCanvas.Rect;

  // Diminui o tamanho do CheckBox
  InflateRect(RectCel, -2, -2);

  // Verifica se a coluna atual é a coluna que receberá o CheckBox
  if CustomCanvas.Column.FieldName = FCheck.FieldName then
  begin
    // Checa o valor do campo
    if CustomCanvas.Column.Field.AsString.Equals('S') then
      Check := DFCS_CHECKED;

    // Desenha a CheckBox...
    DrawFrameControl(Self.Canvas.Handle, RectCel, DFC_BUTTON, DFCS_BUTTONCHECK or Check);

    // Remove o foco do Windows {Winapi.Windows.DrawFocusRect}
    RemoveFocusRect(CustomCanvas);
  end;
end;

procedure TDBGrid.TitleClick(Column: TColumn);
var
  cds    : TClientDataSet;
  iIndex : Integer;
  IX     : TIndexDef;
  sFName : String;
  sFields: String;
  sFDescs: String;
  sColum : String;
  aFields: TStringDynArray;
begin
  // Ordenação ao clicar no título
  if not (dgTitleClick in Options) then
    Exit;

  // Se existe evento assinado no formulário, executa.
  if Assigned(OnTitleClick) then
    OnTitleClick(Column)
  else
  begin
    if Assigned(FCheck) and Column.FieldName.Equals(FCheck.FieldName) then
      FCheck.CheckAll(Column)
    else
    begin
      // Verifica se pode ordenar
      if (not Assigned(Column.Field)) or (not (Column.Field.DataSet is TClientDataSet)) then
        Exit;

      // Armazena ClienteDataSet
      cds := TClientDataSet(Column.Field.DataSet);

      // Se for lookup utiliza o field Key
      if Column.Field.FieldKind = fkLookup then
        sFName := Column.Field.KeyFields
      else
        sFName := Column.FieldName;

      // Aramazena indice original
      if cds.IndexName <> FUltIndex then
        FIndexDef := cds.IndexName;

      // Armazena ordenação inicial
      if FINITIAL_ORDER.IsEmpty then
        if cds.IndexName.IsEmpty then
          FINITIAL_ORDER := szDEFAULT_ORDER
        else
          FINITIAL_ORDER := cds.IndexName;

      // Localiza o Indice
      iIndex := cds.IndexDefs.IndexOf(cds.IndexName);

      // Armazena dados do anterior
      if iIndex > -1 then
      begin
        with cds.IndexDefs[iIndex] do
        begin
          sFields := Fields;
          sFDescs := DescFields;
        end;
      end;

      // Verifica se o field está no indice
      if not ColumnInOrderStr(sFName, sFields) then
      begin
        // Adiciona na ordenação crescente
        if sFields.IsEmpty or not (GetKeyState(VK_CONTROL) and 128 > 0) then
        begin
          sFields := sFName;
          sFDescs := EmptyStr;
        end
        else
          sFields := sFields +';'+ sFName;
      end
      else
      begin
        // Verifica se o field está decrescente
        if ColumnInOrderStr(sFName, sFDescs) then
        begin
          aFields := SplitString(sFDescs, ';');
          sFDescs := EmptyStr;
          for sColum in aFields do
            if sColum <> sFName then
              sFDescs := IfThen(not sFDescs.IsEmpty, sFDescs +';') + sColum;

          aFields := SplitString(sFields, ';');
          sFields := EmptyStr;
          for sColum in aFields do
            if sColum <> sFName then
              sFields := IfThen(not sFields.IsEmpty, sFields +';') + sColum;
        end
        else
        begin
          // Adiciona na ordenação decrescente
          if sFDescs.IsEmpty or not (GetKeyState(VK_CONTROL) and 128 > 0) then
            sFDescs := sFName
          else
            sFDescs := sFDescs +';'+ sFName;
        end;
      end;

      // Se o fiels estiver vazio, volta ao padrão
      if sFields.IsEmpty then
      begin
        // Atribui a ordenação
        if FIndexDef.IsEmpty then
          cds.IndexName := szDEFAULT_ORDER
        else
          cds.IndexName := FIndexDef;
      end
      else
      begin
        // Remove coluna vazia
        sFDescs := ReplaceStr(sFDescs, ';;', ';');
        sFields := ReplaceStr(sFields, ';;', ';');

        // Remove ponto e virgula do inicio
        if (sFDescs.Length > 0) and (sFDescs[1] = ';') then
          sFDescs := Copy(sFDescs, 2 , Length(sFDescs));
        if (sFields.Length > 0) and (sFields[1] = ';') then
          sFields := Copy(sFields, 2 , Length(sFields));

        // Atualiza quantidade
        if FIndexCount <= cds.IndexDefs.Count then
          FIndexCount := cds.IndexDefs.Count;

        // Incrementa contador
        Inc(FIndexCount);

        // Cria o indice
        IX            := cds.IndexDefs.AddIndexDef;
        IX.Name       := 'IX'+ FIndexCount.ToString;
        IX.Fields     := sFields;
        IX.DescFields := sFDescs;

        // Atribui a ordenação
        cds.IndexName := IX.Name;
        FUltIndex     := IX.Name;
      end;
    end;
  end;
end;

procedure TDBGrid.WMKeyDown(var Message: TWMKeyDown);
begin
  try
    case Message.CharCode of
      VK_ESCAPE:
      begin
        DoEGEndMove(False);
        if Assigned(FLocateText) then
          EndLocate;
      end;
      VK_F5:
      begin
        // Verifica se tem a classe semaforo e se setou os items e exibe a legenda
        if Length(FSemaforos) > 0 then
        begin
          ExibirLegenda;
          Message.CharCode := 0;
        end;
      end;
      VK_SPACE:
      begin
        // Verifica se tem check
        if Assigned(FCheck) and not (dgEditing in Options) then
        begin
          FCheck.Check;
          Message.CharCode := 0;
        end;

        // Expande ou recolhe o agrupamento
        if FIsGroupRow then
          GroupCellClick(GetColumnByFieldName('GRUPO'));
      end;
      Ord('C'):
      begin
        if (GetKeyState(VK_CONTROL) < 0) then
        begin
          // Insere o texto da grid no clipboard
          if GetKeyState(VK_SHIFT) < 0 then
            Clipboard.AsText := FSelectedCellDisplayText
          else
          if Assigned(SelectedField) then
            Clipboard.AsText := SelectedField.AsString;

          Message.CharCode := 0;
        end;
      end;
      Ord('F'):
      begin
        // Localiza qualquer informação na grid
        if (GetKeyState(VK_CONTROL) < 0) and not (GetKeyState(VK_SHIFT) < 0) then
        begin
          BeginLocate;
          Message.CharCode := 0;
        end;
      end;
      VK_SHIFT:
      begin
        if (FSelStartRow = -1) and
           Assigned(FCheck) and
           Assigned(Self.DataSource) and
           Assigned(Self.DataSource.DataSet) and
           Self.DataSource.DataSet.Active and
           not Self.DataSource.DataSet.IsEmpty then
          FSelStartRow := Self.DataSource.DataSet.RecNo;
      end;
    end;
  finally
    inherited;
  end;
end;

procedure TDBGrid.WMKeyUp(var Message: TWMKeyUp);
var
  iSelEndRow: Integer;
  bCanCheck : Boolean;
begin
  try
    case Message.CharCode of
      VK_SHIFT:
      begin
        if Assigned(FCheck) and
           Assigned(Self.DataSource) and
           Assigned(Self.DataSource.DataSet) and
           Self.DataSource.DataSet.Active and
           not Self.DataSource.DataSet.IsEmpty
           and (Self.DataSource.DataSet.RecNo <> FSelStartRow)
           and (FSelStartRow <> -1) then
          iSelEndRow := Self.DataSource.DataSet.RecNo
        else
          Exit;

        Self.DataSource.DataSet.DisableControls;
        try
          while FSelStartRow <> iSelEndRow do
          begin
            bCanCheck := True;

            // Evento antes de checar
            if Assigned(FCheck.FOnBeforeCheck) then
              FCheck.FOnBeforeCheck(False, bCanCheck);

            // Se pode checar
            if bCanCheck then
            begin
              // Se tem algum registro
              if FCheck.DBGrid.DataSource.DataSet.RecordCount > 0 then
              begin
                // Marca o registro
                FCheck.DBGrid.DataSource.DataSet.Edit;
                if FCheck.DBGrid.DataSource.DataSet.FieldByName(FCheck.FieldName).AsString.Equals('S') then
                  FCheck.DBGrid.DataSource.DataSet.FieldByName(FCheck.FieldName).AsString := 'N'
                else
                  FCheck.DBGrid.DataSource.DataSet.FieldByName(FCheck.FieldName).AsString := 'S';
                FCheck.DBGrid.DataSource.DataSet.Post;
              end;
            end;

            // Verifica a ordem
            if FSelStartRow > iSelEndRow then
            begin
              Self.DataSource.DataSet.Next;
              Dec(FSelStartRow);
            end
            else
            begin
              Self.DataSource.DataSet.Prior;
              Inc(FSelStartRow);
            end;
          end;
          // Marca o ultimo registro
          FCheck.Check;

          // Se tem o evento executa
          if Assigned(FCheck.FOnAfterCheck) then
            FCheck.FOnAfterCheck;

          // Fica no registro final
          Self.DataSource.DataSet.RecNo := iSelEndRow;
        finally
          Self.DataSource.DataSet.EnableControls;
        end;
        FSelStartRow := -1;
      end;
    end;
  finally
    inherited;
  end;
end;

procedure TDBGrid.WMTimer(var Msg: TWMTimer);
var
  Point: TPoint;
  DrawInfo: TGridDrawInfo;
begin
  // Se estiver Movimentando uma Coluna
  if (FMovingKind <> TMovingKind.mkNone) and (Msg.TimerID = FTimerMoveID) then
  begin
    if not AcquireFocus then
    begin
      FMovingKind := TMovingKind.mkNone;
      Invalidate;
    end;
    // Obtém a Posição do ponteiro do mouse
    GetCursorPos(Point);
    // Obtém a Posição do ponteiro do mouse em relação ao componente
    Point := ScreenToClient(Point);
    // Calcula as Medidas de Desenho da Grid
    CalcDrawInfo(DrawInfo);
    // Atualiza a pintura de Movimentação da Coluna
    DoEGMove(Point.X, Point.Y);
    // Finaliza o Procedimento
    Exit;
  end;

  // Executa evento padrão
  if not (FGridState in [gsColMoving]) then
    inherited;

  // Se for o Timer de Atualização de Posição do Locate
  if Msg.TimerID = FTimerLocateID then
  begin
    if Assigned(FLocateText) then
    begin
      if (Self.CanFocus and Self.Showing) then
      begin
        if not FLocateText.Showing then
          FLocateText.Show;
        FLocateText.UpdatePosition;
      end
      else
      if (not (Self.CanFocus and Self.Showing)) and FLocateText.Showing then
        FLocateText.Hide;
    end
    else
    begin
      KillTimer(Self.Handle, FTimerLocateID);
      FTimerLocateID := 0;
    end;
  end;

  // Se for o Timer de Atualização de Pintura
  if Msg.TimerID = FTimerID then
  begin
    KillTimer(Self.Handle, FTimerID);
    FTimerID := 0;
    Repaint;
  end;
end;

//procedure TDBGrid.WMVScroll(var Message: TWMVScroll);
//begin
//  FGroupTitles.SetStateAllGroups(TGridGroupTitleState.NeedCalcRect);
//  //inherited WMVScroll(Message);
//end;

//procedure TDBGrid.WMHScroll(var Msg: TWMHScroll);
//begin
//  FGroupTitles.SetStateAllGroups(TGridGroupTitleState.NeedCalcRect);
//  // WMHScroll(Message);
//end;

procedure TDBGrid.WMWindowPosChanged(var Message: TWMWindowPosChanged);
begin
  inherited;
  if Assigned(FLocateText) then
    FLocateText.UpdatePosition;
end;

procedure TDBGrid.WMCancelMode(var Msg: TWMCancelMode);
begin
  inherited;
  DoEGEndMove(False);
  Repaint;
end;

procedure TDBGrid.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  inherited;
  // Forçar a Pintura
  Message.Result := 1;
end;

procedure TDBGrid.WMSetCursor(var Msg: TWMSetCursor);
begin
  if MouseInGroup then
    SetCursor(Screen.Cursors[crArrow])
  else
    inherited;
end;

procedure TDBGrid.MouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  CellHit     : TGridCoord;
  DrawInfo    : TGridDrawInfo;
  FSizingIndex: LongInt;
  FSizingPos  : LongInt;
  FSizingOfs  : LongInt;
begin
  FMousePoint := Point(X, Y);
  // Obtém o status de Desenho
  CalcDrawInfo(DrawInfo);
  CalcSizingState(X, Y, FGridState, FSizingIndex, FSizingPos, FSizingOfs, DrawInfo);
  CellHit := Self.MouseCoord(X, Y);
  // Incializa variável
  FResizeColumn := False;
  FResizeColumnIndex := -1;
  try
    if not AcquireFocus then
      Exit;

    // Verifica se está preparando para Redimensionar uma coluna
    if (ssDouble in Shift) and (Button in [mbLeft, mbMiddle]) and (CellHit.Y <= 0) then
    begin
      FResizeColumn := True;
      if Button = mbLeft then
        FResizeColumnIndex := Pred(FSizingIndex);
    end;

    // Semaforo não entra em Edição
    if ((dgIndicator in Options) and ((CellHit.X = 0) or (CellHit.Y = 0))) or
       ((CellHit.X > 0) and (GetColumnKind(Columns[CellHit.X - IndicatorOffset]) = ckSemaforo)) then
    begin
      FTemEdicao := FTemEdicao or (dgEditing in Options);
      Options    := Options - [dgEditing];
    end
    else // Se não é um campo do Semáforo, verifica se a grid permitia edição
    if FTemEdicao and (not (dgEditing in Options)) then
      Options := Options + [dgEditing];

  finally
    // Verifica se é um clique de Movimentação
    if (Button = mbLeft) and (not (ssDouble in Shift)) then
      DoEGBeginMove(CellHit, X, Y);

    // Se não estiver Movimentando
    if (FMovingKind = TMovingKind.mkNone) and not MouseInGroup then
    begin
      EGCalcGroupTitleRect;
      inherited MouseDown(Button, Shift, X, Y);

      // Expande ou recolhe o agrupamento
      if FIsGroupRow and (Button = mbLeft) then
      begin
        if ssDouble in Shift then
          GroupCellClick(GetColumnByFieldName('GRUPO'))
        else
        if (CellHit.X > 0) and (CellHit.Y > 0) and Self.Columns[CellHit.X - IndicatorOffset].FieldName.Equals('GRUPO') then
          GroupCellClick(Self.Columns[CellHit.X - IndicatorOffset])
      end;

      // Verifica se deve checar o registro
      if Assigned(FCheck) and (Button = mbLeft) and (CellHit.X > 0) and (CellHit.Y > 0) and
        (((Shift = [ssLeft]) and (Self.Columns[CellHit.X - IndicatorOffset].FieldName = FCheck.FieldName)) or
         ((ssDouble in Shift) and (Self.Columns[CellHit.X - IndicatorOffset].FieldName <> FCheck.FieldName))) then
        FCheck.Check;
    end;
  end;
end;

procedure TDBGrid.MouseMove(Shift: TShiftState; X, Y: Integer);
begin
  FMousePoint := Point(X, Y);
  // Se estiver Movendo uma Coluna
  if FMovingKind <> TMovingKind.mkNone then
    DoEGMove(X, Y)
  else
  if MouseInGroup then
    InvalidateTitles
  else
    inherited MouseMove(Shift, X, Y);
end;

procedure TDBGrid.MouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  // Se estiver Movimentando Coluna/Grupo de Coluna
  if not (FMovingKind in [TMovingKind.mkNone, TMovingKind.mkStarting]) then
    DoEGEndMove
  else // Se estiver Redimensionando com DuploClique
  if FResizeColumn and (FGridState = gsColSizing) then
  begin
    ResizeColumn;
    FGridState := gsNormal;
  end
  else // Executa o evento padrão
  if FMovingKind in [TMovingKind.mkNone, TMovingKind.mkStarting] then
  begin
    DoEGEndMove;
    EGCalcGroupTitleRect;
    inherited MouseUp(Button, Shift, X, Y);

    // Se for clique com botão do meio, pesquisa na grid o texto
    if Button in [mbMiddle] then
    begin
      if not Assigned(FLocateText) then
        BeginLocate;

      if Assigned(FLocateText) then
        FLocateText.edtText.Text := FSelectedCellDisplayText;
    end;
  end;
end;

procedure TDBGrid.CMMouseEnter(var Message: TMessage);
begin
  inherited;
  Invalidate;
  Application.ProcessMessages;
end;

procedure TDBGrid.CMMouseLeave(var Message: TMessage);
begin
  inherited;
  FMousePoint := Point(0, 0);
  Invalidate;
  Application.ProcessMessages;
end;

procedure TDBGrid.CalcSizingState(X, Y: Integer; var State: TGridState; var Index: Longint; var SizingPos, SizingOfs: Integer; var FixedInfo: TGridDrawInfo);
var
  Cell: TGridCoord;
begin
  State := gsNormal;
  Cell  := Self.MouseCoord(X, Y);
  if (Cell.X > 0) and
     ((not (GetColumnKind(Columns[Cell.X - IndicatorOffset]) in [ckNone, ckData, ckProgress])) or
      (((Cell.X - IndicatorOffset) > 0) and (not (GetColumnKind(Columns[Pred(Cell.X - IndicatorOffset)]) in [ckNone, ckData, ckProgress])))) then
    Exit;

  inherited;
end;

function TDBGrid.ResizeColumn(arrColumns: array of Integer): TDBGrid;
var
  iIndex: Integer;
begin
  Result := Self;
  if Length(arrColumns) = 0 then
  begin
    FResizeColumnIndex := -1;
    ResizeColumn;
  end
  else
  for iIndex in arrColumns do
  begin
    FResizeColumnIndex := iIndex;
    ResizeColumn;
  end;
end;

procedure TDBGrid.ResizeColumn;
var
  iMaxSize: Integer;
  iSize   : Integer;
  cdsDados: TClientDataSet;
  cdsTemp : TClientDataSet;
  Field   : TField;
  iStart  : Integer;
  iStop   : Integer;
  iIndex  : Integer;
  Column  : TColumn;

  function GetPWithStr(str : String; const ufont : TFont): Integer;
  var
    DC : HDC;
    size : TSize;
    SaveFont : HFONT;
  begin
    DC := GetDC(0);
    SaveFont := SelectObject(DC, uFont.Handle);
    GetTextExtentPoint32(DC, PChar(str), Length(str), size);
    SelectObject(DC, SaveFont);
    ReleaseDC(0,DC);
    Result := size.cx;
  end;

begin
  // Obtém o DataSet da Grid
  cdsDados := TClientDataSet(Self.DataSource.DataSet);
  if not cdsDados.Active then
    Exit;

  // Cria o cds Temporário
  cdsTemp := TClientDataSet.Create(nil);
  try
    // Carrega o cds Temporário com os dados do cds da Listagem
    cdsTemp.CloneCursor(cdsDados, True);

    // Configura os Fields do cdsTemporário, para utilizar os mesmos GetText's
    for Field in cdsTemp.Fields do
    begin
      if not Assigned(cdsDados.FindField(Field.FieldName)) then
        Continue;

      if Assigned(cdsDados.FindField(Field.FieldName).OnGetText) then
        Field.OnGetText := cdsDados.FindField(Field.FieldName).OnGetText;
      if Field is TNumericField then
        TNumericField(Field).DisplayFormat := TNumericField(cdsDados.FindField(Field.FieldName)).DisplayFormat;
    end;

    iStart := FResizeColumnIndex;
    iStop  := FResizeColumnIndex;
    if FResizeColumnIndex = -1 then
    begin
      iStart := 0;
      iStop  := Pred(Columns.Count);
    end;

    // Percorre a lista de colunas
    for iIndex := iStart to iStop do
    begin
      Column := Columns[iIndex];
      if GetColumnKind(Column) <> ckData then
        Continue;

      // Define o tamanho mínimo como o tamanho do título
      iMaxSize := GetPWithStr(Column.Title.Caption, Column.Title.Font);

      // Passa por todos os registros da grid
      if Assigned(Column.Field) and Assigned(cdsTemp.FindField(Column.Field.FieldName)) then
      begin
        cdsTemp.First;
        while not cdsTemp.Eof do
        begin
          // Obtém a Largura
          iSize := GetPWithStr(cdsTemp.FieldByName(Column.Field.FieldName).DisplayText, Column.Font);
          // Se o tamanho do texto da grid for maior que o texto anterior, obtem o novo tamanho
          if iSize > iMaxSize then
            iMaxSize := iSize;
          // Vai para o próximo registro
          cdsTemp.Next;
        end;
      end;
      // Define o tamanho
      if (iMaxSize + 10) <> GetColumnWidth(Column) then
        SetColumnWidth(Column, iMaxSize + 10);
    end;
  finally
    FResizeColumn      := False;
    FResizeColumnIndex := -1;
    // Limpa o cds Temporário da memória
    FreeAndNil(cdsTemp);
  end;
end;

function TDBGrid.DoEGBeginMove(CellHit: TGridCoord; X, Y: Integer): Boolean;
begin
  Result :=
    (not (FGridState = gsColSizing)) and
    (not ((CellHit.X >= FixedCols) and (CellHit.Y >= FixedRows))) and
    ((CellHit.Y >= 0) and (CellHit.Y < FixedRows) and (CellHit.X >= FixedCols));

  if Result then
    FMovingKind := TMovingKind.mkStarting
  else
    FMovingKind := TMovingKind.mkNone;
end;

procedure TDBGrid.DoEGMove(X, Y: Integer);
var
  CellHit: TGridCoord;
  bStartMove: Boolean;
begin
  if FMovingKind = TMovingKind.mkNone then
    Exit;

  if FMovingKind = TMovingKind.mkStarting then
  begin
    CellHit := Self.MouseCoord(X, Y);
    if MouseInGroup then
      bStartMove := EGBeginMoveGroupTitle(CellHit, X, Y)
    else
      bStartMove := EGBeginMoveColumn(CellHit, X, Y);
    if not bStartMove then
    begin
      FMovingKind := TMovingKind.mkNone;
      Exit;
    end;
    Invalidate;
    Repaint;
    Application.ProcessMessages;
  end;

  case FMovingKind of
    TMovingKind.mkColumn: EGMoveColumn(X, Y);
    TMovingKind.mkGroup : EGMoveGroupTitle(X, Y);
  end;
end;

function TDBGrid.DoEGMoveScrollH(var gcCellHit: TGridCoord; var DrawInfo: TGridDrawInfo): Boolean;
begin
  if gcCellHit.X < DrawInfo.Horz.FirstGridCell then
  begin
    if gcCellHit.X > DrawInfo.Horz.FixedCellCount then
    begin
      // Envia mensagem de Scroll pro DBGrid (Evendo Padrão em Vcl.Grids.TCustomGrid)
      SendMessage(Self.Handle, WM_HSCROLL, SB_LINEUP, 0);
      // Atualiza a Pintura
      Repaint;
      // Atualiza Bitmap do Canvas do DBGrid
      GetCanvasBitmap;
      // Atualiza as Medidas
      CalcDrawInfo(DrawInfo);
    end;
    gcCellHit.X := DrawInfo.Horz.FirstGridCell;
    Exit(False);
  end
  else
  if (gcCellHit.X > DrawInfo.Horz.LastFullVisibleCell) and (DrawInfo.Horz.LastFullVisibleCell < Pred(DrawInfo.Horz.GridCellCount)) then
  begin
    if (gcCellHit.X >= DrawInfo.Horz.LastFullVisibleCell) and (gcCellHit.X < Pred(DrawInfo.Horz.GridCellCount)) then
    begin
      // Envia mensagem de Scroll pro DBGrid (Evendo Padrão em Vcl.Grids.TCustomGrid)
      SendMessage(Self.Handle, WM_HSCROLL, SB_LINEDOWN, 0);
      // Atualiza a Pintura
      Repaint;
      // Atualiza Bitmap do Canvas do DBGrid
      GetCanvasBitmap;
      // Atualiza as Medidas
      CalcDrawInfo(DrawInfo);
    end;
    gcCellHit.X := DrawInfo.Horz.LastFullVisibleCell;
    Exit(False);
  end
  else
  if gcCellHit.X < 0 then
  begin
    case FMovingKind of
      mkColumn: gcCellHit.X := FMoveColumn.X;
      mkGroup : gcCellHit.X := FMoveGroup.GetStartIndex;
    end;
  end;
  Result := True;
end;

procedure TDBGrid.DoEGMoveDraw(X, Y: Integer);
begin
  case FMovingKind of
    TMovingKind.mkColumn: EGMoveColumnDraw(X, Y);
    TMovingKind.mkGroup : EGMoveGroupTitleDraw(X, Y);
  end;
end;

procedure TDBGrid.DoEGEndMove(bMove: Boolean = True);
begin
  case FMovingKind of
    TMovingKind.mkStarting: FMovingKind := TMovingKind.mkNone;
    TMovingKind.mkColumn  : EGEndMoveColumn(bMove);
    TMovingKind.mkGroup   : EGEndMoveGroupTitle(bMove);
  end;
  EGCalcGroupTitleRect;
  Invalidate;
end;

function TDBGrid.EGBeginMoveColumn(CellHit: TGridCoord; X, Y: Integer): Boolean;
begin
  Result := BeginColumnDrag(CellHit.X, CellHit.X, Point(X, Y));
  if not Result then
    Exit;

  // Salva a Posição inicial da Coluna
  FMovingKind         := TMovingKind.mkColumn;
  FMovingDirection    := TMovingDirection.mdNone;
  FMoveColumn         := CellHit;
  FMoveColumnPos      := FMoveColumn;
  FMoveColumnGroup    := GetColumnGroupTitle(Columns[FMoveColumn.X - IndicatorOffset]);
  FMoveColumnGroupPos := FMoveColumnGroup;

  // Obtém Bitmap do Canvas do DBGrid
  GetCanvasBitmap;

  // Obtém a Posição Horizontal do Clique dentro da Coluna
  if (CellHit.X >= 0) and (CellHit.Y >= 0) then
    FClickOffset := X - CellRect(CellHit.X, CellHit.Y).Left;
end;

procedure TDBGrid.EGMoveColumn(X, Y: Integer);
var
  CellHit : TGridCoord;
  DrawInfo: TGridDrawInfo;
  Axis    : TGridAxisDrawInfo;
  rGroup  : TRect;
  iQtd    : Integer;
begin
  // Obtém Medidas de Pintura da Grid
  CalcDrawInfo(DrawInfo);
  Axis := DrawInfo.Horz;
  // Calcula as Coordenadas da Celula
  CellHit := CalcCoordFromPoint(X, Y, DrawInfo);
  // Se não está posicionado sobre a Célula que está sendo movida Obtém o Grupo à qual a Célula Pertence
  if (FMoveColumn.X <> CellHit.X) and (CellHit.X > 0) then
  begin
    if Assigned(FMoveColumnGroup) then
      FMoveColumnGroupPos := GetColumnGroupTitle(Columns[CellHit.X - IndicatorOffset], FMoveColumnGroup.FGroupTitles, False)
    else
      FMoveColumnGroupPos := GetColumnGroupTitle(Columns[CellHit.X - IndicatorOffset], nil, False)
  end
  else
    FMoveColumnGroupPos := nil;

  if (CellHit.X <= DrawInfo.Horz.LastFullVisibleCell + 1) and
     ((CellHit.X <> FMoveColumn.X) or (CellHit.X <> FMoveColumnPos.X)) and
     (not ((CellHit.X = Axis.FixedCellCount) and (X < Axis.FixedBoundary))) and
     (not ((CellHit.X = Axis.GridCellCount - 1) and (X > Axis.GridBoundary))) then
  begin
    iQtd := 0;
    while True do
    begin
      if Assigned(FMoveColumnGroup) and
         (not InRange(CellHit.X - IndicatorOffset, FMoveColumnGroup.GetStartIndex, FMoveColumnGroup.GetEndIndex)) then
      begin
        {
          SITUAÇÃO: Pertence à um Grupo e está fora das margens dele
          SOLUÇÃO :
            ESQUERDA: Posicionar na primeira coluna do Grupo
            DIREITA : Posicionar na útlima coluna do Grupo
        }
        with FMoveColumnGroup.GetRect do
          if X < Left then // Está À ESQUERDA do Grupo
            CellHit.X := FMoveColumnGroup.GetStartIndex + IndicatorOffset // Posiciona na primeira coluna do grupo
          else
          if X > Right then // Está À DIREITA do Grupo
            CellHit.X := FMoveColumnGroup.GetEndIndex + IndicatorOffset; // Posiciona na última coluna do grupo
      end
      else
      if Assigned(FMoveColumnGroupPos) and (FMoveColumnGroup <> FMoveColumnGroupPos) and
         InRange(CellHit.X - IndicatorOffset, FMoveColumnGroupPos.GetStartIndex, FMoveColumnGroupPos.GetEndIndex) then
      begin
        {
          SITUAÇÃO: Está dentro das margens de um grupo "irmão"
          SOLUÇÃO :
            ESQUERDA: Posicionar na primeira coluna do Grupo
            DIREITA : Posicionar na útlima coluna do Grupo
        }
        rGroup := FMoveColumnGroupPos.GetRect;
        if (X - rGroup.Left) < (rGroup.Right - X) then
          CellHit.X := FMoveColumnGroupPos.GetStartIndex + IndicatorOffset + IfThen(FMoveColumn.X < CellHit.X, -1, 0)
        else
          CellHit.X := FMoveColumnGroupPos.GetEndIndex + IndicatorOffset + IfThen(FMoveColumn.X < CellHit.X, 0, 1);
        CellHit.X := CellHit.X;
      end;
      if DoEGMoveScrollH(CellHit, DrawInfo) then
        Break;

      Inc(iQtd);
      if iQtd > (Columns.Count + 20) then
      begin
        ShowMessage('Houve uma falha ao movimentar a coluna!'+ sLineBreak + 'Comunique a T.I!');
        Break;
      end;
    end;

    FMoveColumnPos := CellHit;
    if FMoveColumnPos.X < 1 then
      FMoveColumnPos.X := 1;

    if FMoveColumn.X = FMoveColumnPos.X then
      FMovingDirection := TMovingDirection.mdNone
    else
    if FMoveColumn.X > FMoveColumnPos.X then
      FMovingDirection := TMovingDirection.mdLeft
    else
    if FMoveColumn.X < FMoveColumnPos.X then
      FMovingDirection := TMovingDirection.mdRight;
  end;

  // Define o Tipo do Cursor
  if Screen.Cursor <> crSizeWE then
    Screen.Cursor := crSizeWE;

  // Define o Timer
  if FTimerMoveID = 0 then
  begin
    FTimerMoveID := RandomRange(200, 300);
    SetTimer(Self.Handle, FTimerMoveID, 30, nil);
  end;

  // Atualiza a Pintura
  DoEGMoveDraw(X, Y);
end;

procedure TDBGrid.EGMoveColumnDraw(X, Y: Integer);
var
  bmp        : TBitmap;
  GPGraphic  : TGPGraphics;
  GPBrush    : TGPSolidBrush;
  GPPen      : TGPPen;
  CellRect   : TRect;
  Grouprect  : TRect;
  iLeft      : Integer;
  iCellHeight: Integer;
begin
  // Cria um bitmap para Copiar o bitmap Original do Canvas do DBGrid
  bmp := TBitmap.Create;
  // Obtém o Bitmap Original
  bmp.Assign(FBitmap);
  // Cria um TGPGraphics que irá desenhar no bmp
  GPGraphic := TGPGraphics.Create(bmp.Canvas.Handle);
  GPBrush   := TGPSolidBrush.Create(aclWhite);
  GPPen     := TGPPen.Create(aclBlue);
  try
    // Define o Modo de Suavização como: Alta Qualidade
    GPGraphic.SetSmoothingMode(SmoothingModeHighQuality);
    // Obtém o Rect da Coluna
    CellRect   := Self.CellRect(FMoveColumnPos.X, FMoveColumnPos.Y);
    // Se está Sob um Grupo
    if Assigned(FMoveColumnGroupPos) and (FMoveColumnGroup <> FMoveColumnGroupPos) then
    begin
      Grouprect := FMoveColumnGroupPos.GetRect;
      if (X - Grouprect.Left) < (Grouprect.Right - X) then
        iLeft := Pred(Grouprect.Left)
      else
        iLeft := Grouprect.Right;
    end
    else // Se não está Sob um Grupo
    begin
      if FMoveColumnPos.X > FMoveColumn.X then
      begin
        if not UseRightToLeftAlignment then
          iLeft := CellRect.Right
        else
          iLeft := Pred(CellRect.Left)
      end
      else
      begin
        if not UseRightToLeftAlignment then
          iLeft := Pred(CellRect.Left)
        else
          iLeft := CellRect.Right;
      end;
    end;

    // Linha Vertical, indicando a nova posição da Grid
    GPPen.SetWidth(1);
    GPGraphic.DrawLine(GPPen, iLeft, 0.0, iLeft, ClientHeight);

    // Obtém o Rect da Celula selecionada
    CellRect        := Self.CellRect(FMoveColumn.X, 0);
    iCellHeight     := CellRect.Height;
    CellRect.Top    := CellRect.Bottom;
    Cellrect.Bottom := CellRect.Top + (ClientHeight - iCellHeight);

    // Retangulo Destacando a coluna que está sendo movida
    GPBrush.SetColor(MakeGDIPColor(clSkyBlue, 75));
    GPGraphic.FillRectangle(GPBrush, CellRect.Left, CellRect.Top, CellRect.Width, Cellrect.Bottom);

    // Retangulo Destacando onde está a coluna, durante a movimentação
    if CellRect.Left <> (X - Abs(FClickOffset)) then
    begin
      GPBrush.SetColor(MakeGDIPColor(clBlack, 25));
      GPGraphic.FillRectangle(GPBrush, X - Abs(FClickOffset), CellRect.Top, CellRect.Width, Cellrect.Bottom);
    end;

    // Desenha o BitMap no Canvas do DBGrid
    Self.Canvas.CopyRect(Rect(0,0, ClientWidth, ClientHeight), bmp.Canvas, Rect(0,0, ClientWidth, ClientHeight));
  finally
    FreeAndNil(GPPen);
    FreeAndNil(GPBrush);
    FreeAndNil(GPGraphic);
    FreeAndNil(bmp);
  end;
end;

procedure TDBGrid.EGEndMoveColumn(bMove: Boolean = True);
var
  FColumnMove: Integer;
  cStart: TColumn;
  cEnd: TColumn;
begin
  if FMovingKind = TMovingKind.mkNone then
    Exit;

  if bMove then
  begin
    // Coluna Desconhecida
    if FMoveColumnPos.X < 0 then
    begin
      // Primeira Coluna
      if FMoveColumnPos.X > FMoveColumn.X then
        FColumnMove := Max(FMoveColumnPos.X, 1)
      else // Ultima Coluna
        FColumnMove := Max(FMoveColumnPos.X, (Columns.Count))
    end
    else
      FColumnMove := FMoveColumnPos.X;

    cStart := nil;
    cEnd   := nil;
    // Se a Coluna está Dentro de um Grupo
    if Assigned(FMoveColumnGroup) then
    begin
      cStart := FMoveColumnGroup.StartColumn;
      cEnd   := FMoveColumnGroup.EndColumn;

      // Se está Movendo a Coluna Inicial
      if FMoveColumnGroup.GetStartIndex = (FMoveColumn.X - IndicatorOffset) then
        cStart := Columns[Min(FMoveColumnGroup.GetStartIndex + IndicatorOffset, FMoveColumnGroup.GetEndIndex)]
      else // Se está Movendo a Coluna Final
      if FMoveColumnGroup.GetEndIndex = (FMoveColumn.X - IndicatorOffset) then
        cEnd := Columns[Max(FMoveColumnGroup.GetEndIndex - IndicatorOffset, FMoveColumnGroup.GetStartIndex)];

      // Se está sendo colocada no Inicio do Grupo Troca a Coluna de Inico
      if FMoveColumnGroup.GetStartIndex = (FColumnMove - IndicatorOffset) then
        cStart := Columns[FMoveColumn.X - IndicatorOffset]
      else // Se está sendo colocada no final do grupo Troca a Coluna do Fim
      if FMoveColumnGroup.GetEndIndex = (FColumnMove - IndicatorOffset) then
        cEnd := Columns[FMoveColumn.X - IndicatorOffset];
    end;

    // Movimenta a Coluna
    MoveColumn(FMoveColumn.X, FColumnMove);

    if Assigned(FMoveColumnGroup) then
    begin
      FMoveColumnGroup.StartColumn := cStart;
      FMoveColumnGroup.EndColumn   := cEnd;
    end;
  end;

  // Encerra o timer
  KillTimer(Self.Handle, FTimerMoveID);
  FTimerMoveID := 0;

  FMoveColumnGroup   := nil;
  FMoveColumnGroupPos:= nil;
  // Encerra a Movimentação
  FMovingKind      := TMovingKind.mkNone;
  FMovingDirection := TMovingDirection.mdNone;

  // Define o Tipo do Cursor
  Screen.Cursor := crDefault;

  // Atualiza a Pintura
  Repaint;
end;

function TDBGrid.EGBeginMoveGroupTitle(CellHit: TGridCoord; X, Y: Integer): Boolean;
var
  gtGroup: TGridGroupTitle;
begin
  if FGroupTitles.TryGet(FMousePoint, gtGroup, True) then
    Result := True
  else
    Exit(False);

  FMovingKind         := TMovingKind.mkGroup; // Tipo de Movimentação: Grupo
  FMoveGroup          := gtGroup; // Grupo que será movimentado
  FMoveGroupOwner     := FMoveGroup.OwnerGroup; // Grupo Raiz do Grupo que será moviementado
  FMoveGroupPos       := FMoveGroup; // Grupo onde o mouse está posicionado (Irmão de FMoveGroup)
  FMoveGroupColumnPos := CellHit; // Coordenadas da coluna que o mouse está posicionado

  // Obtém Bitmap do Canvas do DBGrid
  GetCanvasBitmap;

  // Obtém a Posição Horizontal do Clique dentro da Coluna
  if (CellHit.X >= 0) and (CellHit.Y >= 0) then
    FClickOffset := X - gtGroup.GetRect.Left;
end;

procedure TDBGrid.EGMoveGroupTitle(X, Y: Integer);
var
  CellHit : TGridCoord;
  DrawInfo: TGridDrawInfo;
  Axis    : TGridAxisDrawInfo;
  rGroup  : TRect;
  iQtd    : Integer;
begin
  // Obtém Medidas de Pintura da Grid
  CalcDrawInfo(DrawInfo);
  Axis := DrawInfo.Horz;

  // Calcula as Coordenadas da Celula
  CellHit := CalcCoordFromPoint(X, Y, DrawInfo);
  // Se não está posicionado sobre a Célula que está sendo movida Obtém o Grupo à qual a Célula Pertence
  if (FMoveGroupColumnPos.X <> CellHit.X) and (CellHit.X > 0) then
    FMoveGroupPos := GetColumnGroupTitle(Columns[CellHit.X - IndicatorOffset])
  else
    FMoveGroupPos := nil;

  // Deve ser uma coluna
  if (CellHit.X <= DrawInfo.Horz.LastFullVisibleCell + 1) and
     (not ((CellHit.X = Axis.FixedCellCount) and (X < Axis.FixedBoundary))) and
     (not ((CellHit.X = Axis.GridCellCount - 1) and (X > Axis.GridBoundary))) then
  begin
    iQtd := 0;
    while True do
    begin
      // Se estiver dentro dele mesmo
      if InRange(CellHit.X - IndicatorOffset, FMoveGroup.GetStartIndex, FMoveGroup.GetEndIndex) then
      begin
        {
          SITUAÇÃO: O mouse está se movendo dentro do espaço do grupo que está sendo movido
          SOLUÇÃO :
            ESQUERDA: Posicionar no Início
            DIREITA : Posicionar no Final + 1
        }
        rGroup := FMoveGroup.GetRect;
        if (X - rGroup.Left) < (rGroup.Right - X) then
          CellHit.X := FMoveGroup.GetStartIndex + IndicatorOffset
        else
          CellHit.X := FMoveGroup.GetEndIndex + IndicatorOffset + 1;
      end
      else // Se o Grupo é um Sub-Grupo, valida se está dentro das margens do Grupo Pai
      if Assigned(FMoveGroupOwner) and
         (not InRange(CellHit.X - IndicatorOffset, FMoveGroupOwner.GetStartIndex, FMoveGroupOwner.GetEndIndex)) then
      begin
        {
          SITUAÇÃO: O grupo é um Sub-Grupo, e o mouse está se movendo fora do espaço do Grupo Raiz
          SOLUÇÃO :
            ESQUERDA: Posicionar no Início
            DIREITA : Posicionar no Final + 1
        }
        rGroup := FMoveGroupOwner.GetRect;
        if X < rGroup.Left then
          CellHit.X := FMoveGroupOwner.GetStartIndex + IndicatorOffset
        else
        if X > rGroup.Right then
          CellHit.X := FMoveGroupOwner.GetEndIndex + IndicatorOffset + 1;
      end
      else // Se estiver Sobre um Sub-Grupo Irmão
      if Assigned(FMoveGroupPos) and (FMoveGroupPos <> FMoveGroupOwner) and
         InRange(CellHit.X - IndicatorOffset, FMoveGroupPos.GetStartIndex, FMoveGroupPos.GetEndIndex) then
      begin
        {
          SITUAÇÃO: O mouse está se movendo dentro do espaço de um grupo irmão
          SOLUÇÃO :
            ESQUERDA: Posicionar no Início
            DIREITA : Posicionar no Final + 1
        }
        rGroup := FMoveGroupPos.GetRect;
        if (X - rGroup.Left) < (rGroup.Right - X) then
          CellHit.X := FMoveGroupPos.GetStartIndex + IndicatorOffset
        else
          CellHit.X := FMoveGroupPos.GetEndIndex + IndicatorOffset + 1;
      end;
      if DoEGMoveScrollH(CellHit, DrawInfo) then
        Break;

      Inc(iQtd);
      if iQtd > (Columns.Count + 20) then
      begin
        ShowMessage('Houve uma falha ao movimentar a coluna!'+ sLineBreak + 'Comunique a T.I!');
        Break;
      end;
    end;

    FMoveGroupColumnPos := CellHit;
    if FMoveGroupColumnPos.X < 1 then
      FMoveGroupColumnPos.X := 1;

    if FMoveGroup.GetStartIndex = (FMoveGroupColumnPos.X - IndicatorOffset) then
      FMovingDirection := TMovingDirection.mdNone
    else
    if FMoveGroup.GetStartIndex > (FMoveGroupColumnPos.X - IndicatorOffset) then
      FMovingDirection := TMovingDirection.mdLeft
    else
    if FMoveGroup.GetEndIndex < (FMoveGroupColumnPos.X - IndicatorOffset) then
      FMovingDirection := TMovingDirection.mdRight
  end;

  // Define o Tipo do Cursor
  if Screen.Cursor <> crSizeWE then
    Screen.Cursor := crSizeWE;

  // Define o Timer
  if FTimerMoveID = 0 then
  begin
    FTimerMoveID := RandomRange(200, 300);
    SetTimer(Self.Handle, FTimerMoveID, 30, nil);
  end;

  // Atualiza a Pintura
  DoEGMoveDraw(X, Y);
end;

procedure TDBGrid.EGMoveGroupTitleDraw(X, Y: Integer);
var
  bmp         : TBitmap;
  GPGraphic   : TGPGraphics;
  GPBrush     : TGPSolidBrush;
  GPPen       : TGPPen;
  rCell       : TRect;
  rGroup      : TRect;
  iLeft       : Integer;
  iGroupHeight: Integer;
begin
  // Cria um bitmap para Copiar o bitmap Original do Canvas do DBGrid
  bmp := TBitmap.Create;
  // Obtém o Bitmap Original
  bmp.Assign(FBitmap);
  // Cria um TGPGraphics que irá desenhar no bmp
  GPGraphic := TGPGraphics.Create(bmp.Canvas.Handle);
  GPBrush   := TGPSolidBrush.Create(aclWhite);
  GPPen     := TGPPen.Create(aclBlue);
  try
    // Define o Modo de Suavização como: Alta Qualidade
    GPGraphic.SetSmoothingMode(SmoothingModeHighQuality);

    // Obtém o Rect da Celula e do Grupo
    rCell  := CellRect(FMoveGroupColumnPos.X, FMoveGroupColumnPos.Y);
    rGroup := FMoveGroup.GetRect;

    // Verifica se exibirá a Linha na lateral esquerda ou direita do Grupo
    if (FMoveGroupColumnPos.X - IndicatorOffset) > FMoveGroup.GetStartIndex then
    begin
      if not UseRightToLeftAlignment then
        iLeft := rCell.Left
      else
        iLeft := Pred(rCell.Right)
    end
    else
    begin
      if not UseRightToLeftAlignment then
        iLeft := Pred(rCell.Left)
      else
        iLeft := rCell.Right;
    end;

    // Linha Vertical, indicando a nova posição da Grid
    GPPen.SetWidth(1);
    GPGraphic.DrawLine(GPPen, iLeft, 0.0, iLeft, ClientHeight);

    // Obtém o Rect do Grupo
    iGroupHeight  := Self.CellRect(FMoveGroup.GetStartIndex, 0).Height;
    rGroup.Top    := rGroup.Bottom;
    rGroup.Bottom := rGroup.Top + (ClientHeight - iGroupHeight);

    // Retangulo Destacando a coluna que está sendo movida
    GPBrush.SetColor(MakeGDIPColor(clSkyBlue, 75));
    GPGraphic.FillRectangle(GPBrush, rGroup.Left, rGroup.Top, rGroup.Width, rGroup.Bottom);

    // Retangulo Destacando onde está a coluna, durante a movimentação
    if rGroup.Left <> (X - Abs(FClickOffset)) then
    begin
      GPBrush.SetColor(MakeGDIPColor(clBlack, 25));
      GPGraphic.FillRectangle(GPBrush, X - Abs(FClickOffset), rGroup.Top, rGroup.Width, rGroup.Bottom);
    end;

    // Desenha o BitMap no Canvas do DBGrid
    Self.Canvas.CopyRect(Rect(0,0, ClientWidth, ClientHeight), bmp.Canvas, Rect(0,0, ClientWidth, ClientHeight));
  finally
    FreeAndNil(GPPen);
    FreeAndNil(GPBrush);
    FreeAndNil(GPGraphic);
    FreeAndNil(bmp);
  end;
end;

procedure TDBGrid.EGEndMoveGroupTitle(bMove: Boolean = True);
var
  bNeedMove: Boolean;
  bCanMove: Boolean;
  cStart: TColumn;
  cEnd: TColumn;
begin
  if FMovingKind = TMovingKind.mkNone then
    Exit;

  case FMovingDirection of
    TMovingDirection.mdLeft  : bNeedMove := FMoveGroup.GetStartIndex > (FMoveGroupColumnPos.X - IndicatorOffset);
    TMovingDirection.mdRight : bNeedMove :=
      (FMoveGroup.GetEndIndex < (FMoveGroupColumnPos.X - IndicatorOffset)) and
      (FMoveGroup.GetEndIndex <> FMoveGroup.CalcEndIndex(FMoveGroupColumnPos.X)) and
      (FMoveGroup.CalcEndIndex(FMoveGroupColumnPos.X) <= Columns.Count);
  else bNeedMove := False;
  end;

  // Coluna Desconhecida
  if bMove and bNeedMove then
  begin
    bCanMove := bNeedMove;
    cStart   := nil;
    cEnd     := nil;
    if Assigned(FMoveGroupOwner) then
    begin
      {
        SITUAÇÃO: Está movendo um Sub-Grupo, portanto existe um Grupo Raiz (FMoveGroupOwner)
        VALIDAÇÕES: Se está posicionando o Sub-Grupo no INICIO/FIM do Grupo Raiz, utiliza a coluna INICIO/FIM do Sub-Grupo
      }
      cStart   := FMoveGroupOwner.StartColumn;
      cEnd     := FMoveGroupOwner.EndColumn;
      bCanMove :=
        InRange(FMoveGroup.CalcStartIndex(FMoveGroupColumnPos.X), cStart.Index, cEnd.Index) and
        InRange(FMoveGroup.CalcEndIndex(FMoveGroupColumnPos.X), cStart.Index, cEnd.Index);

      if bCanMove then
      begin
        // Se está Movendo o Sub-Grupo para o Inicio
        if FMoveGroupOwner.GetStartIndex = (FMoveGroupColumnPos.X - IndicatorOffset) then
          cStart := FMoveGroup.StartColumn
        else // Se está Movendo o Sub-Grupo para o Final
        if FMoveGroupOwner.GetEndIndex = ((FMoveGroupColumnPos.X - (FMoveGroup.GetEndIndex - FMoveGroup.GetStartIndex)) - IndicatorOffset) then
          cEnd := FMoveGroup.EndColumn;

        // Se está Movendo o Sub-Grupo do Inicio para outro local
        if FMoveGroupOwner.StartColumn = FMoveGroup.StartColumn then
          cStart := Columns[Min(FMoveGroup.GetEndIndex + IndicatorOffset, Pred(Columns.Count))]
        else // Se está Movendo o Sub-Grupo do Fim para outro local
        if FMoveGroupOwner.EndColumn = FMoveGroup.EndColumn then
          cEnd := Columns[Max(FMoveGroup.GetStartIndex - IndicatorOffset, 0)];
      end;
    end;

    // Movimenta o Sub-Grupo
    if bCanMove then
      FMoveGroup.MoveGroup(FMoveGroupColumnPos.X, True);

    if Assigned(FMoveGroupOwner) then
    begin
      FMoveGroupOwner.StartColumn := cStart;
      FMoveGroupOwner.EndColumn   := cEnd;
    end;
  end;

  // Encerra o timer
  KillTimer(Self.Handle, FTimerMoveID);
  FTimerMoveID := 0;
  // Encerra a Movimentação
  FMoveGroup       := nil;
  FMoveGroupOwner  := nil;
  FMoveGroupPos    := nil;
  FMovingKind      := TMovingKind.mkNone;
  FMovingDirection := TMovingDirection.mdNone;

  // Define o Tipo do Cursor
  Screen.Cursor := crDefault;

  // Atualiza a Pintura
  Repaint;
end;

function TDBGrid.CalcCoordFromPoint(X, Y: Integer; const DrawInfo: TGridDrawInfo): TGridCoord;

  function DoCalc(const AxisInfo: TGridAxisDrawInfo; N: Integer): Integer;
  var
    I, Start, Stop: Longint;
    Line: Integer;
  begin
    with AxisInfo do
    begin
      if N < FixedBoundary then
      begin
        Start := 0;
        Stop :=  FixedCellCount - 1;
        Line := 0;
      end
      else
      begin
        Start := FirstGridCell;
        Stop := GridCellCount - 1;
        Line := FixedBoundary;
      end;
      Result := -1;
      for I := Start to Stop do
      begin
        Inc(Line, AxisInfo.GetExtent(I) + EffectiveLineWidth);
        if N < Line then
        begin
          Result := I;
          Exit;
        end;
      end;
    end;
  end;

  function DoCalcRightToLeft(const AxisInfo: TGridAxisDrawInfo; N: Integer): Integer;
  begin
    N := ClientWidth - N;
    Result := DoCalc(AxisInfo, N);
  end;

begin
  { Calcular as Coordenadas a partir de um Ponto de Pixel }

  if not UseRightToLeftAlignment then
    Result.X := DoCalc(DrawInfo.Horz, X)
  else
    Result.X := DoCalcRightToLeft(DrawInfo.Horz, X);
  Result.Y := DoCalc(DrawInfo.Vert, Y);
end;

procedure TDBGrid.BeginLocate;
begin
  if not FLocateActive then
    Exit;

  if Assigned(FLocateText) then
    EndLocate;

  FLocateText := TLocateText.BeginLocate(Self);
  FTimerLocateID := RandomRange(300, 400);
  SetTimer(Self.Handle, FTimerLocateID, 15, nil);
end;

procedure TDBGrid.HighlightLocate(rText: TRect; const CustomCanvas: TCustomGridCanvas);
var
  cColor : TColor;
  Column : TColumn;
  sDText : String;
  sRemain: string;
  sText  : String;
  iPos   : Integer;
  iLeft  : Integer;
  iTop   : Integer;
  iTPos  : Integer;
  sT: string;
begin
  // Se não estiver localizando um Texto
  if not Assigned(FLocateText) then
    Exit;

  // Verifica se existe
  Column := CustomCanvas.Column;
  if GetColumnKind(Column) = ckNone then
    Exit;

  // Obtém o Texto que está sendo pesquisado
  sText        := UpperCase(FLocateText.edtText.Text);
  // Obtém o Texto que está sendo exibido na Grid
  sDText := Column.Field.DisplayText;

  // Verifica se contém o Texto
  if not ContainsStr(sDText, sText) then
    Exit;

  // Salva a cor do Canvas
  cColor := Self.Canvas.Brush.Color;
  try
    // Inicializa as Variaveis
    iTPos   := 0;
    iTop    := rText.Top;
    sRemain := sDText;

    // Enquanto encontrar o texto procurado na Grid
    while Pos(sText, Copy(sRemain, 1, sRemain.Length)) > 0 do
    begin
      // Obtém a posição do texto
      iPos := Pos(sText, sRemain);
      // Atualiza a posição geral do texto
      if sDText.Equals(sRemain) then
        Inc(iTPos, Pred(iPos))
      else
        Inc(iTPos, sText.Length + Pred(iPos));

      // Extrai do texto original, o texto anterior ao texto pesquisado
      sT := Copy(sDText, 1, iTPos);
      // Atualiza a posição do texto no Rect
      iLeft := rText.Left + Self.Canvas.TextWidth(sT);

      // Se for o "texto atual"
      if (Succ(iTPos)    = FLocateText.TextPos) and
         (FDrawingCell.Y = FLocateText.CellPos.Y) and
         (FDrawingCell.X = FLocateText.CellPos.X)
          then
        Self.Canvas.Brush.Color := clWebOrange
      else // Qualquer outra combinação compatível
        Self.Canvas.Brush.Color := clWebYellow;

      // Desenha o texto com o fundo destacado
      Self.Canvas.TextOut(iLeft, iTop, sText);
      // Atualiza o Texto restante
      sRemain := Copy(sRemain, iPos + sText.Length, sRemain.Length);
    end;
  finally
    // Reseta a cor Original
    Self.Canvas.Brush.Color := cColor;
  end;
end;

procedure TDBGrid.EndLocate;
begin
  if Assigned(FLocateText) then
  begin
    FreeAndNil(FLocateText);
    Repaint;
  end;
end;

function TDBGrid.AcquireFocus: Boolean;
begin
  Result := True;
  if FAcquireFocus and CanFocus and not (csDesigning in ComponentState) then
  begin
    SetFocus;
    Result := Focused or (InplaceEditor <> nil) and TCustomControl(InplaceEditor).Focused;
  end;
end;

procedure TDBGrid.GetCanvasBitmap;
var
  R: TRect;
begin
  if Assigned(FBitmap) then
    FreeAndNil(FBitmap);

  // Calcula o Rect
  R := Rect(0,0, ClientWidth, ClientHeight);

  // Obtém Bitmap do Canvas do DBGrid
  FBitmap := TBitmap.Create;
  FBitmap.Width  := ClientWidth;
  FBitmap.Height := ClientHeight;
  FBitmap.Canvas.CopyRect(R, Self.Canvas, R);
end;

procedure TDBGrid.ExibirLegenda;
begin
  TSemaforoView.ShowSemaforo(FSemaforos);
end;

procedure TDBGrid.UpdateScrollBar;
begin
  // Verifica se deve exibir ScrollBar
  if not (ScrollBars in [ssNone]) then
    inherited;
end;

function TDBGrid.GetColumnOrdering(Column: TColumn): TColumnOrdering;
var
  cds: TClientDataSet;
  iIndex: Integer;
begin
  Result := coNone;

  // Verifica se está assinado
  if not Assigned(Column.Field) or not Assigned(Column.Field.DataSet) or not (Column.Field.DataSet is TClientDataSet)then
    Exit;

  // Obtem o DataSet
  cds := TClientDataSet(Column.Field.DataSet);

  // Localiza o Indice
  iIndex := cds.IndexDefs.IndexOf(cds.IndexName);

  // Se não encontrou sai do procedimento
  if iIndex = -1 then
    Exit;

  with cds.IndexDefs[iIndex] do
  begin
    if ColumnInOrderStr(Column.FieldName, DescFields) then
      Result := coDesc
    else
    if ColumnInOrderStr(Column.FieldName, Fields) then
    begin
      if DescFields.IsEmpty and (ixDescending in Options) then
        Result := coDesc
      else
        Result := coAsc;
    end;
  end;
end;

function TDBGrid.GetOrderingIndicator(Ordering: TColumnOrdering): TPngImage;
var
  GPBitmap : TGPBitmap;
  GPGraphic: TGPGraphics;
  GPBrush  : TGPSolidBrush;
  GPPoints : Array of TGPPoint;
  Encoder  : TGUID;
  MSOutput : TStringStream;
  MSPng    : TStringStream;
begin
  if Ordering = coNone then
    Exit(nil);
  Result := TPngImage.Create;
  if (Ordering = coAsc) and Assigned(FAscIndicator) then
  begin
    Result.Assign(FAscIndicator);
    Exit;
  end
  else
  if (Ordering = coDesc) and Assigned(FDescIndicator) then
  begin
    Result.Assign(FDescIndicator);
    Exit;
  end;

  // Prepara os Points
  if Ordering = coAsc then
    GPPoints := [MakePoint(0, 6), MakePoint(8, 6), MakePoint(4, 0)]
  else
    GPPoints := [MakePoint(0, 0), MakePoint(8, 0), MakePoint(4, 6)];

  GPBitmap  := TGPBitmap.Create(8, 7, PixelFormat32bppARGB); // Cria um TGPBitmap com transparência Alpha
  GPGraphic := TGPGraphics.Create(GPBitmap);
  GPBrush   := TGPSolidBrush.Create(MakeGDIPColor(clHighlight, 255));
  try
    GPGraphic.SetSmoothingMode(SmoothingModeHighQuality);
    GPGraphic.FillPolygon(GPBrush, PGPPoint(@GPPoints[0]), Length(GPPoints));
    MSOutput := TStringStream.Create;
    try
      if GetEncoderClsid('image/png', Encoder) <> -1 then
      begin
        GPBitmap.Save(TStreamAdapter.Create(MSOutput as TStringStream) , Encoder);
        MSOutput.Position := 0;
        MSPng := TStringStream.Create(MSOutput.DataString);
        try
          MSPng.Position := 0;
          Result.LoadFromStream(MSPng);
        finally
          FreeAndNil(MSPng);
        end;
      end;
    finally
      FreeAndNil(MSOutput);
    end;
    case Ordering of
      coAsc:
      begin
        FAscIndicator := TPngImage.Create;
        FAscIndicator.Assign(Result);
      end;
      coDesc:
      begin
        FDescIndicator := TPngImage.Create;
        FDescIndicator.Assign(Result);
      end;
    end;
  finally
    FreeAndNil(GPBitmap);
    FreeAndNil(GPBrush);
    FreeAndNil(GPGraphic);
  end;
end;

function TDBGrid.Group(sOrderField: String = ''): TDBGrid;
begin
  Result := Self;

  if not Assigned(DataSource.DataSet) or not (DataSource.DataSet is TClientDataSet) then
    RaiseGrid('Permitido agrupamento somente para TClientDataSet');

  if not Assigned(TClientDataSet(DataSource.DataSet).FindField('GRUPO')) then
    RaiseGrid('Campo "GRUPO" não encontrado!');

  if not Assigned(TClientDataSet(DataSource.DataSet).FindField('TIPO')) then
    RaiseGrid('Campo "TIPO" não encontrado!');

  if not Assigned(TClientDataSet(DataSource.DataSet).FindField('STATUS')) then
    RaiseGrid('Campo "STATUS" não encontrado!');

  Semaforo('GRUPO')
    .SetMethodRules(GroupMethodRules)
    .Add(GetGroupButtons(TGroupButtons.btExpand),  0, 'Expandir')
    .Add(GetGroupButtons(TGroupButtons.btRetract), 1, 'Recolher');

  Options := Options - [dgTitleClick];

  with TClientDataSet(DataSource.DataSet) do
  begin
    with IndexDefs.AddIndexDef do
    begin
      Name    := 'GROUPORDER';
      Fields  := 'GRUPO;TIPO'+ IfThen(not sOrderField.IsEmpty, ';'+ sOrderField);
      Options := [];
    end;
    IndexName := 'GROUPORDER';

    Filtered := False;
    Filter   := 'STATUS = 1';
    Filtered := True;
  end;

  FIsGroupRow := True;
end;

procedure TDBGrid.GroupMethodRules(var Value: Variant);
var
  cdsClone : TClientDataSet;
begin
  Value := -1;
  if TClientDataSet(DataSource.DataSet).IsEmpty then
    Exit;

  case TClientDataSet(DataSource.DataSet).FieldByName('TIPO').AsInteger of
    0:
    begin
      cdsClone := TClientDataSet.Create(nil);
      try
        cdsClone.CloneCursor(TClientDataSet(DataSource.DataSet), False);
        cdsClone.Filtered := False;
        cdsClone.Filter   := 'GRUPO = '+ TClientDataSet(DataSource.DataSet).FieldByName('GRUPO').AsString +' AND TIPO = 1';
        cdsClone.Filtered := True;

        if cdsClone.RecordCount > 0 then
          Value := 0
        else
          Value := 1;
      finally
        FreeAndNil(cdsClone);
      end;
    end;
  end;
end;

procedure TDBGrid.GroupCellClick(Column: TColumn);
var
  mark: TBookmark;
  iGrupo: Integer;
begin
  with TClientDataSet(DataSource.DataSet) do
  begin
    if IsEmpty then
      Exit;

    if RecordCount = 0 then
      Exit;

    if not Column.FieldName.Equals('GRUPO') or not (FieldByName('TIPO').AsInteger = 0) then
      Exit;

    iGrupo := FieldByName('GRUPO').AsInteger;

    mark := GetBookmark;
    DisableControls;
    try
      Filtered := False;
      Filter   := 'GRUPO = '+ iGrupo.ToString +' AND TIPO = 1';
      Filtered := True;

      First;
      while not Eof do
      begin
        Edit;

        if FieldByName('STATUS').AsInteger = 0 then
          FieldByName('STATUS').AsInteger := 1
        else
          FieldByName('STATUS').AsInteger := 0;

        Next;
      end;
    finally
      Filtered := False;
      Filter   := 'STATUS = 1';
      Filtered := True;
      if BookmarkValid(mark) then
        GotoBookmark(mark);
      EnableControls;
    end;
  end;
end;

function TDBGrid.GetGroupButtons(btType: TGroupButtons): TBitmap;
var
  GPGraphic: TGPGraphics;
  GPBrush  : TGPSolidBrush;
  GPPen    : TGPPen;
  p: Pointer;
begin
  // Cria o Bitmap
  Result := TBitmap.Create;

  // Prepara o Bitmap
  Result.PixelFormat   := pf32Bit;
  Result.Width         := 16;
  Result.Height        := 16;
  Result.HandleType    := bmDIB;
  Result.ignorepalette := true;
  Result.alphaformat   := afPremultiplied;

  // Limpa todos Scanlines
  p := Result.ScanLine[Result.Height - 1];
  ZeroMemory(p, Result.Width * Result.Height * 4);

  GPGraphic := TGPGraphics.Create(Result.Canvas.Handle);
  GPBrush   := TGPSolidBrush.Create(aclWhite);
  GPPen     := TGPPen.Create(aclBlack);
  try
    GPGraphic.SetSmoothingMode(SmoothingModeHighQuality);
    case btType of
      btExpand: // -
      begin
        GPGraphic.DrawLine(GPPen, 3, 3, 12, 3);
        GPGraphic.DrawLine(GPPen, 12, 3, 12, 12);
        GPGraphic.DrawLine(GPPen, 12, 12, 3, 12);
        GPGraphic.DrawLine(GPPen, 3, 12, 3 , 3);

        GPGraphic.DrawLine(GPPen, 5, 7.5, 10, 7.5);
      end;
      btRetract: // +
      begin
        GPGraphic.DrawLine(GPPen, 3, 3, 12, 3);
        GPGraphic.DrawLine(GPPen, 12, 3, 12, 12);
        GPGraphic.DrawLine(GPPen, 12, 12, 3, 12);
        GPGraphic.DrawLine(GPPen, 3, 12, 3 , 3);

        GPGraphic.DrawLine(GPPen, 7.5, 5, 7.5, 10);
        GPGraphic.DrawLine(GPPen, 5, 7.5, 10, 7.5);
      end;
    end;
  finally
    FreeAndNil(GPPen);
    FreeAndNil(GPBrush);
    FreeAndNil(GPGraphic);
  end;
end;

function TDBGrid.ColumnInOrderStr(sField, sList: String): Boolean;
begin
  // Verifica se a coluna atual está sendo ordenada
  Result := IndexStr(sField, SplitString(sList, ';')) >= 0;
end;

function TDBGrid.GetColumnByFieldName(sFieldName: String): TColumn;
var
  col: TCollectionItem;
begin
  Result := nil;
  for col in Self.Columns do
    if TColumn(col).FieldName = sFieldName then
      Exit(TColumn(col));
end;

function TDBGrid.GetColumnKind(Column: TColumn): TColumnKind;
var
  oSemaforo: TSemaforo;
  pProgress: TProgresso;
begin
  Result := ckNone;
  // Verifica se está assinado
  if not Assigned(Column) then
    Exit;

  // Verifica se tem campo
  if Assigned(Column.Field) then
    Result := ckData;

  // Check
  if Assigned(FCheck) and Column.FieldName.Equals(FCheck.FieldName) then
  begin
    Result := ckCheck;
    Exit;
  end;

  // Progresso
  for pProgress in FProgress do
    if Column.FieldName.Equals(pProgress.FieldName) then
      Exit(ckProgress);

  // Semáforo
  for oSemaforo in FSemaforos do
    if oSemaforo.FieldName.Equals(Column.FieldName) then
      Exit(ckSemaforo);
end;

class function TDBGrid.MakeGDIPColor(C: TColor; Alpha: Byte): Cardinal;
var
  tmpRGB : TColorRef;
begin
  tmpRGB := ColorToRGB(C);
  Result := ((DWORD(GetBValue(tmpRGB)) shl  BlueShift) or
             (DWORD(GetGValue(tmpRGB)) shl GreenShift) or
             (DWORD(GetRValue(tmpRGB)) shl   RedShift) or
             (DWORD(Alpha) shl AlphaShift));
end;

procedure TDBGrid.SetColumnWidth(Column: TColumn; iWidth: Integer = 0);
var
  cOldFont: TFont;
begin
  // Foi nescessário essa função pois se a Largura da Coluna não foi alterada,
  //   a função SetWidth do TColumn altera a Fonte da Grid
  // Obtém o Kind da Coluna e Verifica se existe uma largura padrão para ela
  case GetColumnKind(Column) of
    ckCheck    : iWidth := 19;
    ckSemaforo : iWidth := 18;
  end;
  if iWidth = 0 then
    Exit;

  // Verifica se a largura é igual à atual, se sim, finaliza o procedimento
  if GetColumnWidth(Column) = iWidth then
    Exit;

  // Cria o Brush e a Font Auxiliar
  cOldFont := TFont.Create;
  try
    // Armazena o Brush e a Font atual da Grid
    cOldFont.Assign(Self.Canvas.Font);
    // Define a Largura da Coluna
    Column.Width := iWidth;
    // Reseta o Brush e a Font da Grid
    Self.Canvas.Font.Assign(cOldFont);
  finally
    FreeAndNil(cOldFont);
  end;
end;

function TDBGrid.GetColumnWidth(Column: TColumn): Integer;
var
  cOldFont: TFont;
begin
  // Foi nescessário essa função pois se a Largura da Coluna não foi alterada,
  //   a função GetWidth do TColumn altera a Fonte da Grid
  // Cria a Font Auxiliar
  cOldFont := TFont.Create;
  try
    // Armazena a Font atual da Grid
    cOldFont.Assign(Self.Canvas.Font);
    // Obtém a Largura da Coluna
    Result := Column.Width;
    // Reseta a Font da Grid
    Self.Canvas.Font.Assign(cOldFont);
  finally
    FreeAndNil(cOldFont);
  end;
end;

procedure TDBGrid.OnActivateApplication(Sender: TObject);
begin
  if Assigned(Self) then
    Invalidate;
end;

procedure TDBGrid.OnDeactivateApplication(Sender: TObject);
begin
  if Assigned(Self) then
    Invalidate;
end;

function TDBGrid.OrderBy(sFieldsExp: String): TDBGrid;
var
  sField: String;
  cCol: TColumn;
  cOrderAtual: TColumnOrdering;
  cOrderNova: TColumnOrdering;
  I: Integer;
begin
  Result := Self;

  // Passa por todos fields do dataset removendo ordenação
  for I := 0 to Pred(DataSource.DataSet.Fields.Count) do
  begin
    // Obtem coluna atual
    cCol := GetColumnByFieldName(DataSource.DataSet.Fields[I].FieldName);

    // Verifica se tem o field
    if not Assigned(cCol) then
      Continue;

    // Obtem ordenação atual
    cOrderAtual := GetColumnOrdering(cCol);

    // Faz a ordenação
    if cOrderAtual = coDesc then
      Self.TitleClick(cCol)
    else
    if cOrderAtual = coAsc then
    begin
      Self.TitleClick(cCol);
      Self.TitleClick(cCol);
    end;
  end;

  // Passa por todos fields informados inserindo nova ordenação
  for sField in SplitString(sFieldsExp, ',') do
  begin
    // Obtem a ordenação que ficará
    if sField.Trim.Contains(' DESC') then
      cOrderNova := coDesc
    else
      cOrderNova := coAsc;

    // Obtem coluna atual
    cCol := GetColumnByFieldName(sField.Replace(' ASC', EmptyStr).Replace(' DESC', EmptyStr));

    // Verifica se tem o field
    if not Assigned(cCol) then
      Continue;

    // Obtem ordenação atual
    cOrderAtual := GetColumnOrdering(cCol);

    // Verifica se precisa ordenar
    if cOrderAtual = cOrderNova then
      Continue;

    // Faz a ordenação
    if ((cOrderNova = coAsc) and (cOrderAtual = coNone)) or ((cOrderNova = coDesc) and (cOrderAtual = coAsc)) then
      Self.TitleClick(cCol)
    else
    if (cOrderNova = coDesc) and (cOrderAtual = coNone) then
    begin
      Self.TitleClick(cCol);
      Self.TitleClick(cCol);
    end;
  end;
end;

procedure TDBGrid.RaiseGrid(sMessage: String);
begin
  if sMessage.Trim.IsEmpty then
    Exit;

  raise Exception.Create(sMessage + sLineBreak + sLineBreak + 'Erro na TDBGrid: "'+ Self.Name +'"');
end;

function TDBGrid.Highlight: IHighlight;
begin
  if not FIsHighlight then
  begin
    FIsHighlight := True;
    Result := THighlightObject.New(Self);
    Repaint;
  end;
end;

function TDBGrid.MouseInGroup: Boolean;
begin
  Result := FGroupTitles.GroupInPt(FMousePoint, True);
end;

function TDBGrid.GetColumnGroupTitle(cColumn: TColumn; gtGroupList: TList<TGridGroupTitle> = nil; bSubGroups: Boolean = True): TGridGroupTitle;
var
  gtGroupIn: TGridGroupTitle;
begin
  Result := nil;
  if not Assigned(gtGroupList) then
    gtGroupList := FGroupTitles;

  // Percorre a Lista de Grupos
  for gtGroupIn in gtGroupList do
  begin
    // Valida se o Grupo Existe
    if not Assigned(gtGroupIn) then
      Continue;

    if InRange(cColumn.Index, gtGroupIn.GetStartIndex, gtGroupIn.GetEndIndex) then
    begin
      if bSubGroups then
        Result := Self.GetColumnGroupTitle(cColumn, gtGroupIn.FGroupTitles, bSubGroups);

      if Assigned(Result) then
        Exit
      else
        Exit(gtGroupIn);
    end;
  end;
end;

function TDBGrid.EGCellRect(iStartCol, iStartRow: LongInt; iEndCol: LongInt = -1; iEndRow: LongInt = -1): TRect;
begin
  if iEndCol = -1 then
    iEndCol := iStartCol;
  if iEndRow = -1 then
    iEndRow := iStartRow;
  Result := EGBoxRect(iStartCol, iStartRow, iEndCol, iEndRow);
end;

function TDBGrid.EGBoxRect(ALeft, ATop, ARight, ABottom: Longint): TRect;
var
  GridRect: TGridRect;
begin
  GridRect.Left := ALeft;
  GridRect.Right := ARight;
  GridRect.Top := ATop;
  GridRect.Bottom := ABottom;
  EGGridRectToScreenRect(GridRect, Result, False);
end;

procedure TDBGrid.EGGridRectToScreenRect(GridRect: TGridRect; var ScreenRect: TRect; IncludeLine: Boolean);

  function LinePos(const AxisInfo: TGridAxisDrawInfo; Line: Integer): Integer;
  var
    I: Longint;
  begin
    Result := 0;
    // Linha 0 é o Indicador
    if Line = 0 then
      Exit;

    if IndicatorOffset >= 1 then
      Result := AxisInfo.FixedBoundary;

    if Line < AxisInfo.FirstGridCell then
    begin
      for I := Pred(AxisInfo.FirstGridCell) downto Line do
        Dec(Result, AxisInfo.GetExtent(I) + AxisInfo.EffectiveLineWidth);
    end
    else
    if Line > AxisInfo.FirstGridCell then
    begin
      for I := AxisInfo.FirstGridCell to Pred(Line) do
        Inc(Result, AxisInfo.GetExtent(I) + AxisInfo.EffectiveLineWidth);
    end;
  end;

  procedure CalcAxis(const AxisInfo: TGridAxisDrawInfo; GridRectMin, GridRectMax: Integer; var ScreenRectMin, ScreenRectMax: Integer);
  begin
    ScreenRectMin := LinePos(AxisInfo, GridRectMin);
    ScreenRectMax := LinePos(AxisInfo, GridRectMax);
    if ScreenRectMax = 0 then
      ScreenRectMax := ScreenRectMin;
    Inc(ScreenRectMax, AxisInfo.GetExtent(GridRectMax));
    if IncludeLine then
      Inc(ScreenRectMax, AxisInfo.EffectiveLineWidth);
  end;

var
  DrawInfo: TGridDrawInfo;
  Hold: Integer;
begin
  ScreenRect := Rect(0, 0, 0, 0);
  if (GridRect.Left > GridRect.Right) or (GridRect.Top > GridRect.Bottom) then
    Exit;
  CalcDrawInfo(DrawInfo);
  with DrawInfo do
  begin
    CalcAxis(Horz, GridRect.Left, GridRect.Right, ScreenRect.Left, ScreenRect.Right);
    CalcAxis(Vert, GridRect.Top, GridRect.Bottom, ScreenRect.Top, ScreenRect.Bottom);
  end;
  if UseRightToLeftAlignment and (Canvas.CanvasOrientation = coLeftToRight) then
  begin
    Hold := ScreenRect.Left;
    ScreenRect.Left  := ClientWidth - ScreenRect.Right;
    ScreenRect.Right := ClientWidth - Hold;
  end;
end;

procedure TDBGrid.EGCalcGroupTitleRect;
begin
  if FGroupTitles.Count > 0 then
    RowHeights[0] := DefaultRowHeight + FGroupTitles.GetMaxGroupHeight;
end;

procedure TDBGrid.WndProc(var Message: TMessage);
begin
  if Message.Msg = WM_HSCROLL then
  begin
    FGroupTitles.AddState(TGridGroupTitleListStatus.NeedCalcRect);
    FGroupTitles.SetStateAllGroups(TGridGroupTitleState.InvalidateRect);
  end;
  if Message.Msg = WM_VSCROLL then
  begin
    FGroupTitles.AddState(TGridGroupTitleListStatus.NeedCalcRect);
    FGroupTitles.SetStateAllGroups(TGridGroupTitleState.InvalidateRect);
  end;

  inherited WndProc(Message);

  if Message.Msg = WM_HSCROLL then
  begin
    FGroupTitles.AddState(TGridGroupTitleListStatus.NeedCalcRect);
    FGroupTitles.SetStateAllGroups(TGridGroupTitleState.InvalidateRect);
  end;
  if Message.Msg = WM_VSCROLL then
  begin
    FGroupTitles.AddState(TGridGroupTitleListStatus.NeedCalcRect);
    FGroupTitles.SetStateAllGroups(TGridGroupTitleState.InvalidateRect);
  end;
end;

{ TDBGrid.THighlightObject }

class function TDBGrid.THighlightObject.New(AGrid: TDBGrid): IHighlight;
begin
  Result := TDBGrid.THighlightObject.Create;
  TDBGrid.THighlightObject(Result).FGrid := AGrid;
end;

destructor TDBGrid.THighlightObject.Destroy;
begin
  if FGrid.FIsHighlight then
  begin
    FGrid.FIsHighlight := False;
    FGrid.Repaint;
  end;
  inherited;
end;

{ TDBGrid.TCheck }

procedure TDBGrid.TCheck.Check;
var
  bCanCheck : Boolean;
begin
  bCanCheck := True;

  // Evento antes de checar
  if Assigned(Self.FOnBeforeCheck) then
    Self.FOnBeforeCheck(False, bCanCheck);

  // Se pode checar
  if bCanCheck then
  begin
    // Se tem algum registro
    if Self.DBGrid.DataSource.DataSet.RecordCount > 0 then
    begin
      // Marca o registro
      Self.DBGrid.DataSource.DataSet.Edit;
      if Self.DBGrid.DataSource.DataSet.FieldByName(Self.FieldName).AsString.Equals('S') then
        Self.DBGrid.DataSource.DataSet.FieldByName(Self.FieldName).AsString := 'N'
      else
        Self.DBGrid.DataSource.DataSet.FieldByName(Self.FieldName).AsString := 'S';
      Self.DBGrid.DataSource.DataSet.Post;

      // Se tem o evento executa
      if Assigned(Self.FOnAfterCheck) then
        Self.FOnAfterCheck;
    end;
  end;
end;

procedure TDBGrid.TCheck.CheckAll(Column: TColumn);
var
  bMarcar: Boolean;
  bCanCheck: Boolean;
  mark: TBookmark;
begin
  // Se tem algum registro
  if Column.Field.DataSet.RecordCount = 0 then
    Exit;

  // Desabilita os controles
  Column.Field.DataSet.DisableControls;
  try
    // Armazena posição atual do dataset
    mark := Column.Field.DataSet.GetBookmark;

    // Definir se deverá marcar os registros
    bMarcar := Column.Title.Caption.Equals('R') or Column.Title.Caption.Trim.IsEmpty;

    // Passar por todos os registros do dataset
    Column.Field.DataSet.First;
    while not Column.Field.DataSet.Eof do
    begin
      bCanCheck := True;

      // Evento antes de checar o registro atual
      if Assigned(Self.FOnBeforeCheck) then
        Self.FOnBeforeCheck(bMarcar, bCanCheck);

      // Se pode checar
      if bCanCheck then
      begin
        // Marca o registro
        Column.Field.DataSet.Edit;

        // Marcar ou desmarcar todos os registros
        if bMarcar then
          Column.Field.AsString := 'S'
        else
          Column.Field.AsString := 'N';

        Column.Field.DataSet.Post;
      end;

      // Proximo registro
      Column.Field.DataSet.Next;
    end;

    // Se tem o evento executa para todos
    if Assigned(Self.FOnAfterCheck) then
      Self.FOnAfterCheck;

    // Definir qual será o título da coluna
    if bMarcar then
      Column.Title.Caption := 'T'
    else
      Column.Title.Caption := 'R';

    // Volta a posição original antes do check
    if Column.Field.DataSet.BookmarkValid(mark) then
      Column.Field.DataSet.GotoBookmark(mark);
  finally
    // Habilita os controles
    Column.Field.DataSet.EnableControls;
  end;
end;

function TDBGrid.TCheck.OnBeforeCheck(Check: TOnBeforeCheck): TCheck;
begin
  FOnBeforeCheck := Check;
  Result         := Self;
end;

function TDBGrid.TCheck.OnAfterCheck(Check: TOnAfterCheck): TCheck;
begin
  FOnAfterCheck := Check;
  Result        := Self;
end;

{ TDBGrid.TSemaforo }

destructor TDBGrid.TSemaforo.Destroy;
var
  I: Integer;
begin
  // Passa por todas as cores adicionadas
  for I := 0 to High(Cores) do
    if Cores[I].Handle <> 0 then
      FreeAndNil(Cores[I])
    else // Limpa endereço de memória pois ja foi destruido
      Cores[I] := nil;
  // Executa evento padão da classe
  inherited;
end;

function TDBGrid.TSemaforo.Add(clsColor: TColor; aValue: TArray<Variant>; aDescricao: TArray<String>): TSemaforo;
begin
  Add(CriarImagem(MakeGDIPColor(clsColor, 255)), aValue, aDescricao);
  Result := Self;
end;

function TDBGrid.TSemaforo.Add(bmpImage: TBitmap; aValue: TArray<Variant>; aDescricao: TArray<String>): TSemaforo;
var
  I: Integer;
begin
  if High(aValue) <> High(aDescricao) then
    Grid.RaiseGrid('Tamanho da lista de valores diferente das descrições!');
  for I := 0 to High(aValue) do
    Add(bmpImage, aValue[I], aDescricao[I]);
  Result := Self;
end;

function TDBGrid.TSemaforo.Add(clsColor: TColor; Value: Variant; sDescricao: String): TSemaforo;
begin
  Add(CriarImagem(MakeGDIPColor(clsColor, 255)), Value, sDescricao);
  Result := Self;
end;

function TDBGrid.TSemaforo.Add(bmpImage: TBitmap; Value: Variant; sDescricao: String): TSemaforo;
begin
  // Adiciona uma nova posição nos arrays
  SetLength(Cores,      Succ(Length(Cores)));
  SetLength(Valores,    Succ(Length(Valores)));
  SetLength(Descricoes, Succ(Length(Descricoes)));

  // Popula a posição dos arrays com seus respectivos valores
  Cores[Pred(Length(Cores))]           := bmpImage;
  Valores[Pred(Length(Valores))]       := Value;
  Descricoes[Pred(Length(Descricoes))] := sDescricao;

  Result := Self;
end;

function TDBGrid.TSemaforo.Add(Source: TSemaforo): TSemaforo;
var
  I: Integer;
begin
  SetLength(Cores, Length(Source.Cores));
  for I := 0 to High(Source.Cores) do
  begin
    Cores[I] := TBitmap.Create;
    Cores[I].Assign(Source.Cores[I]);
  end;
  Valores    := Copy(Source.Valores,    Low(Source.Valores),    Length(Source.Valores));
  Descricoes := Copy(Source.Descricoes, Low(Source.Descricoes), Length(Source.Descricoes));
  Result := Self;
end;

function TDBGrid.TSemaforo.CriarImagem(GPColor: TGPColor): TBitmap;
var
  GPGraphic: TGPGraphics;
  GPBrush  : TGPSolidBrush;
  GPPen    : TGPPen;
begin
  // Cria o Bitmap
  Result := TBitmap.Create;

  // Prepara o Bitmap
  PrepareBMP(Result, 16, 16);
  GPGraphic   := TGPGraphics.Create(Result.Canvas.Handle);
  GPBrush     := TGPSolidBrush.Create(aclWhite);
  GPPen       := TGPPen.Create(aclBlack);
  try
    GPGraphic.SetSmoothingMode(SmoothingModeHighQuality);

    // Desenha o Fundo
    GPBrush.SetColor(GPColor);
    GPGraphic.FillEllipse(GPBrush, 0.0, 0.0, 15, 15);

    // Desenha a Borda Branca
    GPPen.SetWidth(2);
    GPPen.SetColor(aclWhite);
    GPGraphic.DrawEllipse(GPPen, 1.0, 1.0, 13, 13);

    // Desenha a Borda Cinza
    GPPen.SetWidth(1);
    GPPen.SetColor(aclGray);
    GPGraphic.DrawEllipse(GPPen, 0.0, 0.0, 15, 15);
  finally
    FreeAndNil(GPPen);
    FreeAndNil(GPBrush);
    FreeAndNil(GPGraphic);
  end;
end;

procedure TDBGrid.TSemaforo.PrepareBMP(var bmp: TBitmap; Width, Height: Integer);
var
  p: Pointer;
begin
  bmp.PixelFormat   := pf32Bit;
  bmp.Width         := Width;
  bmp.Height        := Height;
  bmp.HandleType    := bmDIB;
  bmp.ignorepalette := true;
  bmp.alphaformat   := afPremultiplied;
  // Limpa todos Scanlines
  p := bmp.ScanLine[Height - 1];
  ZeroMemory(p, Width * Height * 4);
end;

function TDBGrid.TSemaforo.SetMethodRules(AMethod: TMethodRules): TSemaforo;
begin
  // Assina o methodo de definição de pintura
  Result := Self;
  FMethodRules := AMethod;
end;

{ TDBGrid.TSemaforoView }

class procedure TDBGrid.TSemaforoView.ShowSemaforo(Semaforos: Array of TSemaforo);
var
  view: TSemaforoView;
  oSem: TSemaforo;
begin
  // Se não tem Semáforo
  if Length(Semaforos) = 0 then
    Exit;

  // Cria e configura o Formulario que exibe o Semaforo
  view := TSemaforoView.CreateNew(nil);
  view.BorderIcons  := [biSystemMenu];
  view.BorderStyle  := bsDialog;
  view.Position     := poScreenCenter;
  view.OnClose      := view.OnCloseForm;
  view.OnDeactivate := view.OnDeactivateForm;
  view.OnKeyDown    := view.OnKeyDownForm;
  view.Caption      := 'Legenda do Semáforo';

  for oSem in Semaforos do
  begin
    SetLength(view.FSemaforos, Succ(Length(view.FSemaforos)));
    view.FSemaforos[High(view.FSemaforos)] := oSem;
  end;

  // Prepara e desenha os Semaforos
  view.PrepararSemaforo;

  // Exibe o formulário
  view.Show;
end;

procedure TDBGrid.TSemaforoView.PrepararSemaforo;
var
  siHeight   : Single;
  siWidth    : Single;
  bmp        : TBitmap;
  GPGraphic  : TGPGraphics;
  GPBrush    : TGPSolidBrush;
  GPPen      : TGPPen;
  GPFontT    : TGPFont;
  GPFontI    : TGPFont;
  GPRFont    : TGPRectF;
  GPRText    : TGPRectF;
  GPPText    : TGPPointF;
  img        : TImage;
  Semaforo   : TSemaforo;
  iIndex     : Integer;
  sDescricao : String;
  sValue     : String;
  siTop      : Single;
  GPTxtFormat: TGPStringFormat;

  procedure Inc(var Single: Single; Number: Single);
  begin
    Single := Single + Number;
  end;

begin
  // Dimensões Iniciais
  siHeight := 0;
  siWidth  := 160;

  // Cria o Bitmap do Semaforo
  bmp := TBitmap.Create;
  bmp.Height := 1000;
  bmp.Width  := 1000;

  GPBrush     := TGPSolidBrush.Create(aclWhite);
  GPPen       := TGPPen.Create(aclBlack);
  GPFontT     := TGPFont.Create('Tahoma', 8, FontStyleBold);
  GPFontI     := TGPFont.Create('Tahoma', 8);
  GPTxtFormat := TGPStringFormat.Create();
  GPRFont     := MakeRect(0.0, 0.0, 1000.0, 1000.0);
  try
    // Cria o Graphics para calcular as medidas do Texto
    GPGraphic := TGPGraphics.Create(bmp.Canvas.Handle);
    try
      GPGraphic.SetSmoothingMode(SmoothingModeHighQuality);
      // Percorre a Lista de Semaforos
      for Semaforo in FSemaforos do
      begin
        // Se não há Itens no Semáforo, vai para o próximo
        if Length(Semaforo.Valores) = 0 then
          Continue;

        // Se tem um Título obtém as Medidas do Título
        Inc(siHeight, 8);
        if not Semaforo.Caption.Trim.IsEmpty then
        begin
          // Título terá fonte em Negrito
          GPGraphic.MeasureString(
            WideString(Semaforo.Caption),
            Length(Semaforo.Caption),
            GPFontT, // Fonte do Título
            GPRFont,
            GPTxtFormat,
            GPRText
          );
          Inc(siHeight, GPRText.Height + 4);
          siWidth := Max(siWidth, GPRText.Width + 36);
        end;

        for sDescricao in Semaforo.Descricoes do
        begin
          // Itens terão fontes normais
          GPGraphic.MeasureString(
            WideString(sDescricao),
            Length(sDescricao),
            GPFontI, // Fonte do Item
            GPRFont,
            GPTxtFormat,
            GPRText
          );

          Inc(siHeight, Max(20, GPRText.Height));
          siWidth := Max(siWidth, GPRText.Width + 36);
        end;
      end;
    finally
      FreeAndNil(GPGraphic);
    end;

    // Define a dimensão do Bitmap
    bmp.Height := Round(siHeight);
    bmp.Width  := Round(siWidth);

    // Cria o GDEGraphic
    GPGraphic := TGPGraphics.Create(bmp.Canvas.Handle);
    try
      // Configura o GDI Graphic
      GPGraphic.SetSmoothingMode(SmoothingModeHighQuality);//SmoothingModeAntiAlias);

      // Pinta o fundo branco
      GPBrush.SetColor(aclWhite);
      GPGraphic.FillRectangle(GPBrush, 0.0, 0.0, siWidth + 0.0, siHeight + 0.0);

      // Define a posição Incial
      siTop := 0;
      for Semaforo in FSemaforos do
      begin
        if Length(Semaforo.Valores) = 0 then
          Continue;

        Inc(siTop, 8);
        // Desenha o Título
        // Se tem um Título obtém as Desenha o Título
        if not Semaforo.Caption.Trim.IsEmpty then
        begin
          // Obtém as Dimensões do Texto
          GPGraphic.MeasureString(
            WideString(Semaforo.Caption),
            Length(Semaforo.Caption),
            GPFontT, // Fonte do Título
            GPRFont,
            GPTxtFormat,
            GPRText
          );

          // Configura a Posição do Texto
          GPPText.X := (siWidth - 16 - GPRText.Width) / 2;
          GPPText.Y := siTop;

          // Configura o Texto
          GPGraphic.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);
          // Define a Cor do Texto
          GPBrush.SetColor(aclBlack);
          // Desenha o Texto
          GPGraphic.DrawString(Semaforo.Caption, -1, GPFontT, GPPText, GPTxtFormat, GPBrush);
          Inc(siTop, GPRText.Height + 4);
        end;

        // Desenha os Itens
        for iIndex:= 0 to High(Semaforo.Descricoes) do
        begin
          sDescricao := Semaforo.Descricoes[iIndex];
          sValue    := Semaforo.Valores[iIndex];

          // Desenha a Imagem
          bmp.Canvas.Draw(8, Round(siTop), Semaforo.Cores[AnsiIndexStr(sValue, Semaforo.Valores)]);

          // Posição do Texto
          GPPText.X := 28;
          GPPText.Y := siTop + 1.0;

          // Configura o Texto
          GPGraphic.SetTextRenderingHint(TextRenderingHintClearTypeGridFit);
          // Configura a Cor do Texto
          GPBrush.SetColor(aclBlack);
          // Desenha o Texto
          GPGraphic.DrawString(sDescricao, -1, GPFontI, GPPText, GPTxtFormat, GPBrush);
          Inc(siTop, 20);
        end;

        // Separador
        GPPen.SetWidth(1);
        GPPen.SetColor(aclGray);
        GPGraphic.DrawLine(GPPen, 2.0, siTop, siWidth - 6, siTop);
      end;
    finally
      FreeAndNil(GPGraphic);
    end;

    // Cria o TImage que exibirá o Bitmap
    img := TImage.Create(Self);
    img.Parent := TWinControl(Self);
    img.Align := alClient;
    img.Picture.Assign(bmp);
    img.Show;
  finally
    FreeAndNil(GPTxtFormat);
    FreeAndNil(GPFontI);
    FreeAndNil(GPFontT);
    FreeAndNil(GPPen);
    FreeAndNil(GPBrush);
    FreeAndNil(bmp);
  end;
  // Define a dimensão do Formulário do Semaforo
  Self.Width := Round(siWidth) + 2;
  Self.Height := Round(siHeight) + 30;
end;

procedure TDBGrid.TSemaforoView.OnCloseForm(Sender: TObject; var Action: System.UITypes.TCloseAction);
begin
  Action := System.UITypes.TCloseAction.caFree;
end;

procedure TDBGrid.TSemaforoView.OnDeactivateForm(Sender: TObject);
begin
  TForm(Sender).Close;
end;

procedure TDBGrid.TSemaforoView.OnKeyDownForm(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = VK_ESCAPE then
    Close;
end;

{ TDBGrid.TLocateText }

class function TDBGrid.TLocateText.BeginLocate(var Grid: TDBGrid): TLocateText;
begin
  Result := TDBGrid.TLocateText.CreateNew(nil);

  Result.FormPosOffSet.X := Grid.Width - (30 + 256);
  Result.FormPosOffSet.Y := 30;

  Result.TextPos := 0;
  Result.CellPos.X := 0;
  Result.CellPos.Y := 0;

  Result.FGrid        := Grid;
  Result.BorderStyle  := bsNone;
  Result.Color        := RGB(250, 251, 252) {clMedGray};
  Result.OnClose      := Result.FormClose;
  Result.OnKeyDown    := Result.FormKeyDown;
  Result.CreateControls;
  Result.Show;
  Result.KeyPreview := True;
  Result.UpdatePosition;
  Result.Invalidate;
  if Result.edtText.CanFocus then
    Result.edtText.SetFocus;
end;

procedure TDBGrid.TLocateText.CreateControls;
begin
  pnlClient := TPanel.Create(Self);
  pnlClient.Parent     := Self;
  pnlClient.TabStop    := False;
  pnlClient.Align      := alClient;
  pnlClient.BevelOuter := bvNone;
  pnlClient.AlignWithMargins := True;
  pnlClient.Margins.Left   := 6;
  pnlClient.Margins.Top    := 6;
  pnlClient.Margins.Bottom := 6;
  pnlClient.Margins.Right  := 6;
  pnlClient.Show;

  edtText := TEdit.Create(pnlClient);
  edtText.Parent    := TWincontrol(pnlClient);
  edtText.Align     := alClient;
  edtText.TabOrder  := 0;
  edtText.OnChange  := edtTextChange;
  edtText.Text      := '';
  edtText.OnKeyDown := FormKeyDown;
  edtText.OnKeyPress:= FormKeyPress;
  edtText.CharCase  := ecUpperCase;
  edtText.MaxLength := 100;
  edtText.Show;

  btnUp    := CreateButton(OnUpClick, GetButtonImage(btUp));
  btnUp.Margins.Left := 6;
  btnDown  := CreateButton(OnDownClick, GetButtonImage(btDown));
  btnClose := CreateButton(OnCloseClick, GetButtonImage(btClose));
  btnClose.Margins.Right := 3;

  btnClose.Show;
  btnDown.Show;
  btnUp.Show;
end;

function TDBGrid.TLocateText.CreateButton(EClick: TNotifyEvent; png: TPngImage): TImage;
begin
  Result := TImage.Create(pnlClient);
  Result.Parent  := TWincontrol(pnlClient);
  Result.Show;

  Result.AlignWithMargins := True;
  Result.Margins.Top      := 0;
  Result.Margins.Bottom   := 0;
  Result.Margins.Right    := 0;

  Result.Align   := alRight;
  Result.Width   := 16;
  Result.OnClick := EClick;

  Result.Picture.Assign(png);
  FreeAndNil(png);
  Result.Transparent:= True;
  Result.Center  := True;
end;

function TDBGrid.TLocateText.GetButtonImage(btType: TLocateButtonType): TPngImage;
var
  GPBitmap : TGPBitmap;
  GPGraphic: TGPGraphics;
  GPPen    : TGPPen;
  Encoder  : TGUID;
  MSOutput : TStringStream;
  MSPng    : TStringStream;
begin
  Result    := nil;
  GPBitmap  := TGPBitmap.Create(7, 7, PixelFormat32bppARGB); // Cria um TGPBitmap com transparência Alpha
  GPGraphic := TGPGraphics.Create(GPBitmap);
  GPPen     := TGPPen.Create(aclBlack, 1);
  try
    GPGraphic.SetSmoothingMode(SmoothingModeHighQuality);
    case btType of // Linha 1
      btUp   : GPGraphic.DrawLine(GPPen, 0.0, 5.0, 3.0, 1.0); // "/"
      btDown : GPGraphic.DrawLine(GPPen, 0.0, 1.0, 3.0, 5.0); // "\"
      btClose: GPGraphic.DrawLine(GPPen, 0.0, 0.0, 6.0, 6.0); // "\"
    end;
    case btType of // Linha 2
      btUp   : GPGraphic.DrawLine(GPPen, 3.0, 1.0, 6.0, 5.0); // "\"
      btDown : GPGraphic.DrawLine(GPPen, 3.0, 5.0, 6.0, 1.0); // "/"
      btClose: GPGraphic.DrawLine(GPPen, 0.0, 6.0, 6.0, 0.0); // "/"
    end;
    MSOutput := TStringStream.Create;
    try
      if GetEncoderClsid('image/png', Encoder) <> -1 then
      begin
        GPBitmap.Save(TStreamAdapter.Create(MSOutput as TStringStream) , Encoder);
        MSPng := TStringStream.Create(MSOutput.DataString);
        try
          Result := TPngImage.Create;
          Result.LoadFromStream(MSPng);
        finally
          FreeAndNil(MSPng);
        end;
      end;
    finally
      FreeAndNil(MSOutput);
    end;
  finally
    FreeAndNil(GPBitmap);
    FreeAndNil(GPPen);
    FreeAndNil(GPGraphic);
  end;
end;

procedure TDBGrid.TLocateText.LocateText(bReverse: Boolean = False);
var
  cds   : TClientDataSet;
  bFind : Boolean;
  H     : Integer;
  sDText: String;
  sRText: String;
  sSText: String;
  iPos  : Integer;
  iCol  : Integer;
  iRow  : Integer;
  iTCol : Integer;
begin

  if not Assigned(FGrid.DataSource) then
    Exit;

  if not Assigned(FGrid.DataSource.DataSet) then
    Exit;

  cds := TClientDataSet(FGrid.DataSource.DataSet);

  if cds.IsEmpty then
    Exit;

  // Obtém o Texto a ser pesquisado
  sSText := UpperCase(edtText.Text);
  if sSText.Trim.IsEmpty then
  begin
    FGrid.Repaint;
    Exit;
  end;

  // Desabilita os controles
  cds.DisableControls;
  try
    // Inicializa as Variaveis
    bFind := False; // Não encontrou o texto
    iCol  := FGrid.SelectedIndex; // Coluna selecionada
    iRow  := FGrid.Row; // Linha atual
    iTCol := Pred(FGrid.Columns.Count); // Total de Colunas - 1

    // Obtém a posição que irá iniciar a pesquisa
    iPos := TextPos;
    // Zera a posição original
    TextPos := 0;

    // Percorre duas vezes, pois se estiver no meio do dataset, e chegar ao final, deve voltar ao início
    for H := 0 to 1 do
    begin
      // Percorre todos os registros enquanto não encontrou, e não chegou ao fim ou ao início do DataSet
      while True do
      begin
        // Se já encontrou, finaliza
        if bFind then
          Break;

        // Se está fazendo pesquisa reversa, e chegou ao inicio do dataset e na primeira coluna
        if bReverse and (cds.Bof and (iCol <= 0)) then
        begin
          // Verifica se existe combinação no texto da primeira coluna
          if Assigned(FGrid.Columns[0].Field) then
            sDText := UpperCase(FGrid.Columns[0].Field.DisplayText)
          else
            sDText := EmptyStr;
          sRText := Copy(sDText, 1, Pred(iPos));
          // Se não há combinação, finaliza o WHILE
          if not ContainsStr(sRText, sSText) then
            Break;
        end
        else // Se não está fazendo pesquisa reversa, e chegou ao final do dataset e na útima coluna
        if (not bReverse) and (cds.Eof and (iCol >= iTCol)) then
        begin
          // Verifica se existe combinação no texto da última coluna
          if Assigned(FGrid.Columns[iTCol].Field) then
            sDText := UpperCase(FGrid.Columns[iTCol].Field.DisplayText)
          else
            sDText := EmptyStr;
          sRText := Copy(sDText, Ifthen(iPos = 1,1, Succ(iPos)), sDText.Length);
          // Se não há combinação, finaliza o WHILE
          if not ContainsStr(sRText, sSText) then
            Break;
        end;

        // Percorre todas as colunas enquanto não encontrou, e não chegou à última ou primeira coluna
        while (not bFind) and (((not bReverse) and (iCol <= iTCol)) or (bReverse and (iCol >= 0))) do
        begin
          // Obtém o Texto à ser exibido e converte para UpperCase
          if Assigned(FGrid.Columns[iCol].Field) then
            sDText := UpperCase(FGrid.Columns[iCol].Field.DisplayText)
          else
            sDText := EmptyStr;

          sRText := sDText;

          // Se não está mais na última célula da última pesquisa, zera o contador de posição
          if (CellPos.X <> (iCol + FGrid.IndicatorOffset)) or (CellPos.Y <> iRow) then
          begin
            // Se estiver fazendo pesquisa reversa, a posição incial será a quantidade de caracters + 1, pois,
            //   existe um "Pred() linhas à baixo"
            if bReverse then
              iPos := Succ(sDText.Length)
            else
              iPos := 0;
          end;

          // Se não é pesquisa reversa e está pequisando dentro do texto, ou é pesquisa reversa
          if ((not bReverse) and (iPos > 0)) or bReverse then
          begin
            // Se é uma pesquisa reversa
            if bReverse then
            begin
              // Obtém o Texto Restante
              sRText := Copy(sDText, 1, Pred(iPos));
              // Decrementa a posição
              Dec(iPos, Pred(sSText.Length));
            end
            else // Não é uma pesquisa reversa
            begin
              // Obtém o texto Restante
              sRText := Copy(sDText, iPos + sSText.Length, sDText.Length);
              // Incrementa a posição
              Inc(iPos, Pred(sSText.Length));
            end;
          end;

          // Se contém o Texto pesquisado
          if ContainsStr(sRText, sSText) then
          begin
            // Obtém a Posição do Texto
            if bReverse then
              TextPos := PosReverse(sSText, sRText)
            else
              TextPos := iPos + Pos(sSText, sRText);

            // Muda a coluna da Grid
            FGrid.SelectedIndex := FGrid.Columns[iCol].Index;
            // Salva a posição da Celula
            CellPos.X := iCol + FGrid.IndicatorOffset;
            CellPos.Y := iRow;
            // Atualiza a pintura da Grid
            FGrid.Invalidate;
            bFind := True;
          end;

          // Se é pesquisa reversa
          if bReverse then
            Dec(iCol)  // Coluna anterior
          else // Se não é pesquisa reversa
            Inc(iCol); // Próxima Coluna
        end;

        // Se não encontrou o texto
        if not bFind then
        begin
          // Se é pesquisa reversa
          if bReverse then
          begin
            // Vai para o registro anterior
            cds.Prior;
            // Se está no primeiro registro, apenas decrementa uma coluna, para que o WHILE chegue ao final
            if cds.Bof then
              Dec(iCol)
            else // Posiciona na última coluna
              iCol := iTCol;
            // Vai para a linha anterior
            Dec(iRow);
          end
          else
          begin
            // Vai para o próximo registro
            cds.Next;
            // Se está no útimo registro, apenas incrementa uma coluna, para que o WHILE chegue ao final
            if cds.Eof then
              Inc(iCol)
            else // Posiciona na primeira coluna
              iCol := 0;
            // Vai para a próxima linha
            Inc(iRow);
          end;
        end;
      end;

      // Se encontrou o texto pesquisado, FINALIZA o FOR
      if bFind then
        Break;

      if bReverse then
      begin
        // Posiciona no último registro
        cds.Last;
        // Posiciona na última coluna
        FGrid.SelectedIndex := iTCol;
        iCol := iTCol;
        iRow := Pred(FGrid.RowCount);
      end
      else
      begin
        // Posiciona no primeiro registro
        cds.First;
        // Posiciona na primeira coluna
        FGrid.SelectedIndex := 0;
        iCol := 0;
        iRow := 1;
      end;
    end;
  finally
    cds.EnableControls;
    CellPos.X := FGrid.Col;
    CellPos.Y := FGrid.Row;
    Repaint;
  end;
end;

function TDBGrid.TLocateText.PosReverse(sSubStr, sText: string): Integer;
var
  iPos : Integer;
begin
  // Inicializa na posição ZERO
  Result := 0;
  iPos   := 1;
  while True do
  begin
    iPos := Pos(sSubStr, sText, iPos); // Obtém a primeira posição do Texto
    if iPos = 0 then // Se não encontrou FINALIZA o WHILE
      Break;
    Result := iPos; // Salva a posição atual
    Inc(iPos, sSubStr.Length); // Incrementa à posição, a quantidade de caracteres pesquisados
  end;
end;

procedure TDBGrid.TLocateText.edtTextChange(Sender: TObject);
begin
  TextPos := 0;
  LocateText;
end;

procedure TDBGrid.TLocateText.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Action := caFree;
  FGrid.FLocateText := nil;
  FGrid.Repaint;
end;

procedure TDBGrid.TLocateText.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN, VK_F3 : LocateText(ssShift in Shift);
    VK_ESCAPE        : Close;
  end;

  if Key in [VK_RETURN, VK_F3, VK_ESCAPE] then
    Key := 0;
end;

procedure TDBGrid.TLocateText.FormKeyPress(Sender: TObject; var Key: Char);
var
  I: Integer;
  LOffSet: Integer;
  LBeginWord: Boolean;
  LText: String;
const
  CHARS = ['A'..'Z','a'..'z','0'..'9'];
begin
  // Ctrl + Backspace
  if Key = #127 then
  begin
    Key := #0;
    if not Sender.InheritsFrom(TCustomEdit) then
      Exit;
    LText := TCustomEdit(Sender).Text;
    if LText.Trim.IsEmpty then
      Exit;
    LOffSet := -1;
    LBeginWord := False;
    for I := TCustomEdit(Sender).SelStart downto 0 do
    begin
      LOffSet := I;
      if not LBeginWord then
        LBeginWord := CharInSet(LText[I], CHARS)
      else
      if not CharInSet(LText[I], CHARS) then
        Break;
    end;
    Delete(LText, LOffSet + 1, TCustomEdit(Sender).SelStart - LOffSet);
    TCustomEdit(Sender).Text := LText;
    TCustomEdit(Sender).SelStart := LOffSet;
  end;
end;

procedure TDBGrid.TLocateText.OnCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TDBGrid.TLocateText.OnDownClick(Sender: TObject);
begin
  LocateText(False);
end;

procedure TDBGrid.TLocateText.OnUpClick(Sender: TObject);
begin
  LocateText(True);
end;

procedure TDBGrid.TLocateText.UpdatePosition;
begin
  // Configura a posição
  if FMovendo then
    Exit;
  Self.Left   := FGrid.ClientOrigin.X + FormPosOffSet.X;
  Self.Top    := FGrid.ClientOrigin.Y + FormPosOffSet.Y;
  Self.Height := 33{27};
  Self.Width  := 256{250};

  if Self.Left < FGrid.ClientOrigin.X then
    Self.Left := FGrid.ClientOrigin.X;
  if Self.Top < FGrid.ClientOrigin.Y then
    Self.Top := FGrid.ClientOrigin.Y;

  if (Self.ClientOrigin.X + Self.ClientRect.Width) > (FGrid.ClientOrigin.X + FGrid.Width) then
    Self.Left := (FGrid.ClientOrigin.X + FGrid.Width) - Self.Width;
  if (Self.ClientOrigin.Y + Self.ClientRect.Height) > (FGrid.ClientOrigin.Y + FGrid.Height) then
    Self.Top := (FGrid.ClientOrigin.Y + FGrid.Height) - Self.Height;

  FormPosOffSet.X := Abs(FGrid.ClientOrigin.X - Self.Left);
  FormPosOffSet.Y := Abs(FGrid.ClientOrigin.Y - Self.Top);
end;

procedure TDBGrid.TLocateText.Paint;
begin
  inherited;
  // Desenha a borda do Formulário
  Canvas.Pen.Color   := RGB(221, 221, 221);
  Canvas.Brush.Style := bsClear;
  Canvas.Rectangle(0, 0, ClientWidth - 1, ClientHeight - 1);
end;

procedure TDBGrid.TLocateText.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  inherited;
  // Forçar a Pintura
  Message.Result := 1;
end;

procedure TDBGrid.TLocateText.WMLButtonDown(var Message: TWMLButtonDown);
begin
  inherited;
  FMouseOffSet.X := Message.XPos;
  FMouseOffSet.Y := Message.YPos;
  FMovendo := True;
end;

procedure TDBGrid.TLocateText.WMLButtonUp(var Message: TWMLButtonUp);
begin
  inherited;
  FormPosOffSet.X := Abs(FGrid.ClientOrigin.X - Self.Left);
  FormPosOffSet.Y := Abs(FGrid.ClientOrigin.Y - Self.Top);
  FMovendo := False;
end;

procedure TDBGrid.TLocateText.WMMouseMove(var Message: TWMMouseMove);
begin
  inherited;
  if FMovendo then
  begin
    FormPosOffSet.X := Self.Left - (FMouseOffSet.X - Message.XPos);
    FormPosOffSet.Y := Self.Top  - (FMouseOffSet.Y - Message.YPos);

    if FormPosOffSet.X < FGrid.ClientOrigin.X then
      FormPosOffSet.X := FGrid.ClientOrigin.X;

    if FormPosOffSet.Y < FGrid.ClientOrigin.Y then
      FormPosOffSet.Y := FGrid.ClientOrigin.Y;

    if (FormPosOffSet.X + Self.ClientRect.Width) > (FGrid.ClientOrigin.X + FGrid.Width) then
      FormPosOffSet.X := (FGrid.ClientOrigin.X + FGrid.Width) - Self.Width;
    if (FormPosOffSet.Y + Self.ClientRect.Height) > (FGrid.ClientOrigin.Y + FGrid.Height) then
      FormPosOffSet.Y := (FGrid.ClientOrigin.Y + FGrid.Height) - Self.Height;

    Self.Left := FormPosOffSet.X;
    Self.Top  := FormPosOffSet.Y;
  end;
end;

{ TGridGroupTitleList }

constructor TDBGrid.TGridGroupTitleList.Create(AOwner: TDBGrid);
begin
  inherited Create;
  FGrid := AOwner;
  FMaxGroupHeight := 0;
  FClientRect := Rect(0, 0, 0, 0);
  FState := [];
  FDrawState := [];
end;

constructor TDBGrid.TGridGroupTitleList.Create(AOwner: TGridGroupTitle);
begin
  Create(AOwner.DBGrid);
  FOwnerGroup := AOwner;
end;

destructor TDBGrid.TGridGroupTitleList.Destroy;
var
  gtItem: TGridGroupTitle;
  I: Integer;
begin
  for I := 0 to Pred(Count) do
  begin
    gtItem := Items[I];
    FreeAndNil(gtItem);
  end;
  inherited;
end;

procedure TDBGrid.TGridGroupTitleList.DoMouseDown(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //
end;

procedure TDBGrid.TGridGroupTitleList.DoMouseMove(Shift: TShiftState; X, Y: Integer);
var
  gtItem: TGridGroupTitle;
begin
  if Count = 0 then
    Exit;

  for gtItem in Self do
    if gtItem.MouseIsHover(Point(X, Y)) then
      gtItem.DoMouseMove(Shift, X, Y);
end;

procedure TDBGrid.TGridGroupTitleList.DoMouseUp(Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  //
end;

function TDBGrid.TGridGroupTitleList.AddAndGet(sCaption: String; cStartColumn, cEndColumn: TColumn): TGridGroupTitle;
const
  sErro = 'Erro ao criar o grupo ';
var
  gtColumn: TGridGroupTitle;
begin
  try
    if Contains(sCaption) then
      raise Exception.Create('Grupo "' + sCaption + '" já adicionado!');

    if TryGet(cStartColumn, gtColumn, False) then
      raise Exception.Create(sErro +'"'+sCaption+'": A Coluna Inicial pertence ao Grupo "' + gtColumn.Caption + '"!');

    if TryGet(cEndColumn, gtColumn, False) then
      raise Exception.Create(sErro +'"'+sCaption+'": A Coluna Final pertence ao Grupo "' + gtColumn.Caption + '"!');
  except on E: Exception do
    FGrid.RaiseGrid(E.Message);
  end;
  Result := TGridGroupTitle.Create(Self, sCaption, cStartColumn, cEndColumn);
  AddState(TGridGroupTitleListStatus.NeedCalcRect);
  AddState(TGridGroupTitleListStatus.NeedCalcMaxGroupHeight);
  inherited Add(Result);
  if Assigned(FOwnerGroup) then
    FOwnerGroup.AddState(TGridGroupTitleState.InvalidateRect);
end;

function TDBGrid.TGridGroupTitleList.AddAndGet(sCaption, sStartField, sEndFiled: String): TGridGroupTitle;
begin
  Result := AddAndGet(sCaption, FGrid.GetColumnByFieldName(sStartField), FGrid.GetColumnByFieldName(sEndFiled))
end;

function TDBGrid.TGridGroupTitleList.AddAndGet(sCaption: String; iStartColumn, iEndColumn: Integer): TGridGroupTitle;
begin
  Result := AddAndGet(sCaption, FGrid.Columns[iStartColumn], FGrid.Columns[iEndColumn]);
end;

procedure TDBGrid.TGridGroupTitleList.AddDrawState(State: TGridGroupTitleListDrawState);
begin
  FDrawState := FDrawState + [State];
end;

function TDBGrid.TGridGroupTitleList.Add(sCaption: String; cStartColumn, cEndColumn: TColumn): TGridGroupTitleList;
begin
  Result := Self;
  AddAndGet(sCaption, cStartColumn, cEndColumn);
end;

function TDBGrid.TGridGroupTitleList.Add(sCaption, sStartField, sEndFiled: String): TGridGroupTitleList;
begin
  Result := Self;
  AddAndGet(sCaption, sStartField, sEndFiled);
end;

function TDBGrid.TGridGroupTitleList.Add(sCaption: String; iStartColumn, iEndColumn: Integer): TGridGroupTitleList;
begin
  Result := Self;
  AddAndGet(sCaption, iStartColumn, iEndColumn);
end;

function TDBGrid.TGridGroupTitleList.GetOwnerList: TGridGroupTitleList;
begin
  if Assigned(FOwnerGroup) then
    Result := FOwnerGroup.FOwner
  else
    Result := nil;
end;

function TDBGrid.TGridGroupTitleList.GetGroup(sCaption: String; bIncludeSubGroups: Boolean = True): TGridGroupTitle;
var
  gtItem: TGridGroupTitle;
begin
  Result := nil;
  if Count = 0 then
    Exit;
  for gtItem in Self do
  begin
    // Valida se está assinado
    if not Assigned(gtItem) then
      Continue;

    // Valida se o Caption do Grupo é igual ao informado
    if gtItem.FCaption.Equals(sCaption) then
      Exit(gtItem)
    else // Se for para pesquisar nos Sub-Grupos
    if bIncludeSubGroups then
    begin
      Result := gtItem.FGroupTitles.GetGroup(sCaption, bIncludeSubGroups);
      if Assigned(Result) then
        Exit;
    end;
  end;
end;

function TDBGrid.TGridGroupTitleList.GetGroup(ptMouse: TPoint; bIncludeSubGroups: Boolean = True): TGridGroupTitle;
var
  gtItem: TGridGroupTitle;
begin
  // Inicializa o Result
  Result := nil;
  if Count = 0 then
    Exit;
  if not PtInRect(GetClientRect, ptMouse) then
    Exit;

  for gtItem in Self do
  begin
    // Valida se está assinado
    if not Assigned(gtItem) then
      Continue;

    // Valida se o Mouse está Sobre o Grupo
    if not gtItem.MouseIsHover(ptMouse) then
      Continue;

    // Obtém o Sub-Grupo que o mouse está posicionado
    if bIncludeSubGroups then
      Result := gtItem.FGroupTitles.GetGroup(ptMouse, bIncludeSubGroups);
    // Se obteve um Sub-Grupo Finaliza com o Sub-Grupo
    if Assigned(Result) then
      Exit
    else // Se não finaliza com o Grupo atual
      Exit(gtItem);
  end;
end;

function TDBGrid.TGridGroupTitleList.GetGroup(cColumn: TColumn; bIncludeSubGroups: Boolean): TGridGroupTitle;
var
  gtItem: TGridGroupTitle;
begin
  // Inicializa o Result
  Result := nil;
  if Count = 0 then
    Exit;

  for gtItem in Self do
  begin
    // Valida se está assinado
    if not Assigned(gtItem) then
      Continue;

    // Valida se a Coluna pertence ao Grpo
    if not InRange(cColumn.Index, gtItem.GetStartIndex, gtItem.GetEndIndex) then
      Continue;

    // Obtém o Sub-Grupo que a Coluna pertence
    if bIncludeSubGroups then
      Result := gtItem.FGroupTitles.GetGroup(cColumn, bIncludeSubGroups);
    // Se obteve um Sub-Grupo Finaliza com o Sub-Grupo
    if Assigned(Result) then
      Exit
    else // Se não finaliza com o Grupo atual
      Exit(gtItem);
  end;
end;

function TDBGrid.TGridGroupTitleList.TryGet(sCaption: string; var gtOut: TGridGroupTitle; bIncludeSubGroups: Boolean = True): Boolean;
begin
  Result := False;
  gtOut  := nil;
  if Count > 0 then
  begin
    gtOut  := GetGroup(sCaption, bIncludeSubGroups);
    Result := Assigned(gtOut);
  end;
end;

function TDBGrid.TGridGroupTitleList.TryGet(ptMouse: TPoint; var gtOut: TGridGroupTitle; bIncludeSubGroups: Boolean = True): Boolean;
begin
  Result := False;
  gtOut  := nil;
  if Count > 0 then
  begin
    gtOut  := GetGroup(ptMouse, bIncludeSubGroups);
    Result := Assigned(gtOut);
  end;
end;

function TDBGrid.TGridGroupTitleList.TryGet(cColumn: TColumn; var gtOut: TGridGroupTitle; bIncludeSubGroups: Boolean): Boolean;
begin
  Result := False;
  gtOut  := nil;
  if Count > 0 then
  begin
    gtOut  := GetGroup(cColumn, bIncludeSubGroups);
    Result := Assigned(gtOut);
  end;
end;

function TDBGrid.TGridGroupTitleList.GroupInPt(ptMouse: TPoint; bIncludeSubGroups: Boolean = True): Boolean;
begin
  if Count > 0 then
    Result := Assigned(GetGroup(ptMouse, bIncludeSubGroups))
  else
    Result := False;
end;

procedure TDBGrid.TGridGroupTitleList.RemoveDrawState(State: TGridGroupTitleListDrawState);
begin
  FDrawState := FDrawState - [State];
end;

function TDBGrid.TGridGroupTitleList.Contains(sCaption: String; bIncludeSubGroups: Boolean = True): Boolean;
begin
  if Count > 0 then
    Result := Assigned(GetGroup(sCaption, bIncludeSubGroups))
  else
    Result := False;
end;

function TDBGrid.TGridGroupTitleList.ContainsDrawState(State: TGridGroupTitleListDrawState): Boolean;
begin
  Result := State in FDrawState;
end;

function TDBGrid.TGridGroupTitleList.SetStateAllGroups(State: TGridGroupTitleState): TGridGroupTitleList;
var
  gtItem: TGridGroupTitle;
begin
  Result := Self;
  if Count <= 0 then
    Exit;

  for gtItem in Self do
  begin
    if not Assigned(gtItem) then
      Exit;

    gtItem.AddState(State);
    gtItem.GroupTitles.SetStateAllGroups(State);
  end;
end;

function TDBGrid.TGridGroupTitleList.ContainsState(Status: TGridGroupTitleListStatus): Boolean;
begin
  Result := Status in FState;
end;

procedure TDBGrid.TGridGroupTitleList.AddState(Status: TGridGroupTitleListStatus);
begin
  if ContainsState(Status) then
    Exit;
  FState := FState + [Status];
  if Status = TGridGroupTitleListStatus.NeedCalcMaxGroupHeight then
    if Assigned(FOwnerGroup) and Assigned(FOwnerGroup.FOwner) then
      GetOwnerList.AddState(Status);
end;

procedure TDBGrid.TGridGroupTitleList.DrawGroups;
var
  gtItem: TGridGroupTitle;
begin
  if Count > 0 then
    for gtItem in Self do
      if Assigned(gtItem) then
        gtItem.DrawGroup;
end;

function TDBGrid.TGridGroupTitleList.GetMaxGroupHeight: Integer;
var
  gtItem: TGridGroupTitle;
begin
  Result := FMaxGroupHeight;
  if not ContainsState(TGridGroupTitleListStatus.NeedCalcMaxGroupHeight) or (Count = 0) then
    Exit;
  for gtItem in Self do
    if Assigned(gtItem) then
      with gtItem.FGroupRect do
        if Height > Result then
          Result := Height;
end;

function TDBGrid.TGridGroupTitleList.GetClientRect: TRect;
var
  gtItem: TGridGroupTitle;
  gtFirst: TGridGroupTitle;
  gtLast : TGridGroupTitle;
begin
  if not ContainsState(TGridGroupTitleListStatus.NeedCalcRect) then
    Exit(FClientRect);

  if Count = 0 then
  begin
    FClientRect := Rect(0, 0, 0, 0);
    Exit(FClientRect);
  end;

  if Count = 1 then
  begin
    gtFirst := Self[0];
    gtLast  := gtFirst;
  end
  else
  begin
    gtFirst := nil;
    gtLast  := nil;
    for gtItem in Self do
    begin
      if not Assigned(gtItem) then
        Continue;

      if not Assigned(gtFirst) then
        gtFirst := gtItem;
      if not Assigned(gtLast) then
        gtLast := gtItem;

      if (gtFirst = gtItem) and (gtLast = gtItem) then
        Continue;

      if gtFirst.StartIndex > gtItem.StartIndex then
        gtFirst := gtItem;

      if gtLast.EndIndex < gtItem.EndIndex then
        gtLast := gtItem;
    end;
  end;

  Result.Left   := gtFirst.GetRect.Left;
  Result.Top    := gtFirst.GetRect.Top;
  Result.Right  := gtLast.GetRect.Right;
  Result.Bottom := gtLast.GetRect.Bottom;
  FClientRect := Result;
end;

{ TGridGroupTitle }

constructor TDBGrid.TGridGroupTitle.Create(AOwner: TGridGroupTitleList; sCaption: String; cStartColumn, cEndColumn: TColumn);
begin
  FState          := [TGridGroupTitleState.InvalidateRect];
  FGroupRect      := Rect(0, 0, 0, 0);
  FOwner          := AOwner;
  FGroupTitles    := TGridGroupTitleList.Create(Self);
  //FDrawStatus     := [];
  FDefaultHeight  := AOwner.FGrid.DefaultRowHeight;
  FStartColumn    := cStartColumn;
  FEndColumn      := cEndColumn;
  FCaption        := sCaption;
  FFont           := TFont.Create;
  FFont.Assign(cStartColumn.DefaultFont);
  FTextMargins.Left   := 3;
  FTextMargins.Top    := 3;
  FTextMargins.Right  := 3;
  FTextMargins.Bottom := 3;
  // Valida se a Coluna Inicial é Maior que a Coluna Final, se sim, inverte
  if cStartColumn.Index < cEndColumn.Index then
  begin
    FStartColumn := cStartColumn;
    FEndColumn   := cEndColumn;
  end
  else
  begin
    FStartColumn := cEndColumn;
    FEndColumn   := cStartColumn;
  end;
  CalcRectTextCaption;
end;

function TDBGrid.TGridGroupTitle.GetDBGrid: TDBGrid;
begin
  Result := FOwner.FGrid;
end;

function TDBGrid.TGridGroupTitle.GetOwner: TGridGroupTitle;
begin
  Result := FOwner.FOwnerGroup;
end;

destructor TDBGrid.TGridGroupTitle.Destroy;
begin
  FreeAndNil(FFont);
  FreeAndNil(FGroupTitles);
  inherited;
end;

function TDBGrid.TGridGroupTitle.AddAndGet(sCaption: String; cStartColumn, cEndColumn: TColumn): TGridGroupTitle;
begin
  Result := FGroupTitles.AddAndGet(sCaption, cStartColumn, cEndColumn);
end;

function TDBGrid.TGridGroupTitle.AddAndGet(sCaption, sStartField, sEndFiled: String): TGridGroupTitle;
begin
  Result := FGroupTitles.AddAndGet(sCaption, sStartField, sEndFiled);
end;

function TDBGrid.TGridGroupTitle.AddAndGet(sCaption: String; iStartColumn, iEndColumn: Integer): TGridGroupTitle;
begin
  Result := FGroupTitles.AddAndGet(sCaption, iStartColumn, iEndColumn);
end;

function TDBGrid.TGridGroupTitle.Add(sCaption: String; cStartColumn, cEndColumn: TColumn): TGridGroupTitleList;
begin
  Result := FGroupTitles.Add(sCaption, cStartColumn, cEndColumn);
end;

function TDBGrid.TGridGroupTitle.Add(sCaption, sStartField, sEndFiled: String): TGridGroupTitleList;
begin
  Result := FGroupTitles.Add(sCaption, sStartField, sEndFiled);
end;

function TDBGrid.TGridGroupTitle.Add(sCaption: String; iStartColumn, iEndColumn: Integer): TGridGroupTitleList;
begin
  Result := FGroupTitles.Add(sCaption, iStartColumn, iEndColumn);
end;

function TDBGrid.TGridGroupTitle.AddState(State: TGridGroupTitleState): TGridGroupTitle;
begin
  Result := Self;
  FState := FState + [State];
end;

function TDBGrid.TGridGroupTitle.RemoveState(State: TGridGroupTitleState): TGridGroupTitle;
begin
  Result := Self;
  FState := FState - [State];
end;

function TDBGrid.TGridGroupTitle.GetStartIndex: Integer;
begin
  if Assigned(FStartColumn) then
    Result := FStartColumn.Index
  else
    Result := -1;
end;

function TDBGrid.TGridGroupTitle.GetEndIndex: Integer;
begin
  if Assigned(FEndColumn) then
    Result := FEndColumn.Index
  else
    Result := -1;
end;

function TDBGrid.TGridGroupTitle.GetCountRows: Integer;
var
  gtGroup: TGridGroupTitle;
begin
  Result := 1;
  for gtGroup in FGroupTitles do
    if Assigned(gtGroup) then
      Result := Max(Result, gtGroup.GetCountRows + 1);

  Result := Result;
end;

function TDBGrid.TGridGroupTitle.GetRect: TRect;
var
  DrawInfo: TGridDrawInfo;
  iListMaxHeight: Integer;
begin
  Result := FGroupRect;
  if not ContainsState(TGridGroupTitleState.InvalidateRect) then
    Exit;

  Result := DBGrid.EGCellRect(GetStartIndex + DBGrid.IndicatorOffset, 0, GetEndIndex + DBGrid.IndicatorOffset, 0);

//  if EqualRect(Result, FLastGroupCellRect) and not ContainsState(TGridGroupTitleState.NeedCalcRect) then
//    Exit(FGroupRect)
//  else
//    FLastGroupCellRect := Result;

  Result.Top := 0;
  if Assigned(FOwner.FOwnerGroup) then
    Result.Top := FOwner.FOwnerGroup.GetTextAreaRect.Bottom;

  Result.Bottom := Result.Top + GetTextAreaRect.Height + FGroupTitles.GetClientRect.Height;
  FGroupRect    := Result;

  if FOwner.Count > 0 then
  begin
    iListMaxHeight := FOwner.GetMaxGroupHeight;
    if iListMaxHeight > Result.Bottom then
      Result.Bottom := iListMaxHeight;
  end;
  FGroupRect := Result;
  FGroupVisibleRect := FGroupRect;
  RemoveState(TGridGroupTitleState.InvalidateRect);

  DBGrid.CalcDrawInfo(DrawInfo);
  // Se está totalmente dentro da Àrea visivel da DBGrid então utiliza o método GetRect
  if InRange(GetStartIndex + DBGrid.IndicatorOffset, DrawInfo.Horz.FirstGridCell, DrawInfo.Horz.LastFullVisibleCell) and
     InRange(GetEndIndex + DBGrid.IndicatorOffset,   DrawInfo.Horz.FirstGridCell, DrawInfo.Horz.LastFullVisibleCell) then
    Exit;

  // Se a Borda esquerda está fora do Client da DBGrid
  if FGroupVisibleRect.Left < 0 then
  begin
    // Se a borda Direita está dentro do Client da DBGrid
    if FGroupVisibleRect.Right > 0 then
    begin
      // Se existe um Indicador
      if DBGrid.IndicatorOffset > 0 then
        // Não utilizar EGCellRect
        FGroupVisibleRect.Left := DBGrid.CellRect(DrawInfo.Horz.FirstGridCell, 0).Left
      else // Se não existe um Indicador
        FGroupVisibleRect.Left := 0;
    end
    else // Obtém o Left da primeira coluna visível
      FGroupVisibleRect.Left := DBGrid.EGCellRect(DrawInfo.Horz.FirstGridCell, 0).Left;
  end
  else
  if FGroupVisibleRect.Left > DBGrid.ClientWidth then
    FGroupVisibleRect.Left := DBGrid.ClientWidth;

  if FGroupVisibleRect.Right > DBGrid.ClientWidth then
    FGroupVisibleRect.Right := DBGrid.ClientWidth;

end;

function TDBGrid.TGridGroupTitle.GetVisibleRect: TRect;
//var
//  DrawInfo: TGridDrawInfo;
//  rStart: TRect;
//  rEnd: TRect;
begin
  // Calcular o Rect Visível se necessário
  GetRect;
  Exit(FGroupVisibleRect);

//  DBGrid.CalcDrawInfo(DrawInfo);
//
//  Result := GetRect;
//
//  // Se está totalmente dentro da Àrea visivel da DBGrid então utiliza o método GetRect
//  if InRange(GetStartIndex + DBGrid.IndicatorOffset, DrawInfo.Horz.FirstGridCell, DrawInfo.Horz.LastFullVisibleCell) and
//     InRange(GetEndIndex + DBGrid.IndicatorOffset,   DrawInfo.Horz.FirstGridCell, DrawInfo.Horz.LastFullVisibleCell) then
//    Exit;
//
//  rStart := DBGrid.EGCellRect(GetStartIndex + DBGrid.IndicatorOffset, 0);
//  rEnd   := DBGrid.EGCellRect(GetEndIndex + DBGrid.IndicatorOffset, 0);
//
//  if rStart.Left < 0 then
//  begin
//    if rStart.Right > 0 then
//    begin
//      if DBGrid.IndicatorOffset > 0 then
//        rStart.Left := DBGrid.CellRect(DrawInfo.Horz.FirstGridCell, 0).Left
//      else
//        rStart.Left := 0;
//    end
//    else
//      rStart := DBGrid.EGCellRect(DrawInfo.Horz.FirstGridCell, 0);
//  end
//  else
//  if rStart.Left > DBGrid.ClientWidth then
//    rStart.Left := DBGrid.ClientWidth;
//
//  if rEnd.Right > DBGrid.ClientWidth then
//    rEnd.Right := DBGrid.ClientWidth;
//
//  Result.Left  := rStart.Left;
//  Result.Right := rEnd.Right;
end;

procedure TDBGrid.TGridGroupTitle.CalcRectTextCaption;
var
  fCanvas: TFont;
begin
  FRectTextCaption := Rect(0, 0, 1000, 1000);
  // Obtém o Rect do Grupo
  fCanvas := TFont.Create;
  try
    fCanvas.Assign(DBGrid.Canvas.Font);
    DBGrid.Canvas.Font.Assign(FFont);
    DBGrid.Canvas.TextRect(FRectTextCaption, FCaption, [tfCalcRect, tfWordBreak]);
  finally
    DBGrid.Canvas.Font.Assign(fCanvas);
    FreeAndNil(fCanvas);
  end;
  AddState(TGridGroupTitleState.InvalidateRect);
end;

function TDBGrid.TGridGroupTitle.GetTextAreaRect: TRect;
begin
  Result := FRectTextCaption;
  Result.Right  := Result.Right  + (FTextMargins.Left + FTextMargins.Right);
  Result.Bottom := Result.Bottom + (FTextMargins.Top  + FTextMargins.Bottom)
end;

procedure TDBGrid.TGridGroupTitle.DrawGroup;
var
  fCanvas: TFont;
  rGroup: TRect;
  rTextDraw: TRect;
  gtdwDrawStates: TGridGroupTitleDrawStates;
begin
  rGroup:= GetRect;
//  if EqualRect(FGroupRect, rGroup) then
//    Exit;
  FGroupRect := rGroup;
  if not IsVisible then
    Exit;
  rGroup := GetVisibleRect;

  InflateRect(rGroup, 1, 1);

  DBGrid.Canvas.Pen.Color := RGB(220, 220, 220);

  gtdwDrawStates := GetDrawStatus;
  if TGridGroupTitleDrawState.Hot in gtdwDrawStates then
    DBGrid.Canvas.Brush.Color := RGB(217, 235, 249)
  else
  if TGridGroupTitleDrawState.OwnerHot in gtdwDrawStates then
    DBGrid.Canvas.Brush.Color := RGB(244, 247, 252)
  else
    DBGrid.Canvas.Brush.Color := clWhite;

  DBGrid.Canvas.Brush.Style := bsSolid;
  DBGrid.Canvas.FillRect(rGroup);
  DBGrid.Canvas.Rectangle(rGroup);

  // Obtém o Rect do Texto do Grupo
//  CalcRectTextCaption;
  rTextDraw.Left   := rGroup.Left + (rGroup.Width - FRectTextCaption.Width) div 2;
  rTextDraw.Top    := rGroup.Top + ((DBGrid.DefaultRowHeight - FRectTextCaption.Height) div 2);
  rTextDraw.Right  := rTextDraw.Left + FRectTextCaption.Width;
  rTextDraw.Bottom := rTextDraw.Top + FRectTextCaption.Height;
  DBGrid.Canvas.Brush.Style := bsClear;
  fCanvas := TFont.Create;
  try
    fCanvas.Assign(DBGrid.Canvas.Font);
    DBGrid.Canvas.Font.Assign(FFont);
    //FOwner.IndexOf(Self).ToString
    Winapi.Windows.DrawText(DBGrid.Canvas.Handle, PChar({FOwner.IndexOf(Self).ToString}FCaption), Length(FCaption{FOwner.IndexOf(Self).ToString}), rTextDraw, DT_CENTER);
  finally
    DBGrid.Canvas.Font.Assign(fCanvas);
    FreeAndNil(fCanvas);
  end;

  // Desenha os Sub-Grupos
  FGroupTitles.DrawGroups;
end;

function TDBGrid.TGridGroupTitle.GetDrawStatus: TGridGroupTitleDrawStates;
var
  gtGroup: TGridGroupTitle;
  gtdwsOwner: TGridGroupTitleDrawStates;
  bHotTrack: Boolean;
begin
  //Result := FDrawStatus;
  Result := [];

  if Assigned(OwnerGroup) then
  begin
    gtdwsOwner := OwnerGroup.GetDrawStatus;
    if (TGridGroupTitleDrawState.Hot in gtdwsOwner) or (TGridGroupTitleDrawState.OwnerHot in gtdwsOwner) then
      Result := Result + [TGridGroupTitleDrawState.OwnerHot];
  end;

  if PtInRect(GetRect, DBGrid.FMousePoint) then
  begin
    bHotTrack := not (TGridGroupTitleDrawState.Hot in Result);
    if FGroupTitles.Count > 0 then
    begin
      for gtGroup in FGroupTitles do
      begin
        if not Assigned(gtGroup) then
          Continue;

        if not PtInRect(gtGroup.GetRect, DBGrid.FMousePoint) then
          Continue;

        bHotTrack := False;
        Break;
      end;
    end;

    if bHotTrack then
      Result := Result + [TGridGroupTitleDrawState.Hot]
  end;
end;

procedure TDBGrid.TGridGroupTitle.MoveGroup(iToColumnIndex: Integer; bMoveColumn: Boolean);
var
  iCStart: Integer;
  iCEnd  : Integer;
  iStart : Integer;
  iColumn: Integer;
begin
  {
     -> Movendo Coluna
       - Se está em um grupo: Só pode movimentar dentro dele
       - Não pode movimentar em outro grupo

     -> Movendo Grupo
       - Não pode ficar dentro de um grupo
       - Não pode Sair fora do Grupo pai
  }
  iStart := CalcStartIndex(iToColumnIndex);
  Dec(iToColumnIndex, DBGrid.IndicatorOffset);

  iCStart := GetStartIndex;
  iCEnd   := GetEndIndex;
  if not bMoveColumn then
    Exit;

  // Movendo para a Esquerda |==>|
  if iCStart < iToColumnIndex then
  begin
    // Move as Colunas do Grupo Atual
    if bMoveColumn then
      for iColumn := iCEnd downto iCStart do
        DBGrid.MoveColumn(iColumn + DBGrid.IndicatorOffset, (iStart + Abs(iColumn - iCStart)) + DBGrid.IndicatorOffset);
  end
  else // Movendo para a Direita |<==|
  begin
    // Move as Colunas do Grupo Atual
    if bMoveColumn then
      for iColumn := iCStart to iCEnd do
        DBGrid.Columns[iColumn].Index := (iStart + Abs(iColumn - iCStart));
  end;

  AddState(TGridGroupTitleState.InvalidateRect);
end;

function TDBGrid.TGridGroupTitle.CalcStartIndex(iTOColumnIndex: Integer): Integer;
begin
  Dec(iToColumnIndex, DBGrid.IndicatorOffset);
  Result := GetStartIndex;
  // Movendo para a Esquerda |==>|
  if Result < iToColumnIndex then
    Result := iToColumnIndex - (GetEndIndex - Result) - DBGrid.IndicatorOffset
  else // Movendo para a Direita |<==|
    Result := iToColumnIndex;
end;

function TDBGrid.TGridGroupTitle.ContainsState(State: TGridGroupTitleState): Boolean;
begin
  Result := State in FState;
end;

function TDBGrid.TGridGroupTitle.CalcEndIndex(iTOColumnIndex: Integer): Integer;
begin
  Result := CalcStartIndex(iTOColumnIndex) + (GetEndIndex - GetStartIndex);
end;

procedure TDBGrid.TGridGroupTitle.SetCaption(const Value: string);
begin
  FCaption := Value;
  CalcRectTextCaption;
end;

procedure TDBGrid.TGridGroupTitle.SetEndColumn(const Value: TColumn);
begin
  FEndColumn := Value;
end;

procedure TDBGrid.TGridGroupTitle.SetStartColumn(const Value: TColumn);
begin
  FStartColumn := Value;
end;

procedure TDBGrid.TGridGroupTitle.Invalidate;
begin

end;

function TDBGrid.TGridGroupTitle.IsVisible: Boolean;
//var
//  DrawInfo: TGridDrawInfo;
begin
  with GetRect do
    Result := (Left < Right) and (Left <> Right)
//  DBGrid.CalcDrawInfo(DrawInfo);
//
//  // Se está totalmente dentro da Àrea visivel da DBGrid então utiliza o método GetRect
//  Result :=
//    InRange(GetStartIndex + DBGrid.IndicatorOffset, DrawInfo.Horz.FirstGridCell, DrawInfo.Horz.LastFullVisibleCell + 1) or
//    InRange(GetEndIndex + DBGrid.IndicatorOffset,   DrawInfo.Horz.FirstGridCell, DrawInfo.Horz.LastFullVisibleCell + 1) or
//    InRange(DrawInfo.Horz.FirstGridCell,           GetStartIndex + DBGrid.IndicatorOffset, GetEndIndex + DBGrid.IndicatorOffset) or
//    InRange(DrawInfo.Horz.LastFullVisibleCell + 1, GetStartIndex + DBGrid.IndicatorOffset, GetEndIndex + DBGrid.IndicatorOffset)
end;

function TDBGrid.TGridGroupTitle.MouseIsHover(ptMouse: TPoint): Boolean;
begin
  Result := PtInRect(GetRect, ptMouse);
end;

function TDBGrid.TGridGroupTitle.MouseHit(ptMouse: TPoint): TGridGroupTitleMouseHit;
var
  gtItem: TGridGroupTitle;
begin
  if not MouseIsHover(ptMouse) then
  begin
    if Assigned(FOwner.FOwnerGroup) then
      if FOwner.FOwnerGroup.MouseIsHover(ptMouse) then
        Exit(TGridGroupTitleMouseHit.OwnerHover);

    Exit(TGridGroupTitleMouseHit.None);
  end;

  Result := TGridGroupTitleMouseHit.Hover;
  for gtItem in FGroupTitles do
    if gtItem.MouseIsHover(ptMouse) then
      Exit(TGridGroupTitleMouseHit.SubGroupHover);
end;

procedure TDBGrid.TGridGroupTitle.DoMouseMove(Shift: TShiftState; X, Y: Integer);
begin
  FGroupTitles.DoMouseMove(Shift, X, Y);
  DrawGroup;
end;

{$WARN GARBAGE OFF}
end.
(*
Controle - Versões.
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
*)

