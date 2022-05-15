# --== General ==-- #
variable "install_root" {
  type    = string
}

# --== SMTP ==-- #
variable "smtp_host" {
  type    = string
}
variable "smtp_port" {
  type    = number
}
variable "smtp_username" {
  type    = string
}
variable "smtp_password" {
  type    = string
}

# --== WikiJS ==-- #
variable "db_wikijs_username" {
  type    = string
}
variable "db_wikijs_password" {
  type    = string
}

# --== Nextcloud ==-- #
variable "db_nextcloud_username" {
  type    = string
}
variable "db_nextcloud_password" {
  type    = string
}
variable "nextcloud_username" {
  type    = string
}
variable "nextcloud_password" {
  type    = string
}

# --== Snipe-It ==-- #
variable "snipeit_db" {
  type    = string
}
variable "snipeit_db_username" {
  type    = string
}
variable "snipeit_db_password" {
  type    = string
}

variable "snipeit_email_from_addr" {
  type    = string
}
variable "snipeit_email_from_name" {
  type    = string
}

variable "snipeit_appkey" {
  type    = string
}
variable "snipeit_url" {
  type    = string
}
variable "snipeit_timezone" {
  type    = string
}
variable "snipeit_locale" {
  type    = string
}
