locals {
  availability_zones_count = "${length(data.aws_availability_zones.current.names)}"

}
