# Path based routing alb


```
                                    Internet
                                       |
                              ┌─────────────────┐
                              │   AWS ALB       │
                              │  (appingress)   │
                              │ Internet-facing │
                              └─────────────────┘
                                       |
                              ┌─────────────────┐
                              │  Path Routing   │
                              │  / → nginx      │
                              │  /httpd → httpd │
                              └─────────────────┘
                                       |
                    ┌──────────────────┼──────────────────┐
                    │                  │                  │
                    ▼                  ▼                  ▼
        ┌─────────────────┐  ┌─────────────────┐  ┌─────────────────┐
        │ EKS Cluster     │  │ EKS Cluster     │  │ EKS Cluster     │
        │ Worker Nodes    │  │ Worker Nodes    │  │ Worker Nodes    │
        │ (eu-south-2a)   │  │ (eu-south-2b)   │  │ (eu-south-2c)   │
        └─────────────────┘  └─────────────────┘  └─────────────────┘
                    │                  │                  │
        ┌───────────┼──────────────────┼──────────────────┼───────────┐
        │           │                  │                  │           │
        ▼           ▼                  ▼                  ▼           ▼
┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐ ┌─────────────┐
│ nginx-pod-1 │ │ nginx-pod-2 │ │ httpd-pod-1 │ │ httpd-pod-2 │ │   Other     │
│   :80       │ │   :80       │ │   :80       │ │   :80       │ │   Pods      │
└─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘ └─────────────┘
        │           │                  │                  │
        └───────────┼──────────────────┼──────────────────┘
                    │                  │
        ┌─────────────────┐  ┌─────────────────┐
        │ NodePort Svc    │  │ NodePort Svc    │
        │ nginx-service   │  │ httpd-service   │
        │ Port: 80        │  │ Port: 80        │
        └─────────────────┘  └─────────────────┘
                    │                  │
                    └──────────┬───────┘
                               │
                    ┌─────────────────┐
                    │ AWS Load Bal.   │
                    │ Controller      │
                    │ (Ingress Mgmt)  │
                    └─────────────────┘

```
```
Internet Request
      ↓
┌─────────────────────────────────────────────────────────┐
│                    AWS ALB                              │
│  DNS: appingress-1744794109.eu-south-2.elb.amazonaws.com│
│  Scheme: internet-facing                                │
│  Health Check: HTTP / (200 OK)                          │
└─────────────────────────────────────────────────────────┘
      ↓
┌─────────────────────────────────────────────────────────┐
│                Path-Based Routing                       │
│  Rule 1: / (Prefix) → service-nodeport-nginx:80         │
│  Rule 2: /httpd (Prefix) → service-nodeport-httpd:80    │
└─────────────────────────────────────────────────────────┘
      ↓
┌─────────────────────────────────────────────────────────┐
│                 EKS Cluster                             │
│  Region: eu-south-2                                     │
│  IngressClass: web-app-ingress-class                    │
└─────────────────────────────────────────────────────────┘
      ↓                                   
┌─────────────────┐              ┌─────────────────┐
│  Nginx Service  │              │  Httpd Service  │
│  Type: NodePort │              │  Type: NodePort │
│  Port: 80       │              │  Port: 80       │
│  Selector:      │              │  Selector:      │
│ app=my-pod-nginx│              │ app=my-pod-httpd│
└─────────────────┘              └─────────────────┘
      ↓                                    ↓
┌─────────────────┐              ┌─────────────────┐
│ Nginx Deployment│              │ Httpd Deployment│
│ Replicas: 2     │              │ Replicas: 2     │
│ Image: nginx    │              │ Image: httpd    │
│ Port: 80        │              │ Port: 80        │
│ Content:        │              │ Content:        │
│ "Hello from     │              │ "I am httpd     │
│  nginx"         │              │  server"        │
└─────────────────┘              └─────────────────┘

``` 