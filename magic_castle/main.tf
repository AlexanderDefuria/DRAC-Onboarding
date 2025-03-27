terraform {
  required_version = ">= 1.4.0"
}

variable "pool" {
  description = "Slurm pool of compute nodes"
  default = []
}

module "aws" {
  source         = "./aws"
  config_git_url = "https://github.com/ComputeCanada/puppet-magic_castle.git"
  #config_git_url = "https://github.com/AlexanderDefuria/puppet-magic_castle.git"
  config_version = "14.2.0"

  cluster_name = "magical"
  #cluster_name = "phoenix"
  #domain       = "alexanderdefuria.com"
  domain = "puzzlefish.org"
  #domain       = "calculquebec.cloud"
  # Rocky Linux 9.4 -  ca-central-1
  # https://rockylinux.org/download
  image        = "ami-07fbc9d69b1aa88b9"

  instances = {
    mgmt  =    { type = "m5.xlarge",    count = 1, tags = ["mgmt", "puppet", "nfs"] },
    login =    { type = "m5.4xlarge",  count = 1, tags = ["login", "public", "proxy"] },
    node =     { type = "m5.large",    count = 30, tags = ["node"] },
    # gpu-node = { type = "g4dn.xlarge", count = 2, tags = ["node"], image="ami-0d1b6c42f602ac3e7" },
    # gpu-node-spot = { type = "g4dn.xlarge", count = 1, tags = ["node", "spot"], wait_for_fulfillment = true, block_duration_mintues = 60 },
  }

  # var.pool is managed by Slurm through Terraform REST API.
  # To let Slurm manage a type of nodes, add "pool" to its tag list.
  # When using Terraform CLI, this parameter is ignored.
  # Refer to Magic Castle Documentation - Enable Magic Castle Autoscaling
  pool = var.pool

  volumes = {
    nfs = {
      home     = { size = 250, type = "gp2" }
      project  = { size = 250, type = "gp2" }
      scratch  = { size = 50, type = "gp2" }
    }
  }


  public_keys = [file("~/.ssh/id_ed25519.pub")]

  hieradata = file("./hieradata.yaml")


  nb_users     = 50
  # Shared password, randomly chosen if blank
  guest_passwd = "mindsonai"

  # AWS specifics
  #region            = "us-east-1"
  #region            = "us-east-2"
  region            = "ca-central-1"
  availability_zone = "ca-central-1a"
}

output "accounts" {
  value = module.aws.accounts
}

output "public_ip" {
  value = module.aws.public_ip
}

## Uncomment to register your domain name with custom domain.
#module "dns" {
#  source           = "./dns/txt"
#  name             = module.aws.cluster_name
#  domain           = module.aws.domain
#  public_instances = module.aws.public_instances
#}

module "dns" {
  source           = "git::https://github.com/ComputeCanada/magic_castle.git//dns/cloudflare"
  name             = module.aws.cluster_name
  domain           = module.aws.domain
  public_instances = module.aws.public_instances
}

## Uncomment to register your domain name with Google Cloud
# module "dns" {
#   source           = "./dns/gcloud"
#   project          = "your-project-id"
#   zone_name        = "you-zone-name"
#   name             = module.aws.cluster_name
#   domain           = module.aws.domain
#   public_instances = module.aws.public_instances
# }

output "hostnames" {
	value = module.dns.hostnames
}
