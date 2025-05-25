Program Labor;

uses
  Vcl.Forms,
  LaborExchangeUnit in 'LaborExchangeUnit.pas' {LaborForm},
  AddEditVacancyUnit in 'AddEditVacancyUnit.pas' {AddEditVacancyForm},
  AddEditCandidateUnit in 'AddEditCandidateUnit.pas' {AddEditCandidateForm},
  InstrUnit in 'InstrUnit.pas' {InstrForm},
  DevUnit in 'DevUnit.pas' {DevForm},
  ViewCandidatesUnit in 'ViewCandidatesUnit.pas' {ViewCandidatesForm},
  ViewVacanciesUnit in 'ViewVacanciesUnit.pas' {ViewVacanciesForm},
  SearchUnit in 'SearchUnit.pas' {SearchForm};

{$R *.res}

Begin
    Application.Initialize;
    Application.MainFormOnTaskbar := True;
    Application.CreateForm(TLaborForm, LaborForm);
  Application.CreateForm(TSearchForm, SearchForm);
  Application.Run;

End.
