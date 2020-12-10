object PastaListagem: TPastaListagem
  Left = 0
  Top = 0
  Caption = 'Pasta'
  ClientHeight = 452
  ClientWidth = 727
  Color = clWindow
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object dbgridPasta: TDBGrid
    Left = 0
    Top = 145
    Width = 727
    Height = 307
    Align = alClient
    DataSource = srcPasta
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'tipo'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'projeto_id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'nome'
        Width = 250
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'descricao'
        Width = 250
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 727
    Height = 30
    Align = alTop
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 1
    ExplicitWidth = 852
    object btnIncluir: TButton
      Left = 0
      Top = 0
      Width = 75
      Height = 26
      Align = alLeft
      Caption = 'Incluir'
      TabOrder = 0
      OnClick = btnIncluirClick
      ExplicitLeft = -6
      ExplicitTop = -1
    end
    object btnAlterar: TButton
      Left = 75
      Top = 0
      Width = 75
      Height = 26
      Align = alLeft
      Caption = 'Alterar'
      TabOrder = 1
      OnClick = btnAlterarClick
      ExplicitLeft = 69
      ExplicitTop = -1
    end
    object btnVisualizar: TButton
      Left = 150
      Top = 0
      Width = 75
      Height = 26
      Align = alLeft
      Caption = 'Visualizar'
      TabOrder = 2
      OnClick = btnVisualizarClick
    end
  end
  object pnlPesquisa: TPanel
    Left = 0
    Top = 30
    Width = 727
    Height = 115
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 2
    ExplicitWidth = 852
    object pnlPesquisar: TPanel
      AlignWithMargins = True
      Left = 380
      Top = 5
      Width = 81
      Height = 109
      Margins.Left = 0
      Margins.Top = 5
      Margins.Bottom = 1
      Align = alLeft
      BevelOuter = bvNone
      TabOrder = 0
      object btnPesquisar: TButton
        AlignWithMargins = True
        Left = 3
        Top = 3
        Width = 75
        Height = 73
        Align = alClient
        Caption = 'Pesquisar'
        TabOrder = 0
        OnClick = btnPesquisarClick
      end
      object btnLimpar: TButton
        AlignWithMargins = True
        Left = 3
        Top = 81
        Width = 75
        Height = 25
        Margins.Top = 2
        Align = alBottom
        Caption = 'Limpar'
        TabOrder = 1
      end
    end
    object gbxPesquisa: TGroupBox
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 374
      Height = 109
      Align = alLeft
      Caption = ' Pesquisa '
      TabOrder = 1
    end
  end
  object srcPasta: TDataSource
    AutoEdit = False
    DataSet = PastaController.tblPasta
    Left = 536
    Top = 1
  end
end
