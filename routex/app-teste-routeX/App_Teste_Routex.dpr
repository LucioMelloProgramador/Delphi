program App_Teste_Routex;

uses
  Vcl.Forms,
  AppTesteRoutex in 'AppTesteRoutex.pas' {Form1},
  Routex.Consumer in 'modules\routex\src\Routex.Consumer.pas',
  Routex.Client in 'modules\routex\src\Routex.Client.pas',
  Routex.Config in 'modules\routex\src\Routex.Config.pas',
  Routex.Core in 'modules\routex\src\Routex.Core.pas',
  Routex.Hash.Instancia in 'modules\routex\src\Routex.Hash.Instancia.pas',
  Routex in 'modules\routex\src\Routex.pas',
  Routex.Routes in 'modules\routex\src\Routex.Routes.pas',
  Routex.ValidarObjeto in 'modules\routex\src\Routex.ValidarObjeto.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
