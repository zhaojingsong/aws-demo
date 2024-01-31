// The snapshot repository for the version that has not yet been released
resource "aws_ecr_repository" "snapshot" {
  name                 = "bar"
  image_tag_mutability = "MUTABLE"

  image_scanning_configuration {
    scan_on_push = true
  }
}

#TODO Add release repository