resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = [
      { name = "web-1", network_interface = [{ nat_ip_address = "84.201.128.1" }], fqdn = "web1.ru-central1.internal" },
      { name = "web-2", network_interface = [{ nat_ip_address = "84.201.128.2" }], fqdn = "web2.ru-central1.internal" }
    ]
    databases = [
      { name = "main", network_interface = [{ nat_ip_address = "84.201.128.3" }], fqdn = "main.ru-central1.internal" },
      { name = "replica", network_interface = [{ nat_ip_address = "84.201.128.4" }], fqdn = "replica.ru-central1.internal" }
    ]
    storage = [
      { name = "storage", network_interface = [{ nat_ip_address = "84.201.128.5" }], fqdn = "storage.ru-central1.internal" }
    ]
  })
  filename = "${path.module}/hosts.ini"
}
