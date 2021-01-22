inherited TarefaTipoManutencao: TTarefaTipoManutencao
  Caption = 'Tarefa Tipo'
  ClientHeight = 155
  ClientWidth = 516
  OnClose = FormClose
  ExplicitWidth = 532
  ExplicitHeight = 194
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClientForm: TPanel
    Width = 516
    Height = 155
    ExplicitWidth = 516
    ExplicitHeight = 155
    inherited pnlTitleBar: TPanel
      Width = 516
      ExplicitWidth = 516
      inherited lblTitleForm: TLabel
        Height = 30
      end
    end
    inherited pnlClientArea: TPanel
      Width = 516
      Height = 125
      ExplicitWidth = 516
      ExplicitHeight = 125
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
      object lbid: TLabel
        Left = 8
        Top = 36
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
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
      object dbedtdescricao: TDBEdit
        Left = 8
        Top = 93
        Width = 497
        Height = 21
        DataField = 'descricao'
        DataSource = srcTarefaTipo
        TabOrder = 0
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
      object dbedtnome: TDBEdit
        Left = 54
        Top = 52
        Width = 451
        Height = 21
        DataField = 'nome'
        DataSource = srcTarefaTipo
        TabOrder = 2
      end
      object pnlTop: TPanel
        Left = 0
        Top = 0
        Width = 516
        Height = 30
        Align = alTop
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 3
        object btnConfirmar: TButton
          Left = 0
          Top = 0
          Width = 75
          Height = 26
          Align = alLeft
          Caption = 'Confirmar'
          TabOrder = 0
          OnClick = btnConfirmarClick
        end
      end
    end
  end
  object srcTarefaTipo: TDataSource
    AutoEdit = False
    DataSet = TarefaTipoDados.tblTarefaTipo
    Left = 448
    Top = 1
  end
end
