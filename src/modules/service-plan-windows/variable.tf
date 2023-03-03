variable "windows_service_plan" {
    type = object({
        create      = bool
        name        = string
        location    = string
        rsg_name    = string
        sku_name    = string
        tags        = map(string)
    })
}