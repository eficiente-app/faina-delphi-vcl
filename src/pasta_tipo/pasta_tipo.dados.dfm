object PastaTipoDados: TPastaTipoDados
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object tblPastaTipo: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 32
    Top = 16
    object tblPastaTipoid: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'id'
    end
    object tblPastaTiponome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 1000
    end
    object tblPastaTipodescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 1000
    end
  end
end
