# Replicaset y Statefulset


#### Replicaset

```
A ReplicaSet's purpose is to maintain a stable set of replica Pods running at any given time. Usually, you define a Deployment and let that Deployment manage ReplicaSets automatically.
```

```yaml
apiVersion: v1
kind: Service
metadata: #Labels to identify resource
  name: nginx-service
  labels:
    maintainer: italianodevops
    app: my-nginx
    tier: frontend
    env: development
spec:
  type: NodePort 
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30518
  selector: # Find specified labels defined into metadata
    app: my-nginx
    env: development
---
apiVersion: apps/v1
kind: ReplicaSet
metadata:
  name: nginx-replicaset-1
  labels:
    maintainer: italianodevops
    app: my-nginx
    tier: frontend
    env: development
spec:
  replicas: 3
  selector:
    matchLabels:
      app: my-nginx
      env: development
  template:  # Pods info
    metadata:
      labels:
        maintainer: italianodevops
        app: my-nginx
        tier: frontend
        env: development
    spec:
      containers:
      - name: nginx-container
        image: nginx:latest
```

#### StatefulSet

```javascript
A StatefulSet runs a group of Pods, and maintains a sticky identity for each of those Pods. This is useful for managing applications that need persistent storage or a stable, unique network identity.
```

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: nginx-statefulset
  labels:
    app: k0s-nginx

spec:
  serviceName: k0s-nginx1-service
  replicas: 3
  selector:
    matchLabels:
      app: k0s-nginx
  template:
    metadata:
      labels:
        app: k0s-nginx
    spec:
      containers:
      - name: k0s-nginx-ctn1
        image: nginx:latest
        ports:
        - containerPort: 80
---
apiVersion: v1
kind: Service
metadata:
  name: nginx-external-service
  labels:
    app: k0s-nginx
spec:
  type: NodePort 
  ports:
  - port: 80
    targetPort: 80
    nodePort: 30517  # Specify port
  selector:
    app: k0s-nginx
```