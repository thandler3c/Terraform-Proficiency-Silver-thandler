variable "resource_group" {
    type = object({
        create      = bool
        name        = string
        location    = string
        tags        = map(string)
    })
}