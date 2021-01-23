program Faina;

uses
  Vcl.Forms,
  Formulario.Base in 'src\base\Formulario.Base.pas' {FormularioBase},
  Faina.Login in 'src\Faina.Login.pas' {Login},
  Faina.Configuracoes in 'src\Faina.Configuracoes.pas',
  REST.Connection in 'src\rest\REST.Connection.pas',
  REST.Table in 'src\rest\REST.Table.pas',
  REST.Manager in 'src\rest\REST.Manager.pas',
  REST.Query in 'src\rest\REST.Query.pas',
  Faina.Principal in 'src\Faina.Principal.pas' {Principal},
  Faina.Escuro in 'src\Faina.Escuro.pas',
  Configuracoes.Principal in 'src\configuracoes\Configuracoes.Principal.pas' {ConfiguracoesPrincipal},
  Formulario.DropDown.Base in 'src\base\Formulario.DropDown.Base.pas' {FormularioDropDownBase},
  Extend.DBGrids in 'src\extend\Extend.DBGrids.pas',
  Formulario.Base.Visual in 'src\base\Formulario.Base.Visual.pas' {FormularioBaseVisual},
  SysButtons in 'src\componentes\TSysButtons\SysButtons.pas',
  menu.usuario in 'src\area_trabalho\menu.usuario.pas' {MenuUsuario},
  area_trabalho in 'src\area_trabalho\area_trabalho.pas' {AreaTrabalho},
  task_type_controller in 'src\folder_type\task_type_controller.pas' {TaskTypeController: TDataModule},
  task_type_list in 'src\folder_type\task_type_list.pas' {TaskTypeList},
  task_type_view in 'src\folder_type\task_type_view.pas' {TaskTypeView},
  search_view in 'src\search\search_view.pas' {SearchView},
  folder_controller in 'src\task\folder_controller.pas' {FolderController: TDataModule},
  folder_list in 'src\task\folder_list.pas' {FolderList},
  folder_view in 'src\task\folder_view.pas' {FolderView},
  folder_type_controller in 'src\task_type\folder_type_controller.pas' {FolderTypeController: TDataModule},
  folder_type_list in 'src\task_type\folder_type_list.pas' {FolderTypeList},
  folder_type_view in 'src\task_type\folder_type_view.pas' {PastaTipoManutencao};

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPrincipal, Principal);
  //  Application.CreateForm(Tpasta_tipo_dados, pasta_tipo_dados);
//  Application.CreateForm(Ttarefa_tipo_dados, tarefa_tipo_dados);
  Application.Run;
end.
