# State

Once `terraform apply` has been run at least once, we will have a file `terraform.tfstate`.

An example:

![State example](images/state-example.jpg)

Regarding a team, we would want to share this state.
So instead of each developer relying on local state:

![Local state](images/local-state.jpg)

You could perist the state in a remote datastore:

![Remote shared state](images/remote-shared-state.jpg)

WARNING - state file exposes sensitive data (another reason for saving safely on the cloud) e.g.

![Sensitive data](images/sensitive-state.jpg)