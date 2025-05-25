Unit AddEditVacancyUnit;

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
    TAddEditVacancyForm = Class(TForm)
        EditFirm: TEdit;
        EditSpeciality: TEdit;
        EditJobTitle: TEdit;
        EditWage: TEdit;
        EditVacationDays: TEdit;
        EditAgeRangeMin: TEdit;
        Label1: TLabel;
        Label2: TLabel;
        Label3: TLabel;
        Label4: TLabel;
        Label5: TLabel;
        Label7: TLabel;
        BtnClose: TButton;
        EditAgeRangeMax: TEdit;
        Label8: TLabel;
        CBHigherEducation: TCheckBox;
        Procedure FormCreate(Sender: TObject);
        Function FormHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
        Procedure BtnCloseClick(Sender: TObject);
        Procedure EditWageKeyPress(Sender: TObject; Var Key: Char);
        Procedure ContextBlock(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
        Procedure EditWageChange(Sender: TObject);
        Procedure EditVacationDaysChange(Sender: TObject);
        Procedure EditAgeRangeMinChange(Sender: TObject);
        Procedure EditAgeRangeEndChange(Sender: TObject);
        Procedure EditJobTitleChange(Sender: TObject);
        Procedure EditSpecialityChange(Sender: TObject);
        Procedure EditFirmChange(Sender: TObject);
        Procedure CheckButton();
        Procedure EditAgeRangeMaxChange(Sender: TObject);
    Private Const
        TAllowedKeys: Set Of Char = ['0' .. '9', #8, #127];

    Public
    Var
        IsFilled: Array [1 .. 5] Of Boolean;
        ClosedByButton: Boolean;

    End;

Var
    AddEditVacancyForm: TAddEditVacancyForm;

Implementation

{$R *.dfm}

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

Procedure TAddEditVacancyForm.CheckButton();
Begin
    BtnClose.Enabled := IsFilled[1] And IsFilled[2] And IsFilled[3] And IsFilled[4] And IsFilled[5];

End;

Procedure TAddEditVacancyForm.BtnCloseClick(Sender: TObject);
Begin
    If EditAgeRangeMin.Text = '' Then
        EditAgeRangeMin.Text := '0';
    If EditAgeRangeMax.Text = '' Then
        EditAgeRangeMax.Text := '99';
    ClosedByButton := True;
    Close;

End;

Procedure TAddEditVacancyForm.ContextBlock(Sender: TObject; MousePos: TPoint; Var Handled: Boolean);
Begin
    Handled := True;
End;

Procedure TAddEditVacancyForm.EditAgeRangeEndChange(Sender: TObject);
Var
    Text: String;
Begin
    Text := EditAgeRangeMax.Text;
    If Not IsCurrIntCorrect(Text) Then
    Begin
        EditAgeRangeMax.Text := Text;
        EditAgeRangeMax.SelStart := Length(Text);
    End;
End;

Procedure TAddEditVacancyForm.EditAgeRangeMaxChange(Sender: TObject);
Var
    Text: String;
Begin
    Text := EditAgeRangeMax.Text;
    If Not IsCurrIntCorrect(Text) Then
    Begin
        EditAgeRangeMax.Text := Text;
        EditAgeRangeMax.SelStart := Length(Text);
    End;
    If (EditAgeRangeMax.Text <> '') And (EditAgeRangeMin.Text <> '') And
        (StrToInt(EditAgeRangeMax.Text) < StrToInt(EditAgeRangeMin.Text)) Then
    Begin
        EditAgeRangeMax.Text := EditAgeRangeMin.Text;
        EditAgeRangeMax.SelStart := Length(EditAgeRangeMin.Text);
    End;

End;

Procedure TAddEditVacancyForm.EditAgeRangeMinChange(Sender: TObject);
Var
    Text: String;
Begin
    Text := EditAgeRangeMin.Text;
    If Not IsCurrIntCorrect(Text) Then
    Begin
        EditAgeRangeMin.Text := Text;
        EditAgeRangeMin.SelStart := Length(Text);
    End;
    If (EditAgeRangeMax.Text <> '') And (EditAgeRangeMin.Text <> '') And
        (StrToInt(EditAgeRangeMax.Text) < StrToInt(EditAgeRangeMin.Text)) Then
    Begin
        EditAgeRangeMin.Text := EditAgeRangeMax.Text;
        EditAgeRangeMin.SelStart := Length(EditAgeRangeMax.Text);
    End;
End;

Procedure TAddEditVacancyForm.EditFirmChange(Sender: TObject);
Begin
    If Length(EditFirm.Text) > 0 Then
        IsFilled[1] := True
    Else
        IsFilled[1] := False;

    CheckButton();
End;

Procedure TAddEditVacancyForm.EditJobTitleChange(Sender: TObject);
Begin
    If Length(EditJobTitle.Text) > 0 Then
        IsFilled[3] := True
    Else
        IsFilled[3] := False;

    CheckButton();
End;

Procedure TAddEditVacancyForm.EditSpecialityChange(Sender: TObject);
Begin
    If Length(EditSpeciality.Text) > 0 Then
        IsFilled[2] := True
    Else
        IsFilled[2] := False;

    CheckButton();
End;

Procedure TAddEditVacancyForm.EditVacationDaysChange(Sender: TObject);
Var
    Text: String;
Begin
    Text := EditVacationDays.Text;
    If Not IsCurrIntCorrect(Text) Then
    Begin
        EditVacationDays.Text := Text;
        EditVacationDays.SelStart := Length(Text);
    End;
    If StrToInt(EditVacationDays.Text) > 365 Then
    Begin
        EditVacationDays.Text := '365';
        EditVacationDays.SelStart := 3;
    End;
    If Length(EditVacationDays.Text) > 0 Then
        IsFilled[5] := True
    Else
        IsFilled[5] := False;

    CheckButton();
End;

Procedure TAddEditVacancyForm.EditWageChange(Sender: TObject);
Var
    Text: String;
Begin
    Text := EditWage.Text;
    If Not IsCurrIntCorrect(Text) Then
    Begin
        EditWage.Text := Text;
        EditWage.SelStart := Length(Text);
    End;
    If Length(EditWage.Text) > 0 Then
        IsFilled[4] := True
    Else
        IsFilled[4] := False;

    CheckButton();
End;

Procedure TAddEditVacancyForm.EditWageKeyPress(Sender: TObject; Var Key: Char);
Begin
    If Not(Key In TAllowedKeys) Then
        Key := #0;
End;

Procedure TAddEditVacancyForm.FormCreate(Sender: TObject);
Var
    I: Integer;
Begin
    For I := 1 To 5 Do
        IsFilled[I] := False;
    ClosedByButton := False;
    Constraints.MaxHeight := Height;
    Constraints.MaxWidth := Width;
    Constraints.MinHeight := Height;
    Constraints.MinWidth := Width;
End;

Function TAddEditVacancyForm.FormHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    FormHelp := True;
End;

End.
