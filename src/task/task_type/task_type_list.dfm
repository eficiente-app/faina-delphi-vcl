inherited TaskTypeList: TTaskTypeList
  Caption = 'Tipo de Tarefa'
  ClientHeight = 397
  ClientWidth = 583
  KeyPreview = True
  Position = poOwnerFormCenter
  OnCreate = FormCreate
  ExplicitWidth = 599
  ExplicitHeight = 436
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClientForm: TPanel
    Width = 583
    Height = 397
    ExplicitWidth = 583
    ExplicitHeight = 397
    inherited pnlTitleBar: TPanel
      Width = 583
      Visible = False
      ExplicitWidth = 583
      inherited lblTitleForm: TLabel
        Height = 30
      end
    end
    inherited pnlClientArea: TPanel
      Width = 583
      Height = 367
      ExplicitWidth = 583
      ExplicitHeight = 367
      object dbgridPasta: TDBGrid
        Left = 0
        Top = 145
        Width = 583
        Height = 222
        Align = alClient
        DataSource = srcTarefaTipo
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        PopupMenu = popAcoes
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnCellClick = dbgridPastaCellClick
        Columns = <
          item
            Expanded = False
            FieldName = 'id'
            Title.Alignment = taRightJustify
            Width = 50
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
            Width = 500
            Visible = True
          end>
      end
      object pnlPesquisa: TPanel
        Left = 0
        Top = 30
        Width = 583
        Height = 115
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
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
      object pnlTopo: TPanel
        Left = 0
        Top = 0
        Width = 583
        Height = 30
        Align = alTop
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 2
        object btnIncluir: TButton
          Left = 0
          Top = 0
          Width = 75
          Height = 26
          Align = alLeft
          Caption = 'Adicionar'
          TabOrder = 0
          OnClick = btnIncluirClick
        end
      end
    end
  end
  object srcTarefaTipo: TDataSource
    AutoEdit = False
    DataSet = TaskTypeController.tblTarefaTipo
    Left = 360
  end
  object popAcoes: TPopupMenu
    Left = 440
    object btnRemover: TMenuItem
      Caption = 'Remover'
      OnClick = btnRemoverClick
    end
  end
end
