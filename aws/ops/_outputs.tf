output "roles" {
  value = {
    agent = {
      id                   = aws_iam_role.agent.id
      unique_id            = aws_iam_role.agent.unique_id
      arn                  = aws_iam_role.agent.arn
      max_session_duration = aws_iam_role.agent.max_session_duration
    }

    devops = {
      id                   = aws_iam_role.devops.id
      unique_id            = aws_iam_role.devops.unique_id
      arn                  = aws_iam_role.devops.arn
      max_session_duration = aws_iam_role.devops.max_session_duration
    }

    devops-lambda = {
      id                   = aws_iam_role.devops-lambda.id
      unique_id            = aws_iam_role.devops-lambda.unique_id
      arn                  = aws_iam_role.devops-lambda.arn
      max_session_duration = aws_iam_role.devops-lambda.max_session_duration
    }

    network-admin = {
      id                   = aws_iam_role.network-admin.id
      unique_id            = aws_iam_role.network-admin.unique_id
      arn                  = aws_iam_role.network-admin.arn
      max_session_duration = aws_iam_role.network-admin.max_session_duration
    }

    policy-admin = {
      id                   = aws_iam_role.policy-admin.id
      unique_id            = aws_iam_role.policy-admin.unique_id
      arn                  = aws_iam_role.policy-admin.arn
      max_session_duration = aws_iam_role.policy-admin.max_session_duration
    }

    security-admin = {
      id                   = aws_iam_role.security-admin.id
      unique_id            = aws_iam_role.security-admin.unique_id
      arn                  = aws_iam_role.security-admin.arn
      max_session_duration = aws_iam_role.security-admin.max_session_duration
    }

    ecs-admin = {
      id                   = aws_iam_role.ecs-admin.id
      unique_id            = aws_iam_role.ecs-admin.unique_id
      arn                  = aws_iam_role.ecs-admin.arn
      max_session_duration = aws_iam_role.ecs-admin.max_session_duration
    }

    eks-admin = {
      id                   = aws_iam_role.eks-admin.id
      unique_id            = aws_iam_role.eks-admin.unique_id
      arn                  = aws_iam_role.eks-admin.arn
      max_session_duration = aws_iam_role.eks-admin.max_session_duration
    }
  }
}
