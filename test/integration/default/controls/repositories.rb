# frozen_string_literal: true

control 'repositories' do
  impact 0.6
  title 'Configure the repositories'
  desc '
    Configure the Debian/RedHat repositories for the supported platforms.
  '
  tag 'repositories', 'apt', 'yum'
  ref 'Rspamd prerequisites - Section: Rspamd package repositories', url: 'https://rspamd.com/downloads.html'

  case os[:family]
  when 'debian'
    describe apt('http://rspamd.com/apt-stable/') do
      it { should exist }
      it { should be_enabled }
    end
  when 'redhat', 'centos'
    describe yum.repo('rspamd') do
      it { should exist }
      it { should be_enabled }
    end
  end
end
