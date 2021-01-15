variable "name" {
  description = "The name for the repository."
  type        = string
}

variable "namespace" {
  description = "The namespace for the repository."
  type        = string
  default     = null
}

variable "mutability" {
  description = "The mutability level for the repository."
  type        = string
  default     = "MUTABLE"
}

variable "lifecycle_policy" {
  description = "The lifecycle policy for the repository."
  type        = string
  default     = null
}

variable "enable_scan_on_push" {
  description = "Indicate whether the repository will scan on push."
  type        = bool
  default     = true
}

variable "allowed_read_principals" {
  description = "Indicate who should have read access."
  type        = list(string)
  default     = ["*"]
}

variable "allowed_write_principals" {
  description = "Indicate who should have write access."
  type        = list(string)
  default     = []
}

variable "tags" {
  description = "A mapping of tags to assign to the repository."
  type        = map(string)
  default     = {}
}
