# frozen_string_literal: true

rspamd_user = rspamd_group = case platform[:family]
                             when 'linux', 'arch'
                               'root'
                             else
                               '_rspamd'
                             end

control 'rspamd dkim_keys' do
  impact 1.0
  title 'Manage the DKIM key files and directory'
  desc '
    Manage the DKIM keys and directory
  '
  tag 'rspamd', 'dkim_keys'

  describe file('/var/lib/rspamd/dkim') do
    it { should be_directory }
    it { should be_owned_by rspamd_user }
    it { should be_grouped_into rspamd_group }
    its('mode') { should cmp '0755' }
  end

  %w[
    example.com.key
    example.com.txt
    example.net.key
    example.net.txt
    example.org.key
    example.org.txt
    just.a.domain.key
    just.a.domain.txt
  ].each do |f|
    describe file("/var/lib/rspamd/dkim/#{f}") do
      it { should be_file }
      it { should be_owned_by rspamd_user }
      it { should be_grouped_into rspamd_group }
      its('mode') { should cmp '0640' }
    end
  end
end
