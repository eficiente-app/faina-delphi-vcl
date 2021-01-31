object TaskStatusController: TTaskStatusController
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object tblTaskStatus: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 32
    Top = 16
    object tblTaskStatusid: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'id'
    end
    object tblTaskStatusname: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'name'
      Size = 100
    end
    object tblTaskStatusdescription: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'description'
      Size = 1000
    end
  end
end
