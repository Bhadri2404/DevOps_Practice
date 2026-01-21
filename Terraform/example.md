# Kubernetes ConfigMaps - Complete Guide

## What is a ConfigMap?

A ConfigMap is a Kubernetes object that stores **non-confidential configuration data** as key-value pairs. It allows you to separate configuration from your application code.

```
┌─────────────────┐         ┌─────────────────┐
│   ConfigMap     │         │      Pod        │
│─────────────────│         │─────────────────│
│ DB_HOST=mysql   │ ──────► │ Environment     │
│ LOG_LEVEL=info  │         │ Variables or    │
│ APP_PORT=8080   │         │ Mounted Files   │
└─────────────────┘         └─────────────────┘
```

---

## Why Use ConfigMaps? 

**Without ConfigMap (Bad):**
```yaml
# Configuration hardcoded in Pod - hard to maintain
spec:
  containers: 
    - name: app
      env:
        - name: DB_HOST
          value: "mysql. example.com"  # Hardcoded!
```

**With ConfigMap (Good):**
```yaml
# Configuration externalized - easy to change
spec:
  containers: 
    - name: app
      envFrom:
        - configMapRef:
            name: app-config  # References external ConfigMap
```

**Benefits:**
- ✅ Change config without rebuilding images
- ✅ Reuse same Pod definition across environments
- ✅ Centralized configuration management
- ✅ Easy to version control

---

## Creating ConfigMaps

### Method 1: Command Line (Quick)

```bash
# Single key-value
kubectl create configmap app-config --from-literal=APP_ENV=production

# Multiple key-values
kubectl create configmap app-config \
  --from-literal=APP_ENV=production \
  --from-literal=LOG_LEVEL=info \
  --from-literal=APP_PORT=8080
```

### Method 2: From File

**Step 1: Create your properties files**

```properties
# app.properties
APP_NAME=MyWebApp
APP_ENV=production
APP_PORT=8080
LOG_LEVEL=info
DEBUG_MODE=false
```

```properties
# database.properties
DB_HOST=mysql-service
DB_PORT=3306
DB_NAME=myapp_db
DB_POOL_SIZE=10
DB_TIMEOUT=30
```

**Step 2: Create ConfigMap from files**

```bash
# From single file
kubectl create configmap app-config --from-file=app. properties

# From multiple files
kubectl create configmap app-config \
  --from-file=app. properties \
  --from-file=database.properties
```

**Step 3: View the resulting ConfigMap**

```bash
kubectl get configmap app-config -o yaml
```

**Output:**
```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: app-config
data:
  app.properties: |
    APP_NAME=MyWebApp
    APP_ENV=production
    APP_PORT=8080
    LOG_LEVEL=info
    DEBUG_MODE=false
  database.properties: |
    DB_HOST=mysql-service
    DB_PORT=3306
    DB_NAME=myapp_db
    DB_POOL_SIZE=10
    DB_TIMEOUT=30
```

> **Note:** The filename becomes the key, and the file content becomes the value.

### Method 3: YAML File (Recommended)

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name:  app-config
data:
  # Simple key-value pairs
  APP_ENV: "production"
  LOG_LEVEL: "info"
  APP_PORT: "8080"
  
  # Multi-line config file
  app. properties: |
    server.port=8080
    server.host=0.0.0.0
    feature.enabled=true
```

Apply it:
```bash
kubectl apply -f configmap.yaml
```

---

## Viewing ConfigMaps

```bash
# List all ConfigMaps
kubectl get configmaps

# View details
kubectl describe configmap app-config

# View as YAML
kubectl get configmap app-config -o yaml
```

---

## Injecting ConfigMaps into Pods

### Option 1: All Keys as Environment Variables

```yaml
apiVersion: v1
kind: Pod
metadata: 
  name: my-app
spec:
  containers:
    - name: my-app
      image: my-app:1.0
      envFrom:
        - configMapRef:
            name: app-config
```

**Result in container:**
```bash
$ echo $APP_ENV
production
$ echo $LOG_LEVEL
info
```

### Option 2: Specific Keys as Environment Variables

```yaml
apiVersion: v1
kind: Pod
metadata: 
  name: my-app
spec:
  containers: 
    - name: my-app
      image: my-app: 1.0
      env:
        - name:  ENVIRONMENT      # Custom name
          valueFrom:
            configMapKeyRef:
              name: app-config
              key: APP_ENV       # Key from ConfigMap
```

### Option 3: Mount as Files (Volume)

```yaml
apiVersion: v1
kind:  Pod
metadata:
  name:  my-app
spec:
  containers:
    - name: my-app
      image: my-app:1.0
      volumeMounts:
        - name:  config-volume
          mountPath:  /etc/config
  
  volumes:
    - name:  config-volume
      configMap: 
        name: app-config
```

**Result in container:**
```bash
$ ls /etc/config/
APP_ENV  LOG_LEVEL  APP_PORT  app.properties

$ cat /etc/config/APP_ENV
production
```

### Option 4: Mount Specific File

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: nginx
spec:
  containers:
    - name: nginx
      image: nginx
      volumeMounts:
        - name: config-volume
          mountPath: /etc/nginx/nginx.conf
          subPath: nginx.conf
  
  volumes:
    - name: config-volume
      configMap:
        name: nginx-config
```

---

## Complete Example

```yaml
---
# ConfigMap
apiVersion: v1
kind: ConfigMap
metadata:
  name:  webapp-config
data:
  APP_ENV: "production"
  LOG_LEVEL: "info"
  DB_HOST: "mysql-service"
  DB_PORT: "3306"

---
# Pod using the ConfigMap
apiVersion: v1
kind:  Pod
metadata:
  name:  webapp
spec:
  containers: 
    - name:  webapp
      image: my-webapp:1.0
      ports:
        - containerPort: 8080
      envFrom: 
        - configMapRef: 
            name: webapp-config
```

---

## Quick Reference

| Task | Command |
|------|---------|
| Create from literal | `kubectl create configmap NAME --from-literal=KEY=VALUE` |
| Create from file | `kubectl create configmap NAME --from-file=FILENAME` |
| Create from YAML | `kubectl apply -f configmap.yaml` |
| List ConfigMaps | `kubectl get configmaps` |
| View ConfigMap | `kubectl describe configmap NAME` |
| Delete ConfigMap | `kubectl delete configmap NAME` |
| Edit ConfigMap | `kubectl edit configmap NAME` |

---

## Important Notes

1. **Size Limit:** ConfigMaps are limited to **1 MB**
2. **No Secrets:** Don't store sensitive data (passwords, keys) - use **Secrets** instead
3. **Updates:**
   - Environment variables require Pod restart to update
   - Volume mounts update automatically (except with `subPath`)
4. **Naming:** ConfigMap must exist before the Pod that references it starts
