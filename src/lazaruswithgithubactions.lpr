program LazarusWithGitHubActions;

{$mode objfpc}{$H+}

uses
  {$IFDEF UNIX}
  cthreads,
  {$ENDIF}
  Interfaces, // this includes the LCL widgetset
  Forms, frmMainUnit
  { you can add units after this };

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  {$IF FPC_FULLVERSION >= 30004}
  Application.Scaled:=True;
  {$ENDIF}
  Application.Initialize;
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.

