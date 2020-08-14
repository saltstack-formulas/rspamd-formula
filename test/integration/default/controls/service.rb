# frozen_string_literal: true

control 'rspamd service' do
  impact 1.0
  title 'Manage the Rspamd Service'
  desc '
    Manage the rspamd service
  '
  tag 'rspamd', 'service'

  case os[:family]
  when 'redhat'
    redis_service = 'redis'
  when 'debian'
    redis_service = 'redis-server'
  end

  describe service(redis_service) do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('rspamd') do
    it { should be_enabled }
    it { should be_running }
  end
end
