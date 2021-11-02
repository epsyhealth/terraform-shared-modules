resource "aws_glue_job" "glue_job" {
  name         = "${var.project_name}-${var.name}"
  role_arn     = var.role_arn
  glue_version = var.glue_version

  command {
    python_version  = var.python_version
    script_location = var.script_location
  }

  default_arguments = {
    "--job-language"        = var.job_language
    "--TempDir"             = var.temp_dir
    "--job-bookmark-option" = var.bookmark_option
  }

  worker_type = var.worker_type
  number_of_workers = var.number_of_workers

  connections = var.connections

  tags = var.tags
}

resource "aws_glue_trigger" "glue_trigger" {
  count    = length(var.schedule) > 0 ? 1 : 0
  name     = "${var.name}-schedule"
  schedule = var.schedule
  type     = "SCHEDULED"

  actions {
    job_name = aws_glue_job.glue_job.name
  }
}
