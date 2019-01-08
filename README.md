# terraform-google-spinnaker
A Cloud Foundation Toolkit Module: Opinionated Google Cloud Platform project creation and configuration with Shared VPC, IAM, APIs, etc.

# Pre-reqs

- Google Cloud SDK (gcloud / gsutil)
- terraform
- test-kitchen

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
| ansible\_basedir | This is the location of the ansible playbook on the local disk for the null resource to copy to the GCS bucket | string | - | yes |
| basename | rip this out | string | - | yes |
| dns\_suffix | The DNS suffix to create the actual records | string | - | yes |
| dns\_zone | DNS Zone that will be used to create the Spinnaker service entries | string | - | yes |
| jenkins\_master\_name | Spinnaker resource name for the Jenkins Server you want to register | string | - | yes |
| jenkins\_password | Jenkins password for the username defined in the jenkins_username | string | - | yes |
| jenkins\_port | TCP port that Jenkins is running on | string | - | yes |
| jenkins\_username | Jenkins username to connect to the instance that you defined above | string | - | yes |
| machine\_type | GCE Instance size that the spinnaker instance(s) will be provisioned with. | string | - | yes |
| network | - | string | `default` | no |
| project | GCP Project that Spinnaker will be deployed within | string | - | yes |
| protected\_networks | The network CIDRs that will have access to Spinnaker | list | - | yes |
| region | GCP Region that resources will be deployed into | string | - | yes |
| zone | GCP Availability Zones that the instnaces will be deployed within | string | - | yes |


## Outputs

| Name | Description |
|------|-------------|
| halyard\_config\_gcs\_bucket | GCS Bucket where Halyard Configs and Persistent storage is defined |
| spinnaker\_deck\_allow\_port | Spinnaker Deck UI TCP Port |
| spinnaker\_deck\_url | - |
| spinnaker\_gate\_allow\_port | Spinnaker Gate API TCP Port |
| spinnaker\_gate\_url | - |
| spinnaker\_instance\_ip | GCE Instance IP Address for Spinnaker |
| spinnaker\_instance\_name | Spinnaker GCE Instance name |
| spinnaker\_instance\_zone | Spinnaker instance zone |
| spinnaker\_service\_account | Spinnaker Service account that is used to create GCP resources |
| spinnaker\_service\_account\_key | Spinnaker service account key |


# Validating the Spinnaker Installation

** The full provisioning process of Spinnaker takes roughly 15 minutes **

## Interesting log file locations

- Bootstrapping log file location `/var/log/startup-script.log`
- Spinnaker Logs `/var/log/spinnaker`

## Accessing Spinnaker

URL = http://spkr-gce.{environment}.{dns_suffix}