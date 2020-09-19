# Free5gc NFs

## Docker Build
NFs and utils Docker images : 
- 5GC NFs: AUSF, UDM, UDR & NRF 
- WEBUI for adding UE(s) Credentials

```bash
chmod +x docker_build.sh
./docker_build
```

## free5gc-nfs chart Installation
- helm: v3.0.x 
```bash
*Create mongodb data storage directory* 
mkdir /mongodata
* mongodb.nodeAffinity.nodename value should be the name of the node that contain the mongodata directory  *
helm install free5gc-nfs/ --generate-name  --namespace [value] --set mongodb.nodeAffinity.nodename= [value]  global.plmn.mcc= [value] global.plmn.mnc= [value]
Example: helm install free5gc-nfs/ --generate-name  --namespace test --set mongodb.nodeAffinity.nodename=minikube  global.plmn.mcc=208 global.plmn.mnc=91

```