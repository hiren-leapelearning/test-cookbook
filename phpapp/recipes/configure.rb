node[:deploy].each do |application, deploy|
  Chef::Log.debug("start phpapp configure.rb")
  Chef::Log.debug("#{node[:deploy][application][:deploy_to]}/current")
  Chef::Log.debug("#{node[:environment]}")
  template "#{node[:deploy][application][:deploy_to]}/current/dbconnect.php" do
    source "#{node[:environment]}/dbconnect.php.erb"
    mode '0660'
    owner node[:deploy][application][:user]
    group node[:deploy][application][:group]
    variables(
      :host =>     "host",
      :user =>     "user",
      :password => "pass",
      :db =>       "database",
      :table =>    "table")
      only_if do
        File.exists?("#{node[:deploy][application][:deploy_to]}/current")
      end
    end
    link "/mnt/writeable/pdf" do
      to "#{node[:deploy][application][:deploy_to]}/current/pdf"
    end
Chef::Log.debug("end phpapp configure.rb")
Chef::Log.info "end phpapp configure.rb"
end
