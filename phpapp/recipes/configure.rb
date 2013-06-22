node[:deploy].each do |application, deploy|
    Chef::Log.debug("start phpapp configure.rb")
    Chef::Log.info "start phpapp configure.rb"
    Chef::Log.debug("#{node[:deploy][application][:deploy_to]}/current")
    Chef::Log.info "#{node[:deploy][application][:deploy_to]}/current"
end