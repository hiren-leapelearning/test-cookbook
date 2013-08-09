node[:deploy].each do |application, deploy|
  Chef::Log.debug("start phpapp assets.rb")
  Chef::Log.debug("#{node[:deploy][application][:deploy_to]}/current")
  Chef::Log.debug("#{node[:environment]}")
  current_path = "#{node[:deploy][application][:deploy_to]}/current/"
  Chef::Log.debug("start copy_assets")
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
  Chef::Log.debug("finish copy_assets")
  
  
  
  Chef::Log.debug("start cleanup")
  
  Chef::Log.debug("start cleanup directory")
  cleanup_dir = [
    "#{current_path}/utilities/cap",
    "#{current_path}/utilities/deploy-files",
    "#{current_path}/utilities/AutoCompile.app",
    "#{current_path}/utilities/deploy"
  ]
  
  cleanup_dir.each do |dir_name|
    directory dir_name do
      recursive true
      action :delete
    end
  end
  Chef::Log.debug("finish cleanup directory")
  
  Chef::Log.debug("start cleanup files")
  cleanup_file = [
    "#{current_path}/utilities/autocompile.conf"
  ]
  cleanup_file.each do |file_name| 
    file file_name do 
      action :delete
    end
  end
  Chef::Log.debug("finish cleanup files")  
  
  Chef::Log.debug("finish cleanup")
  
  
  Chef::Log.debug("finish phpapp assets.rb")
end