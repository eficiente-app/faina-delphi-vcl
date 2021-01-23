object FolderController: TFolderController
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
    object tblPastatipo_id: TIntegerField
      DisplayLabel = 'Tipo'
      FieldName = 'tipo_id'
    end
    object tblPastatipo_nome: TStringField
      FieldKind = fkLookup
      FieldName = 'tipo_nome'
      LookupDataSet = FolderTypeController.tblPastaTipo
      LookupKeyFields = 'id'
      LookupResultField = 'nome'
      KeyFields = 'tipo_id'
      Size = 100
      Lookup = True
    end
    object tblPastaprojeto_id: TIntegerField
      DisplayLabel = 'Projeto'
      FieldName = 'projeto_id'
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
end
