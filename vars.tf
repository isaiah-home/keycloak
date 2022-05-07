# --== Database ==-- #

# admin
variable "db_admin_name" {
  type    = string
  default = "admin"
}
variable "db_admin_password" {
  type    = string
  default = "password"
}

# --== Keycloak ==-- #
# keycloak
variable "db_keycloak_name" {
  type    = string
  default = "keycloak"
}
variable "db_keycloak_password" {
  type    = string
  default = "password"
}
variable "keycloak_user" {
  type    = string
  default = "keycloak"
}
variable "keycloak_password" {
  type    = string
  default = "password"
}

# --== WikiJS ==-- #
variable "db_wikijs_name" {
  type    = string
  default = "wikijs"
}
variable "db_wikijs_password" {
  type    = string
  default = "password"
}

# --== Nginx ==-- #
variable "domain" {
  type    = string
  default = "ivcode.org"
}