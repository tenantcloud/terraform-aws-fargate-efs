# resource "aws_efs_file_system" "main" {
#   tags = {
#     Name = join("-", [var.project, "fs"])
#   }
# }

# resource "aws_efs_access_point" "main" {
#   file_system_id = aws_efs_file_system.main.id
#   posix_user {
#     gid = 1000
#     uid = 1000
#   }
#   root_directory {
#     path = "/"
#     creation_info {
#       owner_gid   = 1000
#       owner_uid   = 1000
#       permissions = 777
#     }
#   }

#   tags = {
#     Name = join("-", [var.project, "mp"])
#   }
# }

# resource "aws_efs_file_system_policy" "policy" {
#   file_system_id = aws_efs_file_system.main.id

#   policy = <<POLICY
# {
#     "Version": "2012-10-17",
#     "Id": "ExamplePolicy01",
#     "Statement": [
#         {
#             "Sid": "ExampleSatement01",
#             "Effect": "Allow",
#             "Principal": {
#                 "AWS": "*"
#             },
#             "Resource": "${aws_efs_file_system.main.arn}",
#             "Action": [
#                 "elasticfilesystem:ClientMount",
#                 "elasticfilesystem:ClientWrite"
#             ],
#             "Condition": {
#                 "Bool": {
#                     "aws:SecureTransport": "true"
#                 }
#             }
#         }
#     ]
# }
# POLICY

# }

# resource "aws_efs_mount_target" "main" {
#   count = "2"

#   file_system_id  = aws_efs_file_system.main.id
#   subnet_id       = element([var.subnets_public[0], var.subnets_public[1]], count.index)
#   security_groups = [aws_security_group.efs.id]
# }

# resource "aws_security_group" "efs" {
#   name        = join("-", [var.project, "efs-mount"])
#   description = "Allows NFS traffic from instances within the VPC."
#   vpc_id      = var.vpc_id

#   ingress {
#     from_port = 2049
#     to_port   = 2049
#     protocol  = "tcp"

#     cidr_blocks = [
#       "0.0.0.0/0",
#     ]
#   }

#   egress {
#     from_port = 2049
#     to_port   = 2049
#     protocol  = "tcp"

#     cidr_blocks = [
#       "0.0.0.0/0",
#     ]
#   }

#   tags = {
#     Name = join("-", [var.project, "allow_nfs_fargate"])
#   }
# }