inherited PastaTipoManutencao: TPastaTipoManutencao
  Caption = 'Pasta Tipo'
  ClientHeight = 156
  ClientWidth = 515
  OnClose = FormClose
  ExplicitWidth = 531
  ExplicitHeight = 195
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClientForm: TPanel
    Width = 515
    Height = 156
    ExplicitWidth = 515
    ExplicitHeight = 156
    inherited pnlTitleBar: TPanel
      Width = 515
      ExplicitWidth = 515
    end
    inherited pnlClientArea: TPanel
      Width = 515
      Height = 126
      ExplicitWidth = 515
      ExplicitHeight = 126
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
        DataSource = srcPastaTipo
        ReadOnly = True
        TabOrder = 0
      end
      object pnlTop: TPanel
        Left = 0
        Top = 0
        Width = 515
        Height = 30
        Align = alTop
        BevelKind = bkTile
        BevelOuter = bvNone
        TabOrder = 1
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
      object dbedtdescricao: TDBEdit
        Left = 8
        Top = 93
        Width = 497
        Height = 21
        DataField = 'descricao'
        DataSource = srcPastaTipo
        TabOrder = 2
      end
      object dbedtnome: TDBEdit
        Left = 54
        Top = 52
        Width = 451
        Height = 21
        DataField = 'nome'
        DataSource = srcPastaTipo
        TabOrder = 3
      end
    end
  end
  object srcPastaTipo: TDataSource
    AutoEdit = False
    DataSet = FolderTypeController.tblPastaTipo
    Left = 448
    Top = 1
  end
end
