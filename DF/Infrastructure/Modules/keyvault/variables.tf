variable "name" {
  type = string
}

variable "location" {
  type = string
}

variable "resource_group_name" {
  type = string
}


variable "tags" {
  type    = map
  default = {}
}

variable "sku" {
  default = "standard"
}

variable "access_policies" {
  type = list(object({
    object_id          = string
    key_permissions    = list(string)
    secret_permissions = list(string)
  }))

  default = []
}
