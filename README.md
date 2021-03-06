# tomcat-cookbook

Install and configure Tomcat 8

## Supported Platforms

- CentOS 6.4
- Ubuntu 12.04

## Attributes


## Recipes

### default

```
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
```

### nginx

```
default['tomcat']['nginx']['sites_path']  = '/etc/nginx/sites-enabled'
default['tomcat']['nginx']['server_name'] = "localhost"
default['tomcat']['nginx']['listen']      = "80"
default['tomcat']['nginx']['access_log']  = "/var/log/nginx/tomcat_#{node['tomcat']['server_name']}:#{node['tomcat']['port']}_access.log"
default['tomcat']['nginx']['error_log']  = "/var/log/nginx/tomcat_#{node['tomcat']['server_name']}:#{node['tomcat']['port']}_error.log"
```


## License and Authors

Author:: Gil Gyeong-Min (rushcut@gmail.com)

Licensed under the Apache License, Version 2.0 (the "License"); you may not
use this file except in compliance with the License. You may obtain a copy of
the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
License for the specific language governing permissions and limitations under
the License.
