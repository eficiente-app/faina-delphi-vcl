inherited PastaTipoListagem: TPastaTipoListagem
  Caption = 'Tipos de Pasta'
  ClientHeight = 588
  ClientWidth = 544
  Color = clWindow
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  ExplicitWidth = 560
  ExplicitHeight = 627
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClientForm: TPanel
    Width = 544
    Height = 588
    ExplicitWidth = 544
    ExplicitHeight = 588
    inherited pnlTitleBar: TPanel
      Width = 544
      Visible = False
      ExplicitWidth = 544
      inherited lblTitleForm: TLabel
        Height = 20
      end
    end
    inherited pnlClientArea: TPanel
      Width = 544
      Height = 568
      ExplicitWidth = 544
      ExplicitHeight = 568
      object dbgridPasta: TDBGrid
        Left = 0
        Top = 145
        Width = 544
        Height = 423
        Align = alClient
        DataSource = srcPastaTipo
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
            FieldName = 'nome'
            Width = 150
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'descricao'
            Width = 294
            Visible = True
          end>
      end
      object pnlTopo: TPanel
        Left = 0
        Top = 0
        Width = 544
        Height = 30
        Align = alTop
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 1
        object btnIncluir: TButton
          Left = 0
          Top = 0
          Width = 75
          Height = 26
          Align = alLeft
          Caption = 'Incluir'
          TabOrder = 0
          OnClick = btnIncluirClick
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
        Width = 544
        Height = 115
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 2
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
    end
  end
  object srcPastaTipo: TDataSource
    AutoEdit = False
    DataSet = PastaTipoDados.tblPastaTipo
    OnDataChange = srcPastaTipoDataChange
    Left = 360
    Top = 1
  end
end
