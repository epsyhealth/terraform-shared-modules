# List of modules and example of use

## Glue job
This functionality consists of three modules, [glue_connection](./glue_connection), [glue_iam](./glue_iam) and [glue_job](./glue_job).

### Example
```terraform
locals {
  name = "my-project"
}

module "glue_connection" {
  source = "./glue_connection"

  connection_name = local.name
}

module "glue_iam" {
  source = "./glue_iam"
  
  name = local.name
  s3_buckets = [
    "arn:aws:s3:::${local.name}",
    "arn:aws:s3:::${local.name}/*"
  ]
}

module "glue_job" {
  source = "./glue_job"
  
  for_each = {
    aura_event = {
    }
  }

  project_name = var.project_name
  name = each.key
  script_location = "s3://my-s3-bucket-with-scripts/scripts/glue_job_${each.key}.py"
  temp_dir = "s3://my-s3-bucket-with-scripts/tmp"
  role_arn = module.glue_iam.role_arn
  connections = [local.name]
    schedule = "*/15 * * * *"
}
```

## ECS

### Task
Allows you define ECS task.
