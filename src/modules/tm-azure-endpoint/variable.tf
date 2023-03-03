variable "tm_endpoint" {
  type = object({
    create        = bool
    name          = string
    tm_profile_id = string
    weight        = string
    target        = string
  })

}