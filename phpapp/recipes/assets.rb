node[:deploy].each do |application, deploy|
  Chef::Log.debug("start phpapp assets.rb")
  Chef::Log.debug("#{node[:deploy][application][:deploy_to]}/current")
  Chef::Log.debug("#{node[:environment]}")
  file "#{node[:deploy][application][:deploy_to]}/current/application_lms/config/database.php" do
    source "#{node[:deploy][application][:deploy_to]}/utilities/deploy-files/lms/#{node[:environment]}/database.php"
  end
  file "#{node[:deploy][application][:deploy_to]}/current/application_lms/config/config.php" do
    source "#{node[:deploy][application][:deploy_to]}/utilities/deploy-files/lms/#{node[:environment]}/config.php"
  end
  file "#{node[:deploy][application][:deploy_to]}/current/public_lms/index.php" do
    source "#{node[:deploy][application][:deploy_to]}/utilities/deploy-files/lms/#{node[:environment]}/index.php"
  end
  file "#{node[:deploy][application][:deploy_to]}/current/public_lms/.htaccess" do
    source "#{node[:deploy][application][:deploy_to]}/utilities/deploy-files/lms/#{node[:environment]}/.htaccess"
  end
  file "#{node[:deploy][application][:deploy_to]}/current/utilities/ruckusing/config/database.inc.php" do
    source "#{node[:deploy][application][:deploy_to]}/utilities/deploy-files/lms/#{node[:environment]}/database.inc.php"
  end
Chef::Log.debug("end phpapp assets.rb")
Chef::Log.info "end phpapp assets.rb"
end