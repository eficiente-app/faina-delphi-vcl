object ProjectTypeController: TProjectTypeController
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object tblProjectType: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 32
    Top = 16
    object tblProjectTypeid: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'id'
    end
    object tblProjectTypename: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'name'
      Size = 100
    end
    object tblProjectTypedescription: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'description'
      Size = 1000
    end
  end
end