inherited Main: TMain
  Caption = 'Faina - Gerencie suas Tarefas'
  ClientHeight = 681
  ClientWidth = 1004
  Position = poScreenCenter
  OnShow = FormShow
  ExplicitWidth = 1020
  ExplicitHeight = 720
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlClientForm: TPanel
    Width = 1004
    Height = 681
    ExplicitWidth = 1004
    ExplicitHeight = 681
    inherited pnlTitleBar: TPanel
      Width = 1004
      Height = 20
      Color = 2297098
      TabOrder = 1
      OnDblClick = pnlTitleBarDblClick
      ExplicitWidth = 1004
      ExplicitHeight = 20
      inherited lblTitleForm: TLabel
        Width = 158
        Height = 17
        Caption = 'Faina - Gerencie suas Tarefas'
        ExplicitWidth = 158
      end
    end
    inherited pnlClientArea: TPanel
      Top = 40
      Width = 1004
      Height = 641
      TabOrder = 0
      ExplicitTop = 40
      ExplicitWidth = 1004
      ExplicitHeight = 641
    end
    object pnlAlertaConexao: TPanel
      Left = 0
      Top = 20
      Width = 1004
      Height = 20
      Align = alTop
      BevelOuter = bvNone
      Color = 9607431
      ParentBackground = False
      TabOrder = 2
      Visible = False
      object lblAlertaConexao: TLabel
        Left = 0
        Top = 0
        Width = 73
        Height = 17
        Margins.Left = 8
        Margins.Top = 0
        Margins.Right = 0
        Margins.Bottom = 0
        Align = alClient
        Alignment = taCenter
        Caption = 'Conectado!'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWhite
        Font.Height = -13
        Font.Name = 'Segoe UI Light'
        Font.Style = [fsBold]
        Font.Quality = fqClearType
        ParentFont = False
        Layout = tlCenter
        OnMouseDown = MouseDownMovimentarFormulario
      end
    end
  end
  object tmrAlertaConexao: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = tmrAlertaConexaoTimer
    Left = 768
    Top = 65532
  end
end
