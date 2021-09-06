terraform {
  required_version = ">= 1.0.0"
  required_providers {
    # kubernetes = {
    #   version = "1.13.4" # hard dependecy on eks upstream module constrains
    # }

    helm = {
      version = "2.3.0"
    }
  }
}