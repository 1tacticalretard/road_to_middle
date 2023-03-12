# k8s -- manifests

## How to use it

In order to use the manifests, make sure minikube & kubectl are installed

### Usage example
install [kubectl](https://kubernetes.io/en/docs/tasks/tools/install-kubectl/) and [minikube](https://minikube.sigs.k8s.io/docs/start/)

Once done, feel free to do:

```
minikube start
kubectl apply -f <file_name>.yaml
```
This will create either a pod or a full-scale deployment with NodePort service.

## Linux

For Linux, you may run this command to expose pods so that the nginx webpage is accessible:
```
kubectl port-forward nginx-jenkins 80:80   
```

or Jenkins (made it just for fun):
```
kubectl port-forward nginx-jenkins 8080:80   
```

and enter 127.0.0.1:80 in your browser.

Or do:
```
kubectl get svc
```

in order to check the access link to your page in case you chose to run a deployment.

## Windows

Do the same as for linux for pods, but for deployment instead of:
```
kubectl get svc
```
Do:

```
 minikube service nginx-service --url  
```
Expected result example:
```
http://127.0.0.1:49758
! Because you are using a Docker driver on windows, the terminal needs to be open to run it.
PS C:\kubernetes> kubectl port-forward nginx-deploy-68499d6d66-tgzc2 80:80
```