unit AppTesteRoutex;

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
  {import routeX}
  Routex,
  Vcl.StdCtrls,
  Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    ResponseMemo: TMemo;
    Panel1: TPanel;
    Label2: TLabel;
    APIBaseURLEdit: TEdit;
    Label1: TLabel;
    RouteBaseURLEdit: TEdit;
    LoadExampleButton: TButton;
    Panel2: TPanel;
    Label3: TLabel;
    PortEdit: TEdit;
    StartButton: TButton;
    Label4: TLabel;
    RouteEdit: TEdit;
    GoButton: TButton;
    ShutdownButton: TButton;
    Panel4: TPanel;
    StatusMemo: TMemo;
    Panel5: TPanel;
    procedure StartButtonClick(Sender: TObject);
    procedure LoadExampleButtonClick(Sender: TObject);
    procedure GoButtonClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ShutdownButtonClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  routex: TRoutex;

implementation

{$R *.dfm}

{******************************************************************
 Author: Lucio Mello  -  www.linkedin.com/in/lucio-mello-df
 Date/Version: 2026 - 0.1
 To use RouteX:
 1. Import TRouteX
 2. Use the Configure method to configure the port, the local URL,
    the intended API, and if necessary.
 3. execute Start

 Routex is a microframework that abstracts route creation on top
 of Horse. It lets you define a single default base URL that
 automatically handles all of an API's routes, eliminating the
 need to manually create a route for every endpoint.
*******************************************************************}

procedure TForm1.StartButtonClick(Sender: TObject);
begin
  routex := TRoutex.Create;
  routex.Configure(StrToInt(PortEdit.Text),
                      RouteBaseURLEdit.Text, APIBaseURLEdit.Text, '');
  routex.Start;

  StatusMemo.Lines.Add(routex.GetReturnLog);
  StatusMemo.Lines.Add('[' + TimeToStr(Time) + '] Horse server is online.');
end;

procedure TForm1.LoadExampleButtonClick(Sender: TObject);
begin
  PortEdit.text := '8091';
  APIBaseURLEdit.Text := 'https://api.adviceslip.com/advice';
  RouteBaseURLEdit.Text := '/advice/';
  RouteEdit.Text :=  'http://localhost:' + PortEdit.Text +
  RouteBaseURLEdit.Text + '2';
end;

procedure TForm1.GoButtonClick(Sender: TObject);
begin
  ResponseMemo.Lines.Add(routex.Consumer(RouteEdit.Text));
end;

procedure TForm1.ShutdownButtonClick(Sender: TObject);
begin
  routex.Shutdown;
  StatusMemo.Lines.Add('[' + TimeToStr(Time) + '] Horse server is offline.');
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  StatusMemo.Lines.Add('[' + TimeToStr(Time) + '] Horse server is offline.');
end;

end.
