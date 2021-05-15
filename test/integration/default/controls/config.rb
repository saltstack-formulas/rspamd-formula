# frozen_string_literal: true

config_dir = '/etc/rspamd'

rspamd_conf_override = <<~RSPAMD_CONF_OVERRIDE
  options {
      .include "$CONFDIR/options.inc";
      .include(try=true; priority=1,duplicate=merge) "$LOCAL_CONFDIR/local.d/options.inc";
      .include(try=true; priority=10) "$LOCAL_CONFDIR/override.d/options.inc";
      pidfile = "$RUNDIR/rspamd.pid";
  }
RSPAMD_CONF_OVERRIDE

dkim_domains = <<~DKIM_DOMAINS
  domain {
      example.com {
          path = "/var/lib/rspamd/dkim/example.com.key";
          selector = "example.com";
      }
      example.net {
          path = "/var/lib/rspamd/dkim/example.net.key";
          selector = "fancy_selector";
      }
      just.a.domain {
          path = "/var/lib/rspamd/dkim/just.a.domain.key";
          selector = "just.a.domain";
      }
      this.should.be.merged.too {
          path = "/var/lib/rspamd/dkim/should.be.merged.with.the.others.key";
          selector = "dkim";
      }
  }
DKIM_DOMAINS

control 'rspamd configuration' do
  impact 1.0
  title 'Manage the Rspamd Configuration'
  desc '
    Manage the rspamd configuration
  '
  tag 'rspamd', 'config'

  %w[
    local.d
    override.d
  ].each do |d|
    describe file("#{config_dir}/#{d}") do
      it { should be_directory }
      it { should be_owned_by 'root' }
      it { should be_grouped_into 'root' }
      its('mode') { should cmp '0755' }
    end
  end

  describe file("#{config_dir}/rspamd.conf.override") do
    its('content') { should include(rspamd_conf_override) }
  end

  describe file("#{config_dir}/local.d/redis.conf") do
    its('content') { should match(/^read_servers = "localhost";/) }
    its('content') { should match(/^write_servers = "localhost";/) }
  end

  describe file("#{config_dir}/local.d/dkim_signing.conf") do
    its('content') { should match(/^lis = \["a", "b", "c"\];/) }
    its('content') { should match(/^nom = 1234;/) }
    its('content') { should match(/^stri = "cadena1";/) }
    its('content') { should include(dkim_domains) }
  end
end
