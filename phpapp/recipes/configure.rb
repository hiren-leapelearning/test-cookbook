node[:deploy].each do |application, deploy|
    Chef::Log.debug("start phpapp configure.rb")
    Chef::Log.info "start phpapp configure.rb"
    Chef::Log.debug("#{default[:deploy][application][:absolute_document_root]}")
    Chef::Log.info "#{default[:deploy][application][:absolute_document_root]}"
end