Unit ViewCandidatesUnit;

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

    TViewCandidatesForm = Class(TForm)
        SGMain: TStringGrid;
        Procedure FormCreate(Sender: TObject);
        Function FormHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
        Procedure AddCandidate(FullName: String; BirthDate: TDate; Speciality: String; HasHigherEducation: Boolean; PrefJobTitle: String;
            MinWage: Integer);
    Private
        { Private declarations }
    Public
        I: Integer;
    End;

Var
    ViewCandidatesForm: TViewCandidatesForm;

Implementation

{$R *.dfm}

Procedure TViewCandidatesForm.AddCandidate(FullName: String; BirthDate: TDate; Speciality: String; HasHigherEducation: Boolean;
    PrefJobTitle: String; MinWage: Integer);
Begin
    Inc(I);
    SGMain.Cells[0, I] := FullName;
    SGMain.Cells[1, I] := DateToStr(BirthDate);
    SGMain.Cells[2, I] := Speciality;
    If HasHigherEducation Then
        SGMain.Cells[3, I] := 'Есть'
    Else
        SGMain.Cells[3, I] := 'Нет';
    SGMain.Cells[4, I] := PrefJobTitle;;
    SGMain.Cells[5, I] := IntToStr(MinWage);
    SGMain.RowCount := I + 1;
End;

Procedure TViewCandidatesForm.FormCreate(Sender: TObject);
Begin
    I := 0;
    Constraints.MaxHeight := Height;
    Constraints.MaxWidth := Width;
    Constraints.MinHeight := Height;
    Constraints.MinWidth := Width;
    SGMain.ColCount := 6;
    SGMain.ColWidths[0] := 180; //FullName
    SGMain.ColWidths[1] := 80; //BirthDate
    SGMain.ColWidths[2] := 160; //Speciality
    SGMain.ColWidths[3] := 60; //HasHigherEducation
    SGMain.ColWidths[4] := 115; //PrefJobTitle
    SGMain.ColWidths[5] := 55; //MinWage

    SGMain.Cells[0, 0] := 'ФИО';
    SGMain.Cells[1, 0] := 'Дата рожд.';
    SGMain.Cells[2, 0] := 'Специальность';
    SGMain.Cells[3, 0] := 'В. обр';
    SGMain.Cells[4, 0] := 'Должность';
    SGMain.Cells[5, 0] := 'Оклад';
    SGMain.ColCount := 6;
End;

Function TViewCandidatesForm.FormHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    FormHelp := True;
End;

End.
