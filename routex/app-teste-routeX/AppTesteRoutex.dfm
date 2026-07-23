object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 526
  ClientWidth = 1069
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 15
  object ResponseMemo: TMemo
    Left = 0
    Top = 232
    Width = 1069
    Height = 190
    Align = alClient
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1069
    Height = 193
    Align = alTop
    TabOrder = 1
    object Label2: TLabel
      Left = 8
      Top = 19
      Width = 69
      Height = 15
      Caption = 'API Base URL'
    end
    object Label1: TLabel
      Left = 8
      Top = 75
      Width = 110
      Height = 15
      Caption = 'Local route base URL'
    end
    object Label3: TLabel
      Left = 368
      Top = 75
      Width = 22
      Height = 15
      Caption = 'Port'
    end
    object APIBaseURLEdit: TEdit
      Left = 8
      Top = 40
      Width = 425
      Height = 23
      TabOrder = 0
    end
    object RouteBaseURLEdit: TEdit
      Left = 8
      Top = 96
      Width = 345
      Height = 23
      TabOrder = 1
    end
    object LoadExampleButton: TButton
      Left = 8
      Top = 135
      Width = 114
      Height = 25
      Caption = 'Load Example'
      TabOrder = 2
      OnClick = LoadExampleButtonClick
    end
    object PortEdit: TEdit
      Left = 368
      Top = 96
      Width = 65
      Height = 23
      TabOrder = 3
    end
    object StartButton: TButton
      Left = 128
      Top = 135
      Width = 129
      Height = 25
      Caption = 'Start Horse Server'
      TabOrder = 4
      OnClick = StartButtonClick
    end
    object ShutdownButton: TButton
      Left = 263
      Top = 135
      Width = 170
      Height = 25
      Caption = 'Shut down Horse Server'
      TabOrder = 5
      OnClick = ShutdownButtonClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 193
    Width = 1069
    Height = 39
    Align = alTop
    TabOrder = 2
    object Label4: TLabel
      Left = 13
      Top = 10
      Width = 31
      Height = 15
      Caption = 'Route'
    end
    object RouteEdit: TEdit
      Left = 56
      Top = 6
      Width = 297
      Height = 23
      TabOrder = 0
    end
    object GoButton: TButton
      Left = 359
      Top = 6
      Width = 50
      Height = 25
      Caption = 'Go!'
      TabOrder = 1
      OnClick = GoButtonClick
    end
  end
  object Panel4: TPanel
    Left = 0
    Top = 432
    Width = 1069
    Height = 94
    Align = alBottom
    TabOrder = 3
    object StatusMemo: TMemo
      Left = 1
      Top = 1
      Width = 1067
      Height = 92
      Align = alClient
      Font.Charset = ANSI_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Arial Narrow'
      Font.Style = []
      ParentFont = False
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object Panel5: TPanel
    Left = 0
    Top = 422
    Width = 1069
    Height = 10
    Align = alBottom
    TabOrder = 4
  end
end
