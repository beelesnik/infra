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

variable app_disk_image {
    description = "Disk image for reddit app"
    default     = "reddit-app-1529492708"
}

variable db_disk_image {
    description = "Disk image for reddit db"
    default     = "reddit-db-1529492715"
}
