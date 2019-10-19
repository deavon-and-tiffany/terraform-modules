resource "aws_iam_policy" "security-admin" {
  name        = "security-admin"
  path        = "/ops/"
  description = "A policy that enables the administration of IAM users, groups, and roles within the hierarchy."

  policy = data.aws_iam_policy_document.security-admin.json
}

data "aws_iam_policy_document" "security-admin" {
  statement {
    sid = "AllowSecurityCreation"
    actions = [
      "iam:CreateAccountAlias",
      "iam:CreateGroup",
      "iam:CreateOpenIDConnectProvider",
      "iam:CreateRole",
      "iam:CreateSAMLProvider",
      "iam:CreateServiceLinkedRole",
      "iam:TagRole",
      "iam:TagUser",
      "iam:UntagRole",
      "iam:UntagUser"
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
    sid = "AllowSecurityManagement"
    actions = [
      "iam:AddClientIDToOpenIDConnectProvider",
      "iam:AddUserToGroup",
      "iam:AttachGroupPolicy",
      "iam:AttachRolePolicy",
      "iam:AttachUserPolicy",
      "iam:DeleteAccountAlias",
      "iam:DeleteGroup",
      "iam:DeleteRole",
      "iam:DeleteRolePermissionsBoundary",
      "iam:DeleteSAMLProvider",
      "iam:DeleteServerCertificate",
      "iam:DeleteServiceLinkedRole",
      "iam:DetachGroupPolicy",
      "iam:DetachRolePolicy",
      "iam:DetachUserPolicy",
      "iam:PutRolePermissionsBoundary",
      "iam:PutUserPermissionsBoundary",
      "iam:RemoveClientIDFromOpenIDConnectProvider",
      "iam:RemoveUserFromGroup",
      "iam:SetSecurityTokenServicePreferences",
      "iam:UpdateAssumeRolePolicy",
      "iam:UpdateGroup",
      "iam:UpdateOpenIDConnectProviderThumbprint",
      "iam:UpdateRole",
      "iam:UpdateRoleDescription",
      "iam:UpdateSAMLProvider",
      "iam:UpdateServerCertificate",
      "iam:UploadServerCertificate"
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
}
