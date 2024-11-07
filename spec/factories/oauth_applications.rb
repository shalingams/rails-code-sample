# spec/factories/oauth_applications.rb
FactoryBot.define do
  factory :oauth_application, class: 'Doorkeeper::Application' do
    name { "Test App" }
    redirect_uri { "https://localhost/callback" }
  end

  factory :access_token, class: 'Doorkeeper::AccessToken' do
    application { create(:oauth_application) }
    token { SecureRandom.hex(32) }
    expires_in { 2.hours }
    scopes { 'public' }
  end
end
