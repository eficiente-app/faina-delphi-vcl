program Faina;

uses
  Vcl.Forms,
  Faina.Principal in 'src\Faina.Principal.pas' {Principal},
  Faina.Login in 'src\Faina.Login.pas' {Login},
  Faina.Dados in 'src\Faina.Dados.pas' {Dados: TDataModule},
  Faina.Configuracoes in 'src\Faina.Configuracoes.pas',
  Faina.Pasta.lst.vw in 'src\pasta\Faina.Pasta.lst.vw.pas' {PastaListagem},
  Faina.Pasta.cl in 'src\pasta\Faina.Pasta.cl.pas' {PastaController: TDataModule},
  REST.Connection in 'src\rest\REST.Connection.pas',
  REST.Table in 'src\rest\REST.Table.pas',
  REST.Manager in 'src\rest\REST.Manager.pas',
  REST.Query in 'src\rest\REST.Query.pas',
  Faina.Pasta.man.vw in 'src\pasta\Faina.Pasta.man.vw.pas' {PastaManutencao},
  Faina.Pesquisa in 'src\pesquisa\Faina.Pesquisa.pas' {Pesquisa};

{$R *.res}

begin
  Application.Initialize;
  ReportMemoryLeaksOnShutdown := True;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TDados, Dados);
  Application.CreateForm(TPrincipal, Principal);
  Application.Run;
end.
