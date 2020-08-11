# YAML & JSON & JSON Path

YAML / JSON comparison:

![YAML / JSON](images/yaml-json.png)

## YAML

![YAML](images/yaml.png)

## JSON Path

JSON Path is also applicable to YAML, since YAML and JSON are orthogonal:

![JSON Path dictionaries](images/json-path-dictionaries.png)

---

![JSON Path lists](images/json-path-lists.png)

---

![JSON Path dictionaries and lists](images/json-path-dictionaries-and-lists.png)

---

![JSON Path criteria](images/json-path-criteria.png)

---

![JSON Path criteria](images/json-path-criteria-2.png)

---

![JSON Path wildcard](images/json-path-wildcard.png)

---

![JSON Path wildcard](images/json-path-wildcard-2.png)

---

![JSON Path wildcard](images/json-path-wildcard-3.png)

---

![JSON Path list](images/json-path-list.png)

---

![JSON Path list](images/json-path-list-2.png)

---

![JSON Path list](images/json-path-list-3.png)

## Kubernetes

![Kubectl JSON](images/kubectl-json.png)

The result displayed on the left is essentially a summary. We could include the **-o wide** option for more details, but again, not everything is presented:

![Kubectl JSON](images/kubectl-json-2.png)

---

![Kubectl JSON](images/kubectl-json-3.png)

---

![Kubectl JSON](images/kubectl-json-4.png)

---

![Kubectl JSON](images/kubectl-json-5.png)

And we can combine queries with formatting:

![Kubectl JSON](images/kubectl-json-6.png)

But, we can still do better:

![Kubectl JSON](images/kubectl-json-7.png)

and in conjunction with kubectl:

![Kubectl JSON](images/kubectl-json-8.png)

Or instead of using the above **range** we can use **custom-columns**:

![Kubectl JSON](images/kubectl-json-9.png)

Finally, there is a **--sort-by** e.g.

![Kubectl JSON](images/kubectl-json-10.png)