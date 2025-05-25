object ViewCandidatesForm: TViewCandidatesForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1072#1085#1076#1080#1076#1072#1090#1099
  ClientHeight = 226
  ClientWidth = 682
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnHelp = FormHelp
  TextHeight = 15
  object SGMain: TStringGrid
    Left = 0
    Top = 0
    Width = 681
    Height = 225
    FixedCols = 0
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect, goFixedRowDefAlign]
    ScrollBars = ssVertical
    TabOrder = 0
  end
end
