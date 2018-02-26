unless Rails.env.development?
  class ForbiddenDBSeedError < StandardError; end
  raise ForbiddenDBSeedError,
    "You should not seed the #{Rails.env} environment database."
end

DEVELOPMENT_PASSWORD = 'Devpass1'

# the production environment as this file (wich contains clear text passwords)
# is available at the Git repository.

# Admin
# E-mail doesn't have to be valid as no e-mails are sent
# in the development environment (we're using Letter Opener)
User.create(
  email: 'admin@test.com',
  role: :admin,
  first_name: 'Admin',
  last_name: 'User',
  confirmed_at: Time.zone.today
).tap do |user|
  unless user.persisted?
    user.password = DEVELOPMENT_PASSWORD
    user.password_confirmation = DEVELOPMENT_PASSWORD
    user.confirmed_at = Time.zone.now
    user.save
  end
end

# Ordinary user (non-admin)
User.create(
  email: 'user@test.com',
  password: DEVELOPMENT_PASSWORD,
  password_confirmation: DEVELOPMENT_PASSWORD,
  role: :user,
  first_name: 'Ordinary',
  last_name: 'User',
  confirmed_at: Time.zone.today
).tap do |user|
  unless user.persisted?
    user.password = DEVELOPMENT_PASSWORD
    user.password_confirmation = DEVELOPMENT_PASSWORD
    user.confirmed_at = Time.zone.now
    user.save
  end
end
