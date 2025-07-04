variable "project" {
  description = "The GCP project ID where resources will be created"
  type        = string
}

variable "region" {
  description = "The GCP region for regional resources"
  type        = string
  default     = "us-central1"
}

variable "zone" {
  description = "The GCP zone for zonal resources"
  type        = string
  default     = "us-central1-a"
}

variable "network_name" {
  description = "Name of the VPC network to create/use"
  type        = string
  default     = "chainlink-net"
}

variable "instance_name" {
  description = "Name of the Compute Engine instance"
  type        = string
  default     = "chainlink-node"
}

variable "instance_tags" {
  description = "Network tag applied to the instance for firewall rules"
  type        = string
  default     = "chainlink-node"
}

variable "instance_image" {
  description = "Boot disk image to use (project/image-family)"
  type        = string
  default     = "ubuntu-os-cloud/ubuntu-2004-lts"
}

variable "machine_type" {
  description = "Machine type for the instance"
  type        = string
  default     = "e2-medium"
}

variable "disk_size" {
  description = "Boot disk size in GB"
  type        = number
  default     = 50
}

variable "ssh_user" {
  description = "Username for SSH key metadata on the VM"
  type        = string
}

variable "ssh_key_path" {
  description = "Path to the public SSH key file"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "service_account_email" {
  description = "Service account email to attach to the VM"
  type        = string
}

variable "source_ranges" {
  description = "CIDR range allowed for inbound UI/API access (e.g. YOUR_IP/32)"
  type        = string
}
