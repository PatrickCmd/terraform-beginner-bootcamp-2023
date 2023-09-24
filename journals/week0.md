# Terraform Beginner Bootcamp 2023 - Week0

- [Semantic Versioning 🧙](#semantic-versioning---)
- [Install the Terraform CLI](#install-the-terraform-cli)
  * [Considerations with the Terraform CLI changes](#considerations-with-the-terraform-cli-changes)
  * [Considerations for Linux Distribution](#considerations-for-linux-distribution)
  * [Refactoring into Bash Scripts](#refactoring-into-bash-scripts)
    + [Shebang Considerations](#shebang-considerations)
    + [Execution Considerations](#execution-considerations)
    + [Linux Permissions Considerations](#linux-permissions-considerations)
- [GitPod Lifecycle (Before, Init, Command)](#gitpod-lifecycle-before-init-command)
- [Working Env Vars](#working-env-vars)
    * [env command](#env-command)
    * [Setting and Unsetting Env Vars](#setting-and-unsetting-env-vars)
    * [Printing Vars](#printing-vars)
    * [Scoping of Env Vars](#scoping-of-env-vars)
    * [Persisting Env Vars in Gitpod](#persisting-env-vars-in-gitpod)
- [AWS CLI Installation](#aws-cli-installation)
- [Terraform Basics](#terraform-basics)
  * [Terraform Registry](#terraform-registry)
  * [Terraform Console](#terraform-console)
    + [Terraform Init](#terraform-init)
    + [Terraform Plan](#terraform-plan)
    + [Terraform Apply](#terraform-apply)
    + [Terraform Destroy](#terraform-destroy)
    + [Terraform Lock Files](#terraform-lock-files)
    + [Terraform State Files](#terraform-state-files)
    + [Terraform Directory](#terraform-directory)
    + [Create an AWS S3 bucket](#create-an-aws-s3-bucket)
    + [Random Provider](#random-provider)
    + [AWS Provider](#aws-provider)
- [Issues with Terraform Cloud Login and Gitpod Workspace](#issues-with-terraform-cloud-login-and-gitpod-workspace)
- [Set alias tf for terraform in gitpod](#set-alias-tf-for-terraform-in-gitpod)


## Semantic Versioning 🧙
This project is going utilize semantic versioning for its tagging. [semver.org](https://semver.org/)

The general format:

**MAJOR.MINOR.PATCH**, eg. `1.0.1`

- **MAJOR** version when you make incompatible API changes
- **MINOR** version when you add functionality in a backward compatible manner
- **PATCH** version when you make backward compatible bug fixes in project

## Install the Terraform CLI

### Considerations with the Terraform CLI changes
The Terraform CLI installation instructions have changed due to gpg keyring changes. So we needed refer to the latest install CLI instructions via Terraform Documentation and change the scripting for install.

[Install Terraform CLI](https://developer.hashicorp.com/terraform/tutorials/aws-get-started/install-cli)


### Considerations for Linux Distribution

This project is built against Ubunutu.
Please consider checking your Linux Distrubtion and change accordingly to distrubtion needs. 

[How To Check OS Version in Linux](
https://www.cyberciti.biz/faq/how-to-check-os-version-in-linux-command-line/)

Example of checking OS Version:

```
$ cat /etc/os-release

PRETTY_NAME="Ubuntu 22.04.3 LTS"
NAME="Ubuntu"
VERSION_ID="22.04"
VERSION="22.04.3 LTS (Jammy Jellyfish)"
VERSION_CODENAME=jammy
ID=ubuntu
ID_LIKE=debian
HOME_URL="https://www.ubuntu.com/"
SUPPORT_URL="https://help.ubuntu.com/"
BUG_REPORT_URL="https://bugs.launchpad.net/ubuntu/"
PRIVACY_POLICY_URL="https://www.ubuntu.com/legal/terms-and-policies/privacy-policy"
UBUNTU_CODENAME=jammy
```

### Refactoring into Bash Scripts

- [**Bash Scripting Tutorial](https://www.youtube.com/watch?v=tK9Oc6AEnR4&t=1448s)

While fixing the Terraform CLI gpg depreciation issues we notice that bash scripts steps were a considerable amount more code. So we decided to create a bash script to install the Terraform CLI.

This bash script is located here: [./bin/install_terraform_cli](./bin/install_terraform_cli)

- This will keep the Gitpod Task File ([.gitpod.yml](.gitpod.yml)) tidy.
- This allow us an easier to debug and execute manually Terraform CLI install
- This will allow better portablity for other projects that need to install Terraform CLI.

#### Shebang Considerations

A Shebang (prounced Sha-bang) tells the bash script what program that will interpet the script. eg. `#!/bin/bash`

ChatGPT recommended this format for bash: `#!/usr/bin/env bash`

- for portability for different OS distributions 
-  will search the user's PATH for the bash executable

https://en.wikipedia.org/wiki/Shebang_(Unix)

#### Execution Considerations

When executing the bash script we can use the `./` shorthand notiation to execute the bash script.

eg. `./bin/install_terraform_cli`

If we are using a script in .gitpod.yml  we need to point the script to a program to interpert it.

eg. `source ./bin/install_terraform_cli`

#### Linux Permissions Considerations

In order to make our bash scripts executable we need to change linux permission for the fix to be exetuable at the user mode.

```sh
chmod u+x ./bin/install_terraform_cli
```

alternatively:

```sh
chmod 744 ./bin/install_terraform_cli
```

https://en.wikipedia.org/wiki/Chmod

## GitPod Lifecycle (Before, Init, Command)

We need to be careful when using the Init because it will not rerun if we restart an existing workspace.

https://www.gitpod.io/docs/configure/workspaces/tasks

## Working Env Vars

### env command

We can list out all Enviroment Variables (Env Vars) using the `env` command

We can filter specific env vars using grep eg. `env | grep AWS_`

### Setting and Unsetting Env Vars

In the terminal we can set using `export HELLO='world`

In the terrminal we unset using `unset HELLO`

We can set an env var temporarily when just running a command

```sh
HELLO='world' ./bin/print_message
```
Within a bash script we can set env without writing export eg.

```sh
#!/usr/bin/env bash

HELLO='world'

echo $HELLO
```

### Printing Vars

We can print an env var using echo eg. `echo $HELLO`

### Scoping of Env Vars

When you open up new bash terminals in VSCode it will not be aware of env vars that you have set in another window.

If you want to Env Vars to persist across all future bash terminals that are open you need to set env vars in your bash profile. eg. `.bash_profile`

### Persisting Env Vars in Gitpod

We can persist env vars into gitpod by storing them in Gitpod Secrets Storage.

```
gp env HELLO='world'
```

All future workspaces launched will set the env vars for all bash terminals opened in thoes workspaces.

You can also set en vars in the `.gitpod.yml` but this can only contain non-senstive env vars.

## AWS CLI Installation

AWS CLI is installed for the project via the bash script [`./bin/install_aws_cli`](./bin/install_aws_cli)


- [**Getting Started Install (AWS CLI)**](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)
- [**AWS CLI Env Vars**](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-envvars.html)


We can check if our AWS credentials is configured correctly by running the following AWS CLI command:
```sh
aws sts get-caller-identity
```

If it is succesful you should see a json payload return that looks like this:

```json
{
    "UserId": "AIEAVUO15ZPVHJ5WIJ5KR",
    "Account": "123456789012",
    "Arn": "arn:aws:iam::123456789012:user/terraform-beginner-bootcamp"
}
```

We'll need to generate AWS CLI credits from IAM User in order to use AWS CLI.

## Terraform Basics

### Terraform Registry

Terraform sources their providers and modules from the Terraform registry which located at [registry.terraform.io](https://registry.terraform.io/)

- **Providers** is an interface to APIs that will allow to create resources in terraform.
- **Modules** are a way to make large amount of terraform code modular, portable and sharable.

[Randon Terraform Provider](https://registry.terraform.io/providers/hashicorp/random)

### Terraform Console

We can see a list of all the Terrform commands by simply typing `terraform`


#### Terraform Init

At the start of a new terraform project we will run `terraform init` to download the binaries for the terraform providers that we'll use in this project.

#### Terraform Plan

`terraform plan`

This will generate out a changeset, about the state of our infrastructure and what will be changed.

We can output this changeset ie. "plan" to be passed to an apply, but often you can just ignore outputting.

#### Terraform Apply

`terraform apply`

This will run a plan and pass the changeset to be execute by terraform. Apply should prompt yes or no.

If we want to automatically approve an apply we can provide the auto approve flag eg. `terraform apply --auto-approve`

#### Terraform Destroy

`teraform destroy`
This will destroy resources.

You can alos use the auto approve flag to skip the approve prompt eg. `terraform destroy --auto-approve`

#### Terraform Lock Files

`.terraform.lock.hcl` contains the locked versioning for the providers or modulues that should be used with this project.

The Terraform Lock File **should be committed** to your Version Control System (VSC) eg. Github

#### Terraform State Files

`.terraform.tfstate` contain information about the current state of your infrastructure.

This file **should not be commited** to your VCS.

This file can contain sensentive data.

If you lose this file, you lose knowning the state of your infrastructure.

`.terraform.tfstate.backup` is the previous state file state.

#### Terraform Directory

`.terraform` directory contains binaries of terraform providers.

#### Create an AWS S3 bucket
We created an AWS S3 bucket using terraform and using the `random_string` resource from the `random` terraform provider. When creating a bucket the [AWS Documentation](tps://docs.aws.amazon.com/AmazonS3/latest/userguide/bucketnamingrules.html?icmpid=docs_amazons3_console) shows that we can't create bucket names consisting of random characters.

So we had to configure our `random_string` resource to consist of only lower case letters.

```hcl
# https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/string
resource "random_string" "bucket_name" {
  lower   = true
  upper   = false
  length  = 16
  special = false
}
```

To use the aws resources when need to import the [aws provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

> **Note:** You can't have two terraform required providers configured separately. Meaning that if you intend to have more than two providers they should be in the same `required_providers` section within the terraform block.

```hcl
terraform {
  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "3.5.1"
    }

    aws = {
      source  = "hashicorp/aws"
      version = "5.17.0"
    }
  }
}
```

#### Random Provider

https://registry.terraform.io/providers/hashicorp/random/latest/docs

1. `random`: This is the name given to the random provider configuration block. In Terraform, just like with AWS or other cloud providers, you can specify providers for various purposes. In this case, it's configuring the random provider. You can choose any name you prefer for your provider configuration blocks.

2. `source`: This attribute specifies where Terraform should find the provider plugin code. In this snippet, it's set to "hashicorp/random," which indicates that the random provider is coming from the HashiCorp registry. The source follows the format of "namespace/provider-name," and in this case, it's the random provider from HashiCorp.

3. `version`: This attribute specifies the version of the provider that you want to use. In this snippet, it's set to "3.5.1," which means you want to use version 3.5.1 of the random provider.

The random provider in Terraform is used for generating random values or performing random operations within your Terraform configurations. It's commonly used for tasks like generating random passwords, generating random numbers, or introducing controlled randomness into your infrastructure code.

#### AWS Provider

https://registry.terraform.io/providers/hashicorp/aws/latest/docs

1. `aws`: This is the name given to the AWS provider configuration block. In Terraform, you need to specify a provider for the cloud or service you want to interact with. In this case, it's AWS. You could give it any name you like, but `aws` is a commonly used name for AWS provider configurations.

2. `source`: This attribute specifies where Terraform should find the provider plugin code. In this snippet, it's set to "hashicorp/aws," which indicates that the AWS provider is coming from the HashiCorp registry. The HashiCorp registry is a repository of provider plugins maintained by HashiCorp, the company behind Terraform. The source typically follows the format of "namespace/provider-name," and in this case, it's the AWS provider from HashiCorp.

3. `version`: This attribute specifies the version of the provider that you want to use. In this snippet, it's set to "5.17.0," which means you want to use version 5.17.0 of the AWS provider.

When you define this provider configuration in your Terraform configuration file, it tells Terraform to use the specified AWS provider with the specified version when creating and managing AWS resources in your infrastructure. Terraform will automatically download and use the specified provider version from the HashiCorp registry to interact with AWS.

## Issues with Terraform Cloud Login and Gitpod Workspace

When attempting to run `terraform login` it will launch bash a **wiswig** view to generate a token. However it does not work expected in Gitpod VsCode in the browser.

The workaround is manually generate a token in Terraform Cloud

```
https://app.terraform.io/app/settings/tokens?source=terraform-login
```

Then create open the file manually here:

```sh
touch /home/gitpod/.terraform.d/credentials.tfrc.json
open /home/gitpod/.terraform.d/credentials.tfrc.json
```

Provide the following code (replace your token in the file):

```json
{
  "credentials": {
    "app.terraform.io": {
      "token": "YOUR-TERRAFORM-CLOUD-TOKEN"
    }
  }
}
```

Another observation is that when copying and pasting using short keys `ctrl + c` and  `ctrl + v` doesn't work well in the gitpod terminal environment. To successfully copy or paste, use the context menu options to copy and paste while in the gitpod terminal environment.

Automated this workaround with the following bash script [bin/generate_tfrc_credentials](bin/generate_tfrc_credentials)

## Set alias tf for terraform in gitpod

You can use a simple Bash script to add the alias `tf="terraform"` to your Bash profile. Here's a script to do that:

```bash
#!/bin/bash

# Define the alias
alias_to_add="alias tf='terraform'"

# Check if the alias already exists in the Bash profile
if ! grep -q "$alias_to_add" ~/.bash_profile; then
    # If it doesn't exist, append it to the Bash profile
    echo "$alias_to_add" >> ~/.bash_profile
    echo "Alias 'tf' added to ~/.bash_profile. Please run 'source ~/.bash_profile' to apply it."
else
    echo "Alias 'tf' already exists in ~/.bash_profile. No changes made."
fi
```

Here's what the script does:

1. It defines the alias you want to add as a variable called `alias_to_add`.

2. It checks if the alias already exists in your `~/.bash_profile` file using `grep`. If it doesn't find the alias, it proceeds to add it.

3. If the alias doesn't exist, it appends the alias to your `~/.bash_profile` file and provides a message indicating that the alias has been added.

4. If the alias already exists, it provides a message indicating that no changes have been made.

After creating the script, make it executable by running:

```bash
chmod +x set_tf_alias.sh
```

Then, you can execute the script to add the alias by running:

```bash
./set_tf_alias.sh
```

After running the script, you should run `source ~/.bash_profile` or restart your terminal to apply the changes to your current session.
