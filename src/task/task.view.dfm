inherited TaskView: TTaskView
  Caption = 'Tarefa'
  ClientHeight = 700
  ClientWidth = 600
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
      ExplicitWidth = 600
      inherited lblTitleForm: TLabel
        Width = 32
        Caption = 'Tarefa'
        ExplicitWidth = 32
      end
    end
    inherited pnlClientArea: TPanel
      AlignWithMargins = True
      Left = 3
      Width = 594
      Height = 670
      Margins.Top = 0
      Margins.Bottom = 0
      ExplicitLeft = 3
      ExplicitWidth = 594
      ExplicitHeight = 670
      object bvlSeparadorDireita: TBevel
        AlignWithMargins = True
        Left = 405
        Top = 65
        Width = 1
        Height = 602
        Align = alRight
        Shape = bsRightLine
        Style = bsRaised
        ExplicitLeft = 272
        ExplicitTop = 312
        ExplicitHeight = 50
      end
      object dbedtName: TDBEdit
        Left = 0
        Top = 0
        Width = 594
        Height = 21
        Align = alTop
        TabOrder = 0
      end
      object pnlLateralDireita: TPanel
        Left = 409
        Top = 62
        Width = 185
        Height = 608
        Align = alRight
        BevelOuter = bvNone
        TabOrder = 1
      end
      object pnlTopOptions: TPanel
        Left = 0
        Top = 21
        Width = 594
        Height = 41
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
      end
      object pnlClient: TPanel
        Left = 0
        Top = 62
        Width = 402
        Height = 608
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 3
        object dxRichEditControl1: TdxRichEditControl
          Left = 0
          Top = 0
          Width = 402
          Height = 200
          ActiveViewType = Simple
          Align = alTop
          BorderStyle = cxcbsNone
          TabOrder = 0
        end
      end
    end
  end
end
