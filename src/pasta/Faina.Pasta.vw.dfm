object Pasta: TPasta
  Left = 0
  Top = 0
  Caption = 'Pasta'
  ClientHeight = 411
  ClientWidth = 852
  Color = clBtnFace
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 30
    Width = 852
    Height = 381
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
      end
      item
        Expanded = False
        FieldName = 'incluido_id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'incluido_em'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'alterado_id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'alterado_em'
        Width = 64
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'excluido_id'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'excluido_em'
        Width = 64
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 852
    Height = 30
    Align = alTop
    BevelKind = bkTile
    BevelOuter = bvNone
    TabOrder = 1
    object btnRead: TButton
      Left = 0
      Top = 0
      Width = 75
      Height = 26
      Align = alLeft
      Caption = 'Read'
      TabOrder = 0
      OnClick = btnReadClick
    end
    object btnWrite: TButton
      Left = 75
      Top = 0
      Width = 75
      Height = 26
      Align = alLeft
      Caption = 'Write'
      TabOrder = 1
      OnClick = btnWriteClick
    end
  end
  object srcPasta: TDataSource
    AutoEdit = False
    DataSet = DMPasta.tblPasta
    Left = 664
    Top = 1
  end
end
