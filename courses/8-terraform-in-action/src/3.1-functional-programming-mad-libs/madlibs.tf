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
  }
}

/*
Given a template (known as a Mad Libs) such as:
To make a pizza, you need to take a lump of <noun> and make a thin, round, <adjective> <noun>.

Terraform will randomly fill in the placeholders e.g.
To make a pizza, you need to take a lump of roses and make a thin, round, colorful jewelry.
*/

/*
Variables:
- default — A preselected option to use when no alternative is available. Leaving this argument blank means a variable is mandatory and must be explicitly set.
- description — A string value providing helpful documentation to the user.
- type — A type constraint to set for the variable. Types can be either primitive (e.g. string, integer, bool) or complex (e.g. list, set, map, object, tuple).
- validation — A nested block that can enforce custom validation rules.

Variable values can be accessed within a given module by using the expression:
var.<VARIABLE_NAME>
*/

/*
We could have declared our variables as:

variable "nouns" {
  description = "A list of nouns"
  type        = list(string)
}

variable "adjectives" {
  description = "A list of adjectives"
  type        = list(string)
}

etc.
but have instead gone for the following:
*/

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

/*
Assigning variable values with the default argument is not a good idea because doing so does not facilitate code reuse.
A better way to set variable values is with a variables definition file, which is any file ending in either .tfvars or .tfvars.json.
*/

resource "random_shuffle" "random_nouns" {
  /* A new shuffled list will be generated from the input list */
  input = var.words["nouns"]
}

resource "random_shuffle" "random_adjectives" {
  input = var.words["adjectives"]
}

resource "random_shuffle" "random_verbs" {
  input = var.words["verbs"]
}

resource "random_shuffle" "random_adverbs" {
  input = var.words["adverbs"]
}

resource "random_shuffle" "random_numbers" {
  input = var.words["numbers"]
}

/*
To fill in placeholders in a given text, we can use the built-in templatefile() functions:

Function name
      |
+-----+-----+
|           |
templatefile("templates/alice.tpl.txt", { nouns = ["cat", "milk"...] ... })
              |                 |     |                              |
              |                 |     |                              |
              +--------+--------+     +--------------+---------------+
                       |                             |
                      Path                   Template variables

And we can return the result of templatefile() to the user with an output value.
Output values are used to do two things:

- Pass values between modules
- Print values to the CLI
*/

output "mad_libs" {
  value = templatefile("${path.module}/templates/alice.tpl.txt", {
    nouns = random_shuffle.random_nouns.result
    adjectives = random_shuffle.random_adjectives.result
    verbs = random_shuffle.random_verbs.result
    adverbs = random_shuffle.random_adverbs.result
    numbers = random_shuffle.random_numbers.result
  })
}

/*
Note path.module is a reference to the file system path of the containing module.
*/

/*
terraform init && terraform apply -auto-approve
*/