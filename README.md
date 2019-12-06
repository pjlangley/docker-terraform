# Docker Terraform executable

This docker image provides a dockerised version of
[Terraform](https://www.terraform.io). You can pull this
[docker terraform](https://hub.docker.com/r/pjlangley/terraform)
image from Docker Hub.

It's designed to be used as a terraform executable, like a shell
binary file. The idea is to limit personal machine software
dependencies and provide more reliable developer experience.

## Usage

For example, let's assume you have the following:

```
$ tree
.
└── main.tf

0 directories, 1 file
```

We need to mount the directory above into the container's `/tfconfig` directory.

E.g. you might need to run `terraform init` followed by `plan` or `apply`.
By mounting the directory you'll save any plugin configuration
locally for future commands. Like when working with AWS, for example.

Let's run a command:

```
$ docker run --rm -v `pwd`/.:/tfconfig -it pjlangley/terraform init

Initializing the backend...

Initializing provider plugins...
- Checking for available provider plugins...
- Downloading plugin for provider "aws" (hashicorp/aws) 2.36.0...

The following providers do not have any version constraints in configuration,
so the latest version was installed.

To prevent automatic upgrades to new major versions that may contain breaking
changes, it is recommended to add version = "..." constraints to the
corresponding provider blocks in configuration, with the constraint strings
suggested below.

* provider.aws: version = "~> 2.36"

Terraform has been successfully initialized!

You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.
```

Notice that this plugin is saved locally:

```
$ tree -a
.
├── .terraform
│   └── plugins
│       └── linux_amd64
│           ├── lock.json
│           └── terraform-provider-aws_v2.36.0_x4
└── main.tf

3 directories, 3 files
```

Now you can proceed to run other commands, such as `plan`:

```
$ docker run --rm -v `pwd`/.:/tfconfig -it pjlangley/terraform plan
```

## Build

If you need a bit more control over this image, you can checkout and build it
locally with some supported overrides.

### Specify the Terraform version

```
$ docker build --build-arg TF_VERSION=0.12.16 -t my/terraform .
... build output ...
$ docker run --rm -it my/terraform version
Terraform v0.12.16
```

## License

MIT.
