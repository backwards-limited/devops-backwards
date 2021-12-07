/*
Terraform can be smart enough to work out the necessary provider.
In this case we could (but don't have to) include the following:

provider "local" {}
*/

terraform {
  required_version = ">= 0.15"

  required_providers {
    local = {
      source = "hashicorp/local"
      version = "~> 2.0"
    }
  }
}

resource "local_file" "literature" {
  filename = "art-of-war.txt"

  # Heredoc syntax for multi-line strings. Unlike traditional heredoc, leading whitespace is ignored.
  content = <<-EOT
    Sun Tzu said: The art of war is of vital importance to the State.

    It is a matter of life and death, a road either to safety or to ruin.
    Hence, it is a subject of inquiry which can on no account be neglected.
  EOT
}

/*
terraform init

terraform plan

See plan as a graph
terraform graph | dot -Tsvg > graph.svg

Save plan (as binary) to then view (as JSON)
terraform plan -out plan.out

terraform show -json plan.out > plan.json

Apply with shortcut
terraform apply -auto-approve
*/

/*
What about configuration drift e.g. we manually change the text file?
Let's change "Sun Tzu" with "Napoleon".

Well want we want to do is:
terraform refresh

You can think of terraform refresh like a terraform plan that also alters the state file.
It’s a read-only operation that does not modify managed existing infrastructure — just Terraform state.

Then:
terraform apply -auto-approve

And now our file is restored.
*/

/*
To finally finish off our work:
terraform destroy -auto-approve
*/