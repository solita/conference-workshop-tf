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

variable "apim_sku_name" {
  type = string
  description = "The SKU of the APIM."
  default = "Developer_1"
}

variable "apim_min_api_version" {
  type = string
  default = "2021-08-01"
}
