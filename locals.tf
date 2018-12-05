locals {
  availability_zones_count = "${length(data.aws_availability_zones.current.names)}"
  availability_zone        = "${data.aws_availability_zones.current.names[count.index]}"
}
