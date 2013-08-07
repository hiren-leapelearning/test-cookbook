node[:deploy].each do |application, deploy|
  Chef::Log.debug("start phpapp assets.rb")
  Chef::Log.debug("#{node[:deploy][application][:deploy_to]}/current")
  Chef::Log.debug("#{node[:environment]}")
  Chef::Log.debug("#{current_release}")
  template "#{current_release}/application_lms/config/database.php" do
    source "#{current_release}/utilities/deploy-files/lms/#{node[:environment]}/database.php"
  end
  template "#{current_release}/application_lms/config/config.php" do
    source "#{current_release}/utilities/deploy-files/lms/#{node[:environment]}/config.php"
  end
  template "#{current_release}/application_lms/config/zoho.php" do
    source "#{current_release}/utilities/deploy-files/lms/#{node[:environment]}/zoho.php"
  end
  template "#{current_release}/application_lms/config/xero.php" do
    source "#{current_release}/utilities/deploy-files/lms/#{node[:environment]}/xero.php"
  end
  template "#{current_release}/public_lms/index.php" do
    source "#{current_release}/utilities/deploy-files/lms/#{node[:environment]}/index.php"
  end
  template "#{current_release}/public_lms/.htaccess" do
    source "#{current_release}/utilities/deploy-files/lms/#{node[:environment]}/.htaccess"
  end
  template "#{current_release}/utilities/ruckusing/config/database.inc.php" do
    source "#{current_release}/utilities/deploy-files/lms/#{node[:environment]}/database.inc.php"
  end
Chef::Log.debug("end phpapp assets.rb")
Chef::Log.info "end phpapp assets.rb"
end