resource "yandex_compute_instance" "monitoring" {
    count       = 1
    name        = "master"
    platform_id = "standard-v1"
    zone        = var.zone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 100
  } 

  boot_disk {
    initialize_params {
      image_id = var.image_id
      size     = 30
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.monitoring-subnet1.id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
  }
}