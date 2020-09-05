terraform {
  backend "remote" {
    organization = "jibakurei"

    workspaces {
      name = "_backend"
    }
  }
}
