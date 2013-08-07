node[:deploy].each do |application, deploy|
  Chef::Log.debug("start phpapp assets.rb")
  Chef::Log.debug("#{node[:deploy][application][:deploy_to]}/current")
  Chef::Log.debug("#{node[:environment]}")
  Chef::Log.debug("#{release_path}")
  template "#{release_path}/application_lms/config/database.php" do
    source "#{release_path}/utilities/deploy-files/lms/#{node[:environment]}/database.php"
  end
  template "#{release_path}/application_lms/config/config.php" do
    source "#{release_path}/utilities/deploy-files/lms/#{node[:environment]}/config.php"
  end
  template "#{release_path}/application_lms/config/zoho.php" do
    source "#{release_path}/utilities/deploy-files/lms/#{node[:environment]}/zoho.php"
  end
  template "#{release_path}/application_lms/config/xero.php" do
    source "#{release_path}/utilities/deploy-files/lms/#{node[:environment]}/xero.php"
  end
  template "#{release_path}/public_lms/index.php" do
    source "#{release_path}/utilities/deploy-files/lms/#{node[:environment]}/index.php"
  end
  template "#{release_path}/public_lms/.htaccess" do
    source "#{release_path}/utilities/deploy-files/lms/#{node[:environment]}/.htaccess"
  end
  template "#{release_path}/utilities/ruckusing/config/database.inc.php" do
    source "#{release_path}/utilities/deploy-files/lms/#{node[:environment]}/database.inc.php"
  end
Chef::Log.debug("end phpapp assets.rb")
Chef::Log.info "end phpapp assets.rb"
end