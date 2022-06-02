unit frmMainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes
, SysUtils
, Forms
, Controls
, Graphics
, Dialogs
, ExtCtrls
, StdCtrls
, httpsend
, ResourceUnit
;

type

  { TfrmMain }
    TfrmMain = class(TForm)
    Memo1: TMemo;
      Panel1: TPanel;
      Panel2: TPanel;
      Button1: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private

  public

  end;

var
  frmMain: TfrmMain;

implementation

{$R *.lfm}

{ TfrmMain }

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  Panel1.Caption:= rsTitle;
end;

procedure TfrmMain.Button1Click(Sender: TObject);
var
  http: THTTPSend;
begin
  try
    Button1.Enabled:= False;
    Memo1.Append(rsGet);
    Application.ProcessMessages;
    http:= THTTPSend.Create;
    try
      http.HTTPMethod('GET', 'http://packages.lazarus-ide.org/packagelist.json');
      Memo1.Append(rsGetDone);
    except
      on e: Exception do
      begin
        Memo1.Append(rsGetNotDone);
        ShowMessage(e.Message);
      end;
    end;
  finally
    http.Free;
    Application.ProcessMessages;
    Button1.Enabled:= True
  end;
end;

end.

