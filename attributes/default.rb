default['tomcat']['base_version'] = 8
default['tomcat']['port'] = 8080
default['tomcat']['proxy_port'] = nil
default['tomcat']['ssl_port'] = 8443
default['tomcat']['ssl_proxy_port'] = nil
default['tomcat']['ajp_port'] = 8009
default['tomcat']['shutdown_port'] = 8005
default['tomcat']['catalina_options'] = ''
default['tomcat']['java_options'] = '-Xmx128M -Djava.awt.headless=true'

default['tomcat']['user']  = 'tomcat'
default['tomcat']['group'] = 'tomcat'

default['tomcat']['home']         = "/opt/tomcat"
default['tomcat']['base']         = "/opt/tomcat"
default['tomcat']['config_dir']   = "/opt/tomcat/conf"
default['tomcat']['log_dir']      = "/opt/tomcat/log"
default['tomcat']['tmp_dir']      = "/opt/tomcat/tomcat/temp"
default['tomcat']['work_dir']     = "/opt/tomcat/work"
default['tomcat']['context_dir']  = "#{node["tomcat"]["config_dir"]}/Catalina/localhost"
default['tomcat']['webapp_dir']   = "/opt/tomcat/webapps"
default['tomcat']['keytool']      = 'keytool'
default['tomcat']['lib_dir']      = "#{node["tomcat"]["home"]}/lib"
default['tomcat']['endorsed_dir'] = "#{node["tomcat"]["lib_dir"]}/endorsed"

default['tomcat']['nginx']['sites_path']  = '/etc/nginx/sites-enabled'
default['tomcat']['nginx']['server_name'] = "localhost"
default['tomcat']['nginx']['listen']      = "80"
default['tomcat']['nginx']['access_log']  = "/var/log/nginx/tomcat_#{node['tomcat']['server_name']}:#{node['tomcat']['port']}_access.log"
default['tomcat']['nginx']['error_log']  = "/var/log/nginx/tomcat_#{node['tomcat']['server_name']}:#{node['tomcat']['port']}_error.log"
