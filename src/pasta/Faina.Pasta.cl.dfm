object DMPasta: TDMPasta
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  OnDestroy = DataModuleDestroy
  Height = 150
  Width = 215
  object tblPasta: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 39
    Top = 30
    object tblPastaid: TIntegerField
      FieldName = 'id'
    end
    object tblPastatipo: TIntegerField
      FieldName = 'tipo'
    end
    object tblPastaprojeto_id: TIntegerField
      FieldName = 'projeto_id'
    end
    object tblPastanome: TStringField
      FieldName = 'nome'
      Size = 500
    end
    object tblPastadescricao: TStringField
      FieldName = 'descricao'
      Size = 1000
    end
    object tblPastaincluido_id: TIntegerField
      FieldName = 'incluido_id'
    end
    object tblPastaincluido_em: TDateTimeField
      FieldName = 'incluido_em'
    end
    object tblPastaalterado_id: TIntegerField
      FieldName = 'alterado_id'
    end
    object tblPastaalterado_em: TDateTimeField
      FieldName = 'alterado_em'
    end
    object tblPastaexcluido_id: TIntegerField
      FieldName = 'excluido_id'
    end
    object tblPastaexcluido_em: TDateTimeField
      FieldName = 'excluido_em'
    end
  end
end
