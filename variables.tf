variable "ssh_key" {
  description = "SSH public key for login access."
  type        = string
}

variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "image_id" {
  description = "ID образа для запуска ВМ"
  type        = string
  default     = "fd8bv1vdr0alvbbeq6ej" 
}
