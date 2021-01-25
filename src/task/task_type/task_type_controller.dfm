object TaskTypeController: TTaskTypeController
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object tblTarefaTipo: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 32
    Top = 16
    object tblTarefaTipoid: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'id'
    end
    object tblTarefaTiponome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 1000
    end
    object tblTarefaTipodescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 1000
    end
    object tblTarefaTipoincluido_id: TIntegerField
      FieldName = 'incluido_id'
    end
    object tblTarefaTipoincluido_em: TDateTimeField
      FieldName = 'incluido_em'
    end
    object tblTarefaTipoalterado_id: TIntegerField
      FieldName = 'alterado_id'
    end
    object tblTarefaTipoalterado_em: TDateTimeField
      FieldName = 'alterado_em'
    end
    object tblTarefaTipoexcluido_id: TIntegerField
      FieldName = 'excluido_id'
    end
    object tblTarefaTipoexcluido_em: TDateTimeField
      FieldName = 'excluido_em'
    end
  end
end
