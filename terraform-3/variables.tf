variable project {
  description = "Project ID"
}

variable region {
  description = "Region"
  default     = "europe-west1"
}

variable public_key_path {
  description = "Path to the public key used for ssh access"
}

variable disk_image {
  description = "Disk image"
}

variable app_disk_image {
    description = "Disk image for reddit app"
    default     = "reddit-app-1529104555"
}

variable db_disk_image {
    description = "Disk image for reddit app"
    default     = "reddit-db-1529104698"
}
