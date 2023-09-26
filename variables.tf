variable "user_uuid" {
  description = "User UUID"
  type        = string

  validation {
    condition     = can(regex("^([0-9a-fA-F]){8}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){4}-([0-9a-fA-F]){12}$", var.user_uuid))
    error_message = "User UUID is not in the correct format. It should be a valid UUID."
  }
}
