Unit AddEditCandidateUnit;

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
    Vcl.StdCtrls,
    Vcl.WinXPickers;

Type
    TAddEditCandidateForm = Class(TForm)
        EditFullName: TEdit;
        EditSpeciality: TEdit;
        EditPrefJobTitle: TEdit;
        EditMinWage: TEdit;
        CBHasHigherEducation: TCheckBox;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        Label5: TLabel;
        BtnClose: TButton;
        DPBirthDate: TDatePicker;
        Procedure FormCreate(Sender: TObject);
        Function FormHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
        Procedure BtnCloseClick(Sender: TObject);
        Procedure EditMinWageChange(Sender: TObject);
        Procedure DPBirthDateChange(Sender: TObject);
        Procedure EditMinWageKeyPress(Sender: TObject; Var Key: Char);
        Procedure CheckButton();
        Procedure EditFullNameChange(Sender: TObject);
        Procedure EditSpecialityChange(Sender: TObject);
        Procedure EditPrefJobTitleChange(Sender: TObject);
    Private Const
        TAllowedKeys: Set Of Char = ['0' .. '9', #8, #127];
    Public
        ClosedByButton: Boolean;
        IsFilled: Array [1 .. 4] Of Boolean;
    End;

Var
    AddEditCandidateForm: TAddEditCandidateForm;

Implementation

{$R *.dfm}

Procedure TAddEditCandidateForm.BtnCloseClick(Sender: TObject);
Begin
    ClosedByButton := True;
    Close
End;

Function IsCurrIntCorrect(Var Text: String): Boolean;
Var
    I: Integer;
    Value: Currency;
    IsCorrect: Boolean;
Begin
    I := 1;
    IsCorrect := True;

    While I <= Length(Text) Do
    Begin

        If Not(Text[I] In ['0' .. '9']) Then
        Begin
            Delete(Text, I, 1);
            IsCorrect := False;
        End
        Else
            Inc(I);
    End;

    If (Text <> '') And (IntToStr(StrToInt(Text)) <> Text) Then
    Begin
        IsCorrect := False;
        Text := CurrToStr(StrToCurr(Text));
    End;

    IsCurrIntCorrect := IsCorrect;

End;

Procedure TAddEditCandidateForm.DPBirthDateChange(Sender: TObject);
Begin
    If DPBirthDate.Date > Date Then
    Begin
        DPBirthDate.Date := Date; //—брос на сегодн€шнюю дату
    End;
End;

Procedure TAddEditCandidateForm.EditFullNameChange(Sender: TObject);
Begin
    If Length(EditFullName.Text) > 0 Then
        IsFilled[1] := True
    Else
        IsFilled[1] := False;

    CheckButton;
End;

Procedure TAddEditCandidateForm.EditMinWageChange(Sender: TObject);
Var
    Text: String;
Begin
    Text := EditMinWage.Text;
    If Not IsCurrIntCorrect(Text) Then
    Begin
        EditMinWage.Text := Text;
        EditMinWage.SelStart := Length(Text);
    End;
    If Length(EditMinWage.Text) > 0 Then
        IsFilled[4] := True
    Else
        IsFilled[4] := False;

    CheckButton;

End;

Procedure TAddEditCandidateForm.CheckButton();
Begin
    BtnClose.Enabled := IsFilled[1] And IsFilled[2] And IsFilled[3] And IsFilled[4];
End;

Procedure TAddEditCandidateForm.EditMinWageKeyPress(Sender: TObject; Var Key: Char);
Begin
    If Not(Key In TAllowedKeys) Then
        Key := #0;
End;

Procedure TAddEditCandidateForm.EditPrefJobTitleChange(Sender: TObject);
Begin
    If Length(EditPrefJobTitle.Text) > 0 Then
        IsFilled[3] := True
    Else
        IsFilled[3] := False;

    CheckButton;
End;

Procedure TAddEditCandidateForm.EditSpecialityChange(Sender: TObject);
Begin
    If Length(EditSpeciality.Text) > 0 Then
        IsFilled[2] := True
    Else
        IsFilled[2] := False;

    CheckButton;
End;

Procedure TAddEditCandidateForm.FormCreate(Sender: TObject);
Begin
    IsFilled[1] := False;
    IsFilled[2] := False;
    IsFilled[3] := False;
    IsFilled[4] := False;
    ClosedByButton := False;
    Constraints.MaxHeight := Height;
    Constraints.MaxWidth := Width;
    Constraints.MinHeight := Height;
    Constraints.MinWidth := Width;
End;

Function TAddEditCandidateForm.FormHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    FormHelp := True;
End;

End.
