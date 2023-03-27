# terraform related resources

## useful resources

debug and restricting access to recources with regex:

`https://spacelift.io/blog/terraform-debug`

## directory structure

```sh
appabc/
  env/
    dev/
      main.tf
      variables.tf
      modules.tf
    staging/
      main.tf
      variables.tf
      modules.tf
    prod/
      main.tf
      variables.tf
      modules.tf
  modules/
    mod-a/mod.tf
    mod-b/mod.tf
```

## object control patterns

- prevent people from making changes to certain resources by limiting the
  resources a person/group have access to. if a module requires 8 arguments
  we can default 6 of the arguments to what we want them to be and only allow
  changes to two of them.

## trunk based development

- keep branches shallow
- keep feature branches shortlived

## varaibles (order of precedence)

`lower priority`

1. environment variables, anything that starts with `TF_VAR_*`
2. terraform.tfvars
3. variable.auto.tfvars
4. -var flags at runtime
   `higher priority`

## commands

`terraform show` - show terraform state in json format
`terrafrom output` - how terraform outputs vars to the screen
`terraform -refresh=false` - run terraform without having to reconcile state on remote backend,
this is only good if you are certain the state file is upto date.
`terraform validate` - validates configuration syntax
`terraform fmt` - formats terraform files in a directory
`terraform providers` - shows current providers as configured
`terraform graph` - show visual representation of dependencies in a plan
requires graphviz, run with `terraform graph | dot -Tsvg out.vsg`

## lifecycle rules in resources

used to prevent deleting immutable infrastructure during the apply stage.
they can be used to delete after the new resources have been created or not delet at all

```terraform

resource "aws_ami" "test" {
  name = "test"
  description = "blah blah blah"
  tags = {
    Name = "testAtag"
  }
  lifecycle {
    create_before_destroy = true
    # prevent deletion once something is provisioned, e.g. mysql etc
    # resources can still be destroy using the terraform destroy command
    # prevent_destroy = true
    ignore_changes = [
        tags
    ] # ignores changes to any of the attributes in the list of fields for the resources
  }
}
```

## data source block

```terraform

resource "local_file" "pet" {
  filename = "pets.txt"
  content = data.local_file.mydata.content
}

data "local_file" "mydata" { # resource type is local_file but can be any valid resource type supported by terraform
# the values are now available under mydata name
  filename = "test.file.txt"
}
```

# resources vs datablocks

| type     | desc                                                                |
| -------- | ------------------------------------------------------------------- |
| resouces | read, create, destroy infrastructure, also called managed resources |
| data     | reads infrastructure, also called data resources                    |

## for_each | loop

```terraform


resource "local_file" "test" {
  filename = each.value
  content = "test\n"
  for_each = toset(var.filename) # convert to set
}

variable "filename" {
  type = list(string) # or set(string) -> this would make it a map (iterable for for_each comsumption)
  default = [
    "test1.txt",
    "test2.txt",
    "test3.txt",
    "test4.txt"
  ]
}
```
