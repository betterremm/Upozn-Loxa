object AddEditCandidateForm: TAddEditCandidateForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1050#1072#1085#1076#1080#1076#1072#1090
  ClientHeight = 351
  ClientWidth = 285
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
    Left = 40
    Top = 8
    Width = 27
    Height = 15
    Caption = #1060#1048#1054
  end
  object Label2: TLabel
    Left = 40
    Top = 58
    Width = 83
    Height = 15
    Caption = #1044#1072#1090#1072' '#1088#1086#1078#1076#1077#1085#1080#1103
  end
  object Label3: TLabel
    Left = 40
    Top = 119
    Width = 85
    Height = 15
    Caption = #1057#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1100
  end
  object Label4: TLabel
    Left = 40
    Top = 188
    Width = 120
    Height = 15
    Caption = #1046#1077#1083#1072#1077#1084#1072#1103' '#1076#1086#1083#1078#1085#1086#1089#1090#1100
  end
  object Label5: TLabel
    Left = 40
    Top = 238
    Width = 118
    Height = 15
    Caption = #1052#1080#1085#1080#1084#1072#1083#1100#1085#1099#1081' '#1086#1082#1083#1072#1076
  end
  object EditFullName: TEdit
    Left = 40
    Top = 29
    Width = 209
    Height = 23
    TabOrder = 0
    OnChange = EditFullNameChange
  end
  object EditSpeciality: TEdit
    Left = 40
    Top = 136
    Width = 209
    Height = 23
    TabOrder = 1
    OnChange = EditSpecialityChange
  end
  object EditPrefJobTitle: TEdit
    Left = 40
    Top = 209
    Width = 209
    Height = 23
    TabOrder = 2
    OnChange = EditPrefJobTitleChange
  end
  object EditMinWage: TEdit
    Left = 40
    Top = 259
    Width = 209
    Height = 23
    TabOrder = 3
    OnChange = EditMinWageChange
    OnKeyPress = EditMinWageKeyPress
  end
  object CBHasHigherEducation: TCheckBox
    Left = 40
    Top = 165
    Width = 209
    Height = 17
    Caption = #1042#1099#1089#1096#1077#1077' '#1086#1073#1088#1072#1079#1086#1074#1072#1085#1080#1077
    TabOrder = 4
  end
  object BtnClose: TButton
    Left = 96
    Top = 304
    Width = 97
    Height = 25
    Caption = #1055#1088#1080#1085#1103#1090#1100
    Enabled = False
    TabOrder = 5
    OnClick = BtnCloseClick
  end
  object DPBirthDate: TDatePicker
    Left = 40
    Top = 79
    Date = 45801.000000000000000000
    DateFormat = 'dd/mm/yyyy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Segoe UI'
    Font.Style = []
    MaxYear = 2025
    TabOrder = 6
    OnChange = DPBirthDateChange
  end
end
