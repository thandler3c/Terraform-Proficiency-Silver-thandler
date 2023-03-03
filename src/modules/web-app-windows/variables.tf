variable "windows_web_app" {
    type = object({
        create          = bool
        name            = string
        location        = string
        rsg_name        = string
        service_plan_id = string 
        tags            = map(string)
    })
}