variable "name" {}
variable "workspace" {}

data "terraform_remote_state" "state" {
  backend = "local"

  config = {
    path = "${path.module}/../../components/${var.name}/terraform.tfstate.d/${var.workspace}/terraform.tfstate"
  }
}

output "outputs" {
  value = data.terraform_remote_state.state.outputs
}