# terraform related resources

terraforms language (HCL), its main purpose is to _declare resources_, all
language features are there to make defining resources more flexible and
convinient.

the order of the resources and files are generally not important, terraform
considers implicit and explicit relationships between resources when
determining an order of the operation.

```python
<block type> "<block label>" "<block label>" { # some blocks do not require labels, other requiere one or more
  # block body
  <identifier> = <expression> #Argument
}

# e.g.
resource "aws_vpc" "main" {
  cidr_block = var.base_cidr_block
}
```

## file extensions

`.tf` - general code
`.tf.json` the json version of the code (valid)

_encoding must be utf-8_

## HCL syntax

`blocks` are containers for objects like resources
`arguments` assign a value to a name
`Expressions` represent a value

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

`bash show` - show terraform state in json format
`terrafrom output` - how terraform outputs vars to the screen
`bash -refresh=false` - run terraform without having to reconcile state on remote backend,
this is only good if you are certain the state file is upto date.
`bash validate` - validates configuration syntax
`bash fmt` - formats terraform files in a directory
`bash providers` - shows current providers as configured
`bash graph` - show visual representation of dependencies in a plan
requires graphviz, run with `bash graph | dot -Tsvg out.vsg`

`bash plan -out <plan_name>` - output plan to a file
`bash plan -destroy` - dry run of destroy to check to see what will be destroyed
`bash plan <plan_name>` - apply specific plan file

**important**
`bash apply -target=<resource_name>` - apply changes only to a particular resource (save time)
`bash providers` - show list of providers used in the module

## lifecycle rules in resources

used to prevent deleting immutable infrastructure during the apply stage.
they can be used to delete after the new resources have been created or not delet at all

```bash
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

## resources vs datablocks

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

## modules

current working directory is considers your root module
the root module may contain any number of sub-modules

modules are consider a container for multiple resources that are group together

## override files

main.tf and override.tf
contents of override.tf are merged into one

```terraform
# main.tf
resource "aws_instance" "web" {
  instance_type = "t2.micro"
  ami = "ami-12345"
}

# override.tf
resource "aws_instance" "web" {
  ami = "foo"
}

# results in
resource "aws_instance" "web" {
  instance_type = "t2.micro"
  ami = "foo"
}
```

## config syntax

```terraform
# arguments

<argument> = <value>
e.g. image_id = "terra123"

# blocks

resource "aws_instance" "example" { # example is a label
  ami = "abc134"

  network_interface { # some block types do not require any labels
    # ...
  }
}
```

## comments

```terraform
# single line comment
// single line comment
/* <comment> */ comments that can span over multiple lines
```

## identifiers

resources must be unique

```terraform
resource "aws_instance" "web" {
  // ...
}

// the identifier is aws_instance.web
```

## resources

- are the most important part of the configuration language
- resource types are made up of `providers` `arguments` and `documentation`
  providers - plugins for terraform that offer a collection of resource types
  arguments - are specific to the selected resource type
  documentation - describe its resource type and argument

## meta-arguments ( are used within blocks )

```terraform
resource "aws_instance" "web" {
  depends_on = ... // meta-argument
}
```

`depends_on` = specify hidden dependecies or when a resource or agument relies on
other resources
`count` = create multiple resources instance according to a count
`for_each` = create multiple instances according to a map or a set of strings
`provider` = select a non-default provider configuration
`lifecycle` = set lifecycle customizations
`provisioners` and `connection` - take extra actions after resource creation
`locals` - variables that are local to the resource (possibly module??)

## timeouts

some resource types probied special timeouts nested block arguments for customization of how long
certain operations should take before they timeout

```terraform
resource "aws_db_instance" "example" {
  # ...

  timeouts { // this are handled/provided by the resource type and may not be available everywhere
    create = "60m"
    delete =  "2h"
  }
}
```

## applying configuration

- `create` - creates objects that do not exist in the infrastructur
- `destroy` - destroy resources that exist in the state but no longers exisct in the configuration
- `update-in-place` - update in-place resources whose arguments have changed
- `destroy and re-create` - destroy and recreate resources whose arguments have
  changed, but which cannot be updated in-place due to remoet api limitation

## variables

variables can only be accessed within the module in which it was declared

can be called from command line with `var-file` directive

`terraform apply -var-file=../myvars.tfvars`

- names

  the name of the variable can be anything except for meta-argument name e.g.
  source, version, providers, count, for_each, lifecycle, depends_on, locals (these are not allowed as varilabe names)

- variable declarations

- `default` - default value set if none is provided, this makes the variable optional
- `type`
  - contraints:
    string
    number
    bool
  - contructs:
    list(<type>)
    set(<type>)
    map(<type>)
    object({<attribute = <type>, ...})
    tuple([<type>, ...])
- `description` - ... nuff said
- `validation` -
- `sensitive` - sensitive information should not show up in outputs

```terraform
variable "image_id" {
  type = string
  description = "the id of the machine image (AMI) used for the server"
}
```

- variables allow arbitrary costum validation rules

```terraform
variable = "image_id" {
  type = string
  description = "an image id for aws"
  validation {
    condition = length(var.image_id) > 4 && substr(var.image_id, 0, 4) == "ami-"
    error_message = "the image id value must be a valid ami id and start with ... \"ami-\"."
  }
}
```

## output varaibles - output.tf

- output varaibles are used to export values out of a module

## local variables

```python
locals {
  image_id = "ami-1234"
  user_id = "user_id_123"
}

# using the locals in a resource

resource "aws_instance" "web" {
  image_id = local.image_id
  user = local.user_id
}
```

## module sources

there are 8 module types

1. local paths

```terraform
module "consul" {
  // must begin with ./ or ../
  source = "./consul"
}
```

2. terraform registry

```terraform
module "consul" {
  // public registry
  source = "hashicorp/consul/aws"
  version = "0.1.0"
}
```

3. github

```terraform
module "consul" {
  // can use tags an
  source = "github.com/hashicorp/example?ref=v1.0.0"
  // over ssh
  // source = "git@github.com:hashicorp/example.git"
  version = "0.1.0"
}
```

4. bitbucket
5. generic git, mercurial repositories
6. http url

```terraform
module "vpc" {
  source = "https://example.com/vpc-module.zip"
  // recognized extensions are: zip, (tar.bz2 or tbz2), (tar.gz or tgz), (tar.xz or txz)
}
```

7. s3 buckets (amazon)
8. gcs buckets (google)

## HCL expressions and functions

- expressions are used to reference/compute values withint a configuration
- functions are used to transform or combine values within an expression

### value types:

- string
- number
- bool
- list/tuples
- map/object
- null (nil)

### types os nameb values:

- resources
- input variables
- local values (local.<name>)
- child module outputs (module.<module name>.<output name>)
- data sources
- filesystem and workspace info (path.module, path.root, path.cwd)
- block-local values

### conditional expressions/ternary operator:

- usefull to replace default values

`condition ? <true value> : <false value>`

- both values must be of the same type, it they do not match, terraform will convert them automatically

`condition ? 12 : "hello"` -> "12"

when in doubt:

`condition ? tostring(12) : "hello"`

### function calls

`<function name>(<argument 1>, <argument 2>, ...)

e.g.

```terraform
// terraform console, allows you to test functions

// min(55, 2453, 2) -> 2
// max(55, 2453, 2) -> 2453
```

## terraform backends

built in backends are the only backends available to configure

backends used by terraform-cli:

- local - useful for testing
- remote - when working on teams where version control is necessary

backends used by terraform cloud and enterprise use their own backend

- backends determin two key behaviours

1. where state is stored
2. where operations are performed

```terraform
terraform {
  backend "remote" {
    organization = "corp_example"

    workspaces {
      name = "ex-app-prod"
    }
  }
}
```

### backend limitations

1. a configuration can only provide one backend block
2. a backend cannot refer to named values

- when backend changes you must perform a `terraform init`

- when backend changes, terraform gives you the option to migrate your state

- hashicorp recommends that you manually backup your state, simply copy the `terraform.tfstate` file

### enhanced backend configurations

- you can specify a backend hcl file

```terraform
// main.tf
terraform {
  required_version = "~> 0.12.0"

  backend "remote" {} // empty means use backend.hcl
}

// backend.hcl
workspaces { name = "workspace" }
hostname     = "app.terraform.io"
organization = "company"

// run with `terraform init -backend-config=backend.hcl`
```

### standard backend configurations

- aws S3 bucket
  supports state locking and concistency checking with dynamodb (but must be enabled by setting a field)

  ```terraform
  terraform {
    backend "s3" {
      bucket = "mybucket"
      key    = "path/to/my/key"
      region = "us-east-1"
    }
  }
  /* required permissions
      s3: ListBucket
      s3: GetObject
      s3: PutObject
    */
  /* state locking requires
      dynamodb:GetItem
      dynamodb:PutItem
      dynamodb:DeleteItem
    */
  ```

- azurerm

  ```terraform
  terraform {
    backend "azurerm" {
      resource_group_name  = "StorageAccount-ResourceGroup"
      storage_account_name = "abcd1234"
      container_name       = "tfstate"
      key                  = "prod.terraform.tfstate"
    }
  }
  ```
