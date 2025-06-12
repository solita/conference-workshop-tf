locals {
  region = "westeurope"

  your_name = replace(var.your_name, ".", "")

  tags = {
    Owner = "${var.your_name}@solita.fi"
    DueDate = "2025-06-14" # Tomorrow
  }

  rg = {
    name = "rg-${local.your_name}-001"
  }

  apim = {
    name = "apim-${local.your_name}-001"
    publisher_name = "Solita"
    publisher_email = "${var.your_name}@solita.fi"
  }
}
