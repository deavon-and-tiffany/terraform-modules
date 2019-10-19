resource "aws_iam_policy" "network-viewer" {
  name        = "network-viewer"
  path        = "/ops/"
  description = "A policy that enables the description of network infrastructure within the hierarchy."

  policy = data.aws_iam_policy_document.network-viewer.json
}

data "aws_iam_policy_document" "network-viewer" {
  statement {
    sid = "AllowNetworkView"
    actions = [
      "ec2:DescribeAddresses",
      "ec2:DescribeAggregateIdFormat",
      "ec2:DescribeAvailabilityZones",
      "ec2:DescribeDhcpOptions",
      "ec2:DescribeEgressOnlyInternetGateways",
      "ec2:DescribeFlowLogs",
      "ec2:DescribeIdFormat",
      "ec2:DescribeIdentityIdFormat",
      "ec2:DescribeInternetGateways",
      "ec2:DescribeMovingAddresses",
      "ec2:DescribeNatGateways",
      "ec2:DescribeNetworkAcls",
      "ec2:DescribeNetworkInterfaceAttribute",
      "ec2:DescribeNetworkInterfacePermissions",
      "ec2:DescribeNetworkInterfaces",
      "ec2:DescribeRegions",
      "ec2:DescribeRouteTables",
      "ec2:DescribeSecurityGroupReferences",
      "ec2:DescribeSecurityGroups",
      "ec2:DescribeStaleSecurityGroups",
      "ec2:DescribeSubnets",
      "ec2:DescribeTrafficMirrorFilters",
      "ec2:DescribeTrafficMirrorTargets",
      "ec2:DescribeTransitGatewayAttachments",
      "ec2:DescribeTransitGatewayRouteTables",
      "ec2:DescribeTransitGatewayVpcAttachments",
      "ec2:DescribeTransitGateways",
      "ec2:DescribeVpcEndpointConnectionNotifications",
      "ec2:DescribeVpcEndpointConnections",
      "ec2:DescribeVpcEndpointServiceConfigurations",
      "ec2:DescribeVpcEndpointServicePermissions",
      "ec2:DescribeVpcEndpointServices",
      "ec2:DescribeVpcEndpoints",
      "ec2:DescribeVpcPeeringConnections",
      "ec2:DescribeVpcs"
    ]

    resources = [
      "*"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/org/hierarchy_id"
      values = [
        "$${aws:PrincipalTag/org/hierarchy_id}"
      ]
    }
  }

  statement {
    sid = "AllDescribeTagsForHierarchy"
    actions = [
      "ec2:DescribeTags"
    ]

    resources = [
      "${local.arn_prefix}:dhcp-options/*",
      "${local.arn_prefix}:internet-gateway/*",
      "${local.arn_prefix}:network-acl/*",
      "${local.arn_prefix}:route-table/*",
      "${local.arn_prefix}:security-group/*",
      "${local.arn_prefix}:subnet/*",
      "${local.arn_prefix}:vpc/*"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:ResourceTag/org/hierarchy_id"
      values = [
        "$${aws:PrincipalTag/org/hierarchy_id}"
      ]
    }
  }
}
