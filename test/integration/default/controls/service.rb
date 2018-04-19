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

  # We seem to be hiting this
  if os[:family] == 'debian'
    %w{
      11332
      11333
    }.each do |pn|
      # It takes a while to the port to be listening,
      # se we add a little sleep
      sleep(5)
      describe port(pn) do
        it { should be_listening }
        its('protocols') { should include 'tcp' }
        its('addresses') { should include '0.0.0.0' }
      end
    end
  
    describe port(11334) do
      it { should be_listening }
      its('protocols') { should include 'tcp' }
      its('addresses') { should include '127.0.0.1' }
    end
  end
end
