Unit ViewVacanciesUnit;

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
    Vcl.Grids;

Type

    TViewVacanciesForm = Class(TForm)
        SGMain: TStringGrid;
        Procedure FormCreate(Sender: TObject);
        Function FormHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
        Procedure AddVacancy(Firm: String; Speciality: String; JobTitle: String; Wage: Integer; VacationDays: Integer;
            HasHigherEducation: Boolean; AgeRangeMin, AgeRangeMax: Integer);
    Private
        { Private declarations }
    Public
        I: Integer;
    End;

Var
    ViewVacanciesForm: TViewVacanciesForm;

Implementation

{$R *.dfm}

Procedure TViewVacanciesForm.AddVacancy(Firm: String; Speciality: String; JobTitle: String; Wage: Integer; VacationDays: Integer;
    HasHigherEducation: Boolean; AgeRangeMin, AgeRangeMax: Integer);
Begin
    Inc(I);
    SGMain.Cells[0, I] := Firm;
    SGMain.Cells[1, I] := Speciality;
    SGMain.Cells[2, I] := JobTitle;
    SGMain.Cells[3, I] := IntToStr(Wage);
    SGMain.Cells[4, I] := IntToStr(VacationDays);
    If HasHigherEducation Then
        SGMain.Cells[5, I] := 'Есть'
    Else
        SGMain.Cells[5, I] := 'Нет';
    SGMain.Cells[6, I] := IntToStr(AgeRangeMin) + '-' + IntToStr(AgeRangeMax);

    SGMain.RowCount := I + 1;
End;

Procedure TViewVacanciesForm.FormCreate(Sender: TObject);
Begin
    I := 0;

    SGMain.ColCount := 7;
    SGMain.ColWidths[0] := 190; //Firm
    SGMain.ColWidths[1] := 190; //Speciality
    SGMain.ColWidths[2] := 115; //JobTitle
    SGMain.ColWidths[3] := 55; //Wage
    SGMain.ColWidths[4] := 60; //VacationDays
    SGMain.ColWidths[5] := 60; //HasHigherEducation
    SGMain.ColWidths[6] := 70; //AgeRange

    SGMain.Cells[0, 0] := 'Название фирмы';
    SGMain.Cells[1, 0] := 'Наименование специальности';
    SGMain.Cells[2, 0] := 'Должность';
    SGMain.Cells[3, 0] := 'Оклад';
    SGMain.Cells[4, 0] := 'Отпуск';
    SGMain.Cells[5, 0] := 'В. обр.';
    SGMain.Cells[6, 0] := 'Возраст';

    Constraints.MaxHeight := Height;
    Constraints.MaxWidth := Width;
    Constraints.MinHeight := Height;
    Constraints.MinWidth := Width;
End;

Function TViewVacanciesForm.FormHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    FormHelp := True;
End;

End.
