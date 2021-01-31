inherited TaskLabelView: TTaskLabelView
  Caption = 'Tarefa Etiqueta'
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
      ExplicitTop = 0
      ExplicitWidth = 516
      inherited lblTitleForm: TLabel
        Height = 30
      end
    end
    inherited pnlClientArea: TPanel
      Width = 516
      Height = 125
      ExplicitTop = 33
      ExplicitWidth = 516
      ExplicitHeight = 125
      object lbdescription: TLabel
        Left = 239
        Top = 37
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
      object lbname: TLabel
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
      object Label1: TLabel
        Left = 8
        Top = 79
        Width = 20
        Height = 13
        Caption = 'Tipo'
        FocusControl = DBEdit1
      end
      object sbttipo_id: TSpeedButton
        Left = 46
        Top = 94
        Width = 23
        Height = 23
        Glyph.Data = {
          26040000424D2604000000000000360000002800000012000000120000000100
          180000000000F003000025160000251600000000000000000000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F3FB
          FBFBFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F33C3C3C545454FBFBFBFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFF3F3F33C3C3C000000707070FFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF3F3F33C3C
          3C000000707070FFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFBFB
          FBC3C3C3909090888888B0B0B0F7F7F7F3F3F33C3C3C000000707070FFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFCFCFCF30303000000000000000
          0000000000202020707070000000707070FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFE3E3E3101010080808808080CBCBCBD3D3D3989898101010
          000000989898FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          4C4C4C000000BCBCBCFFFFFFFFFFFFFFFFFFFFFFFFDBDBDB101010282828F7F7
          F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFEBEBEB000000545454FFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF848484000000CBCBCBFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFBFBFBF000000909090FFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFB8B8B80000009C9C9CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFE3E3E3000000747474FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          ACACAC000000A4A4A4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          1818182C2C2CF7F7F7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF505050000000DBDB
          DBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFA0A0A00000005C5C
          5CF7F7F7FFFFFFFFFFFFFFFFFF8484840000006C6C6CFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFF6060600000002020206464646C
          6C6C2C2C2C000000303030EFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          0000FFFFFFFFFFFFFFFFFFFFFFFFACACAC2424240000000000002424247C7C7C
          FBFBFBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFEBEBEBEFEFEFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0000FFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
          FFFFFFFFFFFFFFFF0000}
        OnClick = sbttipo_idClick
      end
      object lbtask_type_name: TLabel
        Left = 75
        Top = 79
        Width = 46
        Height = 13
        Caption = 'Descri'#231#227'o'
        FocusControl = dbedttask_type_name
      end
      object dbedtdescription: TDBEdit
        Left = 239
        Top = 52
        Width = 269
        Height = 21
        DataField = 'description'
        DataSource = srcTaskLabel
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
        DataSource = srcTaskLabel
        ReadOnly = True
        TabOrder = 1
      end
      object dbedtname: TDBEdit
        Left = 54
        Top = 52
        Width = 179
        Height = 21
        DataField = 'name'
        DataSource = srcTaskLabel
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
        object btnConfirm: TButton
          Left = 0
          Top = 0
          Width = 75
          Height = 26
          Align = alLeft
          Caption = 'Confirmar'
          TabOrder = 0
          OnClick = btnConfirmClick
        end
      end
      object DBEdit1: TDBEdit
        Left = 8
        Top = 95
        Width = 40
        Height = 21
        DataField = 'type_task_id'
        DataSource = srcTaskLabel
        TabOrder = 4
      end
      object dbedttask_type_name: TDBEdit
        Left = 75
        Top = 95
        Width = 433
        Height = 21
        TabStop = False
        Color = clCream
        DataField = 'task_type_name'
        DataSource = srcTaskLabel
        ReadOnly = True
        TabOrder = 5
      end
    end
  end
  object srcTaskLabel: TDataSource
    AutoEdit = False
    DataSet = TaskLabelController.tblTaskLabel
    Left = 448
    Top = 1
  end
end
