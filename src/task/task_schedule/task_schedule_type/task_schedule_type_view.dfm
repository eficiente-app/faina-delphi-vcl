inherited TaskScheduleTypeView: TTaskScheduleTypeView
  Caption = 'Tipo de programa'#231#227'o de tarefa '
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
      ExplicitWidth = 516
      ExplicitHeight = 125
      object lbdescription: TLabel
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
      object dbedtdescription: TDBEdit
        Left = 8
        Top = 93
        Width = 497
        Height = 21
        DataField = 'description'
        DataSource = srcTaskScheduleType
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
        DataSource = srcTaskScheduleType
        ReadOnly = True
        TabOrder = 1
      end
      object dbedtname: TDBEdit
        Left = 54
        Top = 52
        Width = 451
        Height = 21
        DataField = 'name'
        DataSource = srcTaskScheduleType
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
    end
  end
  object srcTaskScheduleType: TDataSource
    AutoEdit = False
    DataSet = TaskScheduleTypeController.tblTaskScheduleType
    Left = 448
    Top = 1
  end
end
