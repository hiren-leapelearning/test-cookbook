node[:deploy].each do |application, deploy|
  Chef::Log.debug("start phpapp assets.rb")
  Chef::Log.debug("#{node[:deploy][application][:deploy_to]}/current")
  Chef::Log.debug("#{node[:environment]}")
  current_path = "#{node[:deploy][application][:deploy_to]}/current/"
  Chef::Log.debug("#{current_path}")
  bash "copy_assets" do
    code <<-EOH
    cp #{current_path}/utilities/deploy-files/lms/#{node[:environment]}/database.php #{current_path}/application_lms/config/ 
    cp #{current_path}/utilities/deploy-files/lms/#{node[:environment]}/config.php #{current_path}/application_lms/config/ 
    cp #{current_path}/utilities/deploy-files/lms/#{node[:environment]}/xero.php #{current_path}/application_lms/config/ 
    cp #{current_path}/utilities/deploy-files/lms/#{node[:environment]}/zoho.php #{current_path}/application_lms/config/ 
    cp #{current_path}/utilities/deploy-files/lms/#{node[:environment]}/index.php #{current_path}/public_lms/ 
    cp #{current_path}/utilities/deploy-files/lms/#{node[:environment]}/.htaccess #{current_path}/public_lms/ 
    cp #{current_path}/utilities/deploy-files/lms/#{node[:environment]}/database.inc.php #{current_path}/utilities/ruckusing/config/ 
    EOH
  end
  
  Chef::Log.debug("end phpapp assets.rb")
  Chef::Log.info "end phpapp assets.rb"
end