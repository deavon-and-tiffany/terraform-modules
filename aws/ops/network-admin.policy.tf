resource "aws_iam_policy" "network-admin" {
  name        = "network-admin"
  path        = "/ops/"
  description = "A policy that enables the creation and modification of network infrastructure within the hierarchy."

  policy = data.aws_iam_policy_document.network-admin.json
}

data "aws_iam_policy_document" "network-admin" {
  statement {
    sid = "AllowNetworkCreation"
    actions = [
      "ec2:CreateVpc",
      "ec2:CreateSubnet",
      "ec2:CreateRouteTable",
      "ec2:CreateRoute",
      "ec2:CreateInternetGateway",
      "ec2:CreateNatGateway",
      "ec2:CreateRouteTable",
      "ec2:CreateSecurityGroup",
      "ec2:CreateNetworkAcl",
      "ec2:CreateDhcpOptions",
      "ec2:CreateEgressOnlyInternetGateway"
    ]

    resources = [
      "*"
    ]

    condition {
      test     = "StringEquals"
      variable = "aws:RequestTag/org/hierarchy_id"
      values = [
        "$${aws:PrincipalTag/org/hierarchy_id}"
      ]
    }

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:TagKeys"
      values   = [for k, v in local.required_tags : k]
    }
  }

  statement {
    sid = "AllowNetworkCreationNoTags"
    actions = [
      "ec2:CreateRoute",
      "ec2:CreateNetworkAclEntry",
      "ec2:CreateFlowLogs"
    ]

    resources = [
      "*"
    ]

    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/org/hierarchy_id"
      values = [
        "$${aws:PrincipalTag/org/hierarchy_id}"
      ]
    }
  }

  statement {
    sid = "AllowNetworkManagement"
    actions = [
      "ec2:AcceptVpcEndpointConnections",
      "ec2:AcceptVpcPeeringConnection",
      "ec2:AllocateAddress",
      "ec2:AllocateHosts",
      "ec2:AssignIpv6Addresses",
      "ec2:AssignPrivateIpAddresses",
      "ec2:AssociateDhcpOptions",
      "ec2:AssociateRouteTable",
      "ec2:AssociateSubnetCidrBlock",
      "ec2:AssociateVpcCidrBlock",
      "ec2:AttachInternetGateway",
      "ec2:AuthorizeSecurityGroupEgress",
      "ec2:AuthorizeSecurityGroupIngress",
      "ec2:DeleteInternetGateway",
      "ec2:DeleteNatGateway",
      "ec2:DeleteNetwork*",
      "ec2:DeleteRoute*",
      "ec2:DeleteSecurityGroup",
      "ec2:DeleteSubnet",
      "ec2:DeleteVpc",
      "ec2:DeleteVpcEndpoint*",
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
      "ec2:DescribeNetwork*",
      "ec2:DisassociateRouteTable",
      "ec2:DisassociateSubnetCidrBlock",
      "ec2:DisassociateVpcCidrBlock",
      "ec2:EnableVgwRoutePropagation",
      "ec2:ModifySubnetAttribute",
      "ec2:ModifyVpcAttribute",
      "ec2:ModifyVpcEndpoint",
      "ec2:ModifyVpcEndpointConnectionNotification",
      "ec2:ModifyVpcEndpointServiceConfiguration",
      "ec2:ModifyVpcEndpointServicePermissions",
      "ec2:ModifyVpcTenancy",
      "ec2:MoveAddressToVpc",
      "ec2:RejectVpcEndpointConnections",
      "ec2:ReleaseAddress",
      "ec2:ReplaceNetworkAclAssociation",
      "ec2:ReplaceNetworkAclEntry",
      "ec2:ReplaceRoute",
      "ec2:ReplaceRouteTableAssociation",
      "ec2:RevokeSecurityGroupEgress",
      "ec2:RevokeSecurityGroupIngress",
      "ec2:UnassignIpv6Addresses",
      "ec2:UnassignPrivateIpAddresses",
      "ec2:UpdateSecurityGroupRuleDescriptionsEgress",
      "ec2:UpdateSecurityGroupRuleDescriptionsIngress"
    ]

    resources = [
      "*"
    ]

    condition {
      test     = "StringEquals"
      variable = "ec2:ResourceTag/org/hierarchy_id"
      values = [
        "$${aws:PrincipalTag/org/hierarchy_id}"
      ]
    }
  }

  statement {
    sid = "AllowModifyTagsForHierarchy"
    actions = [
      "ec2:CreateTags",
      "ec2:DeleteTags"
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
      variable = "aws:RequestTag/org/hierarchy_id"
      values = [
        "$${aws:PrincipalTag/org/hierarchy_id}"
      ]
    }

    condition {
      test     = "ForAllValues:StringEquals"
      variable = "aws:TagKeys"
      values   = [for k, v in local.required_tags : k]
    }
  }

  statement {
    sid = "AllDescribeTagsForHierarchy"
    actions = [
      "ec2:DescribeTags"
    ]

    resources = ["*"]
  }
}
