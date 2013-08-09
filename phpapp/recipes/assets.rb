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
    "#{current_path}/.git",
    "#{current_path}/utilities/cap",
    "#{current_path}/utilities/deploy-files",
    "#{current_path}/utilities/AutoCompile.app",
    "#{current_path}/utilities/deploy"
  ]
  
  cleanup_dir.each do |cleanup_dir_name|
    directory cleanup_dir_name do
      recursive true
      action :delete
    end
  end
  Chef::Log.debug("finish cleanup directory")
  
  Chef::Log.debug("start cleanup files")
  cleanup_file = [
    "#{current_path}/.gitignore",
    "#{current_path}/utilities/autocompile.conf"
  ]
  cleanup_file.each do |cleanup_file_name| 
    file cleanup_file_name do 
      action :delete
    end
  end
  Chef::Log.debug("finish cleanup files")  
  
  Chef::Log.debug("finish cleanup")
  
  
  Chef::Log.debug("start create directory")
  create_dir = [
    "#{current_path}/application_lms/cache",
    "#{current_path}/public_lms/tmp"
  ]    
  create_dir.each do |create_dir_name|
    directory create_dir_name do
      owner "root"
      group "root"
      mode 0777
      action :create
    end
  end
  Chef::Log.debug("finish create directory")
  
  Chef::Log.debug("start create symlink")
  link_dir = [
    ["/mnt/writeable/userlogs", "#{current_path}/public_lms/userlogs"],
    ["/mnt/writeable/pdf", "#{current_path}/public_lms/pdf"],
    #["#{shared_path}/wkhtmltopdf", "#{current_path}/public_lms/wkhtmltopdf"],
    ["/mnt/courses", "#{current_path}/public_lms/courses"],
    ["/mnt/courses/showreels", "#{current_path}/public_lms/showreels"],
    ["/mnt/writeable/brochure", "#{current_path}/public_lms/assets/pdf"]    
  ]
  link_dir.each do |link_to_dir_name, link_dir_name|
    link link_dir_name do
      to link_to_dir_name
      only_if do
        ::File.exists?(link_to_dir_name)
      end
    end
  end  
  Chef::Log.debug("finish create symlink")
  
  
  Chef::Log.debug("finish phpapp assets.rb")
  
  
  #create code for shared files not wiped out in deployment
end