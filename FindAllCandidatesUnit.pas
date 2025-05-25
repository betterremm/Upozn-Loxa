unit FindAllCandidatesUnit;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls;

type
  TFindAllCandidatesForm = class(TForm)
    TreeView1: TTreeView;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FindAllCandidatesForm: TFindAllCandidatesForm;

implementation

{$R *.dfm}

end.
