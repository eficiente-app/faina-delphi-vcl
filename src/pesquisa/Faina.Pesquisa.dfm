inherited Pesquisa: TPesquisa
  Caption = 'Pesquisa'
  ClientHeight = 283
  ClientWidth = 430
  Color = clWindow
  OnShow = FormShow
  ExplicitWidth = 446
  ExplicitHeight = 322
  PixelsPerInch = 96
  TextHeight = 13
  object pnlPesquisa: TPanel
    Left = 0
    Top = 30
    Width = 430
    Height = 58
    Align = alTop
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 0
    object lbCampo: TLabel
      Left = 8
      Top = 8
      Width = 33
      Height = 13
      Caption = 'Campo'
    end
    object lbValor: TLabel
      Left = 137
      Top = 8
      Width = 33
      Height = 13
      Caption = 'Campo'
    end
    object cbxCampo: TComboBox
      Left = 8
      Top = 24
      Width = 121
      Height = 21
      TabOrder = 0
    end
    object btnPesquisar: TButton
      Left = 343
      Top = 22
      Width = 75
      Height = 25
      Caption = 'Pesquisar'
      TabOrder = 1
      OnClick = btnPesquisarClick
    end
    object edtValor: TEdit
      Left = 137
      Top = 24
      Width = 200
      Height = 21
      TabOrder = 2
    end
  end
  object dbgrid: TDBGrid
    Left = 0
    Top = 88
    Width = 430
    Height = 195
    Align = alClient
    DataSource = src
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 430
    Height = 30
    Align = alTop
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 2
    object btnConfirmar: TButton
      Left = 0
      Top = 0
      Width = 75
      Height = 26
      Align = alLeft
      Caption = 'Confirmar'
      ModalResult = 1
      TabOrder = 0
      OnClick = btnConfirmarClick
    end
    object btnCancelar: TButton
      Left = 75
      Top = 0
      Width = 75
      Height = 26
      Align = alLeft
      Caption = 'Cancelar'
      ModalResult = 2
      TabOrder = 1
      OnClick = btnCancelarClick
    end
  end
  object src: TDataSource
    Left = 280
    Top = 1
  end
end
