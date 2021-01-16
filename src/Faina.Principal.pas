﻿// Eduardo - 07/11/2020
unit Faina.Principal;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.ExtCtrls,
  Vcl.ComCtrls,
  Vcl.Buttons,
  Vcl.Menus,
  Data.DB,
  System.ImageList,
  Vcl.ImgList,
  System.Actions,
  Vcl.ActnList,
  Faina.Configuracoes,

  cxGraphics,
  cxControls,
  cxLookAndFeels,
  cxLookAndFeelPainters,
  cxStyles,
  cxEdit,
  cxScheduler,
  cxSchedulerStorage,
  cxSchedulerCustomControls,
  cxSchedulerCustomResourceView,
  cxSchedulerDayView,
  cxSchedulerAgendaView,
  cxSchedulerDateNavigator,
  cxSchedulerHolidays,
  cxSchedulerTimeGridView,
  cxSchedulerUtils,
  cxSchedulerWeekView,
  cxSchedulerYearView,
  cxSchedulerGanttView,
  cxSchedulerRecurrence,
  dxBarBuiltInMenu,
  cxSchedulerTreeListBrowser,
  cxSchedulerRibbonStyleEventEditor,
  dxSkinsCore,
  dxSkinsDefaultPainters,
  dxRibbonSkins,
  dxRibbonCustomizationForm,
  cxImageList,
  dxPrinting,
  cxSchedulerActions,
  dxActions,
  dxBar,
  cxClasses,
  dxRibbon;

type
  TPrincipal = class(TForm)
    pnlTop: TPanel;
    tvwMenu: TTreeView;
    sbtConfiguracao: TSpeedButton;
    cxScheduler: TcxScheduler;
    dxRibbon: TdxRibbon;
    dxBarManager: TdxBarManager;
    ActionList1: TActionList;
    cxImageList1: TcxImageList;
    cxImageList2: TcxImageList;
    dxSchedulerNewEvent: TdxSchedulerNewEvent;
    dxRibbonTabHome: TdxRibbonTab;
    dxBarEvent: TdxBar;
    dxBarLargeButtonNewEvent: TdxBarLargeButton;
    dxSchedulerNewRecurringEvent: TdxSchedulerNewRecurringEvent;
    dxBarLargeButtonNewRecurringEvent: TdxBarLargeButton;
    dxSchedulerGoBackward: TdxSchedulerGoBackward;
    dxBarNavigation: TdxBar;
    dxBarLargeButtonGoBackward: TdxBarLargeButton;
    dxSchedulerGoForward: TdxSchedulerGoForward;
    dxBarLargeButtonGoForward: TdxBarLargeButton;
    dxSchedulerGoToToday: TdxSchedulerGoToToday;
    dxBarLargeButtonGotoToday: TdxBarLargeButton;
    dxSchedulerGoToDate: TdxSchedulerGoToDate;
    dxBarLargeButtonGotoDate: TdxBarLargeButton;
    dxSchedulerNextSevenDays: TdxSchedulerNextSevenDays;
    dxBarLargeButtonNext7Days: TdxBarLargeButton;
    dxSchedulerDayView: TdxSchedulerDayView;
    dxBarArrange: TdxBar;
    dxBarLargeButtonDay: TdxBarLargeButton;
    dxSchedulerWorkWeekView: TdxSchedulerWorkWeekView;
    dxBarLargeButtonWorkWeek: TdxBarLargeButton;
    dxSchedulerWeekView: TdxSchedulerWeekView;
    dxBarLargeButtonWeek: TdxBarLargeButton;
    dxSchedulerMonthView: TdxSchedulerMonthView;
    dxBarLargeButtonMonth: TdxBarLargeButton;
    dxSchedulerTimeGridView: TdxSchedulerTimeGridView;
    dxBarLargeButtonTimeline: TdxBarLargeButton;
    dxSchedulerYearView: TdxSchedulerYearView;
    dxBarLargeButtonYear: TdxBarLargeButton;
    dxSchedulerGanttView: TdxSchedulerGanttView;
    dxBarLargeButtonGanttView: TdxBarLargeButton;
    dxSchedulerAgendaView: TdxSchedulerAgendaView;
    dxBarLargeButtonAgenda: TdxBarLargeButton;
    dxSchedulerGroupByNone: TdxSchedulerGroupByNone;
    dxBarGroupBy: TdxBar;
    dxBarLargeButtonGroupByNone: TdxBarLargeButton;
    dxSchedulerGroupByDate: TdxSchedulerGroupByDate;
    dxBarLargeButtonGroupByDate: TdxBarLargeButton;
    dxSchedulerGroupByResource: TdxSchedulerGroupByResource;
    dxBarLargeButtonGroupByResource: TdxBarLargeButton;
    dxRibbonTabView: TdxRibbonTab;
    dxBarTimeScale: TdxBar;
    dxBarSubItem1: TdxBarSubItem;
    dxSchedulerTimeScale60Minutes: TdxSchedulerTimeScale60Minutes;
    dxBarLargeButton60Minutes: TdxBarLargeButton;
    dxSchedulerTimeScale30Minutes: TdxSchedulerTimeScale30Minutes;
    dxBarLargeButton30Minutes: TdxBarLargeButton;
    dxSchedulerTimeScale15Minutes: TdxSchedulerTimeScale15Minutes;
    dxBarLargeButton15Minutes: TdxBarLargeButton;
    dxSchedulerTimeScale10Minutes: TdxSchedulerTimeScale10Minutes;
    dxBarLargeButton10Minutes: TdxBarLargeButton;
    dxSchedulerTimeScale6Minutes: TdxSchedulerTimeScale6Minutes;
    dxBarLargeButton6Minutes: TdxBarLargeButton;
    dxSchedulerTimeScale5Minutes: TdxSchedulerTimeScale5Minutes;
    dxBarLargeButton5Minutes: TdxBarLargeButton;
    dxSchedulerCompressWeekends: TdxSchedulerCompressWeekends;
    dxBarLayout: TdxBar;
    dxBarLargeButtonCompressWeekends: TdxBarLargeButton;
    dxSchedulerWorkTimeOnly: TdxSchedulerWorkTimeOnly;
    dxBarLargeButtonWorkingHours: TdxBarLargeButton;
    dxSchedulerSnapEventsToTimeSlots: TdxSchedulerSnapEventsToTimeSlots;
    dxBarLargeButtonSnapEventsToTimeSlots: TdxBarLargeButton;
    dxSchedulerDateNavigator: TdxSchedulerDateNavigator;
    dxBarLargeButtonDateNavigator: TdxBarLargeButton;
    dxSchedulerResourcesLayoutEditor: TdxSchedulerResourcesLayoutEditor;
    dxBarLargeButtonResourcesLayoutEditor: TdxBarLargeButton;
    dxSchedulerShowPrintForm: TdxSchedulerShowPrintForm;
    dxRibbonTabFile: TdxRibbonTab;
    dxBarPrint: TdxBar;
    dxBarLargeButtonPrint: TdxBarLargeButton;
    dxSchedulerShowPrintPreviewForm: TdxSchedulerShowPrintPreviewForm;
    dxBarLargeButtonPrintPreview: TdxBarLargeButton;
    dxSchedulerShowPageSetupForm: TdxSchedulerShowPageSetupForm;
    dxBarLargeButtonPageSetup: TdxBarLargeButton;
    cxSchedulerStorage: TcxSchedulerStorage;
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sbtConfiguracaoClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
  private
    Configuracoes: TConfiguracoes;
  public
    { Public declarations }
  end;

var
  Principal: TPrincipal;

implementation

uses
  Faina.Login,
  Faina.Escuro,
  pasta.listagem,
  pasta_tipo.listagem,
  tarefa_tipo.listagem;

{$R *.dfm}

procedure TPrincipal.FormCreate(Sender: TObject);
begin
  Configuracoes := TConfiguracoes.Create;
end;

procedure TPrincipal.FormDestroy(Sender: TObject);
begin
  FreeAndNil(Configuracoes);
end;

procedure TPrincipal.FormShow(Sender: TObject);
//var
//  evento1, evento2: TcxSchedulerEvent;
begin
  TLogin.New(Self);

  if FileExists('Scheduler.data') then
    cxSchedulerStorage.LoadFromFile('Scheduler.data');

//  evento1 := cxSchedulerStorage.createEvent;
//  with evento1 do
//  begin
//    Start    := EncodeDate(2020, 11, 23) + EncodeTime(21, 0, 0, 0);
//    Finish   := EncodeDate(2020, 11, 23) + EncodeTime(22, 0, 0, 0);
//    Caption  := 'Teste evento';
//    Post;
//  end;
//
//  evento2 := cxSchedulerStorage.createEvent;
//  with evento2 do
//  begin
//    Start    := EncodeDate(2020, 11, 23) + EncodeTime(22, 0, 0, 0);
//    Finish   := EncodeDate(2020, 11, 23) + EncodeTime(23, 0, 0, 0);;
//    Caption  := 'Teste evento';
//    Post;
//  end;
//
//  evento1.TaskLinks.Add(evento2, TcxSchedulerEventRelation(0));
end;

procedure TPrincipal.sbtConfiguracaoClick(Sender: TObject);
begin
//  TPastaListagem.New;
//  TPastaTipoListagem.New;
  TEscuro.Novo(Self, TTarefaTipoListagem);
end;

procedure TPrincipal.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  cxSchedulerStorage.SaveToFile('Scheduler.data');
end;

end.
