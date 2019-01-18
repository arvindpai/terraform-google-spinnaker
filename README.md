# terraform-google-spinnaker

A Cloud Foundation Toolkit module: This terraform module creates a GCE instance
of spinnaker. The module is based on the [Running Spinnaker on Compute Engine](https://cloud.google.com/solutions/spinnaker-on-compute-engine) solution though Jenkins has been omitted to give freedom of CI choice.

## Testing

This module comes packaged with tests with the goal of exercising the module in
various forms. To execute them, you need the following:

1. A project in GCP.
2. An IAM user with credentials downloaded locally. The
  `GOOGLE_APPLICATION_CREDENTIALS` environment variable should point to its
  path.
3. The following roles attached to that IAM user:
    ```text
    roles/compute.networkAdmin
    roles/compute.loadBalancerAdmin
    ```
4. The `docker` daemon installed and running.

To run the test suites:

1. configure them by populating `terraform.tfvars` using the colocated
  `terraform.tfvars.example` as an example. If this file is not present before
  running tests, the setup process will attempt to provide values.
2. Run the tests with following command:
    ```bash
      make test_integration_docker
    ```

[^]: (autogen_docs_start)


## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| activate_apis |  | list | `<list>` | no |
| ansible_basedir | This is the location of the ansible playbook on the local disk for the null resource to copy to the GCS bucket | string | - | yes |
| boot_disk_size | Size of the spinnaker instance boot disk. | string | `60` | no |
| disable_services_on_destroy | This option informs whether `google_project_service` resources to attempt disable APIs in the case tha this module is destroyed. | string | `false` | no |
| image_family | description | string | `` | no |
| image_name | description | string | `` | no |
| image_project | description | string | `` | no |
| instance_metadata | description | string | `<map>` | no |
| labels | description | string | `<map>` | no |
| machine_type | The size of the spinnaker instance. | string | `n1-standard-4` | no |
| network_name | description | string | `default` | no |
| network_project | description | string | `` | no |
| primary_zone | description | string | `` | no |
| project | Project in which resources will be created. | string | - | yes |
| protected_networks | The network CIDRs that will have access to Spinnaker | list | `<list>` | no |
| redis_configs | description | string | `<map>` | no |
| redis_memory_size_gb | description | string | `1` | no |
| redis_service_tier | description | string | `STANDARD_HA` | no |
| region | The region resources will be deployed into | string | - | yes |
| resource_name | The name given to all resources. | string | `spinnaker` | no |
| secondary_zone | description | string | `` | no |
| service_account_email | description | string | `` | no |
| service_account_scopes | description | list | `<list>` | no |
| subnetwork_name | description | string | `default` | no |
| zone_dns_name | Must include trailing period (.) | string | - | yes |
| zone_name | DNS Zone that will be used to create the Spinnaker service entries | string | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| deck_allow_port | Spinnaker Deck UI TCP Port |
| gate_allow_port | Spinnaker Gate API TCP Port |
| halyard_config_gcs_bucket | GCS Bucket where Halyard Configs and Persistent storage is defined |
| instance_ip | GCE Instance IP Address for Spinnaker |
| instance_name | Spinnaker GCE Instance name |
| service_account | Spinnaker Service account that is used to create GCP resources |
| service_account_key_name | Spinnaker service account key |

[^]: (autogen_docs_end)

# Validating the Spinnaker Installation

** The full provisioning process of Spinnaker takes roughly 15 minutes **

## Interesting log file locations

- Bootstrapping log file location `/var/log/startup-script.log`
- Spinnaker Logs `/var/log/spinnaker`

## Accessing Spinnaker

URL = http://spkr-gce.{environment}.{zone_dns_name}