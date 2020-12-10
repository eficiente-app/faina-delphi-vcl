object PastaController: TPastaController
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
    Left = 24
    Top = 16
    object tblPastaid: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'id'
    end
    object tblPastatipo: TIntegerField
      DisplayLabel = 'Tipo'
      FieldName = 'tipo'
    end
    object tblPastatipo_descricao: TStringField
      FieldName = 'tipo_descricao'
      ProviderFlags = []
      Size = 500
    end
    object tblPastaprojeto_id: TIntegerField
      DisplayLabel = 'Projeto'
      FieldName = 'projeto_id'
    end
    object tblPastaprojeto_descricao: TStringField
      FieldName = 'projeto_descricao'
      ProviderFlags = []
      Size = 500
    end
    object tblPastanome: TStringField
      DisplayLabel = 'Nome'
      FieldName = 'nome'
      Size = 500
    end
    object tblPastadescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
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
  object tblTipo: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 80
    Top = 16
    object tblTipoid: TIntegerField
      DisplayLabel = 'C'#243'digo'
      FieldName = 'id'
    end
    object tblTipodescricao: TStringField
      DisplayLabel = 'Descri'#231#227'o'
      FieldName = 'descricao'
      Size = 1000
    end
    object tblTipoincluido_id: TIntegerField
      FieldName = 'incluido_id'
    end
    object tblTipoincluido_em: TDateTimeField
      FieldName = 'incluido_em'
    end
    object tblTipoalterado_id: TIntegerField
      FieldName = 'alterado_id'
    end
    object tblTipoalterado_em: TDateTimeField
      FieldName = 'alterado_em'
    end
    object tblTipoexcluido_id: TIntegerField
      FieldName = 'excluido_id'
    end
    object tblTipoexcluido_em: TDateTimeField
      FieldName = 'excluido_em'
    end
  end
end
