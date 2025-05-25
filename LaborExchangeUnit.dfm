object LaborForm: TLaborForm
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #1041#1080#1088#1078#1072' '#1090#1088#1091#1076#1072
  ClientHeight = 441
  ClientWidth = 753
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = MainMenu1
  Position = poScreenCenter
  OnCloseQuery = FormCloseQuery
  OnCreate = FormCreate
  OnHelp = FormHelp
  TextHeight = 15
  object Label1: TLabel
    Left = 8
    Top = 3
    Width = 182
    Height = 15
    Caption = #1042#1099#1073#1077#1088#1080#1090#1077' '#1089#1087#1080#1089#1086#1082' '#1076#1083#1103' '#1087#1088#1086#1089#1084#1086#1090#1088#1072
  end
  object SGMain: TStringGrid
    Left = 0
    Top = 216
    Width = 753
    Height = 224
    ColCount = 7
    FixedCols = 0
    RowCount = 2
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect, goFixedRowDefAlign]
    ScrollBars = ssHorizontal
    TabOrder = 0
    Visible = False
    OnSelectCell = SGMainSelectCell
  end
  object CBChoice: TComboBox
    Left = 8
    Top = 24
    Width = 145
    Height = 23
    Style = csDropDownList
    TabOrder = 1
    OnChange = CBChoiceChange
    Items.Strings = (
      #1042#1072#1082#1072#1085#1089#1080#1080
      #1050#1072#1085#1076#1080#1076#1072#1090#1099)
  end
  object BtnAdd: TButton
    Left = 19
    Top = 65
    Width = 75
    Height = 25
    Caption = #1044#1086#1073#1072#1074#1080#1090#1100
    Enabled = False
    TabOrder = 2
    OnClick = BtnAddClick
  end
  object BtnEdit: TButton
    Left = 19
    Top = 112
    Width = 75
    Height = 25
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100
    Enabled = False
    TabOrder = 3
    OnClick = BtnEditClick
  end
  object BtnDelete: TButton
    Left = 19
    Top = 160
    Width = 75
    Height = 25
    Caption = #1059#1076#1072#1083#1080#1090#1100
    Enabled = False
    TabOrder = 4
    OnClick = BtnDeleteClick
  end
  object BtnFindCandidates: TButton
    Left = 328
    Top = 160
    Width = 137
    Height = 25
    Caption = #1055#1086#1076#1086#1073#1088#1072#1090#1100' '#1082#1072#1085#1076#1080#1076#1072#1090#1086#1074
    Enabled = False
    TabOrder = 5
    OnClick = BtnFindCandidatesClick
  end
  object BtnShowDeficitCandidates: TButton
    Left = 487
    Top = 160
    Width = 202
    Height = 25
    Caption = #1055#1086#1082#1072#1079#1072#1090#1100' '#1076#1077#1092#1080#1094#1080#1090#1085#1099#1093' '#1082#1072#1085#1076#1080#1076#1072#1090#1086#1074
    Enabled = False
    TabOrder = 6
    OnClick = BtnShowDeficitCandidatesClick
  end
  object BtnSearch: TButton
    Left = 128
    Top = 160
    Width = 161
    Height = 25
    Caption = #1055#1086#1080#1089#1082' '#1087#1086' '#1089#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1080
    Enabled = False
    TabOrder = 7
    OnClick = BtnSearchClick
  end
  object BtnSort: TButton
    Left = 487
    Top = 129
    Width = 201
    Height = 25
    Caption = #1057#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100' '#1087#1086' '#1089#1087#1077#1094#1080#1072#1083#1100#1085#1086#1089#1090#1080
    Enabled = False
    TabOrder = 8
    OnClick = BtnSortClick
  end
  object MainMenu1: TMainMenu
    Left = 728
    Top = 40
    object NFile: TMenuItem
      Caption = #1060#1072#1081#1083
      object NSave: TMenuItem
        Caption = #1057#1086#1093#1088#1072#1085#1080#1090#1100
        ShortCut = 16467
        OnClick = NSaveClick
      end
      object NOpen: TMenuItem
        Caption = #1054#1090#1082#1088#1099#1090#1100
        ShortCut = 16463
        OnClick = NOpenClick
      end
      object N: TMenuItem
        Caption = '-'
      end
      object NClose: TMenuItem
        Caption = #1047#1072#1082#1088#1099#1090#1100
        ShortCut = 16465
        OnClick = NCloseClick
      end
    end
    object NInstr: TMenuItem
      Caption = #1048#1085#1089#1090#1088#1091#1082#1094#1080#1103
      OnClick = NInstrClick
    end
    object NDev: TMenuItem
      Caption = #1054' '#1088#1072#1079#1088#1072#1073#1086#1090#1095#1080#1082#1077
      OnClick = NDevClick
    end
  end
  object OpenDialog1: TOpenDialog
    Filter = #1058#1080#1087#1080#1079#1080#1088#1086#1074#1072#1085#1085#1099#1081' '#1092#1072#1081#1083'|*.dat'
    Left = 728
    Top = 136
  end
  object SaveDialog1: TSaveDialog
    Filter = #1058#1080#1087#1080#1079#1080#1088#1086#1074#1072#1085#1085#1099#1081' '#1092#1072#1081#1083'|*.dat'
    Left = 728
    Top = 88
  end
end
