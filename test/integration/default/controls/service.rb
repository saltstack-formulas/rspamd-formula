control 'rspamd service' do
  impact 1.0
  title 'Manage the Rspamd Service'
  desc '
    Manage the rspamd service
  '
  tag 'rspamd', 'service'

  describe service('rspamd') do
    it { should be_enabled }
    it { should be_running }
  end

  %w{
    11332
    11333
  }.each do |pn|
    # It takes a while to the port to be listening,
    # se we add a little sleep
    sleep(2)
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
