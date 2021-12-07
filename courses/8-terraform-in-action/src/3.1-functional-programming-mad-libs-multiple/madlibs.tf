/*
Following on from the first singular mad libs, here we generated multiple by using a "for expression".

We also throw in an "upper" function, so to iterate over our lists we have something like:

[ for s in ["cat", "milk", "sun"] : upper(s) ]
which results in:
["CAT", "MILK", "SUN"]

Or, to generate a new "map" use {} instead of [] e.g.:

{ for k, v in var.words : k => length(v) }
which results in:
{ "nouns" = 12, "adjectives" = 6, ... }

NOTE that filters can also be applied e.g.

{ for k, v in var.words : k => [ for s in v : upper(s) ] if k != "numbers" }
*/

terraform {
  required_version = ">= 0.15"

  required_providers {
    /*
    The Random provider allows for constrained randomness within Terraform configurations.
    The Random provider for Terraform introduces a "random_shuffle" resource for safely shuffling lists, which we need to shuffle our words.
    */
    random = {
      source  = "hashicorp/random"
      version = "~> 3.0"
    }

    local = {
      source = "hashicorp/local"
      version = "~> 2.0"
    }

    archive = {
      source = "hashicorp/archive"
      version = "~> 2.0"
    }
  }
}

variable "words" {
  description = "A word pool to use for Mad Libs"

  type = object({
    nouns       = list(string),
    adjectives  = list(string),
    verbs       = list(string),
    adverbs     = list(string),
    numbers     = list(number)
  })

  validation {
    condition = length(var.words["nouns"]) >= 10
    error_message = "At least 10 nouns must be supplied."
  }
}

variable "num_files" {
  default = 10
  type = number
}

/*
We can save the result of an expression by assigning to a local value.
*/

locals {
  /* for expression to uppercase strings and save to a local value */
  uppercase_words = { for k, v in var.words : k => [ for s in v : upper(s) ] }

  /* Read all the text files from the templates folder into a list. */
  templates = tolist(fileset(path.module, "templates/*.txt"))
}

resource "random_shuffle" "random_nouns" {
  /* A new shuffled list will be generated from the input list */
  input = local.uppercase_words["nouns"]
  count = var.num_files
}

resource "random_shuffle" "random_adjectives" {
  input = local.uppercase_words["adjectives"]
  count = var.num_files
}

resource "random_shuffle" "random_verbs" {
  input = local.uppercase_words["verbs"]
  count = var.num_files
}

resource "random_shuffle" "random_adverbs" {
  input = local.uppercase_words["adverbs"]
  count = var.num_files
}

resource "random_shuffle" "random_numbers" {
  input = local.uppercase_words["numbers"]
  count = var.num_files
}

/*
We will save the results to disk with a local_file resource (instead of outputting to the CLI).
*/

resource "local_file" "mad_libs" {
  count = var.num_files
  filename = "madlibs/madlibs-${count.index}.txt"

  content = templatefile(element(local.templates, count.index), {
    nouns = random_shuffle.random_nouns[count.index].result
    adjectives = random_shuffle.random_adjectives[count.index].result
    verbs = random_shuffle.random_verbs[count.index].result
    adverbs = random_shuffle.random_adverbs[count.index].result
    numbers = random_shuffle.random_numbers[count.index].result
  })
}

/*
The element() function operates on a list as if it were circular, retrieving elements at a given index without throwing an out-of-bounds exception.

The count.index expression references the current index of a resource.
*/

/*
We can create arbitrary numbers of Mad Libs stories and output them in a madlibs directory, but wouldn’t it be great to zip the files together as well?
The archive_file data source can do just this.
It outputs all the files in a source directory to a new zip file.
*/

data "archive_file" "mad_libs" {
  depends_on  = [local_file.mad_libs]
  type        = "zip"
  source_dir  = "${path.module}/madlibs"
  output_path = "${path.cwd}/madlibs.zip"
}

/*
terraform init && terraform apply -auto-approve
*/

/*
NOTE Upon running
terraform destroy

the madlibs.zip file will hang around.
This is because this file isn’t a managed resource.
The madlibs.zip was created with a data source, and data sources do not implement Delete().
*/