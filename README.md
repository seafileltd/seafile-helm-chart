# Seafile-Helm-Chart

This is a public repository for storing charts related to quick deployment of Seafile using ***Helm***.

## Deployment

### Preparation

- Create namespace

    ```
    kubectl create namespace seafile
    ```

- Create secret

    ```sh
    # for pro/cluster
    kubectl create secret generic seafile-secret --namespace seafile \
    --from-literal=JWT_PRIVATE_KEY='<required>' \
    --from-literal=SEAFILE_MYSQL_DB_PASSWORD='<required>' \
    --from-literal=INIT_SEAFILE_ADMIN_PASSWORD='<required>' \
    --from-literal=INIT_SEAFILE_MYSQL_ROOT_PASSWORD='<required>' \
    --from-literal=INIT_S3_SECRET_KEY=''  

    # for ce
    kubectl create secret generic seafile-secret --namespace seafile \
    --from-literal=JWT_PRIVATE_KEY='<required>' \
    --from-literal=SEAFILE_MYSQL_DB_PASSWORD='<required>' \
    --from-literal=INIT_SEAFILE_ADMIN_PASSWORD='<required>' \
    --from-literal=INIT_SEAFILE_MYSQL_ROOT_PASSWORD='<required>'  

    ```

    where `JWT_PRIVATE_KEY` can get from `pwgen -s 40 1`

## Install Seafile helm chart

- Copy and modify the `values.yaml` according to your configurations

    ```sh
    cp values/<type of deployment> .yaml ./my-values.yaml # cluster.yaml can change to other type by your deployment situation

    nano my-values.yaml
    ```

- To install the chart use the following:

    ```sh
    helm repo add seafile https://github.com/seafileltd/seafile-helm-chart
    helm upgrade --install seafile seafile/<type of deployment>  --namespace seafile --create-namespace --values my-values.yaml
    ```

>[!NOTE]
>The default service type of Seafile is `LoadBalancer`, and `Nginx-ingress` is not integrated because it is [outdated](https://kubernetes.io/docs/concepts/services-networking/ingress/) in the new *Kubernetes* version, and new features are being added to the [Gateway API](https://kubernetes.io/docs/concepts/services-networking/gateway/). So you should specify *K8S load balancer* for *Seafile* or specify at least one external ip, that can be accessed from external networks.

>[!WARNING]
>For `pro` edition, you should modify the hostname of ***Memcached*** and ***Elasticsearch*** after first-time deployment according to [here](https://manual.seafile.com/latest/setup/k8s_single_node/#start-seafile-server), then restart the instances by 
>```sh
>kubectl delete pod seafile -n seafile
>```

## Uninstall Seafile helm char

helm delete seafile --namespace seafile
