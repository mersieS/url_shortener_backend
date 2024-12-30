Rails.application.config.active_record.encryption = {
  key_derivation_salt: ENV['ACTIVE_RECORD_ENCRYPTION_KEY_DERIVATION_SALT'],
  key_base: ENV['ACTIVE_RECORD_ENCRYPTION_KEY_BASE']
}