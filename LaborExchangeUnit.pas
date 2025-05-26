Unit LaborExchangeUnit;

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
    Vcl.Menus,
    Vcl.Grids,
    Vcl.StdCtrls,
    Vcl.NumberBox,
    Vcl.ComCtrls,
    DateUtils;

Type
    TLaborForm = Class(TForm)
        SGMain: TStringGrid;
        MainMenu1: TMainMenu;
        NFile: TMenuItem;
        NSave: TMenuItem;
        NOpen: TMenuItem;
        N: TMenuItem;
        NClose: TMenuItem;
        NInstr: TMenuItem;
        NDev: TMenuItem;
        CBChoice: TComboBox;
        OpenDialog1: TOpenDialog;
        SaveDialog1: TSaveDialog;
        Label1: TLabel;
        BtnAdd: TButton;
        BtnEdit: TButton;
        BtnDelete: TButton;
        BtnFindCandidates: TButton;
        BtnShowDeficitCandidates: TButton;
        BtnSearch: TButton;
        BtnSort: TButton;
        Procedure FormCreate(Sender: TObject);
        Function FormHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
        Procedure ShowVacancies();
        Procedure ShowCandidates();
        Procedure WorkWithVacancies();
        Procedure WorkWithCandidates();
        Procedure CBChoiceChange(Sender: TObject);
        Procedure BtnAddClick(Sender: TObject);
        Procedure AddVacancy(Firm: String; Speciality: String; JobTitle: String; Wage: Integer; VacationDays: Integer;
            HasHigherEducation: Boolean; AgeRangeMin, AgeRangeMax: Integer);
        Procedure AddCandidate(FullName: String; BirthDate: TDate; Speciality: String; HasHigherEducation: Boolean; PrefJobTitle: String;
            MinWage: Integer);
        Procedure SGMainSelectCell(Sender: TObject; ACol, ARow: LongInt; Var CanSelect: Boolean);
        Procedure BtnEditClick(Sender: TObject);
        Procedure NSaveClick(Sender: TObject);
        Procedure NOpenClick(Sender: TObject);
        Procedure NCloseClick(Sender: TObject);
        Procedure NDevClick(Sender: TObject);
        Procedure NInstrClick(Sender: TObject);
        Procedure FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
        Procedure BtnDeleteClick(Sender: TObject);
        Procedure BtnFindCandidatesClick(Sender: TObject);
        Procedure BtnShowDeficitCandidatesClick(Sender: TObject);
        Procedure BtnSearchClick(Sender: TObject);
        Procedure BtnSortClick(Sender: TObject);
    Private
        FileNotSaved: Boolean;
    Public Type

        //типы для вакансий
        PVacancyNode = ^TVacancyNode;

        TAgeRange = Record
            Min, Max: Integer;
        End;

        TVacancyNode = Record
            Firm: String[20];
            Speciality: String[20];
            JobTitle: String[15];
            Wage: Integer;
            VacationDays: Integer;
            HasHigherEducation: Boolean;
            AgeRange: TAgeRange;
            Next, Prev: PVacancyNode;
        End;

        TVacancyList = Record
            Head, Tail: PVacancyNode;
        End;

        //типы для кандидатов
        PCandidateNode = ^TCandidateNode;

        TCandidateNode = Record
            FullName: String[40];
            BirthDate: TDate;
            Speciality: String[20];
            HasHigherEducation: Boolean;
            PrefJobTitle: String[15];
            MinWage: Integer;
            Next, Prev: PCandidateNode;
        End;

        TCandidateList = Record
            Head, Tail: PCandidateNode;
        End;

        //типы для работы с файлами
        TRecordType = (RtUnknown, RtVacancy, RtCandidate);

        TVacancyData = Record
            Firm: String[20];
            Speciality: String[20];
            JobTitle: String[15];
            Wage: Integer;
            VacationDays: Integer;
            HasHigherEducation: Boolean;
            AgeRange: TAgeRange;
        End;

        TCandidateData = Record
            FullName: String[40];
            BirthDate: TDate;
            Speciality: String[20];
            HasHigherEducation: Boolean;
            PrefJobTitle: String[15];
            MinWage: Integer;
        End;

        TUniversalRecord = Record
            RecType: TRecordType;
            Case Byte Of
                0:
                    (Vacancy: TVacancyData);
                1:
                    (Candidate: TCandidateData);
        End;

    Var
        CandidateList: TCandidateList;
        VacancyList: TVacancyList;

    End;

Var
    LaborForm: TLaborForm;

Implementation

{$R *.dfm}

Uses
    AddEditVacancyUnit,
    AddEditCandidateUnit,
    DevUnit,
    InstrUnit,
    ViewCandidatesUnit,
    ViewVacanciesUnit,
    SearchUnit;

Const
    BOOL_STRING_ARRAY: Array [0 .. 1] Of String = ('Нет', 'Есть');

Procedure TLaborForm.AddVacancy(Firm: String; Speciality: String; JobTitle: String; Wage: Integer; VacationDays: Integer;
    HasHigherEducation: Boolean; AgeRangeMin, AgeRangeMax: Integer);
Var
    PVacancy: PVacancyNode;
Begin
    New(PVacancy);
    PVacancy^.Firm := Firm;
    PVacancy^.Speciality := Speciality;
    PVacancy^.JobTitle := JobTitle;
    PVacancy^.Wage := Wage;
    PVacancy^.VacationDays := VacationDays;
    PVacancy^.HasHigherEducation := HasHigherEducation;
    PVacancy^.AgeRange.Min := AgeRangeMin;
    PVacancy^.AgeRange.Max := AgeRangeMax;
    PVacancy^.Next := Nil;
    PVacancy^.Prev := VacancyList.Tail;
    If VacancyList.Head = Nil Then
    Begin
        VacancyList.Tail := PVacancy;
        VacancyList.Head := PVacancy;
    End
    Else
    Begin
        VacancyList.Tail.Next := PVacancy;
        VacancyList.Tail := PVacancy;
    End;
End;

Procedure TLaborForm.AddCandidate(FullName: String; BirthDate: TDate; Speciality: String; HasHigherEducation: Boolean; PrefJobTitle: String;
    MinWage: Integer);
Var
    PCandidate: PCandidateNode;
Begin
    New(PCandidate);
    PCandidate^.FullName := FullName;
    PCandidate^.BirthDate := BirthDate;
    PCandidate^.Speciality := Speciality;
    PCandidate^.HasHigherEducation := HasHigherEducation;
    PCandidate^.PrefJobTitle := PrefJobTitle;
    PCandidate^.MinWage := MinWage;
    PCandidate^.Next := Nil;
    PCandidate^.Prev := CandidateList.Tail;
    If CandidateList.Head = Nil Then
    Begin
        CandidateList.Tail := PCandidate;
        CandidateList.Head := PCandidate;
    End
    Else
    Begin
        CandidateList.Tail.Next := PCandidate;
        CandidateList.Tail := PCandidate;
    End;

End;

Procedure TLaborForm.BtnAddClick(Sender: TObject);
Begin
    If CBChoice.ItemIndex = 0 Then
    Begin
        With AddEditVacancyForm Do
        Begin
            AddEditVacancyForm := TAddEditVacancyForm.Create(Self);
            ShowModal();
            If ClosedByButton Then
            Begin
                AddVacancy(EditFirm.Text, EditSpeciality.Text, EditJobTitle.Text, StrToInt(EditWage.Text), StrToInt(EditVacationDays.Text),
                    CBHigherEducation.Checked, StrToInt(EditAgeRangeMin.Text), StrToInt(EditAgeRangeMax.Text));
                FileNotSaved := True;
            End;
            Destroy;
            AddEditVacancyForm := Nil;
        End;
        ShowVacancies;
    End
    Else
        If CBChoice.ItemIndex = 1 Then
        Begin
            With AddEditCandidateForm Do
            Begin
                AddEditCandidateForm := TAddEditCandidateForm.Create(Self);
                ShowModal();
                If ClosedByButton Then
                Begin
                    AddCandidate(EditFullName.Text, DPBirthDate.Date, EditSpeciality.Text, CBHasHigherEducation.Checked,
                        EditPrefJobTitle.Text, StrToInt(EditMinWage.Text));
                    FileNotSaved := True;
                End;
                Destroy;
                AddEditCandidateForm := Nil;
            End;
            ShowCandidates;
        End;
End;

Procedure TLaborForm.BtnDeleteClick(Sender: TObject);
Var
    DelVacancyNode: PVacancyNode;
    DelCandidateNode: PCandidateNode;
    I: Integer;
Begin
    If CBChoice.ItemIndex = 0 Then
    Begin

        If MessageBox(LaborForm.Handle, 'Вы уверены, что хотите удалить вакансию?', 'Удалить?', MB_ICONWARNING + MB_YESNO) = ID_YES Then
        Begin
            DelVacancyNode := VacancyList.Head;
            For I := 2 To SGMain.Selection.Top Do
                DelVacancyNode := DelVacancyNode.Next;

            If (DelVacancyNode.Prev = Nil) And (DelVacancyNode.Next = Nil) Then
            Begin
                VacancyList.Head := Nil;
                VacancyList.Tail := Nil;
            End
            Else
                If DelVacancyNode.Prev = Nil Then
                Begin
                    VacancyList.Head := VacancyList.Head.Next;
                    DelVacancyNode.Next.Prev := Nil;
                End
                Else
                    If DelVacancyNode.Next = Nil Then
                    Begin
                        VacancyList.Tail := VacancyList.Tail.Prev;
                        DelVacancyNode.Prev.Next := Nil;
                    End
                    Else
                    Begin
                        DelVacancyNode.Prev.Next := DelVacancyNode.Next;
                        DelVacancyNode.Next.Prev := DelVacancyNode.Prev;
                    End;
            Dispose(DelVacancyNode);

            ShowVacancies();
        End;
    End
    Else
        If CBChoice.ItemIndex = 1 Then
        Begin
            If MessageBox(LaborForm.Handle, 'Вы уверены, что хотите удалить кандидата?', 'Удалить?', MB_ICONWARNING + MB_YESNO)
                = ID_YES Then
            Begin
                DelCandidateNode := CandidateList.Head;
                For I := 2 To SGMain.Selection.Top Do
                    DelCandidateNode := DelCandidateNode.Next;

                If (DelCandidateNode.Prev = Nil) And (DelCandidateNode.Next = Nil) Then
                Begin
                    CandidateList.Head := Nil;
                    CandidateList.Tail := Nil;
                End
                Else
                    If DelCandidateNode.Prev = Nil Then
                    Begin
                        CandidateList.Head := CandidateList.Head.Next;
                        DelCandidateNode.Next.Prev := Nil;
                    End
                    Else
                        If DelCandidateNode.Next = Nil Then
                        Begin
                            CandidateList.Tail := CandidateList.Tail.Prev;
                            DelCandidateNode.Prev.Next := Nil;
                        End
                        Else
                        Begin
                            DelCandidateNode.Prev.Next := DelCandidateNode.Next;
                            DelCandidateNode.Next.Prev := DelCandidateNode.Prev;
                        End;
                Dispose(DelCandidateNode);

                ShowCandidates();
            End;
        End;
End;

Procedure TLaborForm.BtnEditClick(Sender: TObject);
Var
    I: Integer;
    TempVacancy: PVacancyNode;
    TempCandidate: PCandidateNode;
Begin
    If CBChoice.ItemIndex = 0 Then
        With AddEditVacancyForm Do
        Begin

            AddEditVacancyForm := TAddEditVacancyForm.Create(Self);
            TempVacancy := VacancyList.Head;
            For I := 2 To SGMain.Selection.Top Do
                TempVacancy := TempVacancy.Next;

            EditFirm.Text := TempVacancy^.Firm;
            EditSpeciality.Text := TempVacancy^.Speciality;
            EditJobTitle.Text := TempVacancy^.JobTitle;
            EditWage.Text := IntToStr(TempVacancy^.Wage);
            EditVacationDays.Text := IntToStr(TempVacancy^.VacationDays);
            CBHigherEducation.Checked := TempVacancy^.HasHigherEducation;
            EditAgeRangeMin.Text := IntToStr(TempVacancy^.AgeRange.Min);
            EditAgeRangeMax.Text := IntToStr(TempVacancy^.AgeRange.Max);
            For I := 1 To 5 Do
                IsFilled[I] := True;
            BtnClose.Enabled := True;
            ShowModal();
            If ClosedByButton Then
            Begin

                TempVacancy^.Firm := EditFirm.Text;
                TempVacancy^.Speciality := EditSpeciality.Text;
                TempVacancy^.JobTitle := EditJobTitle.Text;
                TempVacancy^.Wage := StrToInt(EditWage.Text);
                TempVacancy^.VacationDays := StrToInt(EditVacationDays.Text);
                TempVacancy^.HasHigherEducation := CBHigherEducation.Checked;
                TempVacancy^.AgeRange.Min := StrToInt(EditAgeRangeMin.Text);
                TempVacancy^.AgeRange.Max := StrToInt(EditAgeRangeMax.Text);
                FileNotSaved := True;
            End;
            Destroy;
            AddEditVacancyForm := Nil;
            ShowVacancies;
        End
    Else
        If CBChoice.ItemIndex = 1 Then
            With AddEditCandidateForm Do
            Begin

                AddEditCandidateForm := TAddEditCandidateForm.Create(Self);
                TempCandidate := CandidateList.Head;
                For I := 2 To SGMain.Selection.Top Do
                    TempCandidate := TempCandidate.Next;

                EditFullName.Text := TempCandidate^.FullName;
                DPBirthDate.Date := TempCandidate^.BirthDate;
                EditSpeciality.Text := TempCandidate^.Speciality;
                CBHasHigherEducation.Checked := TempCandidate^.HasHigherEducation;
                EditPrefJobTitle.Text := TempCandidate^.PrefJobTitle;
                EditMinWage.Text := IntToStr(TempCandidate^.MinWage);

                For I := 1 To 4 Do
                    IsFilled[I] := True;
                BtnClose.Enabled := True;
                ShowModal();
                If ClosedByButton Then
                Begin

                    TempCandidate^.FullName := EditFullName.Text;
                    TempCandidate^.BirthDate := DPBirthDate.Date;
                    TempCandidate^.Speciality := EditSpeciality.Text;
                    TempCandidate^.HasHigherEducation := CBHasHigherEducation.Checked;
                    TempCandidate^.PrefJobTitle := EditPrefJobTitle.Text;
                    TempCandidate^.MinWage := StrToInt(EditMinWage.Text);
                    FileNotSaved := True;
                End;
                Destroy;
                AddEditCandidateForm := Nil;
                ShowVacancies;
            End;

End;

Procedure TLaborForm.BtnFindCandidatesClick(Sender: TObject);
Var
    TempVacancyPointer: PVacancyNode;
    TempCandidatePointer: PCandidateNode;
    I: Integer;
Begin
    TempVacancyPointer := VacancyList.Head;
    For I := 2 To SGMain.Selection.Top Do
        TempVacancyPointer := TempVacancyPointer.Next;
    ViewCandidatesForm := TViewCandidatesForm.Create(Self);
    TempCandidatePointer := CandidateList.Head;
    Repeat
        If (TempCandidatePointer^.Speciality = TempVacancyPointer^.Speciality) And
            (TempCandidatePointer^.PrefJobTitle = TempVacancyPointer^.JobTitle) And
            (TempCandidatePointer^.MinWage <= TempVacancyPointer^.Wage) And
            ((Not TempVacancyPointer^.HasHigherEducation) Or TempCandidatePointer^.HasHigherEducation) And
            (YearsBetween(Date, TempCandidatePointer^.BirthDate) >= TempVacancyPointer^.AgeRange.Min) And
            (YearsBetween(Date, TempCandidatePointer^.BirthDate) <= TempVacancyPointer^.AgeRange.Max) Then
            With TempCandidatePointer^ Do
                ViewCandidatesForm.AddCandidate(FullName, BirthDate, Speciality, HasHigherEducation, PrefJobTitle, MinWage);
        TempCandidatePointer := TempCandidatePointer.Next;
    Until TempCandidatePointer = Nil;
    If ViewCandidatesForm.I > 0 Then
    Begin
        ViewCandidatesForm.Caption := 'Кандидаты в фирму "' + TempVacancyPointer^.Firm + '" на должность "' +
            TempVacancyPointer^.JobTitle + '"';
        ViewCandidatesForm.ShowModal;
    End
    Else
        MessageBox(LaborForm.Handle, 'Нет подходящих кандидатов!', 'Внимание!', MB_ICONWARNING + MB_OK);
    ViewCandidatesForm.Destroy;
    ViewCandidatesForm := Nil;

End;

Procedure TLaborForm.BtnSearchClick(Sender: TObject);
Var
    TempVacancyPointer: PVacancyNode;
    TempCandidatePointer: PCandidateNode;
Begin
    SearchForm := TSearchForm.Create(Self);
    SearchForm.ShowModal;
    If SearchForm.ClosedByButton Then
    Begin
        If CBChoice.ItemIndex = 0 Then
        Begin
            //vac
            ViewVacanciesForm := TViewVacanciesForm.Create(Self);
            TempVacancyPointer := VacancyList.Head;
            Repeat
                If (SearchForm.EditSpeciality.Text = TempVacancyPointer^.Speciality) Then
                    With TempVacancyPointer^ Do
                        ViewVacanciesForm.AddVacancy(Firm, Speciality, JobTitle, Wage, VacationDays, HasHigherEducation, AgeRange.Min,
                            AgeRange.Max);
            Until TempVacancyPointer = Nil;
            If ViewVacanciesForm.I > 0 Then
                ViewVacanciesForm.ShowModal
            Else
                MessageBox(LaborForm.Handle, 'Нет подходящих вакансий!', 'Внимание!', MB_ICONWARNING + MB_OK);

            ViewVacanciesForm.Free;
            ViewVacanciesForm := Nil;
        End
        Else
        Begin
            ViewCandidatesForm := TViewCandidatesForm.Create(Self);
            TempCandidatePointer := CandidateList.Head;
            Repeat
                If (SearchForm.EditSpeciality.Text = TempCandidatePointer^.Speciality) Then
                    With TempCandidatePointer^ Do
                        ViewCandidatesForm.AddCandidate(FullName, BirthDate, Speciality, HasHigherEducation, PrefJobTitle, MinWage);
            Until TempCandidatePointer = Nil;
            If ViewCandidatesForm.I > 0 Then
                ViewCandidatesForm.ShowModal
            Else
                MessageBox(LaborForm.Handle, 'Нет подходящих кандидатов!', 'Внимание!', MB_ICONWARNING + MB_OK);

            ViewCandidatesForm.Free;
            ViewCandidatesForm := Nil;
        End;
    End;
    SearchForm.Free;
    SearchForm := Nil;
End;

Procedure TLaborForm.BtnShowDeficitCandidatesClick(Sender: TObject);
Type
    TStat = Record
        JobTitle: String;
        VacancyCount: Integer;
        CandidateCount: Integer;
    End;
Var
    VacancyPtr: PVacancyNode;
    CandidatePtr: PCandidateNode;
    Stats: Array Of TStat;
    I: Integer;
    Found: Boolean;
    DeficitJobs: Array Of String;
Begin
    VacancyPtr := VacancyList.Head;
    While VacancyPtr <> Nil Do
    Begin
        Found := False;
        I := 0;
        While (I < Length(Stats)) And Not Found Do
        Begin
            If Stats[I].JobTitle = VacancyPtr^.JobTitle Then
            Begin
                Inc(Stats[I].VacancyCount);
                Found := True;

            End;
            Inc(I);
        End;

        If Not Found Then
        Begin
            SetLength(Stats, Length(Stats) + 1);
            Stats[High(Stats)].JobTitle := VacancyPtr^.JobTitle;
            Stats[High(Stats)].VacancyCount := 1;
            Stats[High(Stats)].CandidateCount := 0;
        End;

        VacancyPtr := VacancyPtr^.Next;
    End;

    CandidatePtr := CandidateList.Head;
    While CandidatePtr <> Nil Do
    Begin
        I := 0;
        Found := False;
        While (I < Length(Stats)) And Not Found Do
        Begin
            If Stats[I].JobTitle = CandidatePtr^.PrefJobTitle Then
            Begin
                Inc(Stats[I].CandidateCount);
                Found := True;
            End;
            Inc(I);
        End;
        CandidatePtr := CandidatePtr^.Next;
    End;

    SetLength(DeficitJobs, 0);
    For I := 0 To High(Stats) Do
        If (Stats[I].VacancyCount > 0) And (Stats[I].CandidateCount / Stats[I].VacancyCount < 0.1) Then
        Begin
            SetLength(DeficitJobs, Length(DeficitJobs) + 1);
            DeficitJobs[High(DeficitJobs)] := Stats[I].JobTitle;
        End;

    ViewCandidatesForm := TViewCandidatesForm.Create(Self);
    Try
        CandidatePtr := CandidateList.Head;
        While CandidatePtr <> Nil Do
        Begin
            I := 0;
            Found := False;
            While (I < Length(DeficitJobs)) And Not Found Do
            Begin
                If CandidatePtr^.PrefJobTitle = DeficitJobs[I] Then
                Begin
                    With CandidatePtr^ Do
                        ViewCandidatesForm.AddCandidate(FullName, BirthDate, Speciality, HasHigherEducation, PrefJobTitle, MinWage);
                    Found := True;
                End;
                Inc(I);
            End;
            CandidatePtr := CandidatePtr^.Next;
        End;

        If ViewCandidatesForm.I > 0 Then
        Begin
            ViewCandidatesForm.Caption := 'Кандидаты по дефицитным специальностям';
            ViewCandidatesForm.ShowModal;
        End
        Else
            MessageBox(LaborForm.Handle, 'Кандидатов по дефицитным специальностям не найдено.', 'Внимание!', MB_OK + MB_ICONWarning);
    Finally
        ViewCandidatesForm.Free;
        ViewCandidatesForm := Nil;
    End;
End;

Procedure TLaborForm.CBChoiceChange(Sender: TObject);
Begin
    If CBChoice.ItemIndex = 0 Then
        WorkWithVacancies()
    Else
        WorkWithCandidates();

End;

Procedure TLaborForm.FormCloseQuery(Sender: TObject; Var CanClose: Boolean);
Var
    Res: Integer;
Begin
    CanClose := True;
    Repeat
        If FileNotSaved Then
        Begin
            Res := MessageBox(LaborForm.Handle, 'Хотите сохранить файл перед выходом?', 'Сохранить?', MB_ICONQUESTION + MB_YESNOCANCEL);
            If Res = ID_YES Then
                NSaveClick(Sender)
            Else
                If Res = ID_CANCEL Then
                Begin
                    CanClose := False;
                    Res := ID_NO;
                End;
        End;
    Until (Not FileNotSaved) Or (Res = ID_NO);
End;

Procedure TLaborForm.FormCreate(Sender: TObject);
Begin
    FileNotSaved := True;
    CandidateList.Head := Nil;
    CandidateList.Tail := Nil;
    VacancyList.Head := Nil;
    VacancyList.Tail := Nil;
    Constraints.MaxHeight := Height;
    Constraints.MaxWidth := Width;
    Constraints.MinHeight := Height;
    Constraints.MinWidth := Width;
End;

Procedure TLaborForm.ShowVacancies();
Var
    TempNodePointer: PVacancyNode;
    I: Integer;
Begin
    I := 1;
    If VacancyList.Head = Nil Then
    Begin
        SGMain.Rows[1].Clear;
        SGMain.RowCount := 2;
        BtnDelete.Enabled := False;
        BtnEdit.Enabled := False;
        BtnSearch.Enabled := False;
        BtnSort.Enabled := False;
    End
    Else
    Begin
        TempNodePointer := VacancyList.Head;
        Repeat
        Begin
            SGMain.Cells[0, I] := TempNodePointer^.Firm;
            SGMain.Cells[1, I] := TempNodePointer^.Speciality;
            SGMain.Cells[2, I] := TempNodePointer^.JobTitle;
            SGMain.Cells[3, I] := IntToStr(TempNodePointer^.Wage);
            SGMain.Cells[4, I] := IntToStr(TempNodePointer^.VacationDays);
            SGMain.Cells[5, I] := BOOL_STRING_ARRAY[Ord(TempNodePointer^.HasHigherEducation)];
            SGMain.Cells[6, I] := IntToStr(TempNodePointer^.AgeRange.Min) + '-' + IntToStr(TempNodePointer^.AgeRange.Max);
            Inc(I);
            TempNodePointer := TempNodePointer.Next;
        End
        Until TempNodePointer = Nil;
        SGMain.RowCount := I;
        BtnSearch.Enabled := True;
        BtnSort.Enabled := True;

    End;
    If (CandidateList.Head <> Nil) And (VacancyList.Head <> Nil) Then
        BtnShowDeficitCandidates.Enabled := True
    Else
        BtnShowDeficitCandidates.Enabled := False;

End;

Procedure TLaborForm.SGMainSelectCell(Sender: TObject; ACol, ARow: LongInt; Var CanSelect: Boolean);
Begin
    If ((CBChoice.ItemIndex = 0) And (VacancyList.Head <> Nil)) Or ((CBChoice.ItemIndex = 1) And (CandidateList.Head <> Nil)) Then
    Begin
        BtnDelete.Enabled := True;
        BtnEdit.Enabled := True;

    End
    Else
    Begin
        BtnDelete.Enabled := False;
        BtnEdit.Enabled := False;
    End;

    If (CBChoice.ItemIndex = 0) And (VacancyList.Head <> Nil) And (CandidateList.Head <> Nil) Then
        BtnFindCandidates.Enabled := True
    Else
        BtnFindCandidates.Enabled := False;

End;

Procedure TLaborForm.ShowCandidates();
Var
    TempNodePointer: PCandidateNode;
    I: Integer;
Begin
    I := 1;
    If CandidateList.Head = Nil Then
    Begin
        SGMain.Rows[1].Clear;
        SGMain.RowCount := 2;
        BtnDelete.Enabled := False;
        BtnEdit.Enabled := False;
        BtnSearch.Enabled := False;
        BtnSort.Enabled := False;
    End
    Else
    Begin
        TempNodePointer := CandidateList.Head;
        Repeat
        Begin
            SGMain.Cells[0, I] := TempNodePointer^.FullName;
            SGMain.Cells[1, I] := DateToStr(TempNodePointer^.BirthDate);
            SGMain.Cells[2, I] := TempNodePointer^.Speciality;
            SGMain.Cells[3, I] := BOOL_STRING_ARRAY[Ord(TempNodePointer^.HasHigherEducation)];
            SGMain.Cells[4, I] := TempNodePointer^.PrefJobTitle;;
            SGMain.Cells[5, I] := IntToStr(TempNodePointer^.MinWage);
            Inc(I);
            TempNodePointer := TempNodePointer.Next;
        End
        Until TempNodePointer = Nil;
        SGMain.RowCount := I;
        BtnSearch.Enabled := True;
        BtnSort.Enabled := True;
    End;
    If (CandidateList.Head <> Nil) And (VacancyList.Head <> Nil) Then
        BtnShowDeficitCandidates.Enabled := True
    Else
        BtnShowDeficitCandidates.Enabled := False;
End;

Procedure TLaborForm.WorkWithVacancies();
Begin
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

    ShowVacancies;
    SGMain.Visible := True;
    BtnAdd.Enabled := True;
End;

Procedure TLaborForm.WorkWithCandidates();
Begin
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
    ShowCandidates;
    SGMain.Visible := True;
    BtnAdd.Enabled := True;
End;

Function TLaborForm.FormHelp(Command: Word; Data: THelpEventData; Var CallHelp: Boolean): Boolean;
Begin
    CallHelp := False;
    FormHelp := True;
End;

Procedure TLaborForm.NCloseClick(Sender: TObject);
Begin
    Close
End;

Procedure TLaborForm.NDevClick(Sender: TObject);
Begin
    DevForm := TDevForm.Create(Self);
    DevForm.ShowModal();
    DevForm.Destroy;
    DevForm := Nil;
End;

Procedure TLaborForm.NInstrClick(Sender: TObject);
Begin
    InstrForm := TInstrForm.Create(Self);
    InstrForm.ShowModal();
    InstrForm.Destroy;
    InstrForm := Nil;
End;

Procedure TLaborForm.NOpenClick(Sender: TObject);
Var
    FileRec: File Of TUniversalRecord;
    URec: TUniversalRecord;
    PVac: PVacancyNode;
    PCand: PCandidateNode;
    AFileName: String;
Begin
    If OpenDialog1.Execute Then
        Try
            AFileName := OpenDialog1.FileName;
            If AFileName.EndsWith('.dat') Then
            Begin
                AssignFile(FileRec, AFileName);
                {$I-} Reset(FileRec); {$I+}
                If IOResult <> 0 Then
                    MessageBox(LaborForm.Handle, 'Невозможно получить доступ к этому файлу', 'Внимание!', MB_ICONWARNING + MB_OK)
                Else
                Begin

                    While Not Eof(FileRec) Do
                    Begin
                        Read(FileRec, URec);
                        Case URec.RecType Of
                            RtVacancy:
                                Begin
                                    New(PVac);
                                    PVac^.Firm := URec.Vacancy.Firm;
                                    PVac^.Speciality := URec.Vacancy.Speciality;
                                    PVac^.JobTitle := URec.Vacancy.JobTitle;
                                    PVac^.Wage := URec.Vacancy.Wage;
                                    PVac^.VacationDays := URec.Vacancy.VacationDays;
                                    PVac^.HasHigherEducation := URec.Vacancy.HasHigherEducation;
                                    PVac^.AgeRange := URec.Vacancy.AgeRange;
                                    PVac^.Next := Nil;
                                    PVac^.Prev := VacancyList.Tail;
                                    If VacancyList.Head = Nil Then
                                        VacancyList.Head := PVac
                                    Else
                                        VacancyList.Tail^.Next := PVac;
                                    VacancyList.Tail := PVac;
                                End;

                            RtCandidate:
                                Begin
                                    New(PCand);
                                    PCand^.FullName := URec.Candidate.FullName;
                                    PCand^.BirthDate := URec.Candidate.BirthDate;
                                    PCand^.Speciality := URec.Candidate.Speciality;
                                    PCand^.HasHigherEducation := URec.Candidate.HasHigherEducation;
                                    PCand^.PrefJobTitle := URec.Candidate.PrefJobTitle;
                                    PCand^.MinWage := URec.Candidate.MinWage;
                                    PCand^.Next := Nil;
                                    PCand^.Prev := CandidateList.Tail;
                                    If CandidateList.Head = Nil Then
                                        CandidateList.Head := PCand
                                    Else
                                        CandidateList.Tail^.Next := PCand;
                                    CandidateList.Tail := PCand;
                                End;
                        End;
                    End;

                    CloseFile(FileRec);
                    MessageBox(LaborForm.Handle, 'Файл был успешно открыт!', 'Успех!', MB_ICONINFORMATION + MB_OK);
                End;
            End
            Else
                MessageBox(LaborForm.Handle, 'Файл имеет некорректное расширение. (Не *.dat) ', 'Внимание!', MB_ICONWARNING + MB_OK);

        Except
            MessageBox(LaborForm.Handle, 'Невозможно получить доступ к этому файлу', 'Внимание!', MB_ICONWARNING + MB_OK)

        End;
    If CBChoice.ItemIndex = 0 Then
        ShowVacancies
    Else
        ShowCandidates;
End;

Procedure TLaborForm.NSaveClick(Sender: TObject);
Var
    FileRec: File Of TUniversalRecord;
    CurrVac: PVacancyNode;
    CurrCand: PCandidateNode;
    URec: TUniversalRecord;
    AFileName: String;
Begin
    If SaveDialog1.Execute Then
        Try
            AFileName := SaveDialog1.FileName;
            If AFileName.EndsWith('.dat') Then
            Begin
                AssignFile(FileRec, AFileName);
                {$I-} Rewrite(FileRec); {$I+}
                If IOResult <> 0 Then
                    MessageBox(LaborForm.Handle, 'Невозможно получить доступ к этому файлу', 'Внимание!', MB_ICONWARNING + MB_OK)
                Else
                Begin

                    CurrVac := VacancyList.Head;
                    While Assigned(CurrVac) Do
                    Begin
                        URec.RecType := RtVacancy;
                        URec.Vacancy.Firm := CurrVac^.Firm;
                        URec.Vacancy.Speciality := CurrVac^.Speciality;
                        URec.Vacancy.JobTitle := CurrVac^.JobTitle;
                        URec.Vacancy.Wage := CurrVac^.Wage;
                        URec.Vacancy.VacationDays := CurrVac^.VacationDays;
                        URec.Vacancy.HasHigherEducation := CurrVac^.HasHigherEducation;
                        URec.Vacancy.AgeRange := CurrVac^.AgeRange;
                        Write(FileRec, URec);
                        CurrVac := CurrVac^.Next;
                    End;

                    CurrCand := CandidateList.Head;
                    While Assigned(CurrCand) Do
                    Begin
                        URec.RecType := RtCandidate;
                        URec.Candidate.FullName := CurrCand^.FullName;
                        URec.Candidate.BirthDate := CurrCand^.BirthDate;
                        URec.Candidate.Speciality := CurrCand^.Speciality;
                        URec.Candidate.HasHigherEducation := CurrCand^.HasHigherEducation;
                        URec.Candidate.PrefJobTitle := CurrCand^.PrefJobTitle;
                        URec.Candidate.MinWage := CurrCand^.MinWage;
                        Write(FileRec, URec);
                        CurrCand := CurrCand^.Next;
                    End;

                    CloseFile(FileRec);
                    MessageBox(LaborForm.Handle, 'Файл был успешно сохранен!', 'Успех!', MB_ICONINFORMATION + MB_OK);
                    FileNotSaved := False;
                End;
            End
            Else
                MessageBox(LaborForm.Handle, 'Файл имеет некорректное расширение. (Не *.dat) ', 'Внимание!', MB_ICONWARNING + MB_OK);
        Except
            MessageBox(LaborForm.Handle, 'Невозможно получить доступ к этому файлу', 'Внимание!', MB_ICONWARNING + MB_OK)
        End;
End;

Procedure TLaborForm.BtnSortClick(Sender: TObject);
Var
    Sorted, Current, NextNode, InsertPos: PCandidateNode;
    VSorted, VCurrent, VNextNode, VInsertPos: PVacancyNode;
Begin
    If CBChoice.ItemIndex = 0 Then
    Begin
        If VacancyList.Head <> VacancyList.Tail Then
        Begin

            VSorted := Nil;
            VCurrent := VacancyList.Head;

            While VCurrent <> Nil Do
            Begin
                VNextNode := VCurrent^.Next;

                VInsertPos := VSorted;
                While (VInsertPos <> Nil) And (AnsiCompareText(VCurrent^.Speciality, VInsertPos^.Speciality) > 0) Do
                    VInsertPos := VInsertPos^.Next;

                If VInsertPos = Nil Then
                Begin
                    VCurrent^.Prev := Nil;
                    VCurrent^.Next := Nil;
                    If VSorted = Nil Then
                        VSorted := VCurrent
                    Else
                    Begin
                        Var
                        VLast := VSorted;
                        While VLast^.Next <> Nil Do
                            VLast := VLast^.Next;
                        VLast^.Next := VCurrent;
                        VCurrent^.Prev := VLast;
                    End;
                End
                Else
                    If VInsertPos = VSorted Then
                    Begin
                        VCurrent^.Next := VSorted;
                        VCurrent^.Prev := Nil;
                        VSorted^.Prev := VCurrent;
                        VSorted := VCurrent;
                    End
                    Else
                    Begin
                        VCurrent^.Next := VInsertPos;
                        VCurrent^.Prev := VInsertPos^.Prev;
                        VInsertPos^.Prev^.Next := VCurrent;
                        VInsertPos^.Prev := VCurrent;
                    End;

                VCurrent := VNextNode;
            End;

            VacancyList.Head := VSorted;
            VacancyList.Tail := VSorted;
            While VacancyList.Tail^.Next <> Nil Do
                VacancyList.Tail := VacancyList.Tail^.Next;
        End;
        ShowVacancies
    End
    Else
    Begin
        If CandidateList.Head <> CandidateList.Tail Then
        Begin

            Sorted := Nil;
            Current := CandidateList.Head;

            While Current <> Nil Do
            Begin
                NextNode := Current^.Next;

                InsertPos := Sorted;
                While (InsertPos <> Nil) And (AnsiCompareText(Current^.Speciality, InsertPos^.Speciality) > 0) Do
                    InsertPos := InsertPos^.Next;

                If InsertPos = Nil Then
                Begin
                    Current^.Prev := Nil;
                    Current^.Next := Nil;
                    If Sorted = Nil Then
                        Sorted := Current
                    Else
                    Begin
                        Var
                        Last := Sorted;
                        While Last^.Next <> Nil Do
                            Last := Last^.Next;
                        Last^.Next := Current;
                        Current^.Prev := Last;
                    End;
                End
                Else
                    If InsertPos = Sorted Then
                    Begin
                        Current^.Next := Sorted;
                        Current^.Prev := Nil;
                        Sorted^.Prev := Current;
                        Sorted := Current;
                    End
                    Else
                    Begin
                        Current^.Next := InsertPos;
                        Current^.Prev := InsertPos^.Prev;
                        InsertPos^.Prev^.Next := Current;
                        InsertPos^.Prev := Current;
                    End;

                Current := NextNode;
            End;

            CandidateList.Head := Sorted;
            CandidateList.Tail := Sorted;
            While CandidateList.Tail^.Next <> Nil Do
                CandidateList.Tail := CandidateList.Tail^.Next;
        End;
        ShowCandidates
    End;
End;

End.
