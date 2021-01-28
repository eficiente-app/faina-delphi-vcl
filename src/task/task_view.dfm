inherited TaskView: TTaskView
  Caption = 'Tarefa'
  ClientHeight = 700
  ClientWidth = 600
  OnCreate = FormCreate
  ExplicitWidth = 616
  ExplicitHeight = 739
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClientForm: TPanel
    Width = 600
    Height = 700
    ExplicitWidth = 600
    ExplicitHeight = 700
    inherited pnlTitleBar: TPanel
      Width = 600
      ExplicitTop = -1
      ExplicitWidth = 600
      inherited lblTitleForm: TLabel
        Width = 32
        Caption = 'Tarefa'
        Visible = False
        ExplicitWidth = 32
      end
      object cxDBTextEdit1: TcxDBTextEdit
        Left = 40
        Top = 0
        Margins.Left = 0
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        ParentFont = False
        Style.BorderStyle = ebsNone
        Style.Color = 3806736
        Style.Edges = []
        Style.Font.Charset = DEFAULT_CHARSET
        Style.Font.Color = clWindowText
        Style.Font.Height = -11
        Style.Font.Name = 'Segoe UI'
        Style.Font.Style = []
        Style.LookAndFeel.Kind = lfUltraFlat
        Style.Shadow = False
        Style.TextColor = clWhite
        Style.TransparentBorder = False
        Style.IsFontAssigned = True
        StyleDisabled.LookAndFeel.Kind = lfUltraFlat
        StyleFocused.LookAndFeel.Kind = lfUltraFlat
        StyleHot.LookAndFeel.Kind = lfUltraFlat
        TabOrder = 0
        ExplicitTop = 2
        Width = 121
      end
    end
    inherited pnlClientArea: TPanel
      AlignWithMargins = True
      Left = 3
      Top = 65
      Width = 594
      Height = 635
      Margins.Top = 0
      Margins.Bottom = 0
      ExplicitLeft = 3
      ExplicitWidth = 594
      ExplicitHeight = 670
      object bvlSeparadorDireita: TBevel
        AlignWithMargins = True
        Left = 405
        Top = 3
        Width = 1
        Height = 629
        Align = alRight
        Shape = bsRightLine
        Style = bsRaised
        ExplicitLeft = 272
        ExplicitTop = 312
        ExplicitHeight = 50
      end
      object pnlLateralDireita: TPanel
        Left = 409
        Top = 0
        Width = 185
        Height = 635
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitLeft = 408
        ExplicitTop = 6
      end
      object pnlClient: TPanel
        Left = 0
        Top = 0
        Width = 402
        Height = 635
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitLeft = 1
      end
    end
    object pnlStatusColor: TPanel
      Left = 0
      Top = 30
      Width = 600
      Height = 5
      Align = alTop
      BevelOuter = bvNone
      Color = clGray
      ParentBackground = False
      TabOrder = 2
      ExplicitTop = 27
    end
    object pnlTopOptions: TPanel
      Left = 0
      Top = 35
      Width = 600
      Height = 30
      Align = alTop
      BevelOuter = bvNone
      TabOrder = 3
      ExplicitTop = 36
      object cxComboBox1: TcxComboBox
        Left = 0
        Top = 0
        Align = alLeft
        Properties.ImmediateDropDownWhenActivated = True
        Style.BorderStyle = ebsNone
        Style.TransparentBorder = False
        Style.ButtonStyle = btsUltraFlat
        Style.ButtonTransparency = ebtAlways
        TabOrder = 0
        ExplicitTop = 1
        Width = 121
      end
    end
  end
  object cxEditRepository1: TcxEditRepository
    Left = 123
    Top = 337
    PixelsPerInch = 96
    object cxEditRepository1TextItem1: TcxEditRepositoryTextItem
    end
    object cxEditRepository1TextItem2: TcxEditRepositoryTextItem
    end
    object cxEditRepository1MaskItem1: TcxEditRepositoryMaskItem
    end
    object cxEditRepository1ComboBoxItem1: TcxEditRepositoryComboBoxItem
      Properties.Items.Strings = (
        'TEste'
        '1'
        '2'
        '3'
        '4'
        '5')
    end
  end
end
