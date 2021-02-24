### Install master infrastraction

* download and install terraform by [intstruction](https://www.terraform.io/downloads.html)

* provide AWS credential `aws configure` [docs](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html#cli-configure-quickstart-config)

* ```bash
  cd master_terraform_config
  terraform init
  terraform apply
  cd ..
  ```

* change in files postgres-operator-master/configmap.yaml and 
  postgres-operator-master/postgres-pod-configmap.yaml

  ```bash
  metadata:
    name: postgres-operator
  data:
    logical_backup_s3_access_key_id: <AWS_ACCESS_KEY_ID>
    logical_backup_s3_secret_access_key: <AWS_SECRET_ACCESS_KEY>
    pod_environment_configmap: <POD_CONFIGMAP>
    wal_s3_bucket: <WAL_S3_BUCKET>
  ```

  ```bash
  metadata:
    name: postgres-pod-config
  data:  
    AWS_ACCESS_KEY_ID: <AWS_ACCESS_KEY_ID>
    AWS_ENDPOINT: <AWS_ENDPOINT>
    AWS_REGION: <AWS_REGION>
    AWS_SECRET_ACCESS_KEY: <AWS_SECRET_ACCESS_KEY>
  ```

* write kubeconfig to file.name.master.yaml

  ```bash
  export KUBECONFIG=/path/to/file.name.master.yaml
  kubectl apply -f postgres-operator-master/
  ```

* wait till postgres operator starts to run

```bash
kubectl apply master-postgres-manifest.yaml
```

### Install slave infrastraction

* ```bash
  cd slave_terraform_config
  terraform init
  terraform apply
  cd ..
  ```

* write kubeconfig to file.name.slave.yaml

* change in files postgres-operator-slave/configmap.yaml and 
  postgres-operator-slve/postgres-pod-configmap.yaml

  ```bash
  metadata:
    name: postgres-operator
  data:
    pod_environment_configmap: <POD_CONFIGMAP>
    wal_s3_bucket: <WAL_S3_BUCKET>
  ```

  ```bash
  metadata:
    name: postgres-pod-config
  data:
    STANDBY_AWS_ACCESS_KEY_ID: <AWS_ACCESS_KEY_ID>
    STANDBY_AWS_SECRET_ACCESS_KEY: <AWS_SECRET_ACCESS_KEY>
    STANDBY_WALE_ENV_DIR: /path/to/dir
    STANDBY_AWS_REGION:  <AWS_REGION>
    STANDBY_AWS_ENDPOINT: <AWS_ENDPOINT>
  ```

  ```bash
  export KUBECONFIG=/path/to/file.name.slave.yaml
  kubectl apply -f postgres-operator-slave/
  ```
* wait till postgres operator starts to run

```bash
kubectl apply slave-postgres-manifest.yaml
```
