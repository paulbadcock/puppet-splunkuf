require 'spec_helper'
describe 'splunkuf' do

  context 'with defaults for all parameters' do
    it { should contain_class('splunkuf') }
  end

  context 'on RHEL7' do
    let :facts do
      {
        :osfamily                   => 'RedHat',
        :operatingsystemmajrelease  => '7',
        :architecure                => 'amd64',
      }
    end

    describe 'should install splunk forwarder package' do
      it { should contain_package('splunkforwarder').with_ensure('latest') }
    end

    it do
      should contain_file('/usr/lib/systemd/system/splunkforwarder.service').with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0755',
        })
    end

    it do
      should contain_file('/opt/splunkforwarder/etc/system/local/deploymentclient.conf').with({
        'owner'   => 'splunk',
        'group'   => 'splunk',
        'mode'    => '0644',
        })
    end

    it do
      should_not contain_file('/opt/splunkforwarder/etc/system/local/web.conf').with({
        'owner'   => 'splunk',
        'group'   => 'splunk',
        'mode'    => '0644',
      })
    end

    it do
      should contain_service('splunkforwarder').with({
        'ensure'     => 'running',
        'enable'     => 'true',
      })
    end
  end

  context 'on RHEL7 with Host Port Override' do
    let :facts do
      {
        :osfamily                   => 'RedHat',
        :operatingsystemmajrelease  => '7',
        :architecure                => 'amd64',
      }
    end

    let :params do
      {
        :targeturi    => 'splunkwoo:8089',
        :mgmthostport => '127.0.0.1::9089',
      }
    end

    describe 'should install splunk forwarder package' do
      it { should contain_package('splunkforwarder').with_ensure('latest') }
    end

    it do
      should contain_file('/usr/lib/systemd/system/splunkforwarder.service').with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0755',
      })
    end

    it do
      should contain_file('/opt/splunkforwarder/etc/system/local/deploymentclient.conf').with({
        'owner'   => 'splunk',
        'group'   => 'splunk',
        'mode'    => '0644',
      })
    end

    it do
      should contain_file('/opt/splunkforwarder/etc/system/local/web.conf').with({
        'owner'   => 'splunk',
        'group'   => 'splunk',
        'mode'    => '0644',
      })
    end

    it do
      should contain_service('splunkforwarder').with({
        'ensure'     => 'running',
        'enable'     => 'true',
      })
    end
  end

  context 'on RHEL7 with Client Name' do
    let :facts do
      {
        :osfamily                   => 'RedHat',
        :operatingsystemmajrelease  => '7',
        :architecure                => 'amd64',
      }
    end

    let :params do
      {
        :targeturi    => 'splunkwoo:8089',
        :clientname   => 'host-chicken',
      }
    end

    describe 'should install splunk forwarder package' do
      it { should contain_package('splunkforwarder').with_ensure('latest') }
    end

    it do
      should contain_file('/usr/lib/systemd/system/splunkforwarder.service').with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0755',
      })
    end

    it do
      should contain_file('/opt/splunkforwarder/etc/system/local/deploymentclient.conf').with({
        'owner'   => 'splunk',
        'group'   => 'splunk',
        'mode'    => '0644',
      })
    end

    it do
      should contain_file('/opt/splunkforwarder/etc/system/local/deploymentclient.conf') \
        .with_content(/^clientName = host-chicken$/)
    end

    it do
      should contain_service('splunkforwarder').with({
        'ensure'     => 'running',
        'enable'     => 'true',
      })
    end
  end

  context 'on RHEL6' do
    let :facts do
      {
        :osfamily                   => 'RedHat',
        :operatingsystemmajrelease  => '6',
        :architecure                => 'amd64',
      }
    end

    describe 'should install splunk forwarder package' do
      let(:params) do
        {
          :targeturi => 'splunkwoo:8089',
        }
      end

      it { should contain_package('splunkforwarder').with_ensure('latest') }
    end

    it do
      should contain_file('/etc/init.d/splunkforwarder').with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0755',
        })
    end

    it do
      should contain_file('/opt/splunkforwarder/etc/system/local/deploymentclient.conf').with({
        'owner'   => 'splunk',
        'group'   => 'splunk',
        'mode'    => '0644',
        })
    end

    it do
      should_not contain_file('/opt/splunkforwarder/etc/system/local/web.conf').with({
        'owner'   => 'splunk',
        'group'   => 'splunk',
        'mode'    => '0644',
      })
    end

    it do
      should contain_service('splunkforwarder').with({
        'ensure'     => 'running',
        'enable'     => 'true',
      })
    end
  end

  context 'on RHEL6 with Host Port Override' do
    let :facts do
      {
        :osfamily                   => 'RedHat',
        :operatingsystemmajrelease  => '6',
        :architecure                => 'amd64',
      }
    end

    let :params do
      {
        :mgmthostport => '127.0.0.1:9089'
      }
    end

    describe 'should install splunk forwarder package' do
      let(:params) do
        {
          :targeturi => 'splunkwoo:8089',
        }
      end

    it { should contain_package('splunkforwarder').with_ensure('latest') }
    end

    it do
      should contain_file('/etc/init.d/splunkforwarder').with({
        'owner'   => 'root',
        'group'   => 'root',
        'mode'    => '0755',
      })
    end

    it do
      should contain_file('/opt/splunkforwarder/etc/system/local/deploymentclient.conf').with({
        'owner'   => 'splunk',
        'group'   => 'splunk',
        'mode'    => '0644',
      })
    end

    it do
      should contain_file('/opt/splunkforwarder/etc/system/local/web.conf').with({
        'owner'   => 'splunk',
        'group'   => 'splunk',
        'mode'    => '0644',
      })
    end

    it do
      should contain_service('splunkforwarder').with({
        'ensure'     => 'running',
        'enable'     => 'true',
      })
    end
  end

end
