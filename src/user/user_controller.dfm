object UserController: TUserController
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object tblUser: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 32
    Top = 16
    object tblUserid: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'id'
    end
    object tblUsername: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'name'
      Size = 100
    end
    object tblUserperfil_id: TIntegerField
      FieldName = 'perfil_id'
    end
    object tblUserlogin: TStringField
      FieldName = 'login'
      Size = 30
    end
    object tblUserpassword: TStringField
      FieldName = 'password'
      Size = 1000
    end
    object tblUsertype_id: TIntegerField
      FieldName = 'type_id'
    end
    object tblUsertype_name: TStringField
      FieldKind = fkLookup
      FieldName = 'type_name'
      LookupDataSet = UserTypeController.tblUserType
      LookupKeyFields = 'id'
      LookupResultField = 'name'
      KeyFields = 'type_id'
      Size = 100
      Lookup = True
    end
  end
end
