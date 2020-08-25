# frozen_string_literal: true

control 'rspamd service' do
  impact 1.0
  title 'Manage the Rspamd Service'
  desc '
    Manage the rspamd service
  '
  tag 'rspamd', 'service'

  redis_service = case os[:family]
                  when 'debian'
                    'redis-server'
                  else
                    'redis'
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
    %w[
      11332
      11333
      11334
    ].each do |pn|
      describe port(pn) do
        # It takes a while to the port to be listening,
        # se we add a little sleep
        before do
          30.times do
            unless port(pn).listening?
              puts "Port #{pn} isn't ready, retrying.."
              sleep 1
            end
          end
        end
        it { should be_listening }
        its('protocols') { should include 'tcp' }
        its('addresses') { should include '127.0.0.1' }
      end
    end
  end
end
