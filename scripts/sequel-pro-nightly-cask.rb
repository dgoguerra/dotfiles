# Sequel Pro nightly build, until version 1.2 is released
# and available in the official cask 'sequel-pro'.
#
# Based on 'sequel-pro-nightly' cask which retrieves the latest
# nightly build:
#
#   https://raw.githubusercontent.com/Homebrew/homebrew-cask-versions/master/Casks/sequel-pro-nightly.rb
#
cask 'sequel-pro-nightly-cask' do
  version :latest
  sha256 'ef363f8dc6b23d58d7d1aa9919fabe58fb4399fccc33d1016b80a388419f79be'

  url "https://sequelpro.com/builds/Sequel-Pro-Build-664a46cd7c.zip"
  name 'Sequel Pro'
  homepage 'https://sequelpro.com/test-builds'

  app 'Sequel Pro.app'

  zap trash: '~/Library/Application Support/Sequel Pro/Data'
end
