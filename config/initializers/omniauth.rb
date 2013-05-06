OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '161154117387981', '9fde76f143ecd6b955e1e7870b2fc4e6'
end