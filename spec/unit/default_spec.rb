require 'spec_helper'

describe 'tomcat::default' do

  describe 'default attributes' do

    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it 'create user' do
      expect(chef_run).to create_user('tomcat').with(
        :group => 'tomcat'
      )
    end

    it 'create group' do
      expect(chef_run).to create_group('tomcat')
    end


    it 'download archive' do
      expect(chef_run).to create_remote_file('/var/chef/cache/tomcat-8.0.15.tar.gz').with(
        :source => "http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.15/bin/apache-tomcat-8.0.15.tar.gz"
      )
    end

    it 'create home directory' do
      expect(chef_run).to create_directory('/opt/tomcat').with(
        :owner => 'tomcat',
        :group => 'tomcat',
        :recursive => true
      )
    end

    it 'extract archive' do
      expect(chef_run).to run_execute('extract').with(
        :cwd => '/var/chef/cache',
        :command => 'tar -xvf tomcat-8.0.15.tar.gz -C /opt/tomcat --strip-components 1'
      )
    end

    it 'render setenv.sh file' do
      path = '/opt/tomcat/bin/setenv.sh'
      expect(chef_run).to create_template(path).with(
        :source => 'setenv.sh.erb',
        :owner => 'tomcat',
        :group => 'tomcat'
      )
      expect(chef_run).to render_file(path).with_content("export CATALINA_HOME='/opt/tomcat'")
      expect(chef_run).to render_file(path).with_content("export CATALINA_BASE='/opt/tomcat'")
      expect(chef_run).to render_file(path).with_content("export JAVA_OPTS='-Xmx128M -Djava.awt.headless=true'")
      expect(chef_run).to render_file(path).with_content("export CATALINA_OPTS=''")
    end


    it 'render init script file' do
      path = '/etc/init.d/tomcat'
      expect(chef_run).to create_template(path).with(
        :source => 'init-script.sh.erb',
        :mode   => '0755'
      )
      expect(chef_run).to render_file(path).with_content("TOMCAT_USER=tomcat")
      expect(chef_run).to render_file(path).with_content("TOMCAT_HOME=/opt/tomcat")
    end

    it 'render server.xml file' do
      path = '/opt/tomcat/conf/server.xml'
      expect(chef_run).to create_template(path).with(
        :source => 'server.xml.erb',
        :mode   => '0600'
      )
    end

    it 'does start tomcat service' do
      expect(chef_run).to start_service('tomcat')
    end

    it 'does enable tomcat service' do
      expect(chef_run).to enable_service('tomcat')
    end

  end

end
