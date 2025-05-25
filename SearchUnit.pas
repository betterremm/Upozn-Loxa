Unit SearchUnit;

Interface

Uses
    Winapi.Windows,
    Winapi.Messages,
    System.SysUtils,
    System.Variants,
    System.Classes,
    Vcl.Graphics,
    Vcl.Controls,
    Vcl.Forms,
    Vcl.Dialogs,
    Vcl.StdCtrls;

Type
    TSearchForm = Class(TForm)
        EditSpeciality: TEdit;
        BtnFind: TButton;
    Label1: TLabel;
        Procedure FormCreate(Sender: TObject);
        Function FormHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
        Procedure BtnFindClick(Sender: TObject);
    Private
        { Private declarations }
    Public
        ClosedByButton: Boolean;
    End;

Var
    SearchForm: TSearchForm;

Implementation

{$R *.dfm}

Procedure TSearchForm.BtnFindClick(Sender: TObject);
Begin
    ClosedByButton := True;
    Close
End;

Procedure TSearchForm.FormCreate(Sender: TObject);
Begin
    Constraints.MaxHeight := Height;
    Constraints.MaxWidth := Width;
    Constraints.MinHeight := Height;
    Constraints.MinWidth := Width;
    ClosedByButton := False;
End;

Function TSearchForm.FormHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    FormHelp := True;
End;

End.
