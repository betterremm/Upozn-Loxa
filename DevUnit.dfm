object DevForm: TDevForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = #1054' '#1088#1072#1079#1088#1072#1073#1086#1090#1080#1095#1082#1077
  ClientHeight = 205
  ClientWidth = 343
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
    Left = 24
    Top = 8
    Width = 203
    Height = 128
    Caption = #1051#1077#1096#1072' '#1093#1091#1081#1082#1080#1085#13#10#1041#1043#1059#1048#1056', '#1060#1050#1057#1048#1057' '#1055#1048#13#10'1 '#1082#1091#1088#1089#13#10'tg: mishas23'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -24
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object CloseDevBtn: TButton
    Left = 136
    Top = 160
    Width = 75
    Height = 25
    Caption = #1047#1072#1082#1088#1099#1090#1100
    TabOrder = 0
    OnClick = CloseDevBtnClick
  end
end
