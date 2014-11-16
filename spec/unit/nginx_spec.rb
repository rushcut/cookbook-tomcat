require 'spec_helper'

describe 'tomcat::nginx' do

  describe 'default attributes' do

    let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

    it 'does include default recipe' do
      expect(chef_run).to include_recipe('tomcat::default')
    end

    it 'does context file in to nginx context directory' do
      path = '/etc/nginx/sites-enabled/localhost'
      expect(chef_run).to create_template(path).with(
        :source => "tomcat-nginx.erb"
      )
      expect(chef_run).to render_file(path).with_content("server_name localhost;")
      expect(chef_run).to render_file(path).with_content("listen 80;")
      expect(chef_run).to render_file(path).with_content("proxy_pass http://localhost:8080;")
    end

  end

end
