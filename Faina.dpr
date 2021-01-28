program Faina;

uses
  Vcl.Forms,
  base_form in 'src\base\base_form.pas' {BaseForm},
  Faina.Login in 'src\Faina.Login.pas' {Login},
  Faina.Configuration in 'src\Faina.Configuration.pas',
  REST.Connection in 'src\rest\REST.Connection.pas',
  REST.Table in 'src\rest\REST.Table.pas',
  REST.Manager in 'src\rest\REST.Manager.pas',
  REST.Query in 'src\rest\REST.Query.pas',
  Faina.Main in 'src\Faina.Main.pas' {Main},
  Faina.Shadow in 'src\Faina.Shadow.pas',
  base_form_dropdown in 'src\base\base_form_dropdown.pas' {BaseFormDropDown},
  Extend.DBGrids in 'src\extend\Extend.DBGrids.pas',
  base_form_view in 'src\base\base_form_view.pas' {BaseFormView},
  search_view in 'src\search\search_view.pas' {SearchView},
  user_menu in 'src\workspace\user_menu.pas' {UserMenu},
  workspace.view in 'src\workspace\workspace.view.pas' {WorkSpace},
  SysButtons in 'src\components\TSysButtons\SysButtons.pas',
  main_configuration in 'src\configuration\main_configuration.pas' {MainConfiguration},
  folder_controller in 'src\folder\folder_controller.pas' {FolderController: TDataModule},
  folder_list in 'src\folder\folder_list.pas' {FolderList},
  folder_view in 'src\folder\folder_view.pas' {FolderView},
  folder_type_controller in 'src\folder\folder_type\folder_type_controller.pas' {FolderTypeController: TDataModule},
  folder_type_list in 'src\folder\folder_type\folder_type_list.pas' {FolderTypeList},
  folder_type_view in 'src\folder\folder_type\folder_type_view.pas' {PastaTipoManutencao},
  task_type_controller in 'src\task\task_type\task_type_controller.pas' {TaskTypeController: TDataModule},
  task_type_list in 'src\task\task_type\task_type_list.pas' {TaskTypeList},
  task_type_view in 'src\task\task_type\task_type_view.pas' {TaskTypeView},
  task_view in 'src\task\task_view.pas' {TaskView};

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.Run;
end.
