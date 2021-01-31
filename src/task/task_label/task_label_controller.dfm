object TaskLabelController: TTaskLabelController
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object tblTaskLabel: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 32
    Top = 16
    object tblTaskLabelid: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'id'
    end
    object tblTaskLabelname: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'name'
      Size = 100
    end
    object tblTaskLabeldescription: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'description'
      Size = 1000
    end
    object tblTaskLabeltype_task_id: TIntegerField
      DisplayLabel = 'Tipo'
      FieldName = 'type_task_id'
    end
    object tblTaskLabeltask_type_name: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldKind = fkLookup
      FieldName = 'task_type_name'
      LookupDataSet = TaskTypeController.tblTaskType
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'type_task_id'
      Size = 100
      Lookup = True
    end
  end
end
