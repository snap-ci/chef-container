# this is a workaround in case users install qt48
directory "/opt/rh/qt48/root/usr/include/QtCore" do
  recursive true
end

execute "ln -sf /opt/rh/qt48/root/usr/include/QtCore/qconfig-64.h /opt/rh/qt48/root/usr/include/QtCore/qconfig-x86_64.h" do
  creates "/opt/rh/qt48/root/usr/include/QtCore/qconfig-x86_64.h"
end
