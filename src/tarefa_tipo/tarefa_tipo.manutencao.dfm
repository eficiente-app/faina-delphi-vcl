inherited TarefaTipoManutencao: TTarefaTipoManutencao
  Caption = 'Tarefa Tipo'
  ClientHeight = 124
  ClientWidth = 515
  Color = clWindow
  ExplicitWidth = 531
  ExplicitHeight = 163
  PixelsPerInch = 96
  TextHeight = 13
  object lbid: TLabel
    Left = 8
    Top = 36
    Width = 33
    Height = 13
    Caption = 'C'#243'digo'
  end
  object lbdescricao: TLabel
    Left = 8
    Top = 78
    Width = 46
    Height = 13
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Descri'#231#227'o'
  end
  object lbnome: TLabel
    Left = 54
    Top = 37
    Width = 27
    Height = 13
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Nome'
  end
  object dbedtid: TDBEdit
    Left = 8
    Top = 52
    Width = 40
    Height = 21
    TabStop = False
    Color = clCream
    DataField = 'id'
    DataSource = srcTarefaTipo
    ReadOnly = True
    TabOrder = 1
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 515
    Height = 30
    Align = alTop
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 0
    object btnGravar: TButton
      Left = 0
      Top = 0
      Width = 75
      Height = 26
      Align = alLeft
      Caption = 'Gravar'
      TabOrder = 0
      OnClick = btnGravarClick
    end
    object btnCancelar: TButton
      Left = 75
      Top = 0
      Width = 75
      Height = 26
      Align = alLeft
      Caption = 'Cancelar'
      TabOrder = 1
      OnClick = btnCancelarClick
    end
    object btnExcluir: TButton
      Left = 150
      Top = 0
      Width = 75
      Height = 26
      Align = alLeft
      Caption = 'Excluir'
      TabOrder = 2
      OnClick = btnExcluirClick
    end
    object btnFechar: TButton
      Left = 225
      Top = 0
      Width = 75
      Height = 26
      Align = alLeft
      Caption = 'Fechar'
      TabOrder = 3
      OnClick = btnFecharClick
    end
  end
  object dbedtdescricao: TDBEdit
    Left = 8
    Top = 93
    Width = 497
    Height = 21
    DataField = 'descricao'
    DataSource = srcTarefaTipo
    TabOrder = 3
  end
  object dbedtnome: TDBEdit
    Left = 54
    Top = 52
    Width = 451
    Height = 21
    DataField = 'nome'
    DataSource = srcTarefaTipo
    TabOrder = 2
  end
  object srcTarefaTipo: TDataSource
    AutoEdit = False
    DataSet = TarefaTipoDados.tblTarefaTipo
    Left = 448
    Top = 1
  end
end
