require "#{File.join(File.dirname(__FILE__),'..','spec_helper.rb')}"

describe 'phpmyadmin' do

  let(:title) { 'phpmyadmin' }
  let(:node) { 'rspec.example42.com' }
  let(:facts) { { :ipaddress => '10.42.42.42' , :operatingsystem => 'Ubuntu' } }

  describe 'Test standard installation' do
    it { should contain_package('phpmyadmin').with_ensure('present') }
    it { should contain_file('phpmyadmin.conf').with_ensure('present') }
  end

  describe 'Test standard installation with monitoring' do
    let(:params) { {:monitor => true , :url_check => 'http://phpmyadmin.example42.com' } }
    let(:facts) { { :ipaddress => '10.42.42.42' , :operatingsystem => 'Ubuntu' } }

    it { should contain_file('phpmyadmin.conf').with_ensure('present') }
    it 'should monitor the url' do
      should contain_monitor__url('phpmyadmin_url').with_enable(true)
    end
  end

  describe 'Test source installation' do
    let(:params) { {
      :install        => 'source' ,
      :web_server     => 'apache',
      :install_source => 'http://downloads.sourceforge.net/project/phpmyadmin/phpMyAdmin/4.1.5/phpMyAdmin-4.1.5-all-languages.tar.gz',
    } }
    let(:facts) { { :ipaddress => '10.42.42.42' , :operatingsystem => 'Ubuntu' } }

    it 'should contain a netinstall resource with valid destination_dir' do
      should contain_puppi__netinstall('netinstall_phpmyadmin').with_destination_dir('/var/www')
    end
  end

  describe 'Test decommissioning - absent' do
    let(:params) { {:absent => true, :monitor => true } }
    let(:facts) { { :ipaddress => '10.42.42.42' , :operatingsystem => 'Ubuntu' } }

    it 'should remove Package[phpmyadmin]' do should contain_package('phpmyadmin').with_ensure('absent') end
    it 'should remove phpmyadmin configuration file' do should contain_file('phpmyadmin.conf').with_ensure('absent') end
  end

  describe 'Test customizations - template' do
    let(:params) { {:template => "phpmyadmin/spec.erb" , :options => { 'opt_a' => 'value_a' } } }
    let(:facts) { { :ipaddress => '10.42.42.42' , :operatingsystem => 'Ubuntu' } }

    it 'should generate a valid template' do
      should contain_file('phpmyadmin.conf').with_content(/fqdn: rspec.example42.com/)
    end
    it 'should generate a template that uses custom options' do
      should contain_file('phpmyadmin.conf').with_content(/value_a/)
    end

  end

  describe 'Test customizations - source' do
    let(:params) { {:source => "puppet://modules/phpmyadmin/spec" , :source_dir => "puppet://modules/phpmyadmin/dir/spec" , :source_dir_purge => true } }
    let(:facts) { { :ipaddress => '10.42.42.42' , :operatingsystem => 'Ubuntu' } }

    it 'should request a valid source ' do
      should contain_file('phpmyadmin.conf').with_source("puppet://modules/phpmyadmin/spec")
    end
    it 'should request a valid source dir' do
      should contain_file('phpmyadmin.dir').with_source("puppet://modules/phpmyadmin/dir/spec")
    end
    it 'should purge source dir if source_dir_purge is true' do
      should contain_file('phpmyadmin.dir').with_purge(true)
    end
  end

  describe 'Test customizations - custom class' do
    let(:params) { {:my_class => "phpmyadmin::spec" } }
    let(:facts) { { :ipaddress => '10.42.42.42' , :operatingsystem => 'Ubuntu' } }

    it 'should automatically include a custom class' do
      should contain_file('phpmyadmin.conf').with_content(/fqdn: rspec.example42.com/)
    end
  end

  describe 'Test Puppi Integration' do
    let(:params) { {:puppi => true, :puppi_helper => "myhelper"} }
    let(:facts) { { :ipaddress => '10.42.42.42' , :operatingsystem => 'Ubuntu' } }

    it 'should generate a puppi::ze define' do
      should contain_puppi__ze('phpmyadmin').with_helper("myhelper")
    end
  end

  describe 'Test params lookup' do
    let(:facts) { { :monitor => true , :ipaddress => '10.42.42.42' , :operatingsystem => 'Ubuntu'} }
    let(:params) { { :url_check => 'http://phpmyadmin.example42.com' } }

    it 'should honour top scope global vars' do
      should contain_monitor__url('phpmyadmin_url').with_enable(true)
    end
  end

  describe 'Test params lookup' do
    let(:facts) { { :phpmyadmin_monitor => true , :ipaddress => '10.42.42.42' , :operatingsystem => 'Ubuntu' } }
    let(:params) { { :url_check => 'http://phpmyadmin.example42.com' } }

    it 'should honour module specific vars' do
      should contain_monitor__url('phpmyadmin_url').with_enable(true)
    end
  end

  describe 'Test params lookup' do
    let(:facts) { { :monitor => false , :phpmyadmin_monitor => true , :ipaddress => '10.42.42.42' , :operatingsystem => 'Ubuntu' } }
    let(:params) { { :url_check => 'http://phpmyadmin.example42.com' } }

    it 'should honour top scope module specific over global vars' do
      should contain_monitor__url('phpmyadmin_url').with_enable(true)
    end
  end

  describe 'Test params lookup' do
    let(:facts) { { :monitor => false , :ipaddress => '10.42.42.42' , :operatingsystem => 'Ubuntu' } }
    let(:params) { { :monitor => true , :url_check => 'http://phpmyadmin.example42.com' } }

    it 'should honour passed params over global vars' do
      should contain_monitor__url('phpmyadmin_url').with_enable(true)
    end
  end

end

