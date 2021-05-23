# frozen_string_literal: true

OmniAuth.config.test_mode = true
OmniAuth.config.logger = Rails.logger

def mock_oauth_provider(provider)
  OmniAuth.config.mock_auth[provider.to_sym] = OmniAuth::AuthHash.new(
    provider: provider.to_s,
    uid: '987',
    info: {
      email: 'jubal@bountyhunter.gov',
      name: 'Jubal Early',
      first_name: 'Jubal',
      last_name: 'Early',
      image: 'https://picsum.photos/id/10/100/100'
    }
  )
end
