resource "aws_resourcegroups_group" "terraform" {
  name = "managed-resources"

  resource_query {
    query = <<JSON
    {
        "ResourceTypeFilters": [
            "AWS::AllSupported"
        ],
        "TagFilters": [{
            "Key": "ops/managed-by",
            "Values": ["terraform"]
        }]
    }
    JSON
  }
}

resource "aws_resourcegroups_group" "workspace" {
  name = "managed-resources-${terraform.workspace}"

  resource_query {
    query = <<JSON
    {
        "ResourceTypeFilters": [
            "AWS::AllSupported"
        ],
        "TagFilters": [{
            "Key": "terraform/worspace",
            "Values": ["${terraform.workspace}"]
        }]
    }
    JSON
  }
}

resource "aws_resourcegroups_group" "name" {
  name = var.name

  resource_query {
    query = <<JSON
    {
        "ResourceTypeFilters": [
            "AWS::AllSupported"
        ],
        "TagFilters": [{
            "Key": "org/hierarchy_id",
            "Values": ["${var.org.hierarchy_id}"]
        }]
    }
    JSON
  }
}
