OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '485204984863264', 'ca4dbc7d8dac754185cd60ec41b898a5'
end