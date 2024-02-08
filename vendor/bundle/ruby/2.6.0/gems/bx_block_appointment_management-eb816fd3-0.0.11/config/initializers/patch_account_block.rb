Rails.application.reloader.to_prepare do
  AccountBlock::Account.include(
    BxBlockAppointmentManagement::PatchAccountBlock
  )
end
