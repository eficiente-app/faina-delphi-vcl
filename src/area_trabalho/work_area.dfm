inherited WorkArea: TWorkArea
  Caption = 'WorkArea'
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClientForm: TPanel
    inherited pnlTitleBar: TPanel
      Visible = False
      ExplicitTop = 0
    end
    inherited pnlClientArea: TPanel
      object pnlTop: TPanel
        Left = 0
        Top = 0
        Width = 852
        Height = 54
        Margins.Left = 0
        Margins.Top = 8
        Margins.Right = 0
        Margins.Bottom = 8
        Align = alTop
        BevelOuter = bvNone
        Color = 3806736
        ParentBackground = False
        TabOrder = 0
        object pnlTitle: TPanel
          Left = 0
          Top = 0
          Width = 185
          Height = 54
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object lblTitlePrincipal: TLabel
            AlignWithMargins = True
            Left = 3
            Top = 3
            Width = 179
            Height = 48
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
          Left = 799
          Top = 3
          Width = 50
          Height = 48
          Cursor = crHandPoint
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
        end
        object svgNotificacao: TSVGIconImage
          AlignWithMargins = True
          Left = 769
          Top = 15
          Width = 24
          Height = 24
          Cursor = crHandPoint
          Margins.Top = 15
          Margins.Bottom = 15
          AutoSize = False
          Stretch = False
          SVGText = 
            '<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0' +
            ' 24 24" width="24"><path d="M0 0h24v24H0z" fill="none"/><path d=' +
            '"M12 22c1.1 0 2-.9 2-2h-4c0 1.1.9 2 2 2zm6-6v-5c0-3.07-1.63-5.64' +
            '-4.5-6.32V4c0-.83-.67-1.5-1.5-1.5s-1.5.67-1.5 1.5v.68C7.64 5.36 ' +
            '6 7.92 6 11v5l-2 2v1h16v-1l-2-2zm-2 1H8v-6c0-2.48 1.51-4.5 4-4.5' +
            's4 2.02 4 4.5v6z"/></svg>'
          FixedColor = clWhite
          Align = alRight
        end
        object svgAdicionar: TSVGIconImage
          AlignWithMargins = True
          Left = 739
          Top = 15
          Width = 24
          Height = 24
          Cursor = crHandPoint
          Margins.Top = 15
          Margins.Bottom = 15
          AutoSize = False
          Stretch = False
          SVGText = 
            '<svg xmlns="http://www.w3.org/2000/svg" height="24" viewBox="0 0' +
            ' 24 24" width="24"><path d="M0 0h24v24H0z" fill="none"/><path d=' +
            '"M19 13h-6v6h-2v-6H5v-2h6V5h2v6h6v2z"/></svg>'
          FixedColor = clWhite
          Align = alRight
        end
      end
      object pnlLateralEsquerda: TPanel
        Left = 0
        Top = 54
        Width = 200
        Height = 327
        Align = alLeft
        BevelOuter = bvNone
        Color = 10495813
        ParentBackground = False
        TabOrder = 1
      end
      object pnlAreaTrabalho: TPanel
        Left = 200
        Top = 54
        Width = 652
        Height = 327
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 2
      end
    end
  end
end
