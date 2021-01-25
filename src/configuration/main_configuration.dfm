inherited MainConfiguration: TMainConfiguration
  Caption = 'Configura'#231#245'es'
  OnClose = FormClose
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClientForm: TPanel
    inherited pnlTitleBar: TPanel
      object lblSubTitle: TLabel
        AlignWithMargins = True
        Left = 148
        Top = 0
        Width = 109
        Height = 13
        Margins.Left = 8
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alLeft
        Caption = 'Formul'#225'rio Base - Visual'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -11
        Font.Name = 'Segoe UI Light'
        Font.Style = []
        ParentFont = False
        Layout = tlCenter
        Visible = False
        OnMouseDown = MouseDownMovimentarFormulario
      end
    end
    inherited pnlClientArea: TPanel
      object pnlLateralEsquerda: TPanel
        Left = 0
        Top = 0
        Width = 200
        Height = 381
        Align = alLeft
        BevelOuter = bvNone
        Color = 10495813
        ParentBackground = False
        TabOrder = 0
        object nbMenu: TdxNavBar
          Left = 0
          Top = 0
          Width = 200
          Height = 381
          Align = alClient
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWhite
          Font.Height = -11
          Font.Name = 'Segoe UI Light'
          Font.Style = []
          ActiveGroupIndex = 0
          TabOrder = 0
          LookAndFeel.Kind = lfUltraFlat
          View = 16
          OptionsStyle.DefaultStyles.Background.BackColor = 10495813
          OptionsStyle.DefaultStyles.Background.BackColor2 = 10495813
          OptionsStyle.DefaultStyles.Background.Font.Charset = DEFAULT_CHARSET
          OptionsStyle.DefaultStyles.Background.Font.Color = clWindowText
          OptionsStyle.DefaultStyles.Background.Font.Height = -11
          OptionsStyle.DefaultStyles.Background.Font.Name = 'Tahoma'
          OptionsStyle.DefaultStyles.Background.Font.Style = []
          OptionsStyle.DefaultStyles.Background.AssignedValues = [savBackColor, savBackColor2]
          OptionsStyle.DefaultStyles.GroupBackground.BackColor = 10495813
          OptionsStyle.DefaultStyles.GroupBackground.BackColor2 = 10495813
          OptionsStyle.DefaultStyles.GroupBackground.Font.Charset = DEFAULT_CHARSET
          OptionsStyle.DefaultStyles.GroupBackground.Font.Color = clWindowText
          OptionsStyle.DefaultStyles.GroupBackground.Font.Height = -11
          OptionsStyle.DefaultStyles.GroupBackground.Font.Name = 'Tahoma'
          OptionsStyle.DefaultStyles.GroupBackground.Font.Style = []
          OptionsStyle.DefaultStyles.GroupBackground.AssignedValues = [savBackColor, savBackColor2]
          OptionsStyle.DefaultStyles.GroupHeader.BackColor = 6563356
          OptionsStyle.DefaultStyles.GroupHeader.BackColor2 = 6563356
          OptionsStyle.DefaultStyles.GroupHeader.Font.Charset = DEFAULT_CHARSET
          OptionsStyle.DefaultStyles.GroupHeader.Font.Color = clWhite
          OptionsStyle.DefaultStyles.GroupHeader.Font.Height = -11
          OptionsStyle.DefaultStyles.GroupHeader.Font.Name = 'Segoe UI Light'
          OptionsStyle.DefaultStyles.GroupHeader.Font.Style = [fsBold]
          OptionsStyle.DefaultStyles.GroupHeader.AssignedValues = [savBackColor, savBackColor2, savFont]
          OptionsStyle.DefaultStyles.GroupHeaderActive.BackColor = 7679264
          OptionsStyle.DefaultStyles.GroupHeaderActive.BackColor2 = 7679264
          OptionsStyle.DefaultStyles.GroupHeaderActive.Font.Charset = DEFAULT_CHARSET
          OptionsStyle.DefaultStyles.GroupHeaderActive.Font.Color = clWhite
          OptionsStyle.DefaultStyles.GroupHeaderActive.Font.Height = -11
          OptionsStyle.DefaultStyles.GroupHeaderActive.Font.Name = 'Segoe UI Light'
          OptionsStyle.DefaultStyles.GroupHeaderActive.Font.Style = [fsBold]
          OptionsStyle.DefaultStyles.GroupHeaderActive.AssignedValues = [savBackColor, savBackColor2, savFont]
          OptionsStyle.DefaultStyles.Item.AlphaBlending = 255
          OptionsStyle.DefaultStyles.Item.AlphaBlending2 = 255
          OptionsStyle.DefaultStyles.Item.BackColor = 10495813
          OptionsStyle.DefaultStyles.Item.BackColor2 = 10495813
          OptionsStyle.DefaultStyles.Item.Font.Charset = DEFAULT_CHARSET
          OptionsStyle.DefaultStyles.Item.Font.Color = clWhite
          OptionsStyle.DefaultStyles.Item.Font.Height = -11
          OptionsStyle.DefaultStyles.Item.Font.Name = 'Segoe UI Light'
          OptionsStyle.DefaultStyles.Item.Font.Style = []
          OptionsStyle.DefaultStyles.Item.AssignedValues = [savAlphaBlending, savAlphaBlending2, savBackColor, savBackColor2, savFont]
          OptionsStyle.DefaultStyles.ItemHotTracked.BackColor = 11611214
          OptionsStyle.DefaultStyles.ItemHotTracked.BackColor2 = 11611214
          OptionsStyle.DefaultStyles.ItemHotTracked.Font.Charset = DEFAULT_CHARSET
          OptionsStyle.DefaultStyles.ItemHotTracked.Font.Color = clWhite
          OptionsStyle.DefaultStyles.ItemHotTracked.Font.Height = -11
          OptionsStyle.DefaultStyles.ItemHotTracked.Font.Name = 'Segoe UI Light'
          OptionsStyle.DefaultStyles.ItemHotTracked.Font.Style = []
          OptionsStyle.DefaultStyles.ItemHotTracked.AssignedValues = [savBackColor, savBackColor2, savFont]
          OptionsStyle.DefaultStyles.ItemPressed.BackColor = 10495813
          OptionsStyle.DefaultStyles.ItemPressed.BackColor2 = 10495813
          OptionsStyle.DefaultStyles.ItemPressed.Font.Charset = DEFAULT_CHARSET
          OptionsStyle.DefaultStyles.ItemPressed.Font.Color = clWhite
          OptionsStyle.DefaultStyles.ItemPressed.Font.Height = -11
          OptionsStyle.DefaultStyles.ItemPressed.Font.Name = 'Segoe UI Light'
          OptionsStyle.DefaultStyles.ItemPressed.Font.Style = []
          OptionsStyle.DefaultStyles.ItemPressed.AssignedValues = [savFont]
          OptionsStyle.DefaultStyles.NavigationPaneHeader.BackColor = clNone
          OptionsStyle.DefaultStyles.NavigationPaneHeader.BackColor2 = clNone
          OptionsStyle.DefaultStyles.NavigationPaneHeader.Font.Charset = DEFAULT_CHARSET
          OptionsStyle.DefaultStyles.NavigationPaneHeader.Font.Color = clNone
          OptionsStyle.DefaultStyles.NavigationPaneHeader.Font.Height = -15
          OptionsStyle.DefaultStyles.NavigationPaneHeader.Font.Name = 'Arial'
          OptionsStyle.DefaultStyles.NavigationPaneHeader.Font.Style = [fsBold]
          OptionsStyle.DefaultStyles.NavigationPaneHeader.AssignedValues = [savBackColor, savBackColor2]
          object nbgCadastros: TdxNavBarGroup
            Caption = 'Cadastros'
            SelectedLinkIndex = -1
            TopVisibleLinkIndex = 0
            Links = <
              item
                Item = nbiPastas
              end
              item
                Item = nbiTipoPasta
              end
              item
                Item = nbiTipoTarefa
              end>
          end
          object nbgSitema: TdxNavBarGroup
            Caption = 'Sitema'
            SelectedLinkIndex = -1
            TopVisibleLinkIndex = 0
            Links = <>
          end
          object nbiPastas: TdxNavBarItem
            Caption = 'Pastas'
            OnClick = nbiPastasClick
          end
          object nbiTipoPasta: TdxNavBarItem
            Caption = 'Tipos de Pastas'
            OnClick = nbiTipoPastaClick
          end
          object nbiTipoTarefa: TdxNavBarItem
            Caption = 'Tipo de Tarefa'
            OnClick = nbiTipoTarefaClick
          end
        end
      end
      object pnlAreaTrabalho: TPanel
        Left = 200
        Top = 0
        Width = 652
        Height = 381
        Align = alClient
        BevelOuter = bvNone
        TabOrder = 1
      end
    end
  end
end
