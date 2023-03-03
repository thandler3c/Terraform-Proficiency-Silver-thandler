locals {
  #Lookup the provided resource type from the variables declaration in variables.tf and store all properties in an object for subsequent lookups.
  resource_type_object = lookup(var.resource_type_definition, var.resource_type)

  #Combine the required parameters passed into the module to form the base name.
  name_joined = "${var.environment_abbr}${var.location_abbr}${var.application_abbr}${local.resource_type_object.abbr}"

  #Check 1 - If an instance sequence number was passed into the module, append to the end of the name.
  name_check_1 = var.sequence_number != "" ? join("", ["${local.name_joined}", "${var.sequence_number}"]) : local.name_joined

  #Check 2 - If global_padding is passed into the module, append to the end of the name.
  name_check_2 = var.global_padding > 0 ? join("", ["${local.name_check_1}", "${substr(var.subscription_id, "-${var.global_padding}", -1)}"]) : local.name_check_1

  #Check 3 - If resource type must be lowercase make it so.
  name_check_3 = local.resource_type_object.lowercase ? lower(local.name_check_2) : local.name_check_2

  #Check 4 - If resource type cannot include dashes, remove them
  name_check_4 = local.resource_type_object.dashes ? local.name_check_3 : replace(local.name_check_3, "-", "")

  #Check 5 - Perform final name validation against resource type allowed characters using REGEX. Any double "-" caused by empty segments are collapsed, and any trailing "-" leftover after the trim are also removed.
  name_check_5 = replace(trimsuffix(replace(local.name_check_4, "--", "-"), "-"), "/${local.resource_type_object.regex}/", "")

  #Check 6 - Check name against resource type maximum length and trim if needed. 
  name_check_6 = length(local.name_check_5) > local.resource_type_object.max_length ? substr(local.name_check_5, 0, local.resource_type_object.max_length) : local.name_check_5
}

output "name" {
  value       = local.name_check_6
  description = "Outputs the formatted name."
}
