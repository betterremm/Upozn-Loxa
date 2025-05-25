object SearchForm: TSearchForm
  Left = 0
  Top = 0
  Caption = #1055#1086#1080#1089#1082
  ClientHeight = 91
  ClientWidth = 367
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  OnHelp = FormHelp
  TextHeight = 15
  object Label1: TLabel
    Left = 40
    Top = 27
    Width = 85
    Height = 15
    Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1100
  end
  object EditSpeciality: TEdit
    Left = 40
    Top = 48
    Width = 121
    Height = 23
    MaxLength = 20
    TabOrder = 0
  end
  object BtnFind: TButton
    Left = 248
    Top = 31
    Width = 75
    Height = 25
    Caption = #1053#1072#1081#1090#1080
    Enabled = False
    TabOrder = 1
    OnClick = BtnFindClick
  end
end
