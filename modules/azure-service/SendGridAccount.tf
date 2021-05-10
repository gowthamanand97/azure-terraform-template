# Configure the provider
provider "sendgrid" {
    api_key = "SG.XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX"
}

# Create a template
resource "sendgrid_template" "template"{
    name       = "my-template"
    generation = "dynamic"
}

# Create a template version
resource "sendgrid_template_version" "template_version" {
    name                   = "my-template-version"
    template_id            = sendgrid_template.template.id
    active                 = 1
    html_content           = "<%body%>"
    generate_plain_content = true
    subject                = "subject"
}