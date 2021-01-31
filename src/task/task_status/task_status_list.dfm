inherited TaskStatusList: TTaskStatusList
  Caption = 'Status da Tarefa'
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
      ExplicitTop = 0
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
      object dbgridTaskStatus: TDBGrid
        Left = 0
        Top = 145
        Width = 583
        Height = 222
        Align = alClient
        DataSource = srcTaskStatus
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
        PopupMenu = popAction
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
        OnCellClick = dbgridTaskStatusCellClick
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
            FieldName = 'name'
            Width = 250
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'description'
            Width = 500
            Visible = True
          end>
      end
      object pnlSearch: TPanel
        Left = 0
        Top = 30
        Width = 583
        Height = 115
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object pnlGrupSearch: TPanel
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
          object btnSearch: TButton
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 75
            Height = 73
            Align = alClient
            Caption = 'Pesquisar'
            TabOrder = 0
            OnClick = btnSearchClick
          end
          object btnClear: TButton
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
        object gbxSearch: TGroupBox
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
      object pnlTop: TPanel
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
  object srcTaskStatus: TDataSource
    AutoEdit = False
    DataSet = TaskStatusController.tblTaskStatus
    Left = 360
    Top = 1
  end
  object popAction: TPopupMenu
    Left = 440
    Top = 1
    object btnRemove: TMenuItem
      Caption = 'Remover'
      OnClick = btnRemoveClick
    end
  end
end
