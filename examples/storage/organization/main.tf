/**
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

provider "google" {
  version = "~> 2.0"
}

resource "random_string" "suffix" {
  length  = 4
  upper   = "false"
  special = "false"
}

module "log_export" {
  source                 = "../../..//modules/storage"
  destination_project_id = "${var.project_id}"
  parent_resource_id     = "${var.parent_resource_id}"
  parent_resource_type   = "organization"
  unique_writer_identity = "true"
  filters                = ["resource.type = gce_instance"]
  sink_names             = ["storage_org_${random_string.suffix.result}"]
  storage_bucket_names   = ["storage_org_${random_string.suffix.result}"]
}
