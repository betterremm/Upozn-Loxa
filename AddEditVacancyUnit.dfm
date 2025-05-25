object AddEditVacancyForm: TAddEditVacancyForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1042#1072#1082#1072#1085#1089#1080#1103
  ClientHeight = 386
  ClientWidth = 186
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
  object Label1: TLabel
    Left = 32
    Top = 19
    Width = 111
    Height = 15
    Caption = #1053#1072#1079#1074#1072#1085#1080#1077' '#1082#1086#1084#1087#1072#1085#1080#1080
  end
  object Label2: TLabel
    Left = 32
    Top = 69
    Width = 85
    Height = 15
    Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1100
  end
  object Label3: TLabel
    Left = 32
    Top = 117
    Width = 62
    Height = 15
    Caption = #1044#1086#1083#1078#1085#1086#1089#1090#1100
  end
  object Label4: TLabel
    Left = 32
    Top = 165
    Width = 51
    Height = 15
    Caption = #1047#1072#1088#1087#1083#1072#1090#1072
  end
  object Label5: TLabel
    Left = 32
    Top = 213
    Width = 84
    Height = 15
    Caption = #1054#1090#1087#1091#1089#1082#1085#1099#1077' '#1076#1085#1080
  end
  object Label7: TLabel
    Left = 32
    Top = 284
    Width = 118
    Height = 15
    Caption = #1042#1086#1079#1088#1072#1089#1090#1085#1086#1081' '#1076#1080#1072#1087#1072#1079#1086#1085
  end
  object Label8: TLabel
    Left = 72
    Top = 308
    Width = 5
    Height = 15
    Caption = '-'
  end
  object EditFirm: TEdit
    Left = 32
    Top = 40
    Width = 121
    Height = 23
    MaxLength = 20
    TabOrder = 0
    OnChange = EditFirmChange
  end
  object EditSpeciality: TEdit
    Left = 32
    Top = 88
    Width = 121
    Height = 23
    MaxLength = 20
    TabOrder = 1
    OnChange = EditSpecialityChange
  end
  object EditJobTitle: TEdit
    Left = 32
    Top = 136
    Width = 121
    Height = 23
    MaxLength = 15
    TabOrder = 2
    OnChange = EditJobTitleChange
  end
  object EditWage: TEdit
    Left = 32
    Top = 184
    Width = 121
    Height = 23
    MaxLength = 8
    TabOrder = 3
    OnChange = EditWageChange
    OnContextPopup = ContextBlock
    OnKeyPress = EditWageKeyPress
  end
  object EditVacationDays: TEdit
    Left = 32
    Top = 232
    Width = 121
    Height = 23
    MaxLength = 3
    TabOrder = 4
    OnChange = EditVacationDaysChange
    OnContextPopup = ContextBlock
  end
  object EditAgeRangeMin: TEdit
    Left = 32
    Top = 306
    Width = 34
    Height = 23
    MaxLength = 2
    TabOrder = 5
    OnChange = EditAgeRangeMinChange
    OnContextPopup = ContextBlock
  end
  object BtnClose: TButton
    Left = 48
    Top = 344
    Width = 75
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Enabled = False
    TabOrder = 6
    OnClick = BtnCloseClick
  end
  object EditAgeRangeMax: TEdit
    Left = 83
    Top = 306
    Width = 34
    Height = 23
    MaxLength = 2
    TabOrder = 7
    OnChange = EditAgeRangeMaxChange
    OnContextPopup = ContextBlock
  end
  object CBHigherEducation: TCheckBox
    Left = 32
    Top = 261
    Width = 146
    Height = 17
    Caption = #1042#1099#1089#1096#1077#1077' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1077
    TabOrder = 8
  end
end
