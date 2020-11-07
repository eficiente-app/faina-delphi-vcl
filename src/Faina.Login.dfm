object Login: TLogin
  Left = 0
  Top = 0
  Caption = 'Login'
  ClientHeight = 279
  ClientWidth = 232
  Color = 15592941
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 238
    Width = 232
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 0
    object btnConfirmar: TButton
      Left = 28
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Confirmar'
      ModalResult = 1
      TabOrder = 0
    end
    object btnCancelar: TButton
      Left = 125
      Top = 5
      Width = 75
      Height = 25
      Caption = 'Cancelar'
      ModalResult = 2
      TabOrder = 1
    end
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 232
    Height = 17
    Align = alTop
    BevelOuter = bvNone
    Color = 10495813
    ParentBackground = False
    TabOrder = 1
  end
end
