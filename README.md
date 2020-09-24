# AWS Fargate with (EFS)

![terraform v0.12.x](https://img.shields.io/badge/terraform-v0.12.x-brightgreen.svg)

Create `fargate.tf` file

```HCL
module "fargate" {
  source  = "tenantcloud/fargate/ecs"

  az_count = 2
  app_image = nginx:latest
  app_count = 1
  app_count_min = 1
  app_count_max = 5
  health_check_path = "/"
  fargate_cpu = 512
  fargate_memory = 1024
  dns_zone_id = "Route53ID"
  domain_name = "example.com"
  project = "example"
}
```
