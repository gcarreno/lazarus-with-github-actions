unit TestAliveCase;

{$mode objfpc}{$H+}

interface

uses
  Classes
, SysUtils
, fpcunit
, testutils
, testregistry
, ResourceUnit;

type

  TTestAliveCase= class(TTestCase)
  published
    procedure TestResourceUnitTitle;
  end;

implementation

procedure TTestAliveCase.TestResourceUnitTitle;
begin
  AssertEquals('Title of resources source unit', 'Github actions with Lazarus', rsTitle);
end;



initialization

  RegisterTest(TTestAliveCase);
end.

