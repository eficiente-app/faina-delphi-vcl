﻿program Faina;

uses
  Vcl.Forms,
  Formulario.Base in 'src\base\Formulario.Base.pas' {FormularioBase},
  Faina.Login in 'src\Faina.Login.pas' {Login},
  Faina.Configuracoes in 'src\Faina.Configuracoes.pas',
  pasta.listagem in 'src\pasta\pasta.listagem.pas' {PastaListagem},
  pasta.dados in 'src\pasta\pasta.dados.pas' {PastaDados: TDataModule},
  REST.Connection in 'src\rest\REST.Connection.pas',
  REST.Table in 'src\rest\REST.Table.pas',
  REST.Manager in 'src\rest\REST.Manager.pas',
  REST.Query in 'src\rest\REST.Query.pas',
  pasta.manutencao in 'src\pasta\pasta.manutencao.pas' {PastaManutencao},
  Faina.Pesquisa in 'src\pesquisa\Faina.Pesquisa.pas' {Pesquisa},
  pasta_tipo.dados in 'src\pasta_tipo\pasta_tipo.dados.pas' {PastaTipoDados: TDataModule},
  pasta_tipo.manutencao in 'src\pasta_tipo\pasta_tipo.manutencao.pas' {PastaTipoManutencao},
  pasta_tipo.listagem in 'src\pasta_tipo\pasta_tipo.listagem.pas' {PastaTipoListagem},
  tarefa_tipo.dados in 'src\tarefa_tipo\tarefa_tipo.dados.pas' {TarefaTipoDados: TDataModule},
  tarefa_tipo.listagem in 'src\tarefa_tipo\tarefa_tipo.listagem.pas' {TarefaTipoListagem},
  tarefa_tipo.manutencao in 'src\tarefa_tipo\tarefa_tipo.manutencao.pas' {TarefaTipoManutencao},
  Faina.Principal in 'src\Faina.Principal.pas' {Principal},
  Faina.Escuro in 'src\Faina.Escuro.pas',
  Configuracoes.Principal in 'src\configuracoes\Configuracoes.Principal.pas' {ConfiguracoesPrincipal},
  Formulario.DropDown.Base in 'src\base\Formulario.DropDown.Base.pas' {FormularioDropDownBase},
  Extend.DBGrids in 'src\extend\Extend.DBGrids.pas',
  Formulario.Base.Visual in 'src\base\Formulario.Base.Visual.pas' {FormularioBaseVisual},
  SysButtons in 'src\componentes\TSysButtons\SysButtons.pas',
  menu.usuario in 'src\area_trabalho\menu.usuario.pas' {MenuUsuario},
  area_trabalho in 'src\area_trabalho\area_trabalho.pas' {AreaTrabalho};

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPrincipal, Principal);
  Application.CreateForm(TPastaTipoDados, pasta_tipo_dados);
  Application.CreateForm(TTarefaTipoDados, tarefa_tipo_dados);
  Application.Run;
end.
