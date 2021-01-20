inherited PastaManutencao: TPastaManutencao
  Caption = 'Pasta'
  ClientHeight = 185
  ClientWidth = 515
  ExplicitWidth = 531
  ExplicitHeight = 224
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClientForm: TPanel
    Width = 515
    Height = 185
    ExplicitWidth = 515
    ExplicitHeight = 185
    inherited pnlTitleBar: TPanel
      Width = 515
      ExplicitWidth = 515
    end
    inherited pnlClientArea: TPanel
      Width = 515
      Height = 155
      ExplicitWidth = 515
      ExplicitHeight = 155
      object lbid: TLabel
        Left = 8
        Top = 36
        Width = 33
        Height = 13
        Caption = 'C'#243'digo'
      end
      object lbtipo_id: TLabel
        Left = 54
        Top = 36
        Width = 20
        Height = 13
        Caption = 'Tipo'
      end
      object lbprojeto_id: TLabel
        Left = 283
        Top = 36
        Width = 35
        Height = 13
        Caption = 'Projeto'
      end
      object lbnome: TLabel
        Left = 8
        Top = 78
        Width = 27
        Height = 13
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Nome'
      end
      object lbdescricao: TLabel
        Left = 8
        Top = 118
        Width = 46
        Height = 13
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Caption = 'Descri'#231#227'o'
      end
      object sbttipo_id: TSpeedButton
        Left = 92
        Top = 51
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
      object sbtprojeto_id: TSpeedButton
        Left = 321
        Top = 51
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
      end
      object lbtipo_nome: TLabel
        Left = 121
        Top = 36
        Width = 46
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object lbprojeto_descricao: TLabel
        Left = 350
        Top = 36
        Width = 46
        Height = 13
        Caption = 'Descri'#231#227'o'
      end
      object dbedtid: TDBEdit
        Left = 8
        Top = 52
        Width = 40
        Height = 21
        TabStop = False
        Color = clCream
        DataField = 'id'
        DataSource = srcPasta
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
      object dbedttipo_id: TDBEdit
        Left = 54
        Top = 52
        Width = 40
        Height = 21
        DataField = 'tipo_id'
        DataSource = srcPasta
        TabOrder = 2
      end
      object dbedtprojeto_id: TDBEdit
        Left = 283
        Top = 52
        Width = 40
        Height = 21
        DataField = 'projeto_id'
        DataSource = srcPasta
        TabOrder = 3
      end
      object dbedtnome: TDBEdit
        Left = 8
        Top = 92
        Width = 497
        Height = 21
        DataField = 'nome'
        DataSource = srcPasta
        TabOrder = 4
      end
      object dbedtdescricao: TDBEdit
        Left = 8
        Top = 133
        Width = 497
        Height = 21
        DataField = 'descricao'
        DataSource = srcPasta
        TabOrder = 5
      end
      object dbedttipo_nome: TDBEdit
        Left = 121
        Top = 52
        Width = 156
        Height = 21
        TabStop = False
        Color = clCream
        DataField = 'tipo_nome'
        DataSource = srcPasta
        ReadOnly = True
        TabOrder = 6
      end
      object dbedtprojeto_descricao: TDBEdit
        Left = 350
        Top = 52
        Width = 155
        Height = 21
        TabStop = False
        Color = clCream
        ReadOnly = True
        TabOrder = 7
      end
    end
  end
  object srcPasta: TDataSource
    AutoEdit = False
    DataSet = PastaDados.tblPasta
    Left = 448
    Top = 1
  end
end
