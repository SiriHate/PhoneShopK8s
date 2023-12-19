# PhoneShopK8s
This project is a practical implementation of the deployment of the [PhoneShopService](https://github.com/SiriHate/PhoneShopService) using the Kubernetes cluster.

**Stack**: Java, Spring Boot, Spring AOP, Spring Data JPA, MapStruct, Log4j, Lombok, Jakarta Validation, JUnit, Mockito, PostgreSQL, Kubernetes.

## How To Use?

1) Start the Kubernetes cluster with the following command (if not already created)
```
minikube start
```
2) Open a command prompt in the folder with Kubernetes manifest files
3) Enter the following commands at the command prompt to create a database in a Kubernetes cluster:
```
kubectl apply -f postgres-config.yaml
kubectl apply -f postgres-storage.yaml
kubectl apply -f postgres-deployment.yaml
kubectl apply -f postgres-service.yaml
```
4) Create new table in database:
```
kubectl exec -it <db-pod-name> -- /bin/sh
```
```
psql -h <db-pod-name> -U postgres -d phone_shop_db
```
```
CREATE TABLE phone_shop (
    id SERIAL PRIMARY KEY,
    manufacturer VARCHAR(255),
    model VARCHAR(255),
    storage_size INT,
    color VARCHAR(255),
    cost INT,
    quantity INT
);
```
**HINT:** Password for postgres user is `admin`

5) Enter the following commands at the command prompt to create a web application in a Kubernetes cluster:
```
kubectl apply -f app-deployment.yaml
kubectl apply -f app-service.yaml
kubectl apply -f app-statefulset.yaml
kubectl create secret generic basic-auth --from-file=auth
kubectl apply -f ingress.yaml
```
6) Use the following command to open a tunnel between the local computer and the Kubernetes cluster
```
minikube tunnel
```
7) The program is ready to use and can accept HTTP requests

**HINT:** Login and password for authorization in the service is `admin`

## Examples of HTTP requests

**Create new phone:**
```
POST /api/v1/phones HTTP/1.1
Host: localhost:8080
Content-Type: application/json
Content-Length: 136

{ 
  "manufacturer": "Samsung",
  "model": "Galaxy",
  "storageSize": 512,
  "color": "Black",
  "cost": 1200,
  "quantity": 10
}
```

**Get phone by ID:**
```
GET /api/v1/phones/1 HTTP/1.1
Host: localhost:8080
```

**Get all phones:**
```
GET /api/v1/phones HTTP/1.1
Host: localhost:8080
```

**Update phone info by ID:**
```
PUT /api/v1/phones/1 HTTP/1.1
Host: localhost:8080
Content-Type: application/json
Content-Length: 136

{ 
  "manufacturer": "Apple",
  "model": "Iphone 13",
  "storageSize": 512,
  "color": "Black",
  "cost": 1250,
  "quantity": 5
}
```

**Delete phone by ID:**
```
DELETE /api/v1/phones/1 HTTP/1.1
Host: localhost:8080
```
