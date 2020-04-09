unit frmMainUnit;

{$mode objfpc}{$H+}

interface

uses
  Classes
, SysUtils
, Forms
, Controls
, Graphics
, Dialogs, ExtCtrls
, ResourceUnit;

type

  { TfrmMain }

  TfrmMain = class(TForm)
    Panel1: TPanel;
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

end.

