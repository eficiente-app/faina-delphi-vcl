inherited Principal: TPrincipal
  Caption = 'Principal'
  ClientHeight = 681
  ClientWidth = 1004
  Color = 3806736
  Position = poScreenCenter
  OnShow = FormShow
  ExplicitWidth = 1020
  ExplicitHeight = 720
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClientForm: TPanel
    Width = 1002
    Height = 679
    ExplicitLeft = 1
    ExplicitTop = 1
    ExplicitWidth = 1002
    ExplicitHeight = 679
    inherited pnlTitleBar: TPanel
      Width = 1002
      TabOrder = 1
      ExplicitWidth = 1002
    end
    inherited pnlClientArea: TPanel
      Top = 75
      Width = 1002
      Height = 604
      TabOrder = 0
      ExplicitTop = 86
      ExplicitWidth = 1002
      ExplicitHeight = 593
      object pnlLateralEsquerda: TPanel
        Left = 0
        Top = 0
        Width = 200
        Height = 604
        Align = alLeft
        BevelOuter = bvNone
        Color = 10495813
        ParentBackground = False
        TabOrder = 0
        ExplicitHeight = 593
      end
      object pnlAreaTrabalho: TPanel
        Left = 200
        Top = 0
        Width = 802
        Height = 604
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
        ExplicitTop = 3
        ExplicitHeight = 623
      end
    end
    object pnlTop: TPanel
      Left = 0
      Top = 20
      Width = 1002
      Height = 55
      Margins.Left = 0
      Margins.Top = 8
      Margins.Right = 0
      Margins.Bottom = 8
      Align = alTop
      BevelOuter = bvNone
      Color = 3806736
      ParentBackground = False
      TabOrder = 2
      ExplicitTop = 64
      object pnlTitle: TPanel
        Left = 0
        Top = 0
        Width = 185
        Height = 55
        Align = alLeft
        BevelOuter = bvNone
        TabOrder = 0
        ExplicitHeight = 40
        object lblTitle: TLabel
          AlignWithMargins = True
          Left = 3
          Top = 3
          Width = 179
          Height = 49
          Align = alClient
          Caption = 'Faina'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -27
          Font.Name = 'Segoe UI Light'
          Font.Style = []
          ParentFont = False
          Layout = tlCenter
          ExplicitWidth = 57
          ExplicitHeight = 37
        end
      end
      object svgUserAvatar: TSVGIconImage
        AlignWithMargins = True
        Left = 949
        Top = 3
        Width = 50
        Height = 49
        AutoSize = True
        SVGText = 
          '<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0' +
          ' 24 24" width="24"><path d="M0 0h24v24H0z" fill="none"/><path d=' +
          '"M12 2C6.48 2 2 6.48 2 12s4.48 10 10 10 10-4.48 10-10S17.52 2 12' +
          ' 2zm0 3c1.66 0 3 1.34 3 3s-1.34 3-3 3-3-1.34-3-3 1.34-3 3-3zm0 1' +
          '4.2c-2.5 0-4.71-1.28-6-3.22.03-1.99 4-3.08 6-3.08 1.99 0 5.97 1.' +
          '09 6 3.08-1.29 1.94-3.5 3.22-6 3.22z"/></svg>'
        FixedColor = clWhite
        Align = alRight
        OnClick = svgUserAvatarClick
        ExplicitHeight = 34
      end
    end
  end
end
