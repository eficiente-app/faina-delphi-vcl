inherited MenuUsuario: TMenuUsuario
  Caption = 'MenuUsuario'
  ClientHeight = 110
  ClientWidth = 200
  Color = 10495813
  OnClose = FormClose
  ExplicitWidth = 216
  ExplicitHeight = 149
  PixelsPerInch = 96
  TextHeight = 13
  object pnlTopUsuario: TPanel
    Left = 0
    Top = 0
    Width = 200
    Height = 60
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object svgUserAvatar: TSVGIconImage
      AlignWithMargins = True
      Left = 3
      Top = 3
      Width = 50
      Height = 54
      AutoSize = True
      SVGText = 
        '<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0' +
        ' 24 24" width="24"><path d="M0 0h24v24H0z" fill="none"/><path d=' +
        '"M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12' +
        ' 2zm0 3c1.66 0 3 1.34 3 3s-1.34 3-3 3-3-1.34-3-3 1.34-3 3-3zm0 1' +
        '4.2c-2.5 0-4.71-1.28-6-3.22.03-1.99 4-3.08 6-3.08 1.99 0 5.97 1.' +
        '09 6 3.08-1.29 1.94-3.5 3.22-6 3.22z"/></svg>'
      FixedColor = clWhite
      Align = alLeft
    end
    object pnlInfoUsuario: TPanel
      AlignWithMargins = True
      Left = 59
      Top = 3
      Width = 138
      Height = 54
      Align = alClient
      BevelOuter = bvNone
      TabOrder = 1
      object lblApelidoUsuario: TLabel
        Left = 0
        Top = 0
        Width = 138
        Height = 28
        Align = alClient
        Caption = 'Apelido'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -15
        Font.Name = 'Segoe UI Light'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
        ParentFont = False
        Layout = tlCenter
        ExplicitWidth = 54
        ExplicitHeight = 20
      end
      object lblNomeUsuario: TLabel
        Left = 0
        Top = 28
        Width = 138
        Height = 13
        Align = alBottom
        Caption = 'Nome'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Segoe UI Light'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
        ParentFont = False
        Layout = tlCenter
        ExplicitWidth = 33
      end
      object lblFuncaoPrincipal: TLabel
        Left = 0
        Top = 41
        Width = 138
        Height = 13
        Align = alBottom
        Caption = 'Fun'#231#227'o'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Segoe UI Light'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
        ParentFont = False
        Layout = tlCenter
        ExplicitWidth = 39
      end
    end
  end
  object cxButton1: TcxButton
    Left = 0
    Top = 60
    Width = 200
    Height = 25
    Align = alTop
    Caption = 'Perfil'
    TabOrder = 1
  end
  object cxButton2: TcxButton
    Left = 0
    Top = 85
    Width = 200
    Height = 25
    Align = alTop
    Caption = 'Configura'#231#245'es'
    TabOrder = 2
    OnClick = cxButton2Click
  end
end
