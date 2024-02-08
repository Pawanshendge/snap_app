ActiveSupport.on_load(:account) do
  AccountBlock::Account.include(
    BxBlockAccountGroups::PatchAccountAssociations
  )
end
