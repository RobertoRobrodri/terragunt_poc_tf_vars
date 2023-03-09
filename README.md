
# Terragrunt Demo

- What is Terragrunt?
- About this repository
- Deploy infrastructure


## What is Terragrunt?

Terragrunt is a thin wrapper that provides extra tools
for keeping your configurations DRY, working with multiple
Terraform modules, and managing remote state.

## About this repository

This repo works in conjunction with Terragrunt-poc-template.

Let´s suppose you have the following code:

```
└── live
    ├── sandbox
    │   ├── app
    │   │   └── main.tf
    │   ├── mysql
    │   │   └── main.tf
    │   └── vpc
    │       └── main.tf
    ├── staging
    │   ├── app
    │   │   └── main.tf
    │   ├── mysql
    │   │   └── main.tf
    │   └── vpc
    │       └── main.tf
    └── production
        ├── app
        │   └── main.tf
        ├── mysql
        │   └── main.tf
        └── vpc
            └── main.tf
```
Assuming your configuration remains more or less the same
across all environments, having to maintain all this files of
redundant code is a tiresome task.

Terragunt offers a solution to this. Instead of having a monolitic
code block, we divide the configuration in two blocks: Modules and variables.
Although not neccessary, it is recommended to have them separated
in two repositories, keeping your code cleaner and more organized.

Any variable that differs from one environment to another should be
exposed as a variable.

This way, we have to repositories with the following structure:

Module Templates:
```
└── modules
    ├── app
    │   └── main.tf
    ├── mysql
    │   └── main.tf
    └── vpc
        └── main.tf
```
TF_vars:
```
└── live
    ├── sandbox
    │   ├── app
    │   │   └── terragrunt.hcl
    │   ├── mysql
    │   │   └── terragrunt.hcl
    │   └── vpc
    │       └── terragrunt.hcl
    ├── staging
    │   ├── app
    │   │   └── terragrunt.hcl
    │   ├── mysql
    │   │   └── terragrunt.hcl
    │   └── vpc
    │       └── terragrunt.hcl
    └── production
        ├── app
        │   └── terragrunt.hcl
        ├── mysql
        │   └── terragrunt.hcl
        └── vpc
            └── terragrunt.hcl
```

In the TF_vars repository, we have .hcl files instead of tf vars.
Here is where we give value to all the variables declared in an "input block".


