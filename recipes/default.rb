#
# Cookbook Name:: tomcat
# Recipe:: default
#
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#
group('tomcat')

user('tomcat') do
  group node['tomcat']['group']
end

remote_file File.join(Chef::Config['file_cache_path'], "tomcat-8.0.15.tar.gz") do
  source "http://archive.apache.org/dist/tomcat/tomcat-8/v8.0.15/bin/apache-tomcat-8.0.15.tar.gz"
end

directory node['tomcat']['home'] do
  owner node['tomcat']['user']
  group node['tomcat']['group']
  recursive true
end

execute 'extract' do
  cwd Chef::Config['file_cache_path']
  command "tar -xvf tomcat-8.0.15.tar.gz -C /opt/tomcat --strip-components 1"
end

template File.join(node['tomcat']['home'], "/bin/setenv.sh") do
  source 'setenv.sh.erb'
  owner node['tomcat']['user']
  group node['tomcat']['group']
end

template File.join(node['tomcat']['config_dir'], "server.xml") do
  source "server.xml.erb"
  mode '0600'
end

template "/etc/init.d/tomcat" do
  source 'init-script.sh.erb'
  mode '0755'
end

execute 'fix owner' do
  cwd node['tomcat']['home']
  command "chown -R tomcat:tomcat ."
end

service 'tomcat' do
  action [:start, :enable]
end
