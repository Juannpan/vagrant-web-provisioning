Vagrant.configure("2") do |config|
  # Máquina Web
  config.vm.define "web" do |web|
    web.vm.box = "ubuntu/focal64"
    web.vm.hostname = "web"
    web.vm.network "private_network", ip: "192.168.56.3"
    web.vm.provision "shell", path: "provision-web.sh"
  end

  # Máquina DB
  config.vm.define "db" do |db|
    db.vm.box = "ubuntu/focal64"
    db.vm.hostname = "db"
    db.vm.network "private_network", ip: "192.168.56.4"
    db.vm.provision "shell", path: "provision-db.sh", args: "mi_proyecto admin_proyecto contraseñasegura123"
  end
end
