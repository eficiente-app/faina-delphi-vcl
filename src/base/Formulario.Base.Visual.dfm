object FormularioBaseVisual: TFormularioBaseVisual
  Left = 0
  Top = 0
  Caption = 'Formul'#225'rio Base - Visual'
  ClientHeight = 411
  ClientWidth = 852
  Color = 3806736
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object pnlClientForm: TPanel
    Left = 0
    Top = 0
    Width = 852
    Height = 411
    Margins.Left = 1
    Margins.Top = 1
    Margins.Right = 1
    Margins.Bottom = 1
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    ParentBackground = False
    TabOrder = 0
    object pnlTitleBar: TPanel
      Left = 0
      Top = 0
      Width = 852
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      Color = 3806736
      ParentBackground = False
      TabOrder = 0
      OnMouseDown = MouseDownMovimentarFormulario
      object lblTitleForm: TLabel
        AlignWithMargins = True
        Left = 8
        Top = 0
        Width = 109
        Height = 20
        Margins.Left = 8
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'Formul'#225'rio Base - Visual'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Segoe UI Light'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        OnMouseDown = MouseDownMovimentarFormulario
        ExplicitHeight = 13
      end
    end
    object pnlClientArea: TPanel
      Left = 0
      Top = 20
      Width = 852
      Height = 391
      Align = alClient
      BevelOuter = bvNone
      Color = clWhite
      ParentBackground = False
      TabOrder = 1
    end
  end
end
