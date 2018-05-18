
## Running the example app

To run the example application (the GTFSLoader), run the following command from one of the deployment folders (deployments/compose or deployments/kubernetes) depending on your prefered deployment type:

```
>$ cd example
>$ ./start.sh
```

To get the ip of the example app, run the following command:

```
minikube service gtfsloader-svc --url
```

so you should see something like this

```
>$ http://192.168.99.100:31018/
```

Finally, you can stop the app with the provided script:

```
cd example
>$ ./stop.sh
```
