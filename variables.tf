variable "do_token" {
  type = string
  description = "Token de acceso a DigitalOcean"
  sensitive = true
}

variable "mongo_uri" {
  type = string
  description = "URI para la conexión a MongoDB"
  sensitive = true
}