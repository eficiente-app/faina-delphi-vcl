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
      ExplicitTop = -3
      ExplicitWidth = 1004
      ExplicitHeight = 20
      inherited lblTitleForm: TLabel
        Width = 158
        Height = 20
        Caption = 'Faina - Gerencie suas Tarefas'
        ExplicitTop = -1
        ExplicitWidth = 158
        ExplicitHeight = 20
      end
    end
    inherited pnlClientArea: TPanel
      Top = 20
      Width = 1004
      Height = 661
      Font.Color = clDefault
      ParentFont = False
      TabOrder = 0
      ExplicitTop = 40
      ExplicitWidth = 1004
      ExplicitHeight = 641
    end
  end
  object tmrAlertaConexao: TTimer
    Enabled = False
    Interval = 3000
    OnTimer = tmrAlertaConexaoTimer
    Left = 768
  end
end
