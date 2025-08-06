# Создаем новую сеть - monitoring
resource "yandex_vpc_network" "monitoring" {
    name = var.vpc_name
}

# Создаем новую подсеть - monitoring-subnet1
resource "yandex_vpc_subnet" "monitoring-subnet1" {
    name           = var.subnet1
    zone           = var.zone
    network_id     = yandex_vpc_network.monitoring.id
    v4_cidr_blocks = var.cidr1
}

# Объявляем переменные
variable "zone" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "cidr1" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "monitoring"
  description = "VPC network&subnet name"
}

variable "subnet1" {
  type        = string
  default     = "monitoring-subnet1"
  description = "subnet name"
}