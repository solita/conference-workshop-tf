variable "your_name" {
  type = string
  validation {
    condition = length(var.your_name) > 0
    error_message = "The value must not be empty."
  }
}

variable "subscription_id" {
  type = string
  validation {
    condition = length(var.subscription_id) > 0
    error_message = "The value must not be empty."
  }
}

variable "kv_sku_name" {
  type = string
  default = "standard"
}
