object TaskScheduleController: TTaskScheduleController
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object tblTaskSchedule: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 48
    Top = 16
    object tblTaskScheduleid: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'id'
    end
    object tblTaskScheduletask_id: TIntegerField
      FieldName = 'task_id'
    end
    object tblTaskScheduleuser_id: TIntegerField
      FieldName = 'user_id'
    end
    object tblTaskScheduletype_id: TIntegerField
      FieldName = 'type_id'
    end
    object tblTaskSchedulestart: TDateTimeField
      FieldName = 'start'
    end
    object tblTaskScheduleend: TDateTimeField
      FieldName = 'end'
    end
    object tblTaskScheduleprior_id: TIntegerField
      FieldName = 'prior_id'
    end
    object tblTaskSchedulenext_id: TIntegerField
      FieldName = 'next_id'
    end
  end
end
