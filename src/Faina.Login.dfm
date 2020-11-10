object Login: TLogin
  Left = 0
  Top = 0
  Anchors = [akLeft, akTop, akRight, akBottom]
  BorderStyle = bsNone
  Caption = 'Login'
  ClientHeight = 412
  ClientWidth = 320
  Color = 15592941
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesigned
  DesignSize = (
    320
    412)
  PixelsPerInch = 96
  TextHeight = 13
  object pnlCentro: TPanel
    Left = 47
    Top = 56
    Width = 225
    Height = 300
    Anchors = []
    BevelKind = bkTile
    BevelOuter = bvNone
    ParentBackground = False
    TabOrder = 0
    object pnlTop: TPanel
      Left = 0
      Top = 0
      Width = 221
      Height = 17
      Align = alTop
      BevelOuter = bvNone
      Color = 10495813
      ParentBackground = False
      TabOrder = 0
      ExplicitLeft = 2
      ExplicitWidth = 223
    end
    object pnlBotoes: TPanel
      Left = 0
      Top = 255
      Width = 221
      Height = 41
      Align = alBottom
      BevelOuter = bvNone
      TabOrder = 1
      ExplicitTop = 259
      ExplicitWidth = 223
      object btnConfirmar: TButton
        Left = 24
        Top = 5
        Width = 75
        Height = 25
        Caption = 'Confirmar'
        TabOrder = 0
        OnClick = btnConfirmarClick
      end
      object btnCancelar: TButton
        Left = 121
        Top = 5
        Width = 75
        Height = 25
        Caption = 'Cancelar'
        TabOrder = 1
        OnClick = btnCancelarClick
      end
    end
  end
end
