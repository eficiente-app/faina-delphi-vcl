program Faina;

uses
  Vcl.Forms,
  Faina.Principal in 'src\Faina.Principal.pas' {Principal},
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
  tarefa_tipo.manutencao in 'src\tarefa_tipo\tarefa_tipo.manutencao.pas' {TarefaTipoManutencao};

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TPrincipal, Principal);
  Application.Run;
end.
