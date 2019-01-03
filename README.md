# terraform-google-spinnaker
A Cloud Foundation Toolkit Module: Opinionated Google Cloud Platform project creation and configuration with Shared VPC, IAM, APIs, etc.

# Pre-reqs


# Sample Module Configuration

```hcl-terraform
module "spinnaker" {
  source              = "../../"
  project             = "${var.project_id}"
  dns_zone            = "${var.dns_zone}"
  dns_suffix          = "${var.dns_suffix}"
  network             = "${var.network}"
  region              = "${var.region}"
  jenkins_username    = "spin-admin"
  jenkins_port        = "9090"
  jenkins_master_name = "spin-jenkins"
  jenkins_password    = "xxxxxxx"
  basename = "${var.environment}"
  ansible_basedir = "${var.ansible_basedir}"
}
```

# Module Variable Configuration

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| ansible\_basedir | Required for Ansible configuration | string | - | yes |
| basename | rip this out | string | - | yes |
| dns\_suffix | - | string | - | yes |
| dns\_zone | - | string | - | yes |
| jenkins\_master\_name | - | string | - | yes |
| jenkins\_password | - | string | - | yes |
| jenkins\_port | - | string | - | yes |
| jenkins\_username | - | string | - | yes |
| network | - | string | `default` | no |
| project | - | string | - | yes |
| region | - | string | - | yes |


## Outputs

| Name | Description |
|------|-------------|
| halyard\_config\_gcs\_bucket | - |
| spinnaker\_deck\_allow\_port | - |
| spinnaker\_deck\_url | - |
| spinnaker\_gate\_allow\_port | - |
| spinnaker\_gate\_url | - |
| spinnaker\_instance\_ip | - |
| spinnaker\_instance\_name | - |
| spinnaker\_service\_account | - |
| spinnaker\_service\_account\_key | - |
