provider "google" {
  project = "${var.project}"
  region  = "${var.region}"
}

resource "google_compute_instance" "app" {
  name         = "reddit-app"
  machine_type = "g1-small"
  zone         = "europe-west1-b"
  # определение загрузочного диска
  boot_disk {
    initialize_params {
      image = "${var.disk_image}"
    }
  }
  # определение сетевого интерфейса
  network_interface {
    # сеть, к которой присоединить данный интерфейс
    network = "default"
    # использовать ephemeral IP для доступа из Интернет
    access_config {}
  }
  metadata {
      sshKeys = "appuser:${file(var.public_key_path)}"
    }
  tags = ["reddit-app"]
  # Define connection method for provisioners
  connection {
    type     = "ssh"
    user     = "appuser"
    agent = false
    private_key = "${file("~/.ssh/appuser")}"
  } 
  # Define provisioners. Copy service file for systemd. Note that provisioners launch only while resource is created
  provisioner "file" {
   source      = "files/puma.service"
   destination = "/tmp/puma.service"
  }
  # Define provisioners. Install our app
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}

resource "google_compute_firewall" "firewall_puma" {
  name    = "allow-puma-default"
  # Название сети, в которой действует правило
  network = "default"
  # Какой доступ разрешить
  allow {
    protocol = "tcp"
    ports    = ["9292"]
  }
  # Каким адресам разрешаем доступ
  source_ranges = ["0.0.0.0/0"]
  # Правило применимо для инстансов с тегом …
  target_tags = ["reddit-app"]
}
