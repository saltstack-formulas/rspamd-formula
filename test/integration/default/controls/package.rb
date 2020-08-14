# frozen_string_literal: true

control 'rspamd package' do
  impact 1.0
  title 'Manage the Rspamd Package'
  desc '
    Manage the rspamd package
  '
  tag 'rspamd', 'package'

  describe package('rspamd') do
    it { should be_installed }
  end
end
