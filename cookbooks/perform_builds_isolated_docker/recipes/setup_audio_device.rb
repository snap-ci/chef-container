
group "audio" do
  action :modify
  members "go"
  append true
  system true
end

execute "setup audio device" do
  command "sh /opt/local/audio/audio_setup"
  user "root"
end