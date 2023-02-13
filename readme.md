# Module - Storage Class k8s
[![COE](https://img.shields.io/badge/Created%20By-CCoE-blue)]()
[![HCL](https://img.shields.io/badge/language-HCL-blueviolet)](https://www.terraform.io/)
[![Azure](https://img.shields.io/badge/provider-Azure-blue)](https://registry.terraform.io/providers/hashicorp/azurerm/latest)

Module created to help the creation of storage classes. It can be used in GKE, OKE or EKS without any customization. 

## Compatibility matrix

| Module Version | Terraform Version | Kubernetes Provider Version |
|----------------|-------------------| --------------------------- |
| v1.0.0         | v1.3.6            | 2.17.0                      |

## Specifying a version

To avoid that your code get automatically updates for the module is mandatory to set the version using the `source` option. 
By defining the `?ref=***` in the the URL, you can use a specific version of the module.

Note: The `?ref=***` refers a tag on the git module repo.

## Use case for the creation of azurefiles-csi-zrs storage class
```hcl
module "<storage-class-name>" {
  source = "git::https://github.com/danilomnds/terraform-kubernetes-storageclass?ref=v1.0.0"
  definition = {
    azurefile-csi-zrs = {
      name = <azurefile-csi-zrs>
      parameters = {
        skuName = "Standard_ZRS"
      }
      storage_provisioner    = "file.csi.azure.com"
      reclaim_policy         = "Delete"
      volume_binding_mode    = "Immediate"
      allow_volume_expansion = true
      mount_options          = ["dir_mode=0777", "file_mode=0777", "uid=0", "gid=0", "mfsymlinks", "cache=strict", "actimeo=30"]
    }
  }
}
```

## Use case for the creation of azurefiles-csi-zrs storage class specifying the allowed_topologies
```hcl
module "<storage-class-name>" {
  source = "git::https://github.com/danilomnds/terraform-kubernetes-storageclass?ref=v1.0.0"
  definition = {
    azurefile-csi-zrs = {
      name = <azurefile-csi-zrs>
      parameters = {
        skuName = "Standard_ZRS"
      }
      storage_provisioner    = "file.csi.azure.com"
      reclaim_policy         = "Delete"
      volume_binding_mode    = "Immediate"
      allow_volume_expansion = true
      mount_options          = ["dir_mode=0777", "file_mode=0777", "uid=0", "gid=0", "mfsymlinks", "cache=strict", "actimeo=30"]
      key                    = "failure-domain.beta.kubernetes.io/zone"
      values                 = ["us-east-1a", "us-east-1b"]
    }
  }
}
```
## Input Variables

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| definition | Definitions for the storage class creation  | `any` | n/a | `Yes` |

## List of parameters that can be defined for each storage class

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Name of the storage class | `string` | n/a | No |
| labels | Map of string keys and values that can be used to organize and categorize (scope and select) the storage class | `map()` | n/a | No |
| annotations | An unstructured key value map stored with the storage class that may be used to store arbitrary metadata | `map()` | n/a | No |
| parameters | Parameters for the provisioner that should create volumes of this storage class | `map()` | `null` | No |
| storage_provisioner | Indicates the type of the provisioner | `string` | n/a | `Yes` |
| reclaim_policy | Indicates the reclaim policy to use | `String` | `Delete` | No |
| volume_binding_mode | Indicates when volume binding and dynamic provisioning should occur | `String` | `null` | No |
| allow_volume_expansion | Indicates whether the storage class allow volume expand, default true | `bool` | `true` | No |
| mount_options | Restrict the node topologies where volumes can be dynamically provisioned | `string` | `null` | No |
| allowed_topologies (key)| The label key that the selector applies to | `map()` | `null` | No |
| allowed_topologies (value)| An array of string values. One value must match the label to be selected | `list` | `null` | No |
  
## Documentation
Terraform kubernetes_storage_class: <br>
[https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/storage_class](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/storage_class)<br>