# --== MySQL ==-- #
variable "mysql_password" {
  type    = string
}

# --== Keycloak ==-- #
# keycloak
variable "db_keycloak_username" {
  type    = string
}
variable "db_keycloak_password" {
  type    = string
}
variable "keycloak_username" {
  type    = string
}
variable "keycloak_password" {
  type    = string
}

# --== WikiJS ==-- #
variable "db_wikijs_username" {
  type    = string
}
variable "db_wikijs_password" {
  type    = string
}

