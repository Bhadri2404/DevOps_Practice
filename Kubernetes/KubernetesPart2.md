# 🔐☸️ Kubernetes Master Guide: Security, Storage, Networking, Helm, Kustomize & kubeadm

### *Enterprise Production-Ready | CKA Mastery Level | Senior DevOps Interview Ready*

---

## 📋 Table of Contents

- [Part I: Kubernetes Security](#part-i-kubernetes-security)
  - [1. Kubernetes Security Primitives](#1-kubernetes-security-primitives)
  - [2. Authentication](#2-authentication)
  - [3. TLS Basics](#3-tls-basics)
  - [4. TLS in Kubernetes](#4-tls-in-kubernetes)
  - [5. TLS Certificate Creation](#5-tls-certificate-creation)
  - [6. View Certificate Details](#6-view-certificate-details)
  - [7. Certificates API](#7-certificates-api)
  - [8. KubeConfig](#8-kubeconfig)
  - [9. API Groups](#9-api-groups)
  - [10. Authorization](#10-authorization)
  - [11. Role-Based Access Control (RBAC)](#11-role-based-access-control-rbac)
  - [12. Cluster Roles & ClusterRoleBindings](#12-cluster-roles--clusterrolebindings)
  - [13. Service Accounts](#13-service-accounts)
  - [14. Image Security](#14-image-security)
  - [15. Security Contexts](#15-security-contexts)
  - [16. Network Policies](#16-network-policies)
  - [17. Custom Resource Definitions (CRDs)](#17-custom-resource-definitions-crds)
  - [18. Custom Controllers](#18-custom-controllers)
  - [19. Operator Framework](#19-operator-framework)
- [Part II: Kubernetes Storage](#part-ii-kubernetes-storage)
  - [20. Storage in Docker](#20-storage-in-docker)
  - [21. Volume Driver Plugins](#21-volume-driver-plugins)
  - [22. Container Storage Interface (CSI)](#22-container-storage-interface-csi)
  - [23. Volumes in Kubernetes](#23-volumes-in-kubernetes)
  - [24. Persistent Volumes (PV)](#24-persistent-volumes-pv)
  - [25. Persistent Volume Claims (PVC)](#25-persistent-volume-claims-pvc)
  - [26. Storage Classes](#26-storage-classes)
- [Part III: Kubernetes Networking](#part-iii-kubernetes-networking)
  - [27. Linux Networking: Switching, Routing & Gateways](#27-linux-networking-switching-routing--gateways)
  - [28. DNS Prerequisites](#28-dns-prerequisites)
  - [29. Network Namespaces](#29-network-namespaces)
  - [30. Docker Networking](#30-docker-networking)
  - [31. Cluster Networking](#31-cluster-networking)
  - [32. Pod Networking](#32-pod-networking)
  - [33. CNI in Kubernetes](#33-cni-in-kubernetes)
  - [34. Service Networking](#34-service-networking)
  - [35. DNS in Kubernetes](#35-dns-in-kubernetes)
  - [36. CoreDNS in Kubernetes](#36-coredns-in-kubernetes)
  - [37. Ingress](#37-ingress)
  - [38. Gateway API (2025)](#38-gateway-api-2025)
- [Part IV: Troubleshooting Kubernetes](#part-iv-troubleshooting-kubernetes)
  - [39. Application Failure Troubleshooting](#39-application-failure-troubleshooting)
  - [40. Control Plane Failure Troubleshooting](#40-control-plane-failure-troubleshooting)
  - [41. Worker Node Failure Troubleshooting](#41-worker-node-failure-troubleshooting)
- [Part V: Kubernetes Cluster Installation](#part-v-kubernetes-cluster-installation)
  - [42. Choosing Kubernetes Infrastructure](#42-choosing-kubernetes-infrastructure)
  - [43. ETCD in High Availability (HA)](#43-etcd-in-high-availability-ha)
  - [44. Demo: Cluster Deployment with kubeadm](#44-demo-cluster-deployment-with-kubeadm)
- [Part VI: Helm — Kubernetes Package Manager](#part-vi-helm--kubernetes-package-manager)
  - [45. Installing Helm](#45-installing-helm)
  - [46. Helm 2 vs Helm 3](#46-helm-2-vs-helm-3)
  - [47. Helm Components](#47-helm-components)
  - [48. Helm Charts](#48-helm-charts)
  - [49. Working with Helm Basics](#49-working-with-helm-basics)
  - [50. Customizing Chart Parameters](#50-customizing-chart-parameters)
  - [51. Helm Lifecycle Management](#51-helm-lifecycle-management)
- [Part VII: Kustomize — Native Kubernetes Configuration Management](#part-vii-kustomize--native-kubernetes-configuration-management)
  - [52. Kustomize vs Helm](#52-kustomize-vs-helm)
  - [53. Installing Kustomize](#53-installing-kustomize)
  - [54. Kustomize Output & Deployment](#54-kustomize-output--deployment)
  - [55. Managing Directories with Kustomize](#55-managing-directories-with-kustomize)
  - [56. Common Transformers](#56-common-transformers)
  - [57. Image Transformers](#57-image-transformers)
  - [58. Patches: Introduction & Types](#58-patches-introduction--types)
  - [59. Patching Dictionaries](#59-patching-dictionaries)
  - [60. Patching Lists](#60-patching-lists)
  - [61. Overlays](#61-overlays)
  - [62. Kustomize Components](#62-kustomize-components)

---

---

# Part I: Kubernetes Security

---

## 1. Kubernetes Security Primitives

### 🔍 What Is It?

Kubernetes Security Primitives are the **foundational security controls** that protect the entire cluster from unauthorized access, malicious actions, and internal misuse. They form the **first and deepest line of defense** across all Kubernetes operations — from the physical nodes to the API interactions happening every millisecond.

Think of a Kubernetes cluster like a **government building**: the outer walls (host security) must be hardened, every door has a badge reader (authentication), every room has different clearance levels (authorization), all communication channels are encrypted (TLS), and only authorized departments can talk to each other (network policies).

### 🎯 Why Do We Need It?

In a production enterprise cluster, hundreds of developers, CI/CD pipelines, monitoring agents, and external services all interact with the Kubernetes API continuously. Without security primitives:

- Any compromised pod could access etcd and read all secrets
- A misconfigured service account could delete deployments
- An external attacker could reach internal databases
- A developer with admin rights could accidentally destroy production

Security primitives ensure **principle of least privilege** across every layer of the cluster.

### 🏗️ Core Components Involved

| Layer | Component | Purpose |
|-------|-----------|---------|
| **Host Security** | SSH keys, OS hardening | Prevent unauthorized access to nodes |
| **API Security** | kube-apiserver auth/authz | Control who can do what |
| **Communication Security** | TLS certificates | Encrypt all inter-component traffic |
| **Pod Security** | Security Contexts, PSA | Control container privileges |
| **Network Security** | Network Policies | Control pod-to-pod traffic |

### 🔄 Internal Working — Step-by-Step Flow

```
User/Service → kube-apiserver (HTTPS:6443)
     │
     ├─── [1] Authentication: Who are you?
     │         └─ Certificates / Tokens / OIDC / Static files
     │
     ├─── [2] Authorization: What can you do?
     │         └─ RBAC / ABAC / Node / Webhook
     │
     ├─── [3] Admission Control: Is this request valid?
     │         └─ NamespaceLifecycle / LimitRanger / PodSecurity
     │
     └─── [4] etcd: Store the desired state
```

Every single request to the Kubernetes API — whether from `kubectl`, an internal controller, or a pod via its service account — passes through this exact chain. There are **no exceptions**.

### 🏛️ Architecture Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                     CONTROL PLANE                                │
│                                                                   │
│  ┌─────────────┐    TLS     ┌──────────────┐   TLS   ┌───────┐  │
│  │  kubectl    │ ────────▶  │  kube-        │ ──────▶ │ etcd  │  │
│  │  (admin)    │            │  apiserver    │         └───────┘  │
│  └─────────────┘            │               │                    │
│                             │  AuthN/AuthZ  │   TLS  ┌─────────┐│
│  ┌─────────────┐            │  Admission    │ ──────▶│scheduler││
│  │ ServiceAcct │ ────────▶  │  Control      │         └─────────┘│
│  │ (pod auth)  │            └──────────────┘   TLS  ┌─────────┐ │
│  └─────────────┘                              ──────▶│ctrl-mgr │ │
│                                                       └─────────┘│
└─────────────────────────────────────────────────────────────────┘
         │
         │  TLS (kubelet client cert)
         ▼
┌─────────────────────────────────────────────────────────────────┐
│                      WORKER NODE                                  │
│                                                                   │
│  ┌─────────┐    ┌──────────────┐   ┌──────────────────────────┐  │
│  │ kubelet │    │  kube-proxy  │   │ Pod (SecurityContext)     │  │
│  │ (TLS)   │    │  (iptables)  │   │ NetworkPolicy enforced    │  │
│  └─────────┘    └──────────────┘   └──────────────────────────┘  │
└─────────────────────────────────────────────────────────────────┘
```

### 🌐 Integration with Other Kubernetes Components

- **etcd**: Stores all cluster state — must be encrypted at rest and protected with dedicated certs
- **kubelet**: Uses client certs signed by cluster CA to authenticate to kube-apiserver
- **kube-proxy**: Sets iptables/IPVS rules enforcing Network Policy decisions
- **CNI plugins (Calico, Cilium)**: Enforce NetworkPolicy at the kernel level
- **OPA/Gatekeeper**: Extends admission control with policy-as-code

### 🚀 Real-World Production Scenario

**Application Type**: Multi-tenant SaaS platform (FinTech)

**Infrastructure**:
- 3 master nodes (HA) + 50 worker nodes across 3 AZs
- Kubernetes 1.29 on AWS EKS
- Calico CNI for NetworkPolicy enforcement
- Vault for secrets management
- OPA Gatekeeper for admission policies

**Security Architecture**:
1. Nodes have SSH key-only access; root login disabled
2. All team members use OIDC (Okta) for kubectl authentication — no static credentials
3. RBAC: developers get namespace-scoped roles, SREs get cluster-reader, only pipeline SA gets deploy rights
4. All pods have `runAsNonRoot: true`, `readOnlyRootFilesystem: true`
5. NetworkPolicies: default-deny all, explicit allow per service boundary
6. Secrets encrypted at rest in etcd using AWS KMS provider
7. Pod Security Admission: `enforce: restricted` in production namespaces

**Failure & Recovery**: If apiserver cert expires → renew via `kubeadm certs renew all`. Alert set up via Prometheus `certmanager_certificate_expiration_timestamp_seconds`.

### ✅ Benefits

- Prevents lateral movement in case of pod compromise
- Enforces least privilege across the organization
- Provides audit trail for every API action
- Enables multi-tenancy on shared clusters

### ⚠️ Common Mistakes

1. Leaving `default` service account with cluster-admin rights
2. Not setting `automountServiceAccountToken: false` for pods that don't need API access
3. Using static admin credentials instead of OIDC/certificates
4. Running pods as root with no security context
5. Forgetting to enable NetworkPolicy (many CNIs need it explicitly enabled)

### 🐛 Debugging & Troubleshooting

```bash
# Check what permissions a user has
kubectl auth can-i --list --as=<username>
kubectl auth can-i create pods --as=system:serviceaccount:default:myapp

# Check audit logs for unauthorized access
kubectl logs -n kube-system kube-apiserver-master | grep "Forbidden"

# Verify TLS cert validity
openssl x509 -in /etc/kubernetes/pki/apiserver.crt -noout -dates

# Check who can access what
kubectl get rolebindings,clusterrolebindings --all-namespaces -o wide
```

### 📝 CKA Exam Tips

- Know the `kubectl auth can-i` command — it's tested frequently
- Understand that authentication and authorization are separate concerns
- Know the difference between Role/ClusterRole and RoleBinding/ClusterRoleBinding
- Be aware that security context settings at container level override pod level

### 🏭 Production Best Practices

1. Implement OIDC for human authentication — never distribute static kubeconfig files
2. Enable audit logging in kube-apiserver — critical for compliance (SOC2, PCI-DSS)
3. Use namespaces + RBAC for team isolation
4. Implement Pod Security Admission (replaced PodSecurityPolicy since 1.25)
5. Rotate certificates before expiry — set calendar reminders or use cert-manager

---

### 🔎 Topic Summary: Kubernetes Security Primitives

- **Security Primitives = The security foundation**: host hardening + API access control + encryption + network isolation
- **Every API request flows through**: Authentication → Authorization → Admission Control → etcd
- **Host security first**: Disable password auth, use SSH keys, disable root access on all nodes
- **API Server is the crown jewel**: It must be accessible only over TLS, with cert-based authentication
- **Default deny is king**: NetworkPolicies, RBAC, and Security Contexts should all follow least-privilege
- **Production must have**: OIDC auth, RBAC by team/namespace, encrypted etcd secrets, NetworkPolicies
- **CKA Focus**: Understand the three security layers and be able to configure each with YAML and kubectl commands

---

## 2. Authentication

### 🔍 What Is It?

Authentication in Kubernetes answers the fundamental question: **"Who are you?"** It is the process by which the kube-apiserver verifies the identity of any entity — human or machine — attempting to interact with the cluster. Authentication is the **gate** before any cluster operation, and the quality of your authentication strategy directly determines your security posture.

In enterprise Kubernetes, two types of principals exist:

1. **Human Users** (admins, developers, auditors): Kubernetes has NO native user object. Humans are authenticated externally.
2. **Service Accounts**: First-class Kubernetes objects, created via the API, designed for machine-to-machine authentication.

This architectural decision — no built-in user management — is intentional. It forces integration with enterprise identity providers (LDAP, OIDC, Active Directory), which is where user lifecycle management belongs.

### 🎯 Why Do We Need It?

Without robust authentication:
- Any developer could access production namespaces
- External attackers with network access to the API port could execute arbitrary commands
- Audit logs would show `anonymous` for all actions, making forensics impossible
- Compliance requirements (SOC2, HIPAA, PCI-DSS) would not be met

### 🏗️ Core Components Involved

| Mechanism | Type | Use Case | Security Level |
|-----------|------|----------|----------------|
| Static Basic Auth File | Legacy | Local dev only | ❌ Insecure |
| Static Token File | Legacy | Simple automation | ❌ Insecure |
| TLS Client Certificates | Standard | Human users, CI/CD | ✅ Good |
| OIDC Tokens | Enterprise | SSO integration | ✅✅ Best |
| Service Accounts | Machine | Pod-to-API auth | ✅ Good |
| LDAP (via webhook) | Enterprise | Corp directory sync | ✅✅ Best |

### 🔄 Internal Working — Step-by-Step Flow

```
[1] Client sends request to kube-apiserver:6443
     │
[2]  kube-apiserver checks the request:
     │  ├─ Does it have a client certificate? → Validate against CA
     │  ├─ Does it have a Bearer token? → Check token file or call TokenReview API
     │  ├─ Does it have Basic Auth? → Check static file (legacy)
     │  └─ No credentials? → Treat as system:anonymous
     │
[3]  Authentication succeeds → identity extracted (username, groups)
     │
[4]  Request passed to Authorization module with identity
```

### 🏛️ Architecture Flow

```
kubectl or API Client
        │
        │  HTTPS + (cert | token | basic-auth)
        ▼
┌────────────────────────────────────────────────────┐
│                  kube-apiserver                     │
│                                                     │
│  AuthN Plugin Chain (in order):                    │
│  ┌──────────────────────────────────────────────┐  │
│  │ 1. X509 Client Certs  (check client cert CA) │  │
│  │ 2. Static Token File  (check csv file)       │  │
│  │ 3. Bootstrap Tokens   (for kubelet join)     │  │
│  │ 4. Service Account    (JWT token validation) │  │
│  │ 5. OIDC               (external IdP)         │  │
│  │ 6. Webhook Token Auth (external service)     │  │
│  └──────────────────────────────────────────────┘  │
│                                                     │
│  Identity → username: "dev-user", groups: ["devs"]  │
└────────────────────────────────────────────────────┘
        │
        ▼ (if authenticated)
   Authorization (RBAC/ABAC/Node/Webhook)
```

### 📋 Authentication Mechanisms Deep Dive

#### Static Basic Auth File (DEPRECATED — Never Use in Production)

A CSV file with `password,username,uid,groups` passed to kube-apiserver via `--basic-auth-file`. The password is stored in **plaintext**. This was deprecated and removed from kubeadm-managed clusters. Understanding it helps recognize bad historical configurations.

```
# password,username,uid,group
KpjCVbI7rCFAHYPkByTIzRb7gu1cUc4B,user10,u0010,dev-group
```

```bash
# Example curl (NEVER do in production)
curl -k -u user10:KpjCVbI7rCFAHYPkByTIzRb7gu1cUc4B https://apiserver:6443/api
```

#### Static Token File (DEPRECATED — Avoid)

Similar concept, tokens stored in plaintext. Used with `--token-auth-file`. Subject to the same security issues as static basic auth.

#### TLS Client Certificates (Recommended for Automated Systems)

The most common and secure approach for non-human identities (CI/CD pipelines, internal tools). A certificate signed by the cluster CA proves identity. The `CN` (Common Name) becomes the username; `O` (Organization) becomes the group.

```bash
# Generate user key
openssl genrsa -out dev-user.key 2048

# Generate CSR
openssl req -new -key dev-user.key \
  -subj "/CN=dev-user/O=developers" \
  -out dev-user.csr

# Sign with cluster CA (admin operation)
openssl x509 -req -in dev-user.csr \
  -CA /etc/kubernetes/pki/ca.crt \
  -CAkey /etc/kubernetes/pki/ca.key \
  -CAcreateserial \
  -out dev-user.crt \
  -days 365
```

#### Service Accounts (For Pods/Applications)

Service accounts are **native Kubernetes objects**. They are the correct way for pods, operators, and in-cluster applications to authenticate with the API server.

```yaml
# service-account-example.yaml
# This creates a dedicated service account for a monitoring application
# Best Practice: Never use the 'default' service account for applications
# Default SA has no permissions but its token can still be misused if stolen

apiVersion: v1
kind: ServiceAccount
metadata:
  name: prometheus-sa
  namespace: monitoring
  annotations:
    # Optional: AWS IAM role for IRSA (IAM Roles for Service Accounts)
    eks.amazonaws.com/role-arn: arn:aws:iam::123456789:role/prometheus-role
automountServiceAccountToken: false  # Disable auto-mount; mount explicitly when needed

# Common Error: CrashLoopBackOff due to missing SA token
# Troubleshoot: kubectl describe pod <pod-name> | grep "Service Account"
# Check: kubectl get secret -n monitoring | grep prometheus-sa
```

#### OIDC Authentication (Enterprise Standard)

OIDC (OpenID Connect) integrates Kubernetes with enterprise identity providers like Okta, Azure AD, Dex, or Keycloak. The user logs in to the IdP, receives a JWT token, and uses it as the Bearer token for kubectl. This is the **gold standard** for human authentication in enterprise environments.

```bash
# kube-apiserver flags for OIDC
--oidc-issuer-url=https://accounts.google.com
--oidc-client-id=kubernetes
--oidc-username-claim=email
--oidc-groups-claim=groups
--oidc-ca-file=/etc/kubernetes/oidc-ca.crt
```

### 🚀 Real-World Production Scenario

**Application Type**: Enterprise Banking Platform

**Authentication Strategy**:
- **Developers/SREs**: OIDC via Okta → groups mapped to RBAC roles
- **CI/CD (Jenkins/ArgoCD)**: Dedicated ServiceAccount with limited RBAC, IRSA on AWS
- **Monitoring (Prometheus)**: ServiceAccount with read-only ClusterRole
- **Nodes (kubelet)**: Bootstrap tokens for initial registration, then TLS certificates
- **Audit**: All auth events logged to CloudWatch via kube-apiserver audit webhook

**Security Failure Scenario**: A developer's laptop was compromised. Because they used OIDC, the attacker only had a short-lived JWT token (1 hour). The OIDC refresh token was immediately revoked in Okta, invalidating all access within the hour. If static certificates had been used instead, the attacker could have accessed the cluster for the certificate's full lifetime (up to 1 year).

### ⚠️ Common Mistakes

1. Using `--basic-auth-file` or `--token-auth-file` in any cluster beyond quick tests
2. Sharing a single kubeconfig file with admin credentials across teams
3. Creating service accounts and not configuring `automountServiceAccountToken: false`
4. Not setting certificate expiry alerts — expired certs cause sudden total outages
5. Granting `system:masters` group membership liberally (this bypasses all RBAC)

### 🐛 Debugging & Troubleshooting

```bash
# Test authentication as a specific user
kubectl get pods --as=dev-user --as-group=developers

# Check current authentication context
kubectl config current-context
kubectl config view --minify

# Debug OIDC token (decode JWT)
kubectl get pods -v=9 2>&1 | grep "Authorization: Bearer"

# Check API server logs for auth failures
journalctl -u kube-apiserver | grep "authentication"

# Verify service account token in pod
kubectl exec -it <pod> -- cat /var/run/secrets/kubernetes.io/serviceaccount/token

# Check service account token expiry (Kubernetes 1.22+)
kubectl create token <sa-name> --duration=24h
```

### 📝 CKA Exam Tips

- Know `kubectl create serviceaccount` and how to configure it in pod spec (`serviceAccountName:`)
- Understand that `system:masters` group members bypass RBAC entirely
- Know that `automountServiceAccountToken: false` prevents automatic token mounting
- Certificates API (`CertificateSigningRequest`) is frequently tested
- Be able to create a kubeconfig entry for a new user with their certificate

### 🏭 Production Best Practices

1. **Never** use static password or token files in production
2. Implement OIDC with your enterprise IdP for all human access
3. Set `automountServiceAccountToken: false` at the namespace ServiceAccount level as default
4. Use short-lived tokens (TokenRequest API) over long-lived Secret-based tokens
5. Rotate all certificates annually at minimum; use cert-manager for automation
6. Enable and collect kube-apiserver audit logs for all authentication events
7. Use separate service accounts per application — never share the default SA

---

### 🔎 Topic Summary: Authentication

- **Authentication = "Who are you?"**: The first gate every API request must pass through
- **No native user objects**: Kubernetes delegates human identity to external systems (OIDC, certs)
- **Service Accounts are for machines**: Pods, controllers, and tools use SAs to authenticate with the API
- **Static files are legacy**: Basic-auth and token files are deprecated and insecure — avoid completely
- **OIDC is the enterprise standard**: Integrates with Okta, Azure AD, Google for SSO to kubectl
- **Client certificates** are the most common mechanism for automated pipelines and admin access
- **CKA Focus**: CSR workflow, ServiceAccount config, kubeconfig management, `kubectl auth can-i`

---

## 3. TLS Basics

### 🔍 What Is It?

TLS (Transport Layer Security) is the **cryptographic protocol** that secures all communication within a Kubernetes cluster. Before understanding TLS in Kubernetes, you must understand the foundational concepts: symmetric vs asymmetric encryption, public/private key pairs, Certificate Authorities, and the handshake process.

TLS solves three critical problems simultaneously:
1. **Confidentiality**: Data is encrypted so eavesdroppers see only ciphertext
2. **Integrity**: Data cannot be tampered with in transit without detection
3. **Authentication**: You're talking to who you think you're talking to (not an impostor)

### 🎯 Why Do We Need It?

Without TLS, an attacker with network access between a developer's laptop and the Kubernetes API server could:
- **Read** all kubectl commands and their responses (including secrets)
- **Modify** YAML definitions in transit (change image tags, environment variables)
- **Impersonate** the API server and return false information
- **Replay** captured authentication tokens

With TLS, all of this is cryptographically prevented.

### 🔐 Symmetric vs Asymmetric Encryption

**Symmetric Encryption** uses a single key for both encryption and decryption. It's fast and efficient but has a fundamental problem: **how do you securely share that key with the other party in the first place?** If you send it over the network, an attacker can intercept it.

```
Party A ──[symmetric key]──▶ Party B  (How to share securely?)
        ←─���─[key + data]────
```

**Asymmetric Encryption** solves the key sharing problem by using a **mathematically linked key pair**:
- **Private Key**: Kept secret, never shared, used to decrypt or sign
- **Public Key**: Shared freely, used to encrypt (so only the private key holder can decrypt)

```
Party A (has private key)     Party B (has public key)
                              Encrypts data with A's public key
←────[encrypted data]─────── 
Only A can decrypt with private key
```

### 🔄 TLS Handshake Process (Simplified)

```
Browser/Client                    Server (kube-apiserver)
      │                                    │
      │──── [1] ClientHello ──────────────▶│
      │         (supported TLS versions,   │
      │          cipher suites)            │
      │                                    │
      │◀─── [2] ServerHello + Certificate ─│
      │         (server's public cert,     │
      │          chosen cipher suite)      │
      │                                    │
      │──── [3] Client validates cert ─────│
      │         (Is cert signed by        │
      │          trusted CA? Not expired?) │
      │                                    │
      │──── [4] Client generates session ──│
      │         key, encrypts with         │
      │         server's public key        │
      │◀─── [5] Server decrypts with ──────│
      │         private key, both now      │
      │         share symmetric session key│
      │                                    │
      │═══ [6] Encrypted communication ════│
      │        using symmetric session key │
```

### 🏛️ Certificate Authority (CA) — The Root of Trust

A **Certificate Authority** is an entity that vouches for identity by signing certificates. When your browser trusts HTTPS on a website, it's because the website's certificate was signed by a CA that your browser already trusts (built-in trust store).

In Kubernetes, you create your **own CA** (a "private CA" or "internal CA"). Every certificate in the cluster is signed by this CA. The CA's public certificate is distributed to all components so they can validate each other's identities.

```
Kubernetes CA (ca.key + ca.crt)
        │
        ├── Signs → kube-apiserver.crt
        ├── Signs → etcd.crt
        ├── Signs → kubelet.crt
        ├── Signs → admin.crt
        └── Signs → all other component certs
```

### 🔑 Key File Naming Conventions

| File Type | Typical Extensions | Contains |
|-----------|-------------------|----------|
| Certificate (public) | `.crt`, `.pem` | Public key + identity info |
| Private Key | `.key`, `-key.pem` | Private key (never share!) |
| Certificate Signing Request | `.csr` | Request to have cert signed |

**Memory trick**: If the filename contains "key" → it's a private key. Otherwise, it's a certificate (public).

### 📝 CKA Exam Tips

- Know the difference between symmetric and asymmetric encryption conceptually
- Remember: certificates contain the **public key**; key files contain the **private key**
- The CA is the root of trust — every component trusts certs signed by the cluster CA
- Certificate files: `.crt` or `.pem`; Private key files: `.key` or `-key.pem`

### 🔎 Topic Summary: TLS Basics

- **TLS solves**: Confidentiality (encryption), Integrity (tamper detection), Authentication (identity verification)
- **Asymmetric encryption** solves the key exchange problem: encrypt with public key, decrypt with private key
- **TLS Handshake**: Client validates server cert, exchanges a session key, then uses symmetric encryption for speed
- **Certificate Authority (CA)** is the trust anchor: all certs must be signed by a trusted CA
- **Kubernetes uses its own CA**: Generated during cluster init, signs all component certificates
- **File conventions**: `.crt/.pem` = public certificate; `.key` = private key — NEVER share the private key
- **CKA Focus**: Know CA role, cert file types, and the concept of cert signing

---

## 4. TLS in Kubernetes

### 🔍 What Is It?

TLS in Kubernetes means that **every single communication channel** between cluster components is encrypted and mutually authenticated. Unlike a simple web application where only the server has a certificate, Kubernetes implements **mutual TLS (mTLS)** — both sides of every connection present certificates to verify their identities.

There are two categories of certificates in a Kubernetes cluster:

1. **Server Certificates**: Used by components that run as servers (kube-apiserver, etcd, kubelet) to prove they are who they claim to be
2. **Client Certificates**: Used by components that connect to servers (kubectl, scheduler, controller-manager, kube-proxy) to authenticate themselves

### 🏗️ Certificate Map — All Kubernetes Components

```
┌─────────────────────────────────────────────────────────────────────┐
│                    KUBERNETES TLS CERTIFICATE MAP                    │
├──────────────────────┬──────────────────┬───────────────────────────┤
│ Component            │ Acts as Server   │ Acts as Client            │
├──────────────────────┼──────────────────┼───────────────────────────┤
│ kube-apiserver       │ apiserver.crt    │ apiserver-etcd-client.crt │
│                      │ (HTTPS:6443)     │ apiserver-kubelet-client  │
├──────────────────────┼──────────────────┼───────────────────────────┤
│ etcd                 │ etcd-server.crt  │ etcd-peer.crt (HA)        │
├──────────────────────┼──────────────────┼───────────────────────────┤
│ kubelet              │ kubelet.crt      │ kubelet-client.crt        │
│                      │ (HTTPS:10250)    │ (to apiserver)            │
├──────────────────────┼──────────────────┼───────────────────────────┤
│ kube-scheduler       │ N/A              │ scheduler.crt             │
├──────────────────────┼──────────────────┼───────────────────────────┤
│ kube-controller-mgr  │ N/A              │ controller-manager.crt    │
├──────────────────────┼──────────────────┼───────────────────────────┤
│ kube-proxy           │ N/A              │ kube-proxy.crt            │
├──────────────────────┼──────────────────┼───────────────────────────┤
│ admin (kubectl)      │ N/A              │ admin.crt                 │
└──────────────────────┴──────────────────┴───────────────────────────┘
```

### 🔄 Internal Working

When the kube-scheduler connects to kube-apiserver:
1. Scheduler presents its client certificate (`scheduler.crt`)
2. API server validates: "Is this cert signed by our cluster CA?"
3. API server presents its server certificate (`apiserver.crt`)
4. Scheduler validates: "Is this the real API server?"
5. mTLS connection established
6. Scheduler's identity (`system:kube-scheduler`) used for RBAC authorization

### 🏛️ Architecture Flow

```
┌──────────────────────────────────────────────────────────────┐
│                    Cluster CA                                 │
│          (ca.crt is the root of trust for all)               │
│          (ca.key signs all certificates)                      │
└──────────────────────────┬───────────────────────────────────┘
                           │ Signs all component certs
        ┌──────────────────┼────────────────────┐
        ▼                  ▼                    ▼
┌─────────────┐   ┌─────────────────┐   ┌──────────────────┐
│   etcd      │   │  kube-apiserver │   │    kubelet       │
│  etcd.crt   │   │  apiserver.crt  │   │  kubelet.crt     │
│  etcd.key   │◀──│  apiserver.key  │──▶│  kubelet.key     │
└─────────────┘   └────────┬────────┘   └──────────────────┘
                           │
        ┌──────────────────┼────────────────────┐
        ▼                  ▼                    ▼
┌─────────────┐   ┌─────────────────┐   ┌──────────────────┐
│ scheduler   │   │  controller-mgr │   │  admin (kubectl) │
│ client cert │   │  client cert    │   │  admin.crt       │
└─────────────┘   └─────────────────┘   └──────────────────┘
```

### ⚠️ Common Mistakes

1. **Using a single CA for both Kubernetes components and etcd** — best practice is separate CAs
2. **Forgetting Subject Alternative Names (SANs)** for kube-apiserver — causes "certificate invalid for hostname" errors
3. **Not backing up CA key** — if lost, entire cluster certificates must be regenerated
4. **Not monitoring cert expiry** — expired certs cause sudden total cluster outages

### 📝 CKA Exam Tips

- Know which certificates go where (memorize the table above)
- kube-apiserver has **multiple** certificates: one for clients, one for etcd, one for kubelets
- Know that `O=system:masters` in a client cert grants cluster-admin (RBAC bypass)
- Know the paths: `/etc/kubernetes/pki/` for kubeadm clusters

---

### 🔎 Topic Summary: TLS in Kubernetes

- **Every K8s communication is TLS-encrypted**: No plaintext traffic between components
- **Mutual TLS**: Both sides verify each other's certificates — not just one-way
- **Two cert types**: Server certs (prove server identity) and client certs (prove client identity)
- **One CA rules them all**: The cluster CA is the root of trust that signs every component's cert
- **kube-apiserver is special**: Has multiple certs (server cert + client certs for etcd, kubelets, etc.)
- **Certificate = Identity**: `CN` field is the username, `O` field is the group in Kubernetes
- **CKA Focus**: Know the cert file paths, which component uses which cert, and common SANs

---

## 5. TLS Certificate Creation

### 🔍 What Is It?

Certificate creation is the process of **generating the cryptographic material** (key pairs and signed certificates) needed for each Kubernetes component to participate in the cluster's mutual TLS infrastructure. This is a hands-on process that every Kubernetes administrator must understand deeply, whether setting up a cluster from scratch or recovering from certificate failures.

### 🔄 Complete Certificate Creation Workflow

The process follows a consistent three-step pattern for every certificate:

```
Step 1: Generate Private Key
openssl genrsa -out <component>.key 2048

Step 2: Create Certificate Signing Request (CSR)
openssl req -new -key <component>.key \
  -subj "/CN=<identity>/O=<group>" \
  -out <component>.csr

Step 3: Sign with CA (creates the certificate)
openssl x509 -req -in <component>.csr \
  -CA ca.crt -CAkey ca.key \
  -CAcreateserial \
  -out <component>.crt \
  -days 365
```

### 📋 Creating Each Certificate Type

#### 1. Cluster CA (Self-Signed — The Root)

```bash
# CA doesn't need a CSR signed by anyone else — it signs itself
openssl genrsa -out ca.key 2048
openssl req -new -x509 -days 1826 \
  -key ca.key \
  -subj "/CN=KUBERNETES-CA" \
  -out ca.crt

# This creates the cluster's root of trust
# ca.crt → distributed to all components as the trust anchor
# ca.key → KEEP SECURE — anyone with this can create trusted certs
```

#### 2. Admin User Certificate

```bash
# O=system:masters puts this user in the cluster-admin group
openssl genrsa -out admin.key 2048
openssl req -new -key admin.key \
  -subj "/CN=kubernetes-admin/O=system:masters" \
  -out admin.csr
openssl x509 -req -in admin.csr \
  -CA ca.crt -CAkey ca.key \
  -CAcreateserial -out admin.crt -days 365
```

#### 3. kube-apiserver Certificate (Complex — Needs SANs)

The API server is the most critical certificate. It's accessed by many names and IPs, so the certificate must include all of them as Subject Alternative Names (SANs):

```ini
# openssl.cnf for apiserver SANs
[req]
req_extensions = v3_req
distinguished_name = req_distinguished_name

[v3_req]
basicConstraints = CA:FALSE
keyUsage = nonRepudiation, digitalSignature, keyEncipherment
subjectAltName = @alt_names

[alt_names]
DNS.1 = kubernetes
DNS.2 = kubernetes.default
DNS.3 = kubernetes.default.svc
DNS.4 = kubernetes.default.svc.cluster.local
DNS.5 = master.example.com     # your master hostname
IP.1 = 10.96.0.1               # Kubernetes service ClusterIP
IP.2 = 192.168.1.100           # Master node IP
IP.3 = 127.0.0.1               # Localhost
```

```bash
openssl genrsa -out apiserver.key 2048
openssl req -new -key apiserver.key \
  -subj "/CN=kube-apiserver" \
  -config openssl.cnf \
  -out apiserver.csr
openssl x509 -req -in apiserver.csr \
  -CA ca.crt -CAkey ca.key \
  -CAcreateserial \
  -extensions v3_req \
  -extfile openssl.cnf \
  -out apiserver.crt -days 365
```

#### 4. kubelet Certificates (Per Node)

Each worker node needs its own cert, named after the node:

```bash
# For node worker-01
openssl genrsa -out worker-01.key 2048
# O=system:nodes and CN must be system:node:<nodename>
openssl req -new -key worker-01.key \
  -subj "/CN=system:node:worker-01/O=system:nodes" \
  -out worker-01.csr
openssl x509 -req -in worker-01.csr \
  -CA ca.crt -CAkey ca.key \
  -CAcreateserial -out worker-01.crt -days 365
```

### 🔎 Topic Summary: TLS Certificate Creation

- **Three-step pattern**: Generate key → Create CSR → Sign with CA
- **CA is created first**: Self-signed, no external CA needed for a Kubernetes cluster
- **Every component gets its own key pair**: Never reuse keys between components
- **API server needs SANs**: Must include all DNS names and IPs it's accessed by
- **Identity embedded in cert**: `CN` = username, `O` = group (critical for RBAC)
- **kubelet certs**: Must follow `CN=system:node:<nodename>` and `O=system:nodes` convention
- **CKA Focus**: Know the cert creation commands, SANs for apiserver, and CN/O conventions

---

## 6. View Certificate Details

### 🔍 What Is It?

Certificate inspection is the **diagnostic process** of decoding and verifying the properties of TLS certificates in your cluster. This skill is essential for troubleshooting authentication failures, pre-emptively detecting expiring certificates, and auditing your cluster's security configuration.

Every certificate encodes rich information: who issued it, who it's for, what it's valid for, when it expires, and what it can be used for.

### 🔄 Certificate Inspection Workflow

#### For kubeadm-based Clusters

In kubeadm clusters, certificates live in `/etc/kubernetes/pki/`. Start by inspecting the kube-apiserver manifest:

```bash
# Find which certs are being used
cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep -E "cert|key|ca"

# Inspect a specific certificate
openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout

# What to look for:
# 1. Subject: CN (identity) and O (group)
# 2. Issuer: CN (should be KUBERNETES-CA or similar)
# 3. Validity: Not After (expiry date)
# 4. X509v3 Subject Alternative Name (SANs for apiserver)
```

#### Sample Certificate Output

```
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number: 1234567890
    Signature Algorithm: sha256WithRSAEncryption
    Issuer: CN=kubernetes      ← WHO SIGNED IT
    Validity
        Not Before: Jan  1 00:00:00 2025 GMT
        Not After : Jan  1 00:00:00 2026 GMT   ← EXPIRY DATE
    Subject: CN=kube-apiserver  ← WHO IT'S FOR
    X509v3 Subject Alternative Name:  ← VALID NAMES
        DNS:kubernetes, DNS:kubernetes.default,
        DNS:kubernetes.default.svc,
        DNS:kubernetes.default.svc.cluster.local,
        IP Address:10.96.0.1, IP Address:192.168.1.100
```

#### Checking All Certificate Expiries

```bash
# Quick check for all certs (kubeadm)
kubeadm certs check-expiration

# Output shows all certs and their expiry dates:
# CERTIFICATE                EXPIRES                  RESIDUAL TIME
# admin.conf                 Dec 01 2025 08:30:00 UTC  364d
# apiserver                  Dec 01 2025 08:30:00 UTC  364d
# apiserver-etcd-client      Dec 01 2025 08:30:00 UTC  364d

# Renew all certs (run on master node)
kubeadm certs renew all
```

#### Troubleshooting with Logs

```bash
# For kubeadm clusters (pods)
kubectl logs -n kube-system kube-apiserver-master
kubectl logs -n kube-system etcd-master

# For non-kubeadm clusters (systemd services)
journalctl -u kube-apiserver -l
journalctl -u etcd -l

# If kubectl doesn't work (cert issue prevents API access):
docker ps -a | grep apiserver
docker logs <container-id>
# OR for containerd:
crictl ps | grep apiserver
crictl logs <container-id>
```

### ⚠️ Common Mistakes

1. Not monitoring certificate expiry — certs expire and cause sudden complete outages
2. Forgetting to add SANs when regenerating the apiserver cert after IP changes
3. Not restarting the kube-apiserver pod after cert renewal
4. Losing the CA key — makes it impossible to issue new certificates

### 🐛 Production Alert

```yaml
# Prometheus alert rule for certificate expiry
groups:
- name: kubernetes-cert-expiry
  rules:
  - alert: KubernetesCertificateExpirySoon
    expr: certmanager_certificate_expiration_timestamp_seconds - time() < 86400 * 30
    for: 1h
    labels:
      severity: warning
    annotations:
      summary: "Certificate expiring in less than 30 days"
```

---

### 🔎 Topic Summary: View Certificate Details

- **`openssl x509 -in <cert> -text -noout`** is the universal cert inspection command
- **Key fields to check**: Subject (identity), Issuer (CA), Not After (expiry), SANs
- **`kubeadm certs check-expiration`**: Quick overview of all cluster cert expiry dates
- **`kubeadm certs renew all`**: Renews all certificates signed by the cluster CA
- **kubeadm uses static pods**: If apiserver cert is broken, use `docker logs` or `crictl logs` — kubectl won't work
- **Create a cert inventory spreadsheet**: Track all certs, their locations, expiry dates, and renewal procedures
- **CKA Focus**: Know how to decode certs, check expiry, and where cert files live in kubeadm clusters

---

## 7. Certificates API

### 🔍 What Is It?

The Kubernetes Certificates API is a **built-in mechanism** for managing the certificate lifecycle within a cluster. It provides an automated, API-driven workflow for:

1. Submitting certificate signing requests (CSRs) to the cluster
2. Reviewing and approving/denying those requests
3. Automatically signing approved requests with the cluster CA

Before the Certificates API, issuing certificates required direct access to the CA key on the master node — an operation reserved for cluster administrators. The Certificates API democratizes cert issuance while maintaining control through an approval workflow.

### 🔄 Internal Working — Step-by-Step

```
[User/Admin Needing Certificate]
         │
         │ 1. Generate private key and CSR
         │    openssl genrsa -out user.key 2048
         │    openssl req -new -key user.key -subj "/CN=jane" -out user.csr
         │
         │ 2. Encode CSR in base64
         │    cat user.csr | base64 -w 0
         │
         │ 3. Create CertificateSigningRequest object
         ▼
┌────────────────────────────────────┐
│       kube-apiserver               │
│                                    │
│  CertificateSigningRequest object  │
│  Status: Pending                   │
└────────────┬───────────────────────┘
             │
             │ 4. Cluster Admin reviews and approves
             │    kubectl certificate approve <csr-name>
             │
             │ 5. Controller Manager's CSR-Signing controller
             │    signs the CSR with the cluster CA
             │
             ▼
┌────────────────────────────────────┐
│  CertificateSigningRequest object  │
│  Status: Approved                  │
│  certificate: <base64-encoded-cert>│
└────────────────────────────────────┘
             │
             │ 6. Admin retrieves signed certificate
             │    kubectl get csr <name> -o jsonpath=...
             │    | base64 -d > user.crt
```

### 📋 Complete CertificateSigningRequest Workflow

```yaml
# certificatesigningrequest-jane.yaml
# This requests a client certificate for user 'jane'
# The controller-manager's CSR-Signing controller will sign this
# using the cluster CA specified by --cluster-signing-cert-file

apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: jane   # Must be unique in the cluster (cluster-scoped resource)
spec:
  request: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURSBSRVFVRVNULS0t  # base64 encoded CSR
  signerName: kubernetes.io/kube-apiserver-client  # For client auth to apiserver
  expirationSeconds: 86400  # 24 hours — use short-lived certs in production
  usages:
    - client auth       # This cert will be used for client authentication
    # For kubelet: add "server auth" for kubelet server cert
    # DO NOT add "code signing" or other unnecessary usages (least privilege)

# Common Error: CrashLoopBackOff in pods after cert renewal
# Cause: Application cached old cert before restart
# Fix: kubectl rollout restart deployment/<name>
# Verify: kubectl exec <pod> -- openssl x509 -in /path/to/cert -noout -dates
```

```bash
# Complete workflow
# 1. Generate key and CSR
openssl genrsa -out jane.key 2048
openssl req -new -key jane.key -subj "/CN=jane/O=developers" -out jane.csr

# 2. Create the K8s CSR object
cat <<EOF | kubectl apply -f -
apiVersion: certificates.k8s.io/v1
kind: CertificateSigningRequest
metadata:
  name: jane
spec:
  request: $(cat jane.csr | base64 -w 0)
  signerName: kubernetes.io/kube-apiserver-client
  expirationSeconds: 86400
  usages:
  - client auth
EOF

# 3. Check CSR status
kubectl get csr
# NAME   AGE   SIGNERNAME                            REQUESTOR         CONDITION
# jane   10s   kubernetes.io/kube-apiserver-client   admin             Pending

# 4. Approve the CSR
kubectl certificate approve jane

# 5. Retrieve the signed certificate
kubectl get csr jane -o jsonpath='{.status.certificate}' | base64 -d > jane.crt

# 6. Create kubeconfig for jane
kubectl config set-credentials jane \
  --client-certificate=jane.crt \
  --client-key=jane.key

# 7. Deny a suspicious CSR
kubectl certificate deny malicious-user
```

### 🏛️ Role of Controller Manager

The Controller Manager contains two specific controllers for the Certificates API:
- **CSR-Approving**: Handles automatic approval for bootstrap tokens
- **CSR-Signing**: Actually signs approved CSRs using the cluster CA

```bash
# Controller manager must be configured with CA files:
cat /etc/kubernetes/manifests/kube-controller-manager.yaml | grep signing

# Should show:
# --cluster-signing-cert-file=/etc/kubernetes/pki/ca.crt
# --cluster-signing-key-file=/etc/kubernetes/pki/ca.key
```

### 📝 CKA Exam Tips

- Know the full CSR workflow end-to-end (create, approve, extract cert)
- `kubectl certificate approve <csr-name>` is the approval command
- The CSR object stores the base64-encoded certificate in `.status.certificate` after approval
- CSR objects are cluster-scoped (not namespace-scoped)
- Know `signerName: kubernetes.io/kube-apiserver-client` for client auth certs

---

### 🔎 Topic Summary: Certificates API

- **Certificates API** = automated, API-driven CSR workflow built into Kubernetes
- **Workflow**: User creates CSR → Admin approves → Controller Manager signs → Admin retrieves cert
- **CertificateSigningRequest** is the K8s object type — cluster-scoped, has Pending/Approved/Denied states
- **Controller Manager does the signing** using `--cluster-signing-cert-file` and `--cluster-signing-key-file`
- **`kubectl certificate approve`** and `kubectl certificate deny` are the admin commands
- **Production use**: cert-manager automates this entire workflow for workload certificates
- **CKA Focus**: Be able to create, approve, and extract a CSR end-to-end

---

## 8. KubeConfig

### 🔍 What Is It?

KubeConfig is a **configuration file** that tells `kubectl` how to connect to a Kubernetes cluster and authenticate with it. It consolidates three things: **cluster information** (API server endpoint and CA cert), **user credentials** (certificate, token, or OIDC), and **contexts** (named pairings of cluster + user + namespace).

Without kubeconfig, every kubectl command would require explicit flags for server URL, certificate files, and credentials — an impractical workflow. Kubeconfig makes these implicit via contexts.

**Default location**: `~/.kube/config`

### 🏗️ KubeConfig Structure

```
KubeConfig File
├── clusters[]          → List of clusters with API server URLs and CA certs
├── users[]             → List of users with their authentication credentials
├── contexts[]          → Named combinations of (cluster + user + optional namespace)
└── current-context     → Which context is active right now
```

### 📋 KubeConfig YAML Deep Dive

```yaml
# ~/.kube/config
# This is the standard kubeconfig file structure
# NEVER commit this file to git — it contains private keys/tokens

apiVersion: v1
kind: Config

# current-context defines the default cluster+user+namespace
# switch with: kubectl config use-context <context-name>
current-context: prod-admin@production

clusters:
- name: production
  cluster:
    server: https://prod-api.company.com:6443
    # certificate-authority: /etc/kubernetes/pki/ca.crt  # Option 1: file path
    certificate-authority-data: LS0tLS1CRUdJTi...  # Option 2: embedded base64 (preferred)
    # Use option 2 for portability — the file doesn't need to exist on the target machine

- name: development
  cluster:
    server: https://dev-api.company.com:6443
    certificate-authority-data: LS0tLS1CRUdJTi...

users:
- name: prod-admin
  user:
    # Option 1: Embed certs directly (preferred for portability)
    client-certificate-data: LS0tLS1CRUdJTi...
    client-key-data: LS0tLS1CRUdJTi...

    # Option 2: File paths (less portable)
    # client-certificate: /home/user/.certs/admin.crt
    # client-key: /home/user/.certs/admin.key

    # Option 3: Token (for ServiceAccounts or OIDC)
    # token: eyJhbGciOiJSUzI1NiIsImtpZCI6Ij...

- name: dev-user
  user:
    client-certificate-data: LS0tLS1CRUdJTi...
    client-key-data: LS0tLS1CRUdJTi...

contexts:
- name: prod-admin@production   # Convention: user@cluster
  context:
    cluster: production
    user: prod-admin
    namespace: default          # Optional: set default namespace for this context

- name: dev-user@development
  context:
    cluster: development
    user: dev-user
    namespace: dev-team         # Commands will run in dev-team namespace by default

# ImagePullBackOff can happen if SA tokens in kubeconfig expired
# Fix: kubectl create token <sa> > token && kubectl config set-credentials ...
```

### 🔄 Essential kubectl config Commands

```bash
# View current kubeconfig (merged from all sources)
kubectl config view

# View only active context config
kubectl config view --minify

# List all contexts
kubectl config get-contexts

# Show current context
kubectl config current-context

# Switch context
kubectl config use-context prod-admin@production

# Set namespace for current context
kubectl config set-context --current --namespace=production

# Use a non-default kubeconfig file
kubectl --kubeconfig=/path/to/other/config get pods
# OR set environment variable
export KUBECONFIG=/path/to/config1:/path/to/config2  # Merges multiple files

# Add a new cluster to kubeconfig
kubectl config set-cluster new-cluster \
  --server=https://new-api:6443 \
  --certificate-authority=ca.crt

# Add credentials
kubectl config set-credentials new-user \
  --client-certificate=user.crt \
  --client-key=user.key

# Create new context
kubectl config set-context new-context \
  --cluster=new-cluster \
  --user=new-user \
  --namespace=default
```

### 🚀 Production Scenario: Multi-Cluster Management

**Setup**: An SRE team manages 5 clusters (2 prod, 2 staging, 1 dev). Each engineer has:

```bash
# Using kubectx tool for faster context switching
brew install kubectx  # or apt install kubectx

# List contexts
kubectx
# prod-us-east@prod-us-east
# prod-eu-west@prod-eu-west
# staging-us-east@staging
# dev@development

# Switch quickly
kubectx prod-us-east

# Switch namespace quickly
kubens monitoring
```

**Security**: Kubeconfig files with production credentials are:
- Stored in 1Password or HashiCorp Vault
- Never in Git repositories (check with `git-secrets` or pre-commit hooks)
- Auto-expired tokens via OIDC (no long-lived embedded credentials)
- Separate kubeconfig per cluster — not one merged file

### ⚠️ Common Mistakes

1. Committing kubeconfig with embedded credentials to Git
2. Using the same kubeconfig with admin credentials for all environments
3. Not setting namespace in context — accidentally running commands in wrong namespace
4. Sharing kubeconfig files between team members
5. Using `client-certificate:` (file path) instead of `client-certificate-data:` (embedded) in distributed configs

---

### 🔎 Topic Summary: KubeConfig

- **KubeConfig = connection profile**: tells kubectl where to connect, how to authenticate, and with which permissions
- **Three sections**: clusters (API server URLs), users (credentials), contexts (cluster+user+namespace combos)
- **`current-context`** determines which cluster kubectl talks to by default
- **`kubectl config use-context`** switches between clusters/environments
- **Embed cert data** (base64) rather than file paths for portable configs
- **Never commit to Git**: kubeconfig contains private keys and sensitive tokens
- **CKA Focus**: Know how to create/modify kubeconfig entries, switch contexts, and set namespaces

---

## 9. API Groups

### 🔍 What Is It?

API Groups are how Kubernetes **organizes its vast API surface** into logical, versioned collections. Rather than having a flat namespace of resources, Kubernetes uses a hierarchical structure where resources are grouped by domain and version. This organization enables:

- Independent versioning of different resource types
- Clear ownership of API extensions
- Proper authorization scoping in RBAC rules

### 🏗️ API Group Structure

```
/api (core group — v1 resources)
  └── /v1
        ├── pods
        ├── services
        ├── configmaps
        ├── secrets
        ├── namespaces
        ├── nodes
        ├── persistentvolumes
        ├── persistentvolumeclaims
        └── serviceaccounts

/apis (named groups)
  ├── apps/v1
  │     ├── deployments
  │     ├── replicasets
  │     ├── statefulsets
  │     └── daemonsets
  │
  ├── batch/v1
  │     ├── jobs
  │     └── cronjobs
  │
  ├── networking.k8s.io/v1
  │     ├── ingresses
  │     └── networkpolicies
  │
  ├── rbac.authorization.k8s.io/v1
  │     ├── roles
  │     ├── clusterroles
  │     ├── rolebindings
  │     └── clusterrolebindings
  │
  ├── storage.k8s.io/v1
  │     └── storageclasses
  │
  └── certificates.k8s.io/v1
        └── certificatesigningrequests
```

### 🔄 Exploring the API

```bash
# List all API groups
curl http://localhost:8001 -k  # (after kubectl proxy)

# List all resources in all groups
kubectl api-resources

# List resources in a specific group
kubectl api-resources --api-group=apps

# Get API group and version for a resource
kubectl api-resources | grep deployment
# deployments   deploy   apps/v1   true   Deployment

# Explain a resource (shows its API group)
kubectl explain deployment
# GROUP:      apps
# KIND:       Deployment
# VERSION:    v1
```

### 📝 Importance for RBAC

In RBAC rules, the `apiGroups` field must correctly reference the API group:

```yaml
rules:
- apiGroups: [""]           # "" = core group (pods, services, secrets)
  resources: ["pods"]
  verbs: ["get", "list"]

- apiGroups: ["apps"]       # named group
  resources: ["deployments"]
  verbs: ["get", "list", "create", "update"]

- apiGroups: ["networking.k8s.io"]  # full group name
  resources: ["networkpolicies"]
  verbs: ["get", "list"]
```

### 🔎 Topic Summary: API Groups

- **API Groups organize K8s resources** into versioned, domain-specific collections
- **Core group** (`""`) contains fundamental resources: pods, services, configmaps, secrets
- **Named groups** (`apps`, `batch`, `networking.k8s.io`) contain newer/extension resources
- **RBAC requires correct apiGroups**: `""` for core, `"apps"` for deployments, etc.
- **`kubectl api-resources`** lists all resources with their API group and version
- **CRDs create new API groups**: `myapp.company.com/v1` style
- **CKA Focus**: Know the major groups, and correctly specify them in RBAC YAML

---

## 10. Authorization

### 🔍 What Is It?

Authorization answers the question: **"Are you allowed to do that?"** After authentication confirms *who* you are, authorization determines *what* you can do. Kubernetes supports multiple authorization modes, each with different strengths and use cases.

Authorization in Kubernetes is **additive**: you start with no permissions, and permissions must be explicitly granted. There is no "deny" in RBAC — you simply don't grant what shouldn't be allowed.

### 🏗️ Authorization Modes

| Mode | Description | Use Case |
|------|-------------|----------|
| **RBAC** | Role-based permissions | Standard — use in all production clusters |
| **ABAC** | Attribute-based policies in JSON | Legacy — complex, static file-based |
| **Node** | Special rules for kubelet | Always enabled — controls kubelet access |
| **Webhook** | External authorization service | OPA, custom policy engines |
| **AlwaysAllow** | Permit everything | Testing only — never in production |
| **AlwaysDeny** | Deny everything | Essentially disables the cluster |

### 🔄 Authorization Chain

When multiple modes are configured, they're evaluated in order. The first `ALLOW` wins; if all deny, the request is denied:

```
--authorization-mode=Node,RBAC,Webhook

Request arrives →
  [1] Node authorizer: Is this from a kubelet? For node-specific resources?
       If YES and valid → ALLOW (stop here)
       If NO/DENY → pass to next
  
  [2] RBAC: Is there a role/clusterrole granting this permission?
       If YES → ALLOW (stop here)
       If NO → pass to next
  
  [3] Webhook: Call external service (OPA/custom)
       Returns ALLOW or DENY
       
  [FINAL] If all deny → 403 Forbidden
```

### 📋 Node Authorizer

The Node authorizer is special — it governs what **kubelets** can do. Kubelets need to:
- Read: Secrets, ConfigMaps, Services, Pods assigned to their node
- Write: Node status, Pod status, events
- They **cannot** read secrets for pods on other nodes

Kubelets are identified by their certificate: `CN=system:node:<nodename>` and `O=system:nodes`.

### 📋 RBAC

RBAC (Role-Based Access Control) is the primary authorization mechanism. See Section 11 for full details.

### 📋 Webhook Authorization

```yaml
# kube-apiserver config for OPA webhook authorization
# --authorization-mode=Node,RBAC,Webhook
# --authorization-webhook-config-file=/etc/kubernetes/webhook-authz.yaml

# webhook-authz.yaml
apiVersion: v1
kind: Config
clusters:
- cluster:
    server: https://opa.kube-system.svc.cluster.local:8443/v1/data/k8s/authz
    certificate-authority: /etc/kubernetes/pki/opa-ca.crt
  name: opa
users:
- name: kube-apiserver
  user:
    client-certificate: /etc/kubernetes/pki/apiserver.crt
    client-key: /etc/kubernetes/pki/apiserver.key
contexts:
- context:
    cluster: opa
    user: kube-apiserver
  name: webhook
current-context: webhook
```

### 🐛 Debugging Authorization

```bash
# Check if a user can perform an action
kubectl auth can-i create pods
kubectl auth can-i create pods --namespace production
kubectl auth can-i delete nodes

# Check as another user (impersonation — requires admin rights)
kubectl auth can-i create deployments --as jane
kubectl auth can-i create deployments --as jane --as-group developers

# List all permissions for a service account
kubectl auth can-i --list --as=system:serviceaccount:default:myapp-sa

# Check RBAC rules for a specific resource
kubectl get rolebindings,clusterrolebindings -A | grep <username>
```

---

### 🔎 Topic Summary: Authorization

- **Authorization = "What can you do?"**: Separate from authentication; evaluated second
- **Default deny**: No permissions granted by default; must be explicitly allowed
- **Modes in order**: Node → RBAC → Webhook → AlwaysAllow/AlwaysDeny
- **First ALLOW wins**: Authorization stops at the first module that permits the action
- **RBAC is the standard**: Use it in all production clusters
- **Node authorizer** is special: specifically for kubelet access, keyed on cert format
- **CKA Focus**: `kubectl auth can-i`, understanding the module order, configuring `--authorization-mode`

---

## 11. Role-Based Access Control (RBAC)

### 🔍 What Is It?

RBAC (Role-Based Access Control) is Kubernetes's **primary authorization mechanism**. It allows cluster administrators to define fine-grained permissions for users, groups, and service accounts using two main constructs:

- **Role** / **ClusterRole**: Defines *what actions* can be performed on *which resources*
- **RoleBinding** / **ClusterRoleBinding**: Connects identities (users/groups/SAs) to roles

The power of RBAC lies in its **declarative, API-driven** approach. Unlike ABAC (which requires editing files and restarting the API server), RBAC changes take effect immediately through the Kubernetes API.

### 🏗️ RBAC Objects

| Object | Scope | Purpose |
|--------|-------|---------|
| **Role** | Namespace | Permissions within a single namespace |
| **ClusterRole** | Cluster | Permissions across all namespaces or for cluster-scoped resources |
| **RoleBinding** | Namespace | Binds a Role to subjects within a namespace |
| **ClusterRoleBinding** | Cluster | Binds a ClusterRole to subjects cluster-wide |

### 🔄 RBAC Decision Flow

```
Request: "Can user 'jane' create pods in namespace 'production'?"
         │
         ▼
Find all RoleBindings in 'production' that reference 'jane'
         │
         ├─ Found: jane → developer-role
         │
         ▼
Check developer-role rules:
         │
         ├─ apiGroups: [""]
         │  resources: ["pods"]
         │  verbs: ["get", "list", "create"]  ← "create" is here
         │
         ▼
ALLOW ✅
```

### 📋 Complete RBAC Configuration

```yaml
# rbac-developer-complete.yaml
# This is a production-ready RBAC setup for a developer team
# following least-privilege principles

---
# ROLE: Defines what actions can be performed
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: developer
  namespace: production          # Role is namespace-scoped
  labels:
    managed-by: platform-team
    purpose: developer-access
rules:
  # Core API group resources (pods, services, configmaps)
  - apiGroups: [""]
    resources: ["pods", "pods/log", "pods/exec"]
    verbs: ["get", "list", "watch"]  # Read-only for pods in prod
  
  - apiGroups: [""]
    resources: ["services", "endpoints"]
    verbs: ["get", "list", "watch"]
  
  - apiGroups: [""]
    resources: ["configmaps"]
    verbs: ["get", "list", "watch", "create", "update"]
    # NEVER allow 'delete' on configmaps in production without review
  
  # Apps group: deployments and replicasets
  - apiGroups: ["apps"]
    resources: ["deployments", "replicasets"]
    verbs: ["get", "list", "watch", "update"]
    # Update allows image updates via: kubectl set image
    # Notice: no 'create' or 'delete' — prevent accidental deployment creation
  
  # Allow log access for debugging
  - apiGroups: [""]
    resources: ["pods/log"]
    verbs: ["get"]
  
  # Restrict to specific pods by name (resourceNames)
  # Only allow exec into pods named 'debug-pod'
  - apiGroups: [""]
    resources: ["pods/exec"]
    verbs: ["create"]
    resourceNames: ["debug-pod"]  # Restricts to specific resource names

# Common Error: 403 Forbidden
# kubectl describe clusterrolebinding <name> to see subject mapping
# kubectl auth can-i <verb> <resource> --as=<user> --namespace=<ns>

---
# ROLEBINDING: Connects the role to subjects
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: developer-binding
  namespace: production
subjects:
  # Option 1: Specific user
  - kind: User
    name: jane
    apiGroup: rbac.authorization.k8s.io
  
  # Option 2: Group (all members of the group get this role)
  - kind: Group
    name: developers          # From OIDC/LDAP group claim or cert O= field
    apiGroup: rbac.authorization.k8s.io
  
  # Option 3: ServiceAccount (for automated tools)
  - kind: ServiceAccount
    name: deploy-bot
    namespace: production     # SA namespace must be specified
roleRef:                       # roleRef is immutable — delete and recreate to change
  kind: Role
  name: developer
  apiGroup: rbac.authorization.k8s.io
```

### 🔄 RBAC for CI/CD Pipeline

```yaml
# ci-cd-rbac.yaml
# Service account and RBAC for a deployment pipeline
# Following least-privilege: can deploy but not delete production data

---
apiVersion: v1
kind: ServiceAccount
metadata:
  name: cicd-deployer
  namespace: production
automountServiceAccountToken: false  # Mount explicitly per pod

---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: cicd-deploy-role
  namespace: production
rules:
  - apiGroups: ["apps"]
    resources: ["deployments"]
    verbs: ["get", "list", "create", "update", "patch"]
    # Deliberately excluded: delete (prevents pipeline from deleting deployments)
  
  - apiGroups: [""]
    resources: ["services", "configmaps"]
    verbs: ["get", "list", "create", "update", "patch"]

---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: cicd-deploy-binding
  namespace: production
subjects:
  - kind: ServiceAccount
    name: cicd-deployer
    namespace: production
roleRef:
  kind: Role
  name: cicd-deploy-role
  apiGroup: rbac.authorization.k8s.io
```

### 🔑 RBAC Verbs Reference

| Verb | HTTP Method | What It Does |
|------|-------------|--------------|
| `get` | GET /resource/name | Get a specific resource |
| `list` | GET /resource | List resources of this type |
| `watch` | GET /resource?watch=true | Watch for changes (long poll) |
| `create` | POST /resource | Create a new resource |
| `update` | PUT /resource/name | Replace entire resource |
| `patch` | PATCH /resource/name | Partial update |
| `delete` | DELETE /resource/name | Delete a resource |
| `deletecollection` | DELETE /resource | Delete all resources |
| `exec` | POST /pods/name/exec | Execute command in pod |
| `portforward` | POST /pods/name/portforward | Port forwarding |

### 🐛 Debugging RBAC

```bash
# Comprehensive RBAC debugging workflow

# 1. Check if user can perform action
kubectl auth can-i create deployments --as jane -n production
# Output: yes/no

# 2. If 'no', find what roles/bindings exist for the user
kubectl get rolebindings -n production -o yaml | grep -A 5 "jane"
kubectl get clusterrolebindings -o yaml | grep -A 5 "jane"

# 3. Describe a specific role to see its rules
kubectl describe role developer -n production

# 4. Check all permissions for a service account
kubectl auth can-i --list \
  --as=system:serviceaccount:production:myapp \
  --namespace=production

# 5. Find who has a specific permission
# (Requires kubectl with --subresource support or oc)
kubectl get rolebindings,clusterrolebindings -A -o json | \
  jq '.items[] | select(.roleRef.name=="cluster-admin") | .subjects'

# 6. Common error: "forbidden: User cannot get resource"
# Resolution path:
#   a) Identify the exact permission needed
#   b) kubectl auth can-i <verb> <resource> --as=<user>
#   c) Create/update role with the needed permissions
#   d) Bind the role to the user
```

### 📝 CKA Exam Tips

- Know the four RBAC object types: Role, ClusterRole, RoleBinding, ClusterRoleBinding
- `kubectl auth can-i` is the most important debugging command for RBAC
- The `roleRef` in RoleBinding/ClusterRoleBinding is **immutable** — delete and recreate to change
- `kubectl create role` and `kubectl create rolebinding` have imperative forms — know them
- A ClusterRole can be bound with a **RoleBinding** to limit it to a namespace

```bash
# Imperative RBAC creation (fast in exam)
kubectl create role developer --verb=get,list,create --resource=pods -n dev
kubectl create rolebinding dev-bind --role=developer --user=jane -n dev

# ClusterRole imperative
kubectl create clusterrole cluster-reader --verb=get,list,watch --resource=nodes
kubectl create clusterrolebinding jane-cluster-reader --clusterrole=cluster-reader --user=jane
```

---

### 🔎 Topic Summary: RBAC

- **RBAC = permission grants**: Role defines what; RoleBinding defines who gets what
- **Namespace vs Cluster scope**: Role/RoleBinding = namespace; ClusterRole/ClusterRoleBinding = cluster
- **Additive permissions**: Start with zero; explicitly grant what's needed
- **apiGroups matter**: `""` for core, `"apps"` for deployments, etc. — wrong group = 403 Forbidden
- **`resourceNames`**: Restrict roles to specific resource names for fine-grained control
- **Production principle**: One ServiceAccount per application, minimal verbs, narrow resources
- **CKA Focus**: Create roles/bindings imperatively, use `kubectl auth can-i` for verification

---

## 12. Cluster Roles & ClusterRoleBindings

### 🔍 What Is It?

ClusterRoles and ClusterRoleBindings extend RBAC beyond namespaces to the **cluster-wide scope**. They are necessary for:

1. **Cluster-scoped resources**: Nodes, PersistentVolumes, Namespaces, StorageClasses, ClusterRoles — these don't belong to any namespace, so namespace-scoped Roles can't govern them
2. **Cross-namespace access**: When a user needs the same permissions in every namespace (e.g., a cluster-wide monitoring agent)

### 🏗️ Namespaced vs Cluster-Scoped Resources

```bash
# List all NAMESPACED resources
kubectl api-resources --namespaced=true | head -20
# pods, services, configmaps, secrets, deployments, ingresses...

# List all CLUSTER-SCOPED resources  
kubectl api-resources --namespaced=false | head -20
# nodes, persistentvolumes, namespaces, storageclasses, clusterroles...
```

### 📋 ClusterRole & ClusterRoleBinding Examples

```yaml
# cluster-admin-rbac.yaml
# ClusterRole for a storage administrator
# They can manage PersistentVolumes (cluster-scoped) and StorageClasses

---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: storage-admin
rules:
  # PersistentVolumes are cluster-scoped — can ONLY be governed by ClusterRole
  - apiGroups: [""]
    resources: ["persistentvolumes"]
    verbs: ["get", "list", "watch", "create", "delete", "update"]
  
  # StorageClasses are cluster-scoped
  - apiGroups: ["storage.k8s.io"]
    resources: ["storageclasses"]
    verbs: ["get", "list", "watch", "create", "update", "delete"]
  
  # Node management — cluster-scoped
  - apiGroups: [""]
    resources: ["nodes"]
    verbs: ["get", "list", "watch"]

---
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: storage-admin-binding
subjects:
  - kind: User
    name: storage-admin-user
    apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole
  name: storage-admin
  apiGroup: rbac.authorization.k8s.io
```

### 🔑 ClusterRole Bound with RoleBinding (Hybrid Pattern)

A powerful pattern: **bind a ClusterRole with a namespace-scoped RoleBinding** to give namespace-limited access using a centrally-managed ClusterRole:

```yaml
# This grants the 'developer' ClusterRole ONLY in 'dev' namespace
# Pattern: ClusterRole (permission definition) + RoleBinding (scope limiting)
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: dev-namespace-access
  namespace: dev
subjects:
  - kind: User
    name: alice
    apiGroup: rbac.authorization.k8s.io
roleRef:
  kind: ClusterRole        # Referencing a ClusterRole, not a Role
  name: developer          # This ClusterRole is reused across teams
  apiGroup: rbac.authorization.k8s.io
```

### 📝 CKA Exam Tips

- Use `kubectl api-resources --namespaced=false` to identify cluster-scoped resources
- A ClusterRole can be used with a RoleBinding to limit scope to a namespace
- ClusterRoleBindings grant permissions cluster-wide (including all namespaces for namespaced resources)
- Kubernetes creates several default ClusterRoles: `cluster-admin`, `view`, `edit`, `admin`

---

### 🔎 Topic Summary: Cluster Roles & ClusterRoleBindings

- **ClusterRoles govern cluster-scoped resources**: nodes, PVs, namespaces, storageclasses
- **ClusterRoleBindings grant cluster-wide access** to namespaced resources
- **ClusterRole + RoleBinding = namespace-scoped access with centralized definition** (reusable)
- **Default ClusterRoles**: `cluster-admin` (all), `admin` (namespace-all), `edit`, `view`
- **`kubectl api-resources --namespaced=false`** lists resources that require ClusterRole
- **Production**: Use ClusterRoles for shared permission templates; bind with RoleBinding for namespaced scope
- **CKA Focus**: Know when to use ClusterRole vs Role, and when to use ClusterRoleBinding vs RoleBinding

---

## 13. Service Accounts

### 🔍 What Is It?

A Service Account is a **Kubernetes-native identity for workloads and automated processes**. Unlike human users (managed externally via OIDC/certs), service accounts are first-class Kubernetes API objects that provide a standardized way for:

- Pods to authenticate with the Kubernetes API
- External tools (CI/CD, monitoring) to interact with the cluster
- Operators and controllers to watch and modify cluster resources

Every namespace automatically gets a `default` service account. Every pod that doesn't specify a service account uses this default SA.

### 🔄 Service Account Token Evolution

Kubernetes has significantly evolved how SA tokens work:

| Version | Behavior |
|---------|---------|
| < 1.21 | Auto-created Secret with non-expiring token |
| 1.21-1.23 | TokenRequest API introduced; projected volumes used |
| ≥ 1.24 | No auto-created Secret tokens; use `kubectl create token` for temporary tokens |

### 📋 Complete Service Account Configuration

```yaml
# service-account-full.yaml
# Production-ready service account for a monitoring application

---
# ServiceAccount definition
apiVersion: v1
kind: ServiceAccount
metadata:
  name: prometheus-sa
  namespace: monitoring
  annotations:
    # AWS: IRSA (IAM Roles for Service Accounts) — no secret needed!
    eks.amazonaws.com/role-arn: arn:aws:iam::123456789012:role/prometheus-role
    # GCP: Workload Identity
    # iam.gke.io/gcp-service-account: prometheus@project.iam.gserviceaccount.com
automountServiceAccountToken: false  # SECURITY: Don't auto-mount; mount explicitly

---
# ClusterRole for Prometheus to read all metrics
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRole
metadata:
  name: prometheus-reader
rules:
  - apiGroups: [""]
    resources: ["nodes", "pods", "services", "endpoints"]
    verbs: ["get", "list", "watch"]
  - apiGroups: ["apps"]
    resources: ["deployments", "replicasets", "daemonsets", "statefulsets"]
    verbs: ["get", "list", "watch"]

---
# Bind the ClusterRole to the ServiceAccount
apiVersion: rbac.authorization.k8s.io/v1
kind: ClusterRoleBinding
metadata:
  name: prometheus-reader-binding
subjects:
  - kind: ServiceAccount
    name: prometheus-sa
    namespace: monitoring
roleRef:
  kind: ClusterRole
  name: prometheus-reader
  apiGroup: rbac.authorization.k8s.io

---
# Pod using the ServiceAccount with explicit token mount
apiVersion: v1
kind: Pod
metadata:
  name: prometheus
  namespace: monitoring
spec:
  serviceAccountName: prometheus-sa      # Use our dedicated SA
  automountServiceAccountToken: false    # Override at pod level (belt & suspenders)
  
  volumes:
    # Kubernetes 1.22+: Projected volume with time-bound token
    - name: prometheus-token
      projected:
        sources:
          - serviceAccountToken:
              audience: prometheus        # Audience binding
              expirationSeconds: 3600     # 1 hour — rotated automatically
              path: token
  
  containers:
    - name: prometheus
      image: prom/prometheus:v2.45.0
      volumeMounts:
        - name: prometheus-token
          mountPath: /var/run/secrets/kubernetes.io/serviceaccount
          readOnly: true

# ImagePullBackOff: Occurs if prometheus image tag doesn't exist
# Fix: kubectl describe pod prometheus -n monitoring | grep "Events:"
# Check: kubectl get events -n monitoring | grep prometheus

# CrashLoopBackOff: Often caused by missing RBAC permissions
# Fix: kubectl logs prometheus -n monitoring
# Check: kubectl auth can-i list pods --as=system:serviceaccount:monitoring:prometheus-sa
```

### 🔄 Creating Tokens (Kubernetes 1.24+)

```bash
# Create a time-limited token (recommended)
kubectl create token prometheus-sa -n monitoring --duration=24h

# For legacy tools that still need a Secret-based token:
kubectl apply -f - <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: prometheus-sa-token
  namespace: monitoring
  annotations:
    kubernetes.io/service-account.name: prometheus-sa
type: kubernetes.io/service-account-token
EOF

# Retrieve the token
kubectl get secret prometheus-sa-token -n monitoring -o jsonpath='{.data.token}' | base64 -d
```

### 🚀 Production Scenario

**Application**: Internal deployment tool (ArgoCD alternative)

**Service Account Design**:
- `argocd-application-controller`: ClusterRole with read access to all resources
- `argocd-server`: Namespace-scoped role for modifying deployments
- `argocd-repo-server`: No Kubernetes API access needed (only accesses Git)
- All SAs: `automountServiceAccountToken: false`; mounted via projected volumes only

**Security hardening**:
```bash
# Prevent all pods from auto-mounting SA tokens at namespace level
kubectl patch serviceaccount default -n production \
  -p '{"automountServiceAccountToken": false}'
```

---

### 🔎 Topic Summary: Service Accounts

- **Service Accounts = machine identity**: For pods, controllers, and automated tools
- **Default SA exists in every namespace** but has no permissions unless explicitly bound
- **`automountServiceAccountToken: false`** is a security best practice — mount only when needed
- **Kubernetes 1.24+ change**: No auto-created non-expiring tokens; use `kubectl create token` or projected volumes
- **TokenRequest API** creates time-bound, audience-bound, object-bound tokens — more secure
- **IRSA/Workload Identity**: Cloud-native way to give pods cloud IAM permissions without static credentials
- **CKA Focus**: Create SA, bind to role, configure pod with SA, understand token mounting behavior

---

## 14. Image Security

### 🔍 What Is It?

Image security in Kubernetes encompasses the **controls and practices** that ensure container images deployed to your cluster are trusted, unmodified, and sourced from authorized registries. In a production environment, image security is a critical attack vector — a compromised or malicious image can exfiltrate data, mine crypto, or serve as a pivot point for lateral movement.

### 🏗️ Container Image Naming

Understanding the full image reference format is essential:

```
registry/repository/image:tag@digest

Examples:
- nginx                           → docker.io/library/nginx:latest
- myorg/myapp:v1.2.3              → docker.io/myorg/myapp:v1.2.3
- gcr.io/google-containers/pause  → gcr.io/google-containers/pause:latest
- private-registry.io/apps/api    → private-registry.io/apps/api:latest
```

### 📋 Private Registry Configuration

```yaml
# private-registry-pod.yaml
# Pulling from a private registry with authentication

---
# Step 1: Create the registry credential secret
# kubectl create secret docker-registry regcred \
#   --docker-server=private-registry.company.com \
#   --docker-username=robot-account \
#   --docker-password=<secret> \
#   --docker-email=ci@company.com
#   -n production

# Or declaratively:
apiVersion: v1
kind: Secret
metadata:
  name: regcred
  namespace: production
type: kubernetes.io/dockerconfigjson
data:
  # Base64 encoded Docker config JSON
  .dockerconfigjson: eyJhdXRocyI6...  # kubectl create secret generates this

---
# Step 2: Reference in Pod spec
apiVersion: v1
kind: Pod
metadata:
  name: api-server
  namespace: production
spec:
  containers:
    - name: api
      image: private-registry.company.com/apps/api:v2.3.1
      # ImagePullBackOff troubleshooting:
      # 1. kubectl describe pod api-server | grep -A 20 "Events:"
      # 2. Check: is the secret in the SAME namespace as the pod?
      # 3. Check: is the image tag correct?
      # 4. Check: does the registry credential have pull permissions?
      # 5. kubectl get events -n production | grep ImagePull
  
  imagePullSecrets:
    - name: regcred  # Must be in the SAME namespace as the pod
  
  # Best practice: Always use specific tags, NEVER 'latest' in production
  # Specific tags: Reproducible deployments, easy rollback
  # 'latest': Non-deterministic, breaks idempotency, security risk

# Common Errors:
# ImagePullBackOff → wrong registry URL, bad credentials, non-existent tag
# ErrImagePull → transient network issue or auth failure
# Fix: kubectl describe pod <name> | grep "Failed to pull"
# Fix: docker login <registry> to test credentials manually
```

### 🏛️ Image Security Architecture

```
┌────────────────────────────────────────────────────────────────┐
│                  IMAGE SECURITY LAYERS                          │
│                                                                 │
│  1. SOURCE CONTROL                                              │
│     Dockerfile → Git → Build pipeline                          │
│     ↓ OPA/Conftest validates Dockerfile                        │
│                                                                 │
│  2. BUILD & SCAN                                                │
│     Docker build → Trivy/Snyk/Clair scans image                │
│     ↓ Fail build if critical CVEs found                        │
│                                                                 │
│  3. SIGN & PUSH                                                 │
│     cosign sign image → Push to private registry               │
│     ↓ Image digest recorded                                    │
│                                                                 │
│  4. ADMISSION CONTROL (Deploy time)                            │
│     Kubernetes admission webhook verifies:                      │
│     - Image from approved registry only                        │
│     - Image has valid cosign signature                         │
│     - No 'latest' tag                                          │
│                                                                 │
│  5. RUNTIME MONITORING                                          │
│     Falco monitors syscalls for suspicious behavior            │
└────────────────────────────────────────────────────────────────┘
```

### 🚀 Production Image Security Practices

```bash
# 1. Always pin to digest (most secure)
image: nginx@sha256:a8281ce42034b5d21a9db... # Immutable reference

# 2. Use specific version tags (acceptable)
image: nginx:1.25.3  # Known, reproducible

# 3. NEVER do this in production
image: nginx:latest  # Non-deterministic, breaks rollback

# Scan images for vulnerabilities
trivy image --severity HIGH,CRITICAL nginx:1.25.3

# Sign images with cosign
cosign sign --key cosign.key private-registry.io/myapp:v1.0.0

# Verify signature
cosign verify --key cosign.pub private-registry.io/myapp:v1.0.0
```

### 📝 CKA Exam Tips

- Know how to create a `docker-registry` type Secret
- The imagePullSecret must be in the **same namespace** as the pod
- You can add imagePullSecrets to a ServiceAccount (so all pods using that SA inherit them)
- Know the full image name format: `registry/user/image:tag`

---

### 🔎 Topic Summary: Image Security

- **Image naming**: `registry/repository/image:tag` — default registry is `docker.io`
- **Private registries**: Require `kubernetes.io/dockerconfigjson` type Secrets
- **`imagePullSecrets`**: Must be in the same namespace as the pod consuming it
- **Never use `latest` in production**: Use specific tags or digests for reproducibility and security
- **Image scanning**: Integrate Trivy/Snyk in CI/CD to catch CVEs before deployment
- **Image signing**: cosign + admission webhooks verify image provenance at deploy time
- **CKA Focus**: Create docker-registry Secrets, add to pod spec, troubleshoot ImagePullBackOff

---

## 15. Security Contexts

### 🔍 What Is It?

A Security Context in Kubernetes defines **privilege and access control settings for a pod or container**. It's the mechanism that translates container-level security concerns into kernel-level Linux security controls. Security contexts control:

- **Which user/group** the process runs as
- **Linux capabilities** (what privileged operations are allowed)
- **Seccomp profiles** (which syscalls are permitted)
- **SELinux/AppArmor labels**
- **File system mount options**
- **Privilege escalation restrictions**

Security contexts are the **most direct way to apply defense-in-depth** to running workloads. A properly configured security context can contain a compromised container and prevent it from affecting the host or other pods.

### 🏗️ Security Context Scope

- **Pod-level**: Applies to all containers in the pod (unless overridden at container level)
- **Container-level**: Applies to a specific container, overrides pod-level settings

```yaml
# security-context-complete.yaml
# Production-hardened pod with comprehensive security context
# This configuration significantly reduces the attack surface

apiVersion: v1
kind: Pod
metadata:
  name: hardened-app
  namespace: production
spec:
  # Pod-level security context — applies to ALL containers
  securityContext:
    runAsUser: 1000              # Don't run as root (UID 0)
    runAsGroup: 3000             # Set GFS group
    fsGroup: 2000                # Files created in volumes owned by this group
    runAsNonRoot: true           # Kubernetes-level check: fail if container tries to run as root
    seccompProfile:              # Restrict system calls (Kubernetes 1.19+)
      type: RuntimeDefault       # Use the container runtime's default seccomp profile
    # OOMKilled mitigation: securityContext won't prevent OOMKilled
    # OOMKilled is caused by containers exceeding memory limits
    # Fix OOMKilled: increase memory limits in container resources section
  
  containers:
    - name: app
      image: myapp:v1.2.3
      
      # Container-level security context — overrides pod-level
      securityContext:
        allowPrivilegeEscalation: false  # Prevents setuid binaries from gaining root
        readOnlyRootFilesystem: true     # Container FS is read-only (prevents file tampering)
        runAsNonRoot: true               # Belt & suspenders
        
        # Linux Capabilities — control fine-grained privileges
        capabilities:
          drop:
            - ALL          # Drop ALL capabilities by default
          add:
            - NET_BIND_SERVICE  # Only add what's needed (bind to port < 1024)
            # Common caps to add only if absolutely required:
            # - CHOWN: Change file ownership
            # - NET_ADMIN: Network administration
            # WARNING: Avoid CAP_SYS_ADMIN — essentially root-equivalent
      
      # If readOnlyRootFilesystem: true, writable volumes must be explicit
      volumeMounts:
        - name: tmp
          mountPath: /tmp    # App needs to write temp files
        - name: logs
          mountPath: /app/logs
      
      resources:
        requests:
          memory: "64Mi"     # Low memory can cause OOMKilled
          cpu: "100m"        # CPU throttling if request too low
        limits:
          memory: "128Mi"
          cpu: "500m"
          # OOMKilled: Container used more than 128Mi → killed by kernel
          # kubectl describe pod <name> | grep "OOMKilled"
          # Fix: Increase limits.memory or optimize app memory usage
  
  volumes:
    - name: tmp
      emptyDir: {}     # In-memory ephemeral storage
    - name: logs
      emptyDir: {}

# CPU Throttling: Happens when container hits cpu.limits
# Symptom: Slow application, high latency
# Fix: Increase cpu.limits or optimize code
# Check: kubectl top pod <name>
# Metrics: container_cpu_cfs_throttled_periods_total in Prometheus
```

### 🔑 Pod Security Standards (PSS) — Kubernetes 1.25+

Pod Security Standards replaced PodSecurityPolicy. Three levels:

| Level | Description | Use Case |
|-------|-------------|----------|
| **Privileged** | No restrictions | System/infra pods (CNI, CSI drivers) |
| **Baseline** | Minimal restrictions | Most workloads |
| **Restricted** | Hardened — matches security context best practices | Production workloads |

```bash
# Apply Pod Security Standards to a namespace
kubectl label namespace production \
  pod-security.kubernetes.io/enforce=restricted \
  pod-security.kubernetes.io/warn=restricted \
  pod-security.kubernetes.io/audit=restricted

# Test: try to create a privileged pod in this namespace
kubectl run test --image=nginx --privileged -n production
# Error: pods "test" is forbidden: violates PodSecurity "restricted:latest"
```

### 🐛 Debugging Security Context Issues

```bash
# Check if pod was killed due to security context violation
kubectl describe pod <pod-name> | grep -E "OOMKilled|Failed|Error|Reason"

# Check container exit code (137 = OOMKilled, 1 = app error)
kubectl get pod <pod-name> -o jsonpath='{.status.containerStatuses[0].lastState.terminated.exitCode}'

# Check if running as correct user
kubectl exec <pod-name> -- id
kubectl exec <pod-name> -- whoami

# List capabilities
kubectl exec <pod-name> -- cat /proc/1/status | grep Cap
capsh --decode=00000000a80425fb  # decode capabilities

# Check if privilege escalation is possible
kubectl exec <pod-name> -- cat /proc/1/status | grep NoNewPrivs
```

---

### 🔎 Topic Summary: Security Contexts

- **Security contexts control**: User/group, capabilities, read-only FS, privilege escalation, seccomp
- **Pod level** applies to all containers; **container level** overrides pod level
- **Best practices**: `runAsNonRoot`, `readOnlyRootFilesystem`, `allowPrivilegeEscalation: false`, `drop: [ALL]`
- **Pod Security Admission** (since 1.25): Namespace-level enforcement of `restricted`/`baseline`/`privileged`
- **OOMKilled**: Container exceeded memory limit → killed by kernel; fix by increasing `limits.memory`
- **CPU Throttling**: Container hitting cpu.limits → increase limits or optimize
- **CKA Focus**: Configure security context at pod and container level, know what each field does

---

## 16. Network Policies

### 🔍 What Is It?

A Network Policy is a Kubernetes resource that controls **which pods can communicate with which other pods, services, and external endpoints**. By default, Kubernetes allows all traffic between all pods — a "flat network" where any pod can reach any other pod. Network policies change this to a **zero-trust model**: all traffic is denied unless explicitly permitted.

Network policies are the Kubernetes equivalent of **firewall rules at the application layer** (L3/L4).

**Critical**: Network policies are enforced by the **CNI plugin** — not by Kubernetes itself. Your CNI plugin must support NetworkPolicy (Calico, Cilium, Weave Net, Antrea do; Flannel does NOT enforce policies).

### 🔄 How Network Policies Work

```
Without NetworkPolicy:
Pod A → Pod B → Pod C  (all traffic allowed)

With NetworkPolicy:
Pod A → [NetworkPolicy: only API pods can access DB] → Pod C (only if A is API pod)
Pod B → [BLOCKED] → Pod C
```

### 🏛️ Architecture: Traffic Flow with NetworkPolicies

```
Internet/External
      │
      │
  ┌───┴────────────────────────────────────────────────┐
  │                  Kubernetes Cluster                  │
  │                                                      │
  │  [frontend pod]                                      │
  │       │ NetworkPolicy: allow egress to backend:3000  │
  │       ▼                                              │
  │  [backend pod]                                       │
  │       │ NetworkPolicy: allow egress to database:5432 │
  │       ▼                                              │
  │  [database pod]                                      │
  │    NetworkPolicy: ONLY allow ingress from backend    │
  │    All other ingress → BLOCKED by CNI               │
  └──────────────────────────────────────────────────────┘
```

### 📋 Network Policy Examples

```yaml
# network-policy-complete.yaml
# Production-ready 3-tier application network policy

---
# POLICY 1: Default deny all ingress and egress for the production namespace
# Start with deny-all, then explicitly allow what's needed
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-all
  namespace: production
spec:
  podSelector: {}          # Empty selector = applies to ALL pods in namespace
  policyTypes:
    - Ingress
    - Egress               # Deny ALL ingress AND egress
  # No rules = no allowed traffic

---
# POLICY 2: Allow DNS (critical — without this, pods can't resolve hostnames)
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: allow-dns
  namespace: production
spec:
  podSelector: {}
  policyTypes:
    - Egress
  egress:
    - ports:
        - port: 53
          protocol: UDP
        - port: 53
          protocol: TCP    # DNS over TCP for large responses

---
# POLICY 3: Database pod — only allow backend pods to connect on port 5432
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: database-network-policy
  namespace: production
spec:
  podSelector:
    matchLabels:
      role: database         # This policy applies to pods labeled 'role: database'
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        # AND condition: pod selector AND namespace selector
        - podSelector:
            matchLabels:
              role: backend   # Only backend pods
          namespaceSelector:
            matchLabels:
              environment: production  # Only from production namespace

        # OR condition: also allow from backup server
        - ipBlock:
            cidr: 10.10.5.0/24        # Backup server IP range
            except:
              - 10.10.5.10/32          # Except this specific IP
      ports:
        - protocol: TCP
          port: 5432                  # PostgreSQL

  egress:
    - to:
        - ipBlock:
            cidr: 10.10.5.0/24        # Backup server
      ports:
        - protocol: TCP
          port: 443                    # HTTPS backup exporter

---
# POLICY 4: Backend pod — allow from frontend, allow to database
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: backend-network-policy
  namespace: production
spec:
  podSelector:
    matchLabels:
      role: backend
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              role: frontend
      ports:
        - protocol: TCP
          port: 3000
  egress:
    - to:
        - podSelector:
            matchLabels:
              role: database
      ports:
        - protocol: TCP
          port: 5432

# IMPORTANT: AND vs OR in podSelector + namespaceSelector
# AND (pod AND namespace must match):
#   from:
#   - podSelector: {matchLabels: {role: backend}}
#     namespaceSelector: {matchLabels: {env: prod}}  # Same list item = AND
#
# OR (pod OR namespace):
#   from:
#   - podSelector: {matchLabels: {role: backend}}    # Separate list items = OR
#   - namespaceSelector: {matchLabels: {env: prod}}
```

### 🐛 Debugging Network Policies

```bash
# Test connectivity between pods
kubectl exec -it frontend-pod -- curl -v http://backend-svc:3000
kubectl exec -it frontend-pod -- nc -zv database-svc 5432

# If connection fails, check NetworkPolicies
kubectl get networkpolicies -n production
kubectl describe networkpolicy database-network-policy -n production

# Check CNI support for NetworkPolicy
kubectl get pods -n kube-system | grep -E "calico|cilium|weave"

# For Calico: check policy evaluation
calicoctl get networkpolicy -A

# Temporarily delete policy to test (DANGEROUS in production!)
kubectl delete networkpolicy database-network-policy -n production
# Test if connectivity works → if yes, policy was blocking
# Restore the policy immediately!
```

### 📝 CKA Exam Tips

- Empty `podSelector: {}` applies to ALL pods in the namespace
- Policies with empty rules (no ingress/egress rules listed) mean **all traffic of that type is blocked**
- Items in the same list entry are AND conditions; separate entries are OR conditions
- Always add an `allow-dns` policy after default-deny-all, or pods can't resolve names
- `policyTypes` must explicitly list `Ingress` and/or `Egress` to activate those directions

---

### 🔎 Topic Summary: Network Policies

- **Default allow → explicit deny-all → explicit allow**: The secure network policy pattern
- **CNI must support it**: Flannel does NOT enforce NetworkPolicies; use Calico, Cilium, or Weave Net
- **podSelector + namespaceSelector AND/OR**: Same list entry = AND; separate entries = OR
- **Always allow DNS** after default-deny-all: port 53 UDP/TCP to kube-dns
- **policyTypes** must be explicitly listed; not specifying Egress = egress is uncontrolled
- **Production**: Default-deny-all first, then explicit allow per service boundary
- **CKA Focus**: Write NetworkPolicy YAML, understand AND/OR logic, know which CNIs support it

---

## 17. Custom Resource Definitions (CRDs)

### 🔍 What Is It?

A Custom Resource Definition (CRD) is a Kubernetes API extension mechanism that lets you **define your own resource types** within Kubernetes. Once registered, these custom resources behave exactly like native resources: they're stored in etcd, accessible via kubectl, support RBAC, and can be watched by controllers.

CRDs are the foundation of the Kubernetes **operator pattern** — they allow complex, stateful applications (databases, message queues, ML pipelines) to be managed using Kubernetes-native APIs.

### 🔄 CRD Architecture

```
Without CRD:
kubectl apply -f flightticket.yaml
→ Error: no matches for kind "FlightTicket"

With CRD registered:
kubectl apply -f crd.yaml           # Register the new resource type
kubectl apply -f flightticket.yaml  # Create a FlightTicket object
→ FlightTicket stored in etcd

With CRD + Controller:
kubectl apply -f flightticket.yaml  → Stored in etcd
                                    → Controller detects new FlightTicket
                                    → Controller calls bookflight.com API
                                    → FlightTicket status updated
```

### 📋 CRD Example with OpenAPI Validation

```yaml
# flightticket-crd.yaml
# Custom Resource Definition for managing flight ticket bookings
# CRDs extend the Kubernetes API with domain-specific resource types

apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  # Name format MUST be: <plural>.<group>
  name: flighttickets.flights.company.com
spec:
  group: flights.company.com      # API group for this resource
  scope: Namespaced                # Namespaced or Cluster
  
  names:
    plural: flighttickets          # kubectl get flighttickets
    singular: flightticket         # kubectl get flightticket <name>
    kind: FlightTicket             # Used in YAML: kind: FlightTicket
    shortNames:
      - ft                         # kubectl get ft
    categories:
      - all                        # Included in: kubectl get all
  
  versions:
    - name: v1
      served: true                 # This version is served by the API
      storage: true                # This version is stored in etcd
      
      # OpenAPI v3 validation schema — validates CR before storing
      schema:
        openAPIV3Schema:
          type: object
          required: ["spec"]
          properties:
            spec:
              type: object
              required: ["from", "to", "passengers"]
              properties:
                from:
                  type: string
                  minLength: 3
                  maxLength: 3     # IATA airport code (e.g., "LHR")
                to:
                  type: string
                  minLength: 3
                  maxLength: 3
                passengers:
                  type: integer
                  minimum: 1
                  maximum: 9
                class:
                  type: string
                  enum: ["economy", "business", "first"]
                  default: "economy"
            status:
              type: object
              properties:
                phase:
                  type: string
                  enum: ["Pending", "Confirmed", "Cancelled"]
                bookingReference:
                  type: string
      
      # Add status and scale subresources
      subresources:
        status: {}                 # Enables .status updates via /status subresource
      
      # Define additional printer columns for kubectl get output
      additionalPrinterColumns:
        - name: From
          type: string
          jsonPath: .spec.from
        - name: To
          type: string
          jsonPath: .spec.to
        - name: Status
          type: string
          jsonPath: .status.phase
        - name: Age
          type: date
          jsonPath: .metadata.creationTimestamp
```

```yaml
# flightticket-example.yaml
# An instance of the custom FlightTicket resource
apiVersion: flights.company.com/v1
kind: FlightTicket
metadata:
  name: london-trip
  namespace: travel
spec:
  from: "BOM"      # Mumbai
  to: "LHR"        # London Heathrow
  passengers: 2
  class: business
```

### 🔄 CRD Workflow Commands

```bash
# Register the CRD
kubectl apply -f flightticket-crd.yaml

# Verify CRD is registered
kubectl get crd
kubectl describe crd flighttickets.flights.company.com

# Create a FlightTicket instance
kubectl apply -f flightticket-example.yaml

# Interact with FlightTicket just like native resources
kubectl get flighttickets -n travel
kubectl get ft -A  # Using short name
kubectl describe flightticket london-trip -n travel

# Update FlightTicket
kubectl patch flightticket london-trip -n travel \
  --type=json -p='[{"op":"replace","path":"/spec/class","value":"first"}]'

# Delete FlightTicket
kubectl delete flightticket london-trip -n travel

# RBAC for CRDs: same as native resources
kubectl create role ft-reader \
  --verb=get,list,watch \
  --resource=flighttickets.flights.company.com \
  -n travel
```

---

### 🔎 Topic Summary: Custom Resource Definitions (CRDs)

- **CRDs extend the K8s API**: Define your own resource types stored in etcd, accessible via kubectl
- **CRD = schema definition**: Registers a new resource type with validation, versioning, and printer columns
- **Custom Resource = instance**: An object of the custom type; stored and managed like native resources
- **Without a controller**: CR is just data; no actions happen automatically
- **With a controller**: Controller watches CRs and takes actions (call APIs, create/modify resources)
- **OpenAPI validation**: Define the schema to catch errors at admission time
- **CKA Focus**: Create CRDs from YAML, interact with custom resources, understand the operator pattern

---

## 18. Custom Controllers

### 🔍 What Is It?

A Custom Controller is a **running process** (typically in Go) that watches for changes to Custom Resources (or native Kubernetes resources) and **reconciles the actual state with the desired state**. The controller is the "brains" of the operator pattern — the CRD defines what, and the controller makes it happen.

Every native Kubernetes controller (deployment controller, replicaset controller, etc.) follows the same pattern: **watch** → **detect delta** → **act** → **repeat**.

### 🔄 Controller Architecture

```
                    Kubernetes API (etcd)
                          │
                          │ Watch FlightTickets
                          ▼
┌─────────────────────────────────────────────────────┐
│                  Custom Controller                   │
│                                                      │
│  Informer (caches + watches)                        │
│       │                                             │
│       ▼ Object created/updated/deleted              │
│  Work Queue (rate-limited, dedup)                   │
│       │                                             │
│       ▼                                             │
│  Reconcile Loop                                     │
│    ├── Get current state from API                  │
│    ├── Compare with desired state                  │
│    ├── IF delta exists:                            │
│    │     → Call bookflight.com API                 │
│    │     → Update FlightTicket.status              │
│    └── IF no delta: nothing to do                  │
└─────────────────────────────────────────────────────┘
```

### 🔑 Key Concepts in Custom Controllers

1. **Informers**: Cache resources locally + deliver events when things change → reduces API server load
2. **Work Queue**: Deduplicates and rate-limits reconcile requests
3. **Reconciliation**: Idempotent function that brings actual state to desired state
4. **Leader Election**: Multiple controller replicas run, but only one is active — prevents split-brain

```bash
# Deploy a custom controller as a Deployment
# The controller watches for FlightTicket objects and books flights

kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: flight-controller
  namespace: flight-system
spec:
  replicas: 2                    # 2 replicas for HA; leader election picks active one
  selector:
    matchLabels:
      app: flight-controller
  template:
    metadata:
      labels:
        app: flight-controller
    spec:
      serviceAccountName: flight-controller-sa  # Needs RBAC to watch FlightTickets
      containers:
      - name: controller
        image: company.registry.io/flight-controller:v1.2.3
        args:
          - --leader-elect=true   # Enable leader election
          - --leader-elect-namespace=flight-system
EOF
```

---

### 🔎 Topic Summary: Custom Controllers

- **Controllers = the operational logic**: CRD defines the API; controller makes things happen
- **Reconcile loop**: Idempotent function that continuously drives actual state to desired state
- **Informers + Work Queue**: Efficient event handling with local caching to reduce API load
- **Leader election**: Required for HA controller deployments — only one reconciles at a time
- **Written in Go** typically using `controller-runtime` or `client-go` libraries
- **Sample-controller on GitHub**: Official example to clone and modify for custom logic
- **CKA Focus**: Understand the operator pattern conceptually; know that controllers watch for changes and act

---

## 19. Operator Framework

### 🔷 What Is the Operator Framework?

The **Operator Framework** is a toolkit that packages a **Custom Resource Definition (CRD)** and a **Custom Controller** together into a single deployable unit called an **Operator**. It encodes human operational knowledge — installation, upgrades, backups, failover, and scaling — into software that runs natively inside Kubernetes using the same reconciliation loop that powers Deployments, StatefulSets, and ReplicaSets.

Think of it this way:
- A **Deployment controller** knows how to keep N replicas of a generic pod running
- An **Operator** knows how to keep a **PostgreSQL cluster**, **Kafka broker**, or **etcd cluster** fully healthy — including all complex Day-2 operational tasks a DBA or platform engineer would normally perform manually

The Operator pattern represents the **highest form of Kubernetes automation** — moving from infrastructure-as-code to **operations-as-code**.

---

### 🔷 Why Do We Need It?

**Without Operators:**
- CRDs and Controllers must be deployed separately — coordination overhead, error-prone
- Day-2 operations such as backup, restore, failover, and rolling upgrades require **manual human intervention**
- Every team needs deep specialized knowledge about each stateful application
- No standardized Kubernetes-native interface for full application lifecycle management
- Scaling a database cluster means manual SSH and command execution on nodes

**With Operators:**
- CRD and Controller are **packaged and deployed as a single atomic unit**
- Operational knowledge is **automated and codified** inside Go, Ansible, or Helm logic
- Teams interact using simple Kubernetes YAML — the Operator handles all complexity underneath
- Self-healing, self-scaling, and self-upgrading applications become achievable
- Consistent behavior enforced across dev, staging, and production environments

---

### 🔷 Core Components

| Component | Role |
|---|---|
| **CRD (Custom Resource Definition)** | Defines the new resource type schema in the Kubernetes API |
| **Custom Controller** | Watches CR objects and runs reconciliation business logic |
| **Operator Lifecycle Manager (OLM)** | Manages Operator install, upgrade, and dependency resolution |
| **OperatorHub.io** | Public catalog of 300+ community and vendor Operators |
| **Operator SDK** | Framework to build Operators in Go, Ansible, or Helm |
| **ClusterServiceVersion (CSV)** | Operator metadata — RBAC permissions, owned CRDs, description |
| **Subscription** | OLM object that tracks desired Operator channel and update strategy |

---

### 🔷 Internal Working — Step-by-Step Flow

```
Step 1:  Admin installs OLM on cluster
Step 2:  Admin applies Operator YAML or installs from OperatorHub
Step 3:  OLM creates CRD and deploys Controller as a Pod/Deployment
Step 4:  User creates a Custom Resource object
         Example: PostgresCluster with 3 replicas, 100Gi storage
Step 5:  kube-apiserver validates CR against CRD schema and stores in etcd
Step 6:  Controller Informer/Watcher detects new CR via kube-apiserver Watch API
Step 7:  CR event placed onto Controller internal work queue
Step 8:  Worker goroutine dequeues item and runs Reconcile() function
Step 9:  Reconcile() reads desired state from CR .spec
Step 10: Reconcile() queries actual cluster state (StatefulSets, Pods, Services, PVCs)
Step 11: Reconcile() computes diff and creates/updates/deletes resources to close the gap
Step 12: Controller updates CR .status subresource with current observed state
Step 13: Loop runs continuously — any drift immediately triggers re-reconciliation
Step 14: On failure → Controller auto-heals by restarting pods,
         promoting replica to primary, or triggering backup restore
```

---

### 🔷 Architecture Flow

```
┌─────────────────────────────────────────────────────────────────────┐
│                           Control Plane                             │
│                                                                     │
│  ┌──────────────────┐  ┌���─────────────────┐  ┌──────────────────┐  │
│  │  kube-apiserver  │  │      etcd         │  │       OLM        │  │
│  │                  │◄─►  (stores all CR   │  │  (manages        │  │
│  │  Validates CR    │  │   objects and     │  │   Operator       │  │
│  │  against CRD     │  │   desired state)  │  │   lifecycle)     │  │
│  └────────┬─────────┘  └──────────────────┘  └──────────────────┘  │
│           │                                                          │
│           │  Watch API (Informer — long-lived HTTP connection)       │
│           ▼                                                          │
│  ┌──────────────────────────────────────────────────────────────┐   │
│  │              Custom Controller Pod                            │   │
│  │                                                              │   │
│  │  Informer → Delta FIFO Queue → Worker → Reconcile()          │   │
│  │                                              │               │   │
│  │                               Read CR spec   │               │   │
│  │                               Query cluster  │               │   │
│  │                               Compute diff   │               │   │
│  │                               Apply changes  │               │   │
│  └──────────────────────────────────────────────┬──────────────┘   │
└─────────────────────────────────────────────────┼───────────────────┘
                                                  │
                    Creates/Updates/Deletes        │
                                                  ▼
┌─────────────────────────────────────────────────────────────────────┐
│                           Worker Nodes                              │
│                                                                     │
│  StatefulSet Pods   Services   PersistentVolumeClaims   Secrets     │
│  (Managed Application — PostgreSQL, Kafka, etcd, etc.)              │
└─────────────────────────────────────────────────────────────────────┘
```

---

### 🔷 How Operator Integrates With Other Kubernetes Components

- **etcd** — stores all CR objects and their desired state persistently
- **kube-apiserver** — receives all CR CRUD operations; Controller watches via Informer
- **kubelet** — runs both the Controller pods and the managed application pods on worker nodes
- **RBAC** — Operator requires ClusterRole/ClusterRoleBinding to watch, create, update resources
- **PersistentVolumes** — Operator provisions, expands, and manages storage for stateful apps
- **Secrets** — Operator creates, rotates, and manages application credentials automatically
- **OLM** — manages the Operator's own lifecycle: install, upgrade, conflict detection
- **Prometheus** — Operators expose metrics endpoints; Prometheus scrapes for observability

---

### 🔷 Real-World Production Scenario

**Application Type:** Production-grade PostgreSQL database cluster on Kubernetes

**Infrastructure:**
- AWS EKS, 3 master nodes, 6 worker nodes across 3 Availability Zones
- Operator Used: Crunchy Data PostgreSQL Operator (PGO)
- Storage: EBS CSI driver with gp3 StorageClass

**Deployment Flow:**
1. Install OLM on EKS cluster using official install script
2. Create a namespace `postgres-operator` for Operator isolation
3. Deploy PostgreSQL Operator from OperatorHub via a Subscription object
4. OLM installs CSV, creates CRDs: PostgresCluster, PGUpgrade, PGBackup
5. Create a `PostgresCluster` CR specifying replicas, storage size, backup schedule
6. Operator creates Primary StatefulSet, Replica StatefulSets, PGBouncer Deployment
7. PVCs backed by EBS gp3 volumes provisioned per pod via CSI driver
8. Operator creates Secrets for superuser, replication user, app user credentials
9. Operator configures pgBackRest for S3-backed continuous WAL archiving

**Security Considerations:**
- Operator ClusterRole scoped to only PostgreSQL-related resources
- All credentials in Kubernetes Secrets encrypted at rest via AWS KMS
- Network Policies restrict direct pod communication — only app pods reach PostgreSQL Service
- TLS enforced between app and PostgreSQL using auto-rotated certificates

**Scaling Strategy:**
- Update `replicas` field in PostgresCluster CR
- Operator detects change, creates new Replica StatefulSet, waits for sync
- Load balancer Service updated to include new replica in read pool

**Monitoring and Alerting:**
- Operator sidecar exports PostgreSQL metrics via postgres_exporter
- Prometheus scrapes metrics endpoint
- Grafana dashboard shows replication lag, connection pool saturation, transaction rate
- PagerDuty alert fires if replication lag exceeds 30 seconds

**Failure and Recovery:**
- Primary pod crashes → Operator detects within seconds via Watch API
- Operator promotes the most up-to-date replica to new primary
- Updates Service endpoints to point to new primary
- Sends notification via webhook → Slack alert to on-call team
- Accidental data deletion → Operator restores from latest S3 WAL backup using pgBackRest

---

### 🔷 YAML Example — CRD, CR, and Operator Deployment

```yaml
# Step 1: Custom Resource Definition
# Tells Kubernetes about the new PostgresCluster resource type
# Must be applied BEFORE any PostgresCluster CR objects are created
# Error without CRD: "no matches for kind PostgresCluster"
apiVersion: apiextensions.k8s.io/v1
kind: CustomResourceDefinition
metadata:
  name: postgresclusters.postgres-operator.crunchydata.com
spec:
  group: postgres-operator.crunchydata.com
  scope: Namespaced
  names:
    plural: postgresclusters
    singular: postgrescluster
    kind: PostgresCluster
    shortNames:
    - pgc
  versions:
  - name: v1beta1
    served: true
    storage: true
    schema:
      openAPIV3Schema:
        type: object
        properties:
          spec:
            type: object
            properties:
              postgresVersion:
                type: integer
                minimum: 13
              instances:
                type: array
              backups:
                type: object

---
# Step 2: Custom Resource (CR)
# User creates this to request a PostgreSQL cluster
# Operator watches for this and acts on it
# CrashLoopBackOff on Operator pod → check RBAC permissions
# kubectl describe pod <operator-pod> -n postgres-operator
apiVersion: postgres-operator.crunchydata.com/v1beta1
kind: PostgresCluster
metadata:
  name: production-pg
  namespace: databases
spec:
  postgresVersion: 15

  instances:
  - name: primary
    replicas: 3
    # Missing resource limits → OOMKilled risk under heavy query load
    # Check: kubectl describe pod production-pg-primary-0
    resources:
      requests:
        memory: "2Gi"
        cpu: "1000m"
      limits:
        memory: "4Gi"
        cpu: "2000m"
    dataVolumeClaimSpec:
      accessModes:
      - ReadWriteOnce
      resources:
        requests:
          storage: 100Gi
      storageClassName: ebs-gp3

  backups:
    pgbackrest:
      repos:
      - name: repo1
        s3:
          bucket: "prod-pg-backups"
          endpoint: "s3.amazonaws.com"
          region: "us-east-1"

---
# Step 3: OLM Subscription
# Tells OLM to install and keep the Operator updated
# channel: stable → production-safe releases only
# installPlanApproval: Manual → require human approval before upgrades
# Automatic → Operator upgrades without approval (risky in production)
apiVersion: operators.coreos.com/v1alpha1
kind: Subscription
metadata:
  name: postgresql-operator
  namespace: postgres-operator
spec:
  channel: v5
  name: postgresql
  source: operatorhubio-catalog
  sourceNamespace: olm
  installPlanApproval: Manual
```

---

### 🔷 Benefits

- Encapsulates complex operational knowledge into reusable, shareable software
- Dramatically reduces human error during Day-2 operations
- Enables truly self-healing infrastructure for stateful applications
- Provides a declarative management interface using standard Kubernetes YAML
- Operators are reusable across teams, clusters, and environments
- Reduces mean time to recovery (MTTR) through automated failure response

---

### 🔷 Common Use Cases

- Database management — PostgreSQL, MySQL, MongoDB, CockroachDB, Cassandra
- Message queue management — Kafka, RabbitMQ, NATS
- Monitoring stacks — Prometheus Operator, Grafana Operator, Alertmanager
- Service mesh lifecycle — Istio Operator, Linkerd
- Certificate management — cert-manager Operator
- etcd cluster management — etcd Operator
- Elasticsearch cluster management — ECK (Elastic Cloud on Kubernetes)

---

### 🔷 Common Mistakes

- Installing an Operator **without installing OLM first** — Operator pod creation fails silently
- Not granting sufficient RBAC permissions to Operator — reconciliation loop fails with Forbidden errors
- Running **multiple conflicting versions** of the same Operator — CRD schema conflicts
- Deleting an Operator **without cleaning up CRDs** — orphaned CR objects remain in cluster indefinitely
- Ignoring Operator upgrade paths — breaking changes in CRD schema between major versions cause data loss
- Using `installPlanApproval: Automatic` in production — unexpected Operator upgrades break running applications
- Not monitoring Operator controller logs — silent failures go undetected

---

### 🔷 Debugging and Troubleshooting

```bash
# Check if OLM is installed and healthy
kubectl get pods -n olm

# Check Operator pod status and restart count
kubectl get pods -n <operator-namespace>

# Read Operator controller logs for reconciliation errors
kubectl logs -n <operator-namespace> <operator-pod-name> -f

# Check all CRDs registered by the Operator
kubectl get crd | grep <operator-group>

# Check CR object status and events
kubectl describe <custom-resource-kind> <cr-name> -n <namespace>

# Check RBAC permissions granted to Operator ServiceAccount
kubectl get clusterrolebinding | grep <operator-name>
kubectl describe clusterrolebinding <operator-rolebinding>

# Check OLM ClusterServiceVersion install status
kubectl get csv -n <operator-namespace>
kubectl describe csv <csv-name> -n <operator-namespace>

# Check OLM InstallPlan status
kubectl get installplan -n <operator-namespace>
kubectl describe installplan <installplan-name> -n <operator-namespace>

# Check Subscription for update channel and approval status
kubectl get subscription -n <operator-namespace>
```

---

### 🔷 CKA Exam Tips

- Understand the core relationship clearly: **CRD defines the type, Controller acts on it, Operator packages both**
- Know how to **create a CRD from YAML** and **apply a CR object**
- Understand that **OLM manages Operator lifecycle** — it is not part of the Operator itself
- Know that Operators require **RBAC ClusterRole/ClusterRoleBinding** to function
- Be comfortable reading `kubectl describe` output on CR objects to identify status issues
- Exam scenarios often ask you to create a CRD, create a CR, and verify the CR is accepted
- Know the difference between `served: true` and `storage: true` fields in CRD versions

---

### 🔷 Production Best Practices

- Always use **OLM** for Operator lifecycle management in production clusters
- Pin Operator versions using specific channel subscriptions — avoid uncontrolled auto-upgrades
- Monitor Operator controller logs via centralized logging using ELK, Loki, or Splunk
- Scope Operator RBAC to **minimum required permissions** — avoid cluster-admin for Operators
- Test every Operator upgrade path in staging environment before promoting to production
- Document every CR field — application teams use CRs as their primary operational interface
- Use `installPlanApproval: Manual` in production for controlled Operator upgrades
- Regularly audit `kubectl get csv` to ensure all Operators are in Succeeded phase

---

### 📌 Topic Summary — Operator Framework

- An **Operator = CRD + Custom Controller** packaged together as a deployable unit
- Operators automate **Day-2 operations** — backup, restore, upgrade, failover, scaling
- The **Operator Lifecycle Manager (OLM)** handles Operator installation and version management
- **OperatorHub.io** provides a catalog of 300+ production-ready Operators for all major applications
- Operators use Kubernetes' native **reconciliation loop** to continuously maintain desired state
- **RBAC is mandatory** — Operators need ClusterRole permissions to watch and manage cluster resources
- `installPlanApproval: Manual` should be used in **production** to prevent unexpected upgrades
- Production use cases include databases, message queues, monitoring stacks, and service meshes
- **Interview phrasing:** *"An Operator extends Kubernetes with domain-specific operational knowledge, automating complex stateful application management through CRDs and custom controllers that run the same reconciliation loop as native Kubernetes controllers"*
- **Production takeaway:** Operators are not just deployment tools — they are **automated site reliability engineers** for your stateful applications

---

# 🗄️ PART II: Kubernetes Storage

---

## 20. Storage in Docker

### 🔷 What Is Storage in Docker?

Docker manages container data through a **layered filesystem architecture** backed by **storage drivers**. Every container image is composed of multiple **read-only layers** stacked on top of each other. When a container runs, a thin **writable layer** is added on top. Understanding this model is foundational to understanding how Kubernetes manages container storage, since Kubernetes container runtimes (containerd, CRI-O) follow the exact same layered storage model.

---

### 🔷 Why Do We Need to Understand It?

- Every container in Kubernetes is built on the same layered image system used by Docker
- Understanding layers helps optimize **image sizes and CI/CD build times** in production pipelines
- Understanding volumes and bind mounts explains how **Kubernetes PVs and PVCs** work at the runtime level
- Debugging storage-related issues in Kubernetes pods requires understanding underlying container storage mechanics
- Node disk space management in production requires understanding how image layers accumulate on worker nodes

---

### 🔷 Core Storage Concepts

**1. Image Layers — Read-Only and Immutable**

Each instruction in a Dockerfile creates a new immutable read-only layer containing only the changes from the previous layer.

```
Layer 5: ENTRYPOINT instruction           ← App startup, smallest layer
Layer 4: COPY app.py /opt/source-code     ← Application source code
Layer 3: RUN pip install flask            ← Python packages installed
Layer 2: RUN apt-get install python       ← OS packages (~300MB)
Layer 1: FROM ubuntu                      ← Base OS image (~120MB)
```

**Why this matters in production:**
- Multiple images sharing the same base layers — massive **disk savings** on nodes
- Changing only Layer 4 (application code) → Docker rebuilds only Layers 4 and 5
- Results in **fast CI/CD pipelines** — only changed layers are rebuilt and pushed

**2. Container Writable Layer — Copy-on-Write**

When a container starts, Docker adds a thin **writable layer** on top of read-only image layers. All runtime changes — log files, temporary files, modified configs — go into this writable layer.

```
┌────────────────────────────────────┐
│   Writable Container Layer         │  ← Created when container starts
│   (all runtime changes go here)    │  ← DELETED when container is removed
├────────────────────────────────────┤
│   Read-Only Image Layer 5          │
│   Read-Only Image Layer 4          │  ← Shared across ALL containers
│   Read-Only Image Layer 3          │     using this same image
│   Read-Only Image Layer 2          │
│   Read-Only Image Layer 1          │
└────────────────────────────────────┘
```

**Copy-on-Write mechanism:**
- Container wants to modify `app.py` from Layer 4
- Docker **copies** `app.py` into the writable layer first
- Container modifies the **copy** — original Layer 4 remains completely untouched
- Multiple containers can safely share the same image layers simultaneously

---

### 🔷 Docker Storage Drivers

Storage drivers manage how layers are stored on disk and how the copy-on-write mechanism operates.

| Storage Driver | OS Support | Production Status |
|---|---|---|
| **overlay2** | Ubuntu, CentOS/RHEL 8+, Debian | ✅ Recommended for all modern systems |
| **aufs** | Ubuntu (older kernels) | ⚠️ Legacy, being phased out |
| **devicemapper** | CentOS/RHEL (older) | ⚠️ Requires direct-lvm mode for production |
| **btrfs** | SUSE Linux | ✅ Supported, native filesystem features |
| **zfs** | Ubuntu with ZFS | ✅ Supported, snapshot capabilities |

**Production standard:** `overlay2` is the default and recommended storage driver for all modern Kubernetes deployments. It delivers the best performance and stability across Ubuntu and CentOS/RHEL 8+.

---

### 🔷 Volume Types — Persistence Options

| Type | Storage Location | Managed By | Persistence | Production Use Case |
|---|---|---|---|---|
| **Volume** | `/var/lib/docker/volumes/` | Docker | Survives container lifecycle | Databases, persistent logs |
| **Bind Mount** | Any host filesystem path | User/Admin | Host-dependent | Dev environments, config injection |
| **tmpfs** | Host RAM | Docker | Lost on container stop | Sensitive temp data, tokens |

---

### 🔷 Internal Working — Volume Mount Flow in Kubernetes Context

```
Kubernetes Pod Creation Requested
              │
              ▼
Container Runtime (containerd) pulls image layers
              │
              ├──► overlay2 driver stacks read-only layers
              │    at /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/
              │
              ├──► Creates writable container layer on top of image layers
              │
              ├──► kubelet calls CSI NodePublishVolume for PVC-backed volumes
              │    CSI driver mounts block device at staging path on node
              │    Then bind-mounts from staging to container target path
              │
              └──► Container starts with:
                       - Read-only image layers (shared, efficient)
                       - Writable container layer (ephemeral)
                       - Mounted persistent volumes (durable)
```

---

### 🔷 Architecture Flow

```
Developer pushes code → CI/CD builds Docker image
                │
                ▼
        Image layers cached at each build stage
        Only changed layers rebuilt and pushed to registry
                │
                ▼
Kubernetes pulls image to worker node
        overlay2 stores layers at /var/lib/containerd/
                │
                ├──► Multiple pods use same image → layers shared on node
                │    (disk efficient — 10 pods using same image = 1 copy of layers)
                │
                ├──► Each running pod gets own thin writable layer
                │
                └──► PVC volumes mounted separately by CSI driver
                     (persists beyond pod lifecycle)
```

---

### 🔷 Real-World Production Scenario

**Problem encountered:** A Node.js application container was writing large access logs inside the container writable layer. When the pod was restarted due to a node failure, all logs were permanently lost. The team had no visibility into what happened before the restart.

**Root cause:** Logs written to `/var/log/app` inside the container — this path was in the ephemeral writable layer, not a mounted volume.

**Solution implemented:**
- Mount a Kubernetes PersistentVolumeClaim at `/var/log/app` inside the pod
- Logs now persist across pod restarts and node rescheduling
- Added a Fluentd sidecar container that reads from the same mounted volume
- Fluentd ships logs to Elasticsearch in real time
- Even if the application pod crashes, logs from the volume are still accessible

**Production lesson:** Never store any data you want to retain inside the container writable layer. Always use mounted volumes for logs, databases, uploads, and any stateful data.

---

### 🔷 YAML Example — Understanding Container Layer vs Volume

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: storage-demo-pod
  namespace: production
spec:
  containers:
  - name: app
    image: myapp:2.1.0
    
    # Resource limits — critical in production
    # Without memory limits → container may consume all node memory
    # OOMKilled: kernel terminates container when memory limit exceeded
    # Symptom: kubectl describe pod shows "OOMKilled" in Last State
    # Fix: increase memory limit or optimize application memory usage
    resources:
      requests:
        memory: "256Mi"
        cpu: "250m"
      limits:
        memory: "512Mi"   # OOMKilled if app exceeds this
        cpu: "500m"       # CPU throttled if app exceeds this (not killed)
    
    volumeMounts:
    # This path IS persisted — backed by PVC
    # Data survives container restart and pod rescheduling
    - name: app-data
      mountPath: /data/app
    
    # This path IS persisted — backed by PVC
    # Logs available even after pod crash for debugging
    - name: app-logs
      mountPath: /var/log/app
    
    # This path is NOT persisted — inside container writable layer
    # /tmp data is lost on container restart
    # For shared temp data between containers, use emptyDir instead
    
  volumes:
  # PVC-backed volume — data persists beyond pod lifecycle
  - name: app-data
    persistentVolumeClaim:
      claimName: app-data-pvc
  
  # PVC-backed volume for logs — enables post-mortem log access
  - name: app-logs
    persistentVolumeClaim:
      claimName: app-logs-pvc
```

---

### 🔷 Debugging Storage Issues on Nodes

```bash
# Check disk usage on worker node
df -h /var/lib/containerd

# Check overlay2 layer sizes consuming disk
du -sh /var/lib/containerd/io.containerd.snapshotter.v1.overlayfs/

# Check which images are cached on node
crictl images

# Check containerd storage driver
containerd config dump | grep snapshotter

# List image layers for a specific image
docker history <image-name>

# Clean up unused image layers to recover disk space
crictl rmi --prune

# Check pod storage usage
kubectl exec -it <pod-name> -- df -h
```

---

### 🔷 Common Mistakes

- Storing persistent application data inside the container writable layer — **data lost on restart**
- Using `devicemapper` in loopback mode (default) in production — severe I/O performance degradation
- Not cleaning up dangling image layers on nodes — disk space exhaustion causes pod eviction
- Using bind mounts in multi-node Kubernetes — host paths differ per node causing scheduling inconsistency
- Building fat Docker images with all layers in a single RUN command — loses layer caching benefits
- Running containers as root — writable layer owned by root creates security vulnerabilities

---

### 🔷 CKA Exam Tips

- Understand that **container writable layer is ephemeral** — lost when container is removed
- Know the difference between **volumes** (persistent), **bind mounts** (host path), and **tmpfs** (RAM)
- Know that `overlay2` is the default storage driver for modern Kubernetes nodes
- Understand how **PVCs connect to persistent storage** at the container runtime level
- Be able to explain why data in `/tmp` inside a container is lost on restart

---

### 🔷 Production Best Practices

- Always mount volumes for any data that must survive container restarts
- Use `overlay2` storage driver on all production Kubernetes worker nodes
- Implement image layer cache optimization in CI/CD pipelines — sort Dockerfile instructions from least to most frequently changed
- Monitor node disk usage with Prometheus node_exporter — alert at 70% disk usage threshold
- Regularly prune unused images from nodes using `crictl rmi --prune`
- Never write sensitive data to container writable layer — use tmpfs volumes or Secrets instead
- Set explicit resource limits on all containers to prevent unbounded disk and memory usage

---

### 📌 Topic Summary — Storage in Docker

- Docker uses a **layered read-only image architecture** with a thin ephemeral **writable container layer** on top
- **Copy-on-Write** ensures all containers sharing the same image layers do so safely without modification conflicts
- **overlay2** is the default and recommended storage driver for all modern production Kubernetes worker nodes
- Container writable layer is **completely ephemeral** — any data stored there is permanently lost on container removal
- **Volumes** provide persistence — data survives the full container lifecycle
- In Kubernetes, containerd follows the exact same layered model — **PVs and PVCs** replace Docker volumes as the persistence mechanism
- Node disk space management requires awareness of image layer accumulation — regular pruning is necessary
- **Interview phrasing:** *"Docker's layered storage model enables efficient image sharing and fast container startup. The container writable layer is ephemeral — any data requiring persistence must be stored in mounted volumes, not inside the container filesystem"*
- **Production takeaway:** Treat the container writable layer as completely disposable — design every application assuming the container can be deleted and recreated at any moment

---

## 21. Volume Driver Plugins in Docker

### 🔷 What Are Volume Driver Plugins?

**Volume driver plugins** are extensions that allow Docker to create and manage volumes on **external storage systems** beyond the local host filesystem. They completely decouple **where data is physically stored** from **how the container runtime operates**, enabling containers to access persistent storage that survives beyond the lifecycle of any single host machine.

---

### 🔷 Why Do We Need Them?

The default Docker `local` volume driver stores data only on the node running the container. In a Kubernetes cluster with multiple nodes this creates a critical problem:

- Pod on Node A writes application data to Node A local disk
- Pod gets rescheduled to Node B due to node failure or scaling event
- Pod on Node B **cannot access data** written on Node A
- Application crashes or starts with empty state — **data effectively lost**

Volume driver plugins solve this by storing data on **shared external storage** that is accessible from any node in the cluster, making data location transparent to the container.

---

### 🔷 Common Volume Driver Plugins

| Plugin | Storage Backend | Cloud/Platform | Enterprise Use |
|---|---|---|---|
| **local** | Host filesystem | Any | Dev/Test only |
| **Rex-Ray/EBS** | AWS EBS | AWS | Production EC2/EKS |
| **Rex-Ray/GCE** | Google Persistent Disk | GCP | Production GKE |
| **Rex-Ray/Azure** | Azure Managed Disk | Azure | Production AKS |
| **Portworx** | Multi-cloud distributed storage | Any | Enterprise multi-cloud |
| **Convoy** | NFS, EBS, VFS | Multiple | Multi-provider abstraction |
| **NetApp Trident** | NetApp ONTAP | On-premises | Enterprise data center |
| **GlusterFS** | Gluster Distributed FS | On-premises | Distributed on-prem storage |
| **VMware vSphere** | vSAN | VMware environments | On-premises VMware |

---

### 🔷 Internal Working — How Volume Plugins Operate

```
Container Start Requested with External Volume
              │
              ▼
Docker Engine identifies volume-driver in run command
              │
              ▼
Docker calls Volume Driver Plugin RPC: Mount()
              │
              ▼
Volume Driver Plugin calls External Storage API
Example: AWS SDK → CreateVolume() if volume doesn't exist
Example: AWS SDK → AttachVolume() to attach EBS to current EC2 instance
              │
              ▼
External storage provisioned and attached to host node
at /dev/xvdf or similar block device path
              │
              ▼
Docker formats and mounts block device at volume path
/var/lib/docker/volumes/<volume-name>/_data
              │
              ▼
Volume bind-mounted into container at specified mountPath
              │
              ▼
Container reads/writes — data goes to external storage transparently
              │
              ▼
On container stop → Volume Driver calls Unmount() and DetachVolume()
EBS volume detaches from EC2 but DATA PERSISTS on EBS
```

---

### 🔷 Architecture Flow

```
┌──────────────────────────────────────────────────────────────┐
│                        Docker Host                           │
│                                                              │
│  ┌─────────────────────────────────────────────────────┐    │
│  │  Docker Engine                                       │    │
│  │                                                      │    │
│  │  Container Runtime ──► Volume Plugin API             │    │
│  │                              │                       │    │
│  └──────────────────────────────┼───────────────────────┘    │
│                                 │                             │
└─────────────────────────────────┼─────────────────────────────┘
                                  │  RPC: Create/Mount/Unmount/Delete
                                  ▼
┌──────────────────────────────────────────────────────────────┐
│              Volume Driver Plugin (Rex-Ray/EBS)              │
│                                                              │
│  Translates Docker volume API calls to storage API calls     │
└──────────────────────────────┬───────────────────────────────┘
                               │  AWS SDK API calls
                               ▼
┌──────────────────────────────────────────────────────────────┐
│                    AWS EBS Service                           │
│                                                              │
│  CreateVolume → AttachVolume → DetachVolume → DeleteVolume   │
└──────────────────────────────────────────────────────────────┘
```

---

### 🔷 Connection to Kubernetes CSI

The Docker volume plugin model was the **direct conceptual predecessor** to Kubernetes CSI. The evolution:

```
Docker Volume Plugins (2015)
        │
        ▼ Kubernetes needed a standardized version
Container Storage Interface - CSI (2018)
        │
        ▼ CSI became the universal standard
CSI drivers for all major storage systems (2019 onwards)
        │
        ▼ In-tree plugins deprecated
All storage managed exclusively via CSI drivers (Kubernetes 1.24+)
```

In modern Kubernetes:
- Docker volume plugins are **not used** directly
- **StorageClasses** with CSI provisioners replace them entirely
- The concepts are identical — only the implementation and standardization differ

---

### 🔷 YAML Example — Using External Storage via Volume Driver

```yaml
# Docker run command using Rex-Ray EBS volume driver
# This is the Docker-level concept — in Kubernetes use CSI StorageClass instead

# Docker CLI equivalent:
# docker run -it \
#   --name mysql-prod \
#   --volume-driver rexray/ebs \
#   --mount src=mysql-data-vol,target=/var/lib/mysql \
#   mysql:8.0

# In Kubernetes, this translates to:
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-data-pvc
  namespace: databases
spec:
  accessModes:
  - ReadWriteOnce
  storageClassName: ebs-gp3     # CSI StorageClass replaces volume driver plugin
  resources:
    requests:
      storage: 50Gi

---
apiVersion: v1
kind: Pod
metadata:
  name: mysql-pod
  namespace: databases
spec:
  containers:
  - name: mysql
    image: mysql:8.0
    
    # OOMKilled risk: MySQL buffer pool defaults to 128MB
    # Set innodb_buffer_pool_size appropriately via env var
    # If container hits memory limit → OOMKilled
    # kubectl describe pod mysql-pod → check "OOMKilled" in Last State
    resources:
      requests:
        memory: "1Gi"
        cpu: "500m"
      limits:
        memory: "2Gi"
        cpu: "1000m"
    
    env:
    - name: MYSQL_ROOT_PASSWORD
      valueFrom:
        secretKeyRef:
          name: mysql-secret
          key: root-password
          # CrashLoopBackOff if secret 'mysql-secret' does not exist
          # Fix: kubectl get secret mysql-secret -n databases
    
    volumeMounts:
    - name: mysql-data
      mountPath: /var/lib/mysql
    
  volumes:
  - name: mysql-data
    persistentVolumeClaim:
      claimName: mysql-data-pvc
      # PVC backed by EBS CSI driver
      # Volume persists when pod is deleted or rescheduled
      # EBS volume detaches from old node, reattaches to new node automatically
```

---

### 🔷 Debugging Volume Plugin Issues

```bash
# Check if volume plugin is registered
docker plugin ls

# Check plugin logs
journalctl -u docker -f | grep volume

# In Kubernetes — check CSI driver pod status (CSI replaces plugins)
kubectl get pods -n kube-system | grep csi

# Check VolumeAttachment status (shows attach/detach state)
kubectl get volumeattachment

# Describe failing PVC
kubectl describe pvc <pvc-name> -n <namespace>

# Check events for storage issues
kubectl get events -n <namespace> --sort-by='.lastTimestamp'
```

---

### 📌 Topic Summary — Volume Driver Plugins in Docker

- Volume driver plugins enable Docker to use **external storage systems** beyond the local node disk
- Critical for **multi-node environments** where pods can be rescheduled to any node at any time
- Key plugins for cloud: **Rex-Ray/EBS** (AWS), **Rex-Ray/GCE** (GCP), **Portworx** (multi-cloud)
- Plugins translate Docker volume API calls into **external storage API calls** transparently
- The Docker volume plugin model is the **direct conceptual predecessor** to Kubernetes CSI drivers
- In modern production Kubernetes, **CSI drivers fully replace** Docker volume plugins
- Understanding this history explains **why CSI was designed** the way it is
- **Interview phrasing:** *"Docker volume driver plugins externalize storage to shared systems accessible from any node. In Kubernetes, this concept is standardized and evolved into the Container Storage Interface, which provides a vendor-agnostic way to integrate any storage system"*
- **Production takeaway:** Never design stateful Kubernetes workloads assuming data stays on a specific node — always use network-attached storage via CSI drivers

---

## 22. Container Storage Interface (CSI)

### 🔷 What Is CSI?

The **Container Storage Interface (CSI)** is an **open industry standard specification** that defines a common API for container orchestrators (Kubernetes, Cloud Foundry, Mesos, Nomad) to interact with storage systems. It allows storage vendors to write a **single plugin** that works across all supported orchestrators without any modification.

Before CSI, Kubernetes had storage drivers **embedded directly in its core source code** — called in-tree plugins. Adding a new storage vendor required modifying and recompiling the Kubernetes binary itself, creating a slow, tightly-coupled, unmaintainable architecture.

---

### 🔷 Why Was CSI Created?

**Problems with in-tree storage plugins:**
- Every new storage vendor required a **Kubernetes core code change** and a full release cycle
- Bug fixes in storage drivers could only ship with the next Kubernetes version — months of delay
- Storage vendor teams had no control over their plugin release cadence or quality
- The Kubernetes binary grew increasingly large with each added storage plugin
- Testing a storage plugin required running the entire Kubernetes test suite

**CSI Solution:**
- Storage plugins are **out-of-tree** — completely separate from Kubernetes core
- Storage vendors own their plugin development, testing, and release cycle independently
- Any CSI-compliant plugin works with any CSI-compliant orchestrator
- Kubernetes core stays lean — no more storage vendor code in the main binary
- Plugins can be installed, updated, and removed without touching Kubernetes itself

---

### 🔷 Core Components

| Component | Type | Role |
|---|---|---|
| **CSI Driver** | Plugin | Implements the CSI spec for a specific storage system |
| **Identity Service** | gRPC service | Returns plugin capabilities and health status |
| **Controller Service** | gRPC service | Handles volume provisioning, attachment, deletion |
| **Node Service** | gRPC service | Handles volume mounting/unmounting on individual nodes |
| **external-provisioner** | Sidecar container | Watches PVCs and calls CreateVolume on CSI driver |
| **external-attacher** | Sidecar container | Watches VolumeAttachments and calls ControllerPublish |
| **external-resizer** | Sidecar container | Watches PVCs for resize requests, calls ControllerExpandVolume |
| **node-driver-registrar** | Sidecar container | Registers CSI driver with kubelet on each node |

---

### 🔷 Internal Working — CSI Volume Provisioning Flow

```
Step 1:  User creates PVC with storageClassName: ebs-gp3
Step 2:  kube-apiserver stores PVC in etcd with status: Pending
Step 3:  external-provisioner sidecar watches for new unbound PVCs
Step 4:  external-provisioner calls CSI CreateVolume RPC on controller service
Step 5:  CSI controller plugin calls AWS EBS API: CreateVolume()
Step 6:  EBS volume created in AWS with requested size and type
Step 7:  CSI driver returns volume_id back to external-provisioner
Step 8:  external-provisioner creates a PV object bound to the PVC
Step 9:  PVC status changes from Pending to Bound
Step 10: Pod scheduler places pod on node (respecting zone constraints)
Step 11: kubelet on node detects pod needs CSI volume
Step 12: external-attacher calls CSI ControllerPublishVolume RPC
Step 13: CSI controller calls AWS EBS API: AttachVolume() to EC2 instance
Step 14: Volume appears as block device /dev/xvdf on node
Step 15: kubelet calls CSI NodeStageVolume RPC (format + mount to staging path)
Step 16: kubelet calls CSI NodePublishVolume RPC (bind-mount to pod target path)
Step 17: Container starts and can read/write the mounted volume
```

---

### 🔷 Architecture Flow

```
┌────────────────────────────────────────────────────────────────────┐
│                          Kubernetes Control Plane                  │
│                                                                    │
│  kube-apiserver                                                    │
│       │                                                            │
│       ├── PVC created ──► external-provisioner sidecar watches    │
│       │                          │                                 │
│       │                          ▼                                 │
│       │                   CSI CreateVolume RPC                     │
│       │                          │                                 │
│       │                          ▼                                 │
│       │              CSI Controller Service Pod                    │
│       │              (StatefulSet/Deployment)                      │
│       │                          │                                 │
│       │                          ▼                                 │
│       │              External Storage API                          │
│       │              (AWS EBS, Azure Disk, GCE PD)                 │
│       │                                                            │
│       └── VolumeAttachment ──► external-attacher sidecar watches  │
└──────────────────────────────────────┬─────────────────────────────┘
                                       │
                     ControllerPublishVolume RPC
                                       │
                                       ▼
┌────────────────────────────────────────────────────────────────────┐
│                          Worker Node                               │
│                                                                    │
│  kubelet                                                           │
│       │                                                            │
│       ├── Calls NodeStageVolume RPC ──► CSI Node Plugin DaemonSet │
│       │         (mounts to /var/lib/kubelet/plugins/csi-staging/)  │
│       │                                                            │
│       └── Calls NodePublishVolume RPC ──► CSI Node Plugin          │
│                 (bind-mounts to /var/lib/kubelet/pods/<pod>/volumes)│
│                                                                    │
│  Container accesses volume at mountPath specified in Pod spec      │
└────────────────────────────────────────────────────────────────────┘
```

---

### 🔷 CSI RPC Methods Reference

| RPC Method | Service | Description |
|---|---|---|
| `GetPluginInfo` | Identity | Returns plugin name, version, and capabilities |
| `GetPluginCapabilities` | Identity | Lists what the plugin supports |
| `Probe` | Identity | Health check for the plugin |
| `CreateVolume` | Controller | Provisions a new volume on external storage |
| `DeleteVolume` | Controller | Deletes a provisioned volume |
| `ControllerPublishVolume` | Controller | Attaches volume to a specific node |
| `ControllerUnpublishVolume` | Controller | Detaches volume from a node |
| `ControllerExpandVolume` | Controller | Expands volume size |
| `NodeStageVolume` | Node | Mounts volume to global staging path on node |
| `NodeUnstageVolume` | Node | Unmounts volume from global staging path |
| `NodePublishVolume` | Node | Bind-mounts volume from staging to pod target path |
| `NodeUnpublishVolume` | Node | Unmounts volume from pod target path |

---

### 🔷 Popular CSI Drivers in Production

| CSI Driver | Storage Backend | Provisioner Name | Cloud/Platform |
|---|---|---|---|
| AWS EBS CSI Driver | Amazon EBS | `ebs.csi.aws.com` | AWS |
| Azure Disk CSI Driver | Azure Managed Disk | `disk.csi.azure.com` | Azure |
| GCE Persistent Disk CSI | Google Persistent Disk | `pd.csi.storage.gke.io` | GCP |
| NFS CSI Driver | NFS Server | `nfs.csi.k8s.io` | Any |
| Portworx CSI | Portworx storage | `pxd.portworx.com` | Multi-cloud |
| Ceph RBD CSI | Ceph cluster | `rbd.csi.ceph.com` | On-premises |
| OpenEBS | Local/network storage | `openebs.io/local` | Any |
| Longhorn | Distributed block storage | `driver.longhorn.io` | On-premises |

---

### 🔷 YAML Example — StorageClass Using CSI Driver

```yaml
# StorageClass backed by AWS EBS CSI Driver
# Enables dynamic volume provisioning — no manual PV creation needed
# Production-grade configuration with encryption and performance tuning
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: ebs-gp3-encrypted
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
    # Set as default StorageClass — PVCs without storageClassName use this

provisioner: ebs.csi.aws.com
# provisioner must exactly match installed CSI driver name
# Wrong name: PVC stays Pending forever
# Fix: kubectl get csidrivers to see registered driver names

volumeBindingMode: WaitForFirstConsumer
# WaitForFirstConsumer: volume created only when pod is scheduled
# This ensures EBS volume is created in SAME AZ as pod
# Without this: EBS volume might be in us-east-1a but pod on us-east-1b
# Result: ControllerPublishVolume fails → pod stuck in ContainerCreating

reclaimPolicy: Retain
# Retain: PV persists after PVC deletion
# Administrator must manually delete PV and EBS volume
# Use Retain for production databases — prevents accidental data loss
# Delete: automatically deletes PV and EBS volume with PVC
# Use Delete for ephemeral workloads like CI/CD build caches

allowVolumeExpansion: true
# Allows resizing PVC storage without recreating pod
# User updates PVC spec.resources.requests.storage
# CSI driver calls ControllerExpandVolume then NodeExpandVolume

parameters:
  type: gp3
  # gp3: Latest generation EBS — better baseline IOPS/throughput than gp2
  # gp2: Legacy, IOPS tied to volume size (3 IOPS/GB)
  # io2: High-performance for databases needing >16,000 IOPS
  
  iops: "3000"
  # Baseline IOPS for gp3 — can set up to 16,000 without extra cost up to 3000
  
  throughput: "125"
  # Throughput in MiB/s — gp3 baseline is 125 MiB/s
  
  encrypted: "true"
  # Always encrypt storage in production
  # Required for PCI-DSS, HIPAA, SOC2 compliance
  
  kmsKeyId: "arn:aws:kms:us-east-1:123456789012:key/mrk-xxx"
  # Use dedicated KMS key per environment for audit trail
  # Allows per-key rotation policy and access control

---
# PersistentVolumeClaim using the StorageClass above
# User creates this — StorageClass handles PV creation automatically
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: postgres-data-pvc
  namespace: databases
spec:
  accessModes:
  - ReadWriteOnce
  # ReadWriteOnce: single node read-write (EBS limitation)
  # ReadWriteMany: multi-node read-write (EFS, NFS, Ceph)
  # ReadOnlyMany: multi-node read-only
  
  storageClassName: ebs-gp3-encrypted
  # Must match StorageClass name exactly
  # Wrong name: PVC stays Pending
  # Fix: kubectl get storageclass to list available classes
  
  resources:
    requests:
      storage: 100Gi
  # Request 100GB
  # With allowVolumeExpansion: true, can be increased later
  # Cannot be decreased — EBS does not support volume shrink
```

---

### 🔷 Real-World Production Scenario

**Application:** Kafka cluster on EKS requiring high-throughput persistent storage with zone awareness

**Problem encountered:** Initial deployment used `Immediate` binding mode in StorageClass. Kafka broker PVCs provisioned EBS volumes in `us-east-1a`. Pods were scheduled in `us-east-1b` due to node anti-affinity rules. EBS attachment failed — pod stuck in ContainerCreating for 15 minutes.

**Fix applied:**
- Changed StorageClass `volumeBindingMode` to `WaitForFirstConsumer`
- EBS volumes now created only after pod is scheduled — always in correct AZ
- Kafka brokers deployed across 3 AZs with 3 separate StatefulSets
- Each StatefulSet uses node affinity to pin to a specific AZ

**Scaling result:**
- Adding Kafka broker = updating StatefulSet replicas
- CSI driver provisions new EBS volume in correct AZ automatically
- No manual storage provisioning required

**Monitoring:**
- `ebs_volume_read_ops_total` and `ebs_volume_write_ops_total` tracked in Prometheus
- CloudWatch EBS metrics correlated with application latency
- Alert fires when IOPS consistently above 80% of provisioned capacity

---

### 🔷 Debugging CSI Issues

```bash
# List all registered CSI drivers in cluster
kubectl get csidrivers

# Check CSI driver pods are running
kubectl get pods -n kube-system | grep csi

# Check CSI controller logs for provisioning errors
kubectl logs -n kube-system <ebs-csi-controller-pod> \
  -c ebs-plugin --tail=50

# Check CSI node plugin logs for mount errors
kubectl logs -n kube-system <ebs-csi-node-pod-on-failing-node> \
  -c ebs-plugin --tail=50

# Check PVC events for provisioning failure details
kubectl describe pvc <pvc-name> -n <namespace>

# Check PV details and CSI handle
kubectl describe pv <pv-name>

# Check VolumeAttachment status
kubectl get volumeattachment
kubectl describe volumeattachment <va-name>

# Check CSINode for driver registration on specific node
kubectl describe csinode <node-name>

# Events for storage-related failures
kubectl get events -n <namespace> \
  --field-selector reason=FailedMount \
  --sort-by='.lastTimestamp'
```

---

### 📌 Topic Summary — Container Storage Interface (CSI)

- CSI is an **open standard** that defines how orchestrators communicate with storage systems via gRPC RPCs
- CSI replaced **in-tree storage plugins** eliminating the need to modify Kubernetes core for new storage vendors
- Core RPC categories: **Identity** (plugin info), **Controller** (provision/attach), **Node** (mount/unmount)
- CSI drivers deployed as **DaemonSet** (node plugin running on every node) + **Deployment** (controller plugin)
- `WaitForFirstConsumer` binding mode is **critical for zone-aware storage** like EBS and Azure Disk
- `allowVolumeExpansion: true` enables **live storage resize** without recreating pods
- Always use `reclaimPolicy: Retain` for **production databases** to prevent accidental data loss
- **Interview phrasing:** *"CSI decouples storage provider plugins from Kubernetes core, enabling storage vendors to independently develop and release drivers that work with any CSI-compliant orchestrator through a standardized gRPC API"*
- **Production takeaway:** Every production Kubernetes cluster should have a well-configured default StorageClass backed by a CSI driver with encryption, appropriate binding mode, and reclaim policy matching data retention requirements

---

## 23. Volumes in Kubernetes

### 🔷 What Are Kubernetes Volumes?

A **Kubernetes Volume** is a storage abstraction defined at the **Pod level** that provides storage accessible to containers within that pod. Unlike container-level storage (which disappears on container restart), a Volume exists for the **entire lifetime of the pod** that defines it. Multiple containers within the same pod can access and share the same volume simultaneously.

The critical distinction in the storage hierarchy:
- **Container filesystem** — lost when the container restarts
- **Kubernetes Volume** — survives container restarts within the same pod
- **PersistentVolume** — survives pod deletion entirely and can be rebound to new pods

---

### 🔷 Why Do We Need Volumes?

- Containers are designed to be stateless and ephemeral — their local filesystem resets on restart
- Applications need to share data between containers in the same pod (sidecar pattern)
- Configuration files and secrets need to be injected into containers at runtime
- Log files need to persist beyond container crashes for post-mortem debugging
- Stateful applications (databases, message queues) need durable storage that outlives pods

---

### 🔷 Volume Types Reference

| Volume Type | Persistence | Use Case | Production Suitable |
|---|---|---|---|
| `emptyDir` | Pod lifetime only | Shared temp space between containers, caching | ✅ Yes for temp use |
| `hostPath` | Node filesystem | Node-level access (logging agents, monitoring) | ⚠️ Limited/risky |
| `configMap` | ConfigMap lifetime | Config file injection into containers | ✅ Yes |
| `secret` | Secret lifetime | Credential injection into containers | ✅ Yes |
| `persistentVolumeClaim` | PV lifetime | All production persistent storage | ✅ Yes — primary choice |
| `projected` | Combined sources | Combined token + config + secret mounts | ✅ Yes |
| `emptyDir (Memory)` | Pod lifetime (RAM) | Sensitive temporary data, high-speed scratch | ✅ Yes for specific use |
| `nfs` | NFS server lifetime | Shared storage across multiple pods | ✅ Yes with caution |
| `downwardAPI` | Pod lifetime | Expose pod metadata to containers | ✅ Yes |

---

### 🔷 Internal Working — Volume Mount Flow

```
Step 1:  Pod spec submitted to kube-apiserver
Step 2:  kube-scheduler assigns pod to a worker node
Step 3:  kubelet on the worker node receives pod spec
Step 4:  kubelet processes each volume in spec.volumes[]:

         emptyDir   → kubelet creates temp directory on node
         configMap  → kubelet fetches from kube-apiserver,
                      writes keys as files in tmpfs mount
         secret     → kubelet fetches from kube-apiserver,
                      decodes base64, writes as files in tmpfs mount
         PVC        → kubelet calls CSI NodePublishVolume RPC,
                      CSI driver mounts block device to target path

Step 5:  kubelet passes volume mount specifications to container runtime
Step 6:  Container runtime creates container with volume bind-mounts
Step 7:  Container starts — volumes accessible at specified mountPaths
Step 8:  Container restarts → volumes remounted, previous data accessible
Step 9:  Pod deleted → emptyDir cleaned up, PVC released per reclaim policy
```

---

### 🔷 Architecture Flow

```
┌──────────────────────────────────────────────────────────────────┐
│                         Control Plane                            │
│                                                                  │
│  kube-apiserver stores Pod spec with volume definitions in etcd  │
│  ConfigMap and Secret data stored in etcd (encrypted at rest)    │
└─────────────────────────────────┬────────────────────────────────┘
                                  │
                    kubelet reads pod spec
                                  │
                                  ▼
┌──────────────────────────────────────────────────────────────────┐
│                         Worker Node                              │
│                                                                  │
│  ┌─────────────────────────────────────────────────────────┐    │
│  │  kubelet                                                │    │
│  │                                                         │    │
│  │  ┌──────────────┐  ┌─────────────┐  ┌──────────────┐  │    │
│  │  │  emptyDir    │  │ configMap   │  │ PVC via CSI  │  │    │
│  │  │  → /tmp/dir  │  │ → tmpfs     │  │ → block dev  │  │    │
│  │  │  on node     │  │ → files     │  │ → mount path │  │    │
│  │  └──────────────┘  └─────────────┘  └──────────────┘  │    │
│  │                                                         │    │
│  └─────────────────────────┬───────────────────────────────┘    │
│                             │ Bind-mount into container          │
│  ┌──────────────────────────▼──────────────────────────────┐    │
│  │  Container                                              │    │
│  │  /tmp/processing   → emptyDir                           │    │
│  │  /etc/config       → configMap files                    │    │
│  │  /data/app         → PVC-backed persistent storage      │    │
│  └─────────────────────────────────────────────────────────┘    │
└──────────────────────────────────────────────────────────────────┘
```

---

### 🔷 YAML Example — Pod With Multiple Volume Types

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: multi-volume-production-pod
  namespace: production
  labels:
    app: myapp
    tier: backend
spec:
  
  # Use a non-root service account — principle of least privilege
  serviceAccountName: myapp-sa
  
  # Prevent privilege escalation at pod level
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    fsGroup: 2000      # All volume files owned by group 2000
  
  containers:
  - name: app
    image: myapp:3.1.0
    
    # Resource limits — mandatory in production
    # OOMKilled: app exceeds memory limit → kernel kills container
    # Symptom: kubectl describe pod → Last State: OOMKilled
    # Fix: increase memory limit OR fix memory leak in application
    # CPU throttling: app exceeds CPU limit → kernel throttles (not killed)
    # Symptom: high latency, slow responses despite low CPU usage
    # Fix: increase CPU limit OR optimize CPU-intensive code paths
    resources:
      requests:
        memory: "512Mi"
        cpu: "500m"
      limits:
        memory: "1Gi"
        cpu: "1000m"
    
    volumeMounts:
    
    # Persistent application data — survives pod deletion
    - name: app-persistent-data
      mountPath: /data/app
    
    # Application config from ConfigMap — injected as files
    # CrashLoopBackOff if ConfigMap 'app-config' doesn't exist
    # or if expected key is missing from ConfigMap
    # Debug: kubectl get configmap app-config -n production
    - name: app-config-volume
      mountPath: /etc/app/config
      readOnly: true
    
    # Database credentials from Secret — injected as files
    # CrashLoopBackOff if Secret 'db-credentials' doesn't exist
    # or if application fails to read expected file paths
    # Debug: kubectl get secret db-credentials -n production
    - name: db-credentials-volume
      mountPath: /etc/app/secrets
      readOnly: true
    
    # Temporary processing space — shared with sidecar
    # All data lost when pod is deleted — do not store anything permanent here
    - name: shared-temp
      mountPath: /tmp/processing
    
    # Downward API — inject pod metadata as files
    # Useful for logging pod name/namespace in application logs
    - name: pod-info
      mountPath: /etc/podinfo
      readOnly: true
  
  # Sidecar: ships logs to centralized logging system
  - name: log-shipper
    image: fluentd:v1.16
    resources:
      requests:
        memory: "128Mi"
        cpu: "100m"
      limits:
        memory: "256Mi"
        cpu: "200m"
    volumeMounts:
    # Reads app logs from shared emptyDir volume
    - name: shared-temp
      mountPath: /tmp/processing
      readOnly: true
  
  volumes:
  
  # PVC-backed persistent storage — primary storage for production data
  - name: app-persistent-data
    persistentVolumeClaim:
      claimName: app-data-pvc
      # PVC must exist before pod creation
      # Pod stays Pending if PVC doesn't exist or is not Bound
      # Debug: kubectl get pvc app-data-pvc -n production
  
  # ConfigMap volume — each key becomes a separate file
  - name: app-config-volume
    configMap:
      name: app-config
      # Optional items to mount only specific keys
      items:
      - key: app.properties
        path: app.properties
      - key: logging.xml
        path: logging.xml
      defaultMode: 0444   # Read-only for all users
  
  # Secret volume — base64 decoded automatically by kubelet
  - name: db-credentials-volume
    secret:
      secretName: db-credentials
      defaultMode: 0400   # Owner read-only — critical for credential security
      # Group readable would be 0440, world readable 0444 (never do this)
  
  # emptyDir — temporary shared space between containers
  - name: shared-temp
    emptyDir:
      medium: ""          # "" = disk-backed
      sizeLimit: "500Mi"  # Prevents temp data from filling node disk
      # medium: "Memory" = RAM-backed tmpfs (faster but uses node RAM)
      # Use Memory medium for sensitive data like tokens (no disk writes)
  
  # Downward API volume — exposes pod metadata as files
  - name: pod-info
    downwardAPI:
      items:
      - path: "pod-name"
        fieldRef:
          fieldPath: metadata.name
      - path: "namespace"
        fieldRef:
          fieldPath: metadata.namespace
      - path: "pod-ip"
        fieldRef:
          fieldPath: status.podIP
```

---

### 🔷 emptyDir Deep Dive — Production Use Cases

```
Use Case 1: Sidecar Log Shipper Pattern
  Main container writes logs to /var/log/app (emptyDir)
  Log-shipper sidecar reads from /var/log/app and ships to Elasticsearch
  Both containers share the same emptyDir volume
  
Use Case 2: Git-Sync Init Container Pattern
  Init container clones Git repo into emptyDir at /repo
  Main container reads application code from /repo
  emptyDir shared between init and main container
  
Use Case 3: Temporary File Processing
  Main container downloads large file to emptyDir at /tmp/downloads
  Processing sidecar reads from /tmp/downloads and processes chunks
  Processed output written to PVC-backed volume
  Temporary download deleted when processing complete
  
Use Case 4: Prometheus Multi-target Data Collection
  Multiple target scraper containers each write metrics to emptyDir
  Aggregator container reads all metric files and exposes unified endpoint
```

---

### 🔷 Real-World Production Scenario

**Application:** Microservices-based e-commerce platform running on GKE

**Volume strategy per service tier:**

| Service | Volume Type | Justification |
|---|---|---|
| PostgreSQL (orders DB) | PVC → Persistent Disk CSI | Durable transactional data |
| Redis (session cache) | PVC → Persistent Disk CSI | Session data must survive restarts |
| Application pods | ConfigMap + Secret volumes | Config and credentials injection |
| Log aggregator | emptyDir shared with fluentd | Temporary log buffering before shipping |
| Prometheus | PVC → Persistent Disk CSI | Metrics must survive Prometheus restarts |
| Build agents (CI/CD) | emptyDir medium: "" | Ephemeral build cache, deleted after build |

**Security enforcement:**
- All Secret volumes mounted with `defaultMode: 0400` — only container user can read
- ConfigMap volumes mounted with `defaultMode: 0444` — readable but not writable
- No `hostPath` volumes in any production namespace — enforced via OPA Gatekeeper policy
- All PVC-backed volumes encrypted at rest via KMS

---

### 🔷 Common Mistakes

- Using `hostPath` for persistent data in multi-node clusters — pod rescheduling causes data loss
- Mounting entire Secret as volume when only one key is needed — exposes unnecessary credentials
- Not setting `sizeLimit` on emptyDir — single container fills node disk causing pod evictions
- Using `emptyDir` for data that must survive pod restarts — all data lost on pod deletion
- Not setting `readOnly: true` on config/secret mounts — container can inadvertently modify configs
- Using `defaultMode: 0777` on Secret volumes — all users in container can read credentials
- Forgetting to create ConfigMap or Secret before pod — pod stuck in Init or CrashLoopBackOff

---

### 🔷 Debugging Volume Issues

```bash
# Check pod status and volume mount errors
kubectl describe pod <pod-name> -n <namespace>
# Look for: "MountVolume.SetUp failed" in Events section

# Check if ConfigMap exists
kubectl get configmap <cm-name> -n <namespace>

# Check if Secret exists
kubectl get secret <secret-name> -n <namespace>

# Verify volume is mounted inside container
kubectl exec -it <pod-name> -n <namespace> -- ls -la /etc/app/config/
kubectl exec -it <pod-name> -n <namespace> -- cat /etc/app/config/app.properties

# Check PVC binding status
kubectl get pvc -n <namespace>

# Check emptyDir usage inside pod
kubectl exec -it <pod-name> -n <namespace> -- df -h /tmp/processing

# Check events for volume-related failures
kubectl get events -n <namespace> \
  --field-selector reason=FailedMount \
  --sort-by='.lastTimestamp'
```

---

### 🔷 CKA Exam Tips

- Know **all common volume types** and when to use each one
- Understand that `emptyDir` is **pod-scoped** — lost when pod is deleted
- Know that `hostPath` should be avoided — exam may test security awareness
- Understand that `configMap` and `secret` volumes inject data as **files** (not environment variables)
- Know how to mount a **specific key** from a ConfigMap using `items` field
- Understand `defaultMode` for setting **file permissions** on mounted volumes
- Be able to troubleshoot `MountVolume.SetUp failed` errors using `kubectl describe pod`

---

### 🔷 Production Best Practices

- Use **PVC-backed volumes** for all production persistent data — never hostPath or emptyDir
- Always set `sizeLimit` on `emptyDir` volumes to prevent disk exhaustion
- Mount Secrets with `defaultMode: 0400` — no group or world read permissions
- Mount ConfigMaps as read-only (`readOnly: true`) to prevent accidental modification
- Use the `downwardAPI` volume to inject pod metadata for better application observability
- Enforce no-hostPath policy using OPA Gatekeeper or Kyverno admission controllers
- Always create ConfigMaps and Secrets **before** pods that depend on them in deployment manifests

---

### 📌 Topic Summary — Volumes in Kubernetes

- Kubernetes Volumes exist at the **Pod level** and survive **container restarts** within the same pod
- `emptyDir` provides temporary pod-scoped storage — **lost when pod is deleted**, ideal for sidecars
- `configMap` and `secret` volumes inject Kubernetes objects as **files** into the container filesystem
- `persistentVolumeClaim` is the **primary volume type for production** persistent storage
- Setting appropriate `defaultMode` permissions on Secret volumes is a **critical security practice**
- Missing ConfigMap or Secret results in **CrashLoopBackOff or Init:Error** — always create dependencies first
- emptyDir `sizeLimit` must always be set to **prevent disk exhaustion** on worker nodes
- **Interview phrasing:** *"Kubernetes volumes extend storage beyond the container lifecycle within a pod. For data that must outlast pods entirely, PersistentVolumeClaims bound to PersistentVolumes backed by CSI drivers are the correct solution"*
- **Production takeaway:** Every volume type has a specific purpose — using the wrong type (emptyDir for permanent data, hostPath in multi-node clusters) is one of the most common and costly mistakes in Kubernetes deployments

---

## 24. Persistent Volumes (PV)

### 🔷 What Are Persistent Volumes?

A **PersistentVolume (PV)** is a piece of storage in the Kubernetes cluster that has been **provisioned by an administrator** or **dynamically provisioned by a StorageClass**. It is a cluster-level resource — not namespaced — representing a physical or virtual storage unit that exists independently of any individual pod or namespace.

PVs abstract away the underlying storage infrastructure details from application developers. An administrator provisions storage with specific characteristics, and developers claim portions of that storage through PersistentVolumeClaims without needing to know what backend storage is being used.

---

### 🔷 Why Do We Need PVs?

**Without PersistentVolumes:**
- Storage configuration is duplicated in every Pod spec
- Every developer needs to know AWS EBS volume IDs, NFS server paths, or GCE disk names
- No central governance of available storage in the cluster
- Changing storage backend requires updating every Pod definition

**With PersistentVolumes:**
- Administrators define and manage storage centrally
- Developers request storage via PVCs — backend details hidden
- Storage can be pre-provisioned or dynamically provisioned
- Consistent access control and reclaim policies enforced cluster-wide
- Storage lifecycle (create, bind, release, delete) managed by Kubernetes

---

### 🔷 PV Lifecycle States

```
Available  →  Bound  →  Released  →  Available/Deleted
   │             │           │
   │             │           └── After PVC deleted:
   │             │               Retain: Released state, admin reclaims
   │             │               Delete: PV and storage deleted
   │             │               Recycle: Data scrubbed, back to Available
   │             │
   └─────────────┴── PVC created matching PV specs → Bound
```

---

### 🔷 PV Access Modes

| Access Mode | Short Name | Description | Storage Support |
|---|---|---|---|
| `ReadWriteOnce` | RWO | One node read-write | EBS, Azure Disk, GCE PD |
| `ReadOnlyMany` | ROX | Multiple nodes read-only | NFS, CephFS, EFS |
| `ReadWriteMany` | RWX | Multiple nodes read-write | NFS, CephFS, EFS, GlusterFS |
| `ReadWriteOncePod` | RWOP | Single pod read-write (Kubernetes 1.22+) | CSI drivers supporting it |

**Critical production note:** EBS and Azure Disk only support `ReadWriteOnce`. Applications needing multi-pod write access must use NFS, CephFS, or Amazon EFS with `ReadWriteMany`.

---

### 🔷 Internal Working — Static PV Provisioning Flow

```
Step 1:  Administrator provisions physical storage
         (creates EBS volume, NFS export, GCE PD, etc.)
Step 2:  Administrator creates PV manifest referencing the storage
Step 3:  PV applied to cluster → kube-apiserver stores in etcd
Step 4:  PV status: Available (not yet bound to any PVC)
Step 5:  Developer creates PVC requesting specific capacity and access mode
Step 6:  kube-controller-manager PersistentVolumeController finds best matching PV
Step 7:  PVC and PV bound together → both show status: Bound
Step 8:  Pod references PVC → volume mounted to container
Step 9:  PVC deleted → PV transitions to Released state
Step 10: Reclaim policy determines what happens next:
         Retain  → PV stays Released, admin manually reclaims
         Delete  → PV and underlying storage deleted automatically
         Recycle → Data scrubbed, PV returns to Available
```

---

### 🔷 Architecture Flow

```
┌─────────────────────────────────────────────────────────────────┐
│                      Control Plane                              │
│                                                                 │
│  kube-apiserver: PV and PVC objects stored in etcd              │
│                                                                 │
│  PersistentVolumeController (part of kube-controller-manager)  │
│       │                                                         │
│       ├── Watches for new PVCs in Available state              │
│       ├── Scans Available PVs for matching candidate           │
│       │   Match criteria: capacity, accessModes, storageClass  │
│       └── Binds PVC to best matching PV                        │
│                                                                 │
│  AttachDetachController (part of kube-controller-manager)      │
│       │                                                         │
│       └── Manages volume attachment to nodes                   │
└──────────────────────────────┬──────────────────────────────────┘
                               │
                               ▼
┌─────────────────────────────────────────────────────────────────┐
│                      Worker Node                                │
│                                                                 │
│  kubelet receives pod spec with PVC reference                   │
│       │                                                         │
│       ├── Calls CSI NodeStageVolume (format + global mount)    │
│       └── Calls CSI NodePublishVolume (bind-mount to pod path) │
│                                                                 │
│  Container accesses storage at mountPath                       │
└─────────────────────────────────────────────────────────────────┘
```

---

### 🔷 YAML Example — Static PV Provisioning

```yaml
# Static PersistentVolume — manually provisioned by administrator
# Use case: pre-existing EBS volume with data that must be migrated
# Administrator creates PV explicitly pointing to existing storage
apiVersion: v1
kind: PersistentVolume
metadata:
  name: postgres-pv-prod
  labels:
    # Labels allow PVC to use labelSelector for specific PV binding
    app: postgres
    environment: production
    tier: database
  annotations:
    # Document storage details for operations team
    storage.company.com/provisioned-by: "platform-team"
    storage.company.com/ticket: "INFRA-12345"
spec:
  
  # Capacity of this PV
  capacity:
    storage: 100Gi
  
  # Access mode must match what the application needs
  # EBS only supports ReadWriteOnce — single node at a time
  # Trying ReadWriteMany with EBS → PV never binds to PVC
  accessModes:
  - ReadWriteOnce
  
  # Reclaim policy — what happens when PVC is deleted
  # Retain: RECOMMENDED for production databases
  # PV stays in Released state, data preserved, admin must manually clean up
  # Delete: PV and EBS volume automatically deleted with PVC
  # Never use Delete for production databases — risk of accidental data loss
  persistentVolumeReclaimPolicy: Retain
  
  # StorageClass binding — empty string means no dynamic provisioning
  # PVC must explicitly select this PV via selector or storageClassName: ""
  storageClassName: ""
  
  # Volume mode: Filesystem (default) or Block
  # Filesystem: formatted and mounted as directory (default for most apps)
  # Block: raw block device, used by databases needing direct block access
  volumeMode: Filesystem
  
  # The actual storage backend — EBS volume
  # This is what the PV points to physically
  awsElasticBlockStore:
    volumeID: vol-0a1b2c3d4e5f67890
    # Volume ID must match an existing EBS volume in same AZ and region
    # Wrong volume ID: pod stuck in ContainerCreating
    # Volume in wrong AZ: ControllerPublishVolume fails
    fsType: ext4
    # ext4: most common, good performance
    # xfs: better for large files, used by many databases

---
# PV backed by NFS — supports ReadWriteMany for multi-pod access
# Use case: shared content storage, media files, shared config
apiVersion: v1
kind: PersistentVolume
metadata:
  name: shared-content-pv
spec:
  capacity:
    storage: 500Gi
  accessModes:
  - ReadWriteMany    # Multiple pods across multiple nodes can write
  persistentVolumeReclaimPolicy: Retain
  storageClassName: nfs-storage
  nfs:
    server: 10.100.1.50    # NFS server IP address
    path: /exports/shared-content
    # NFS server must be reachable from all worker nodes
    # Check: mount -t nfs 10.100.1.50:/exports/shared-content /mnt/test
    readOnly: false

---
# PV backed by local storage (high-performance, zone-pinned)
# Use case: databases needing low-latency local SSD access
# WARNING: pod must be scheduled on the specific node where local disk exists
# Requires node affinity — pod cannot move to another node
apiVersion: v1
kind: PersistentVolume
metadata:
  name: fast-local-ssd-pv
spec:
  capacity:
    storage: 200Gi
  accessModes:
  - ReadWriteOnce
  persistentVolumeReclaimPolicy: Delete
  storageClassName: local-ssd
  volumeMode: Filesystem
  local:
    path: /mnt/local-ssd    # Path to local SSD mounted on this specific node
  nodeAffinity:
    # MANDATORY for local volumes — ties PV to specific node
    # Without nodeAffinity: local PV cannot be used correctly
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - worker-node-3   # Exact node where local SSD is mounted
```

---

### 🔷 PV Binding Criteria

When a PVC is created, Kubernetes evaluates PVs for binding using:

```
1. storageClassName must match (or both empty for manual binding)
2. accessModes must satisfy PVC request (PV must support requested modes)
3. capacity must be >= PVC requested storage (smallest sufficient PV is chosen)
4. volumeMode must match (Filesystem vs Block)
5. selector labels must match (if PVC uses labelSelector)
6. If multiple PVs qualify → smallest sufficient one is selected
```

**Important:** If a 500Gi PV exists and a 10Gi PVC is created with no other matching PV, the 10Gi PVC will bind to the 500Gi PV — **remaining 490Gi is wasted and unavailable to other PVCs**. Dynamic provisioning with StorageClasses prevents this by provisioning exactly the requested size.

---

### 🔷 Real-World Production Scenario

**Application:** Elasticsearch cluster requiring high-performance local NVMe storage

**Architecture:**
- 3 Elasticsearch data nodes each requiring 2TB NVMe SSD local storage
- Local storage provides 10x better IOPS than network-attached storage
- Each data node pinned to a specific worker node with local NVMe
- PersistentVolumeReclaimPolicy: Retain — data preserved if pod fails

**Static PV provisioning workflow:**
1. Platform team provisions 3 worker nodes each with 2TB NVMe SSD
2. NVMe formatted and mounted at `/mnt/nvme` on each node
3. Platform team creates 3 PVs — one per node — with `local` storage type and `nodeAffinity`
4. Each Elasticsearch StatefulSet pod gets its own PVC that binds to its dedicated PV
5. Pods cannot be rescheduled to other nodes — this is acceptable for Elasticsearch data nodes

**Monitoring:**
- Node disk usage tracked via Prometheus node_exporter
- Elasticsearch index size vs PV capacity tracked via custom metric
- Alert at 80% PV capacity — triggers manual capacity expansion

---

### 🔷 Debugging PV Issues

```bash
# List all PersistentVolumes and their status
kubectl get pv
# Key columns: STATUS (Available/Bound/Released/Failed), CLAIM, RECLAIM POLICY

# Describe specific PV for details and events
kubectl describe pv <pv-name>

# Check why PV is stuck in Released (not reusable)
# When PV has claimRef — it remembers previous PVC and won't rebind
kubectl get pv <pv-name> -o yaml | grep claimRef
# Fix: remove claimRef to make PV Available again
kubectl patch pv <pv-name> -p \
  '{"spec":{"claimRef": null}}'

# Check PVC binding status
kubectl get pvc -n <namespace>

# Describe PVC for binding failure details
kubectl describe pvc <pvc-name> -n <namespace>
# Look for: "no persistent volumes available" or "matches found but access modes don't match"

# Check volume attachment
kubectl get volumeattachment

# Events related to PV/PVC issues
kubectl get events --field-selector reason=FailedMount \
  --sort-by='.lastTimestamp'
```

---

### 🔷 CKA Exam Tips

- Know the **4 PV lifecycle states**: Available → Bound → Released → (Deleted/Available/Failed)
- Know all **3 reclaim policies** and when to use each: `Retain`, `Delete`, `Recycle`
- Know the **4 access modes**: RWO, ROX, RWX, RWOP and which storage backends support which
- Understand **binding criteria** — capacity, accessModes, storageClassName must all match
- Know how to **manually reclaim** a Released PV by removing the `claimRef` field
- Understand the difference between **static provisioning** (admin creates PV) and **dynamic provisioning** (StorageClass creates PV automatically)
- Be able to identify why a PVC is in `Pending` state — access mode mismatch, no matching PV, wrong storageClassName

---

### 🔷 Production Best Practices

- Always set `persistentVolumeReclaimPolicy: Retain` for production database PVs
- Document PV purpose using labels and annotations for operational visibility
- Use **dynamic provisioning via StorageClasses** for all new deployments — manual PV creation doesn't scale
- Reserve static PV provisioning for **pre-existing data migration** scenarios
- Monitor PV usage and alert at 75-80% capacity before applications start failing
- Never use `Recycle` reclaim policy — it is deprecated and unreliable
- For local PVs, always set `nodeAffinity` — without it the pod may not be able to access the volume

---

### 📌 Topic Summary — Persistent Volumes (PV)

- PV is a **cluster-scoped resource** representing a piece of physical or virtual storage provisioned for the cluster
- PV **lifecycle states**: Available → Bound → Released → Deleted/Available depending on reclaim policy
- **Reclaim policies**: `Retain` (data safe, admin reclaims), `Delete` (auto-delete), `Recycle` (deprecated)
- **Access modes** define how many nodes can access the volume and in what mode — EBS only supports RWO
- Static PV provisioning is for **pre-existing storage** — dynamic provisioning via StorageClass is preferred for new workloads
- If a small PVC binds to a large PV, the **unused capacity is wasted** — dynamic provisioning solves this
- **Interview phrasing:** *"A PersistentVolume is a cluster-scoped storage abstraction provisioned by an administrator that exists independently of pods, allowing storage to survive pod lifecycle events and be managed centrally"*
- **Production takeaway:** Use `Retain` reclaim policy for all production stateful workloads — the small operational overhead of manual PV reclamation is vastly outweighed by the protection against accidental data loss

---

## 25. Persistent Volume Claims (PVC)

### 🔷 What Are PVCs?

A **PersistentVolumeClaim (PVC)** is a **request for storage** made by a user or application in Kubernetes. It is the mechanism through which applications claim portions of the storage pool managed by administrators via PersistentVolumes. PVCs are **namespaced resources** — they belong to a specific namespace and can only be used by pods in the same namespace.

The PVC is the developer's interface to storage. The developer specifies **what they need** (how much storage, what access mode) without knowing **where it comes from** (which storage backend, which datacenter, which cloud region). This separation of concerns is the fundamental design principle of Kubernetes storage.

---

### 🔷 Why Do We Need PVCs?

- Provides a **clean separation** between storage administration (PVs) and application consumption (PVCs)
- Developers don't need to know storage infrastructure details — just request what they need
- Kubernetes handles the **binding logic** — finds the right PV automatically
- PVCs make storage **portable** — same PVC definition works across dev, staging, and production
- PVCs serve as the **glue** between pods and PersistentVolumes
- With StorageClasses, PVCs trigger **dynamic provisioning** automatically

---

### 🔷 Internal Working — PVC Lifecycle

```
Step 1:  Developer creates PVC manifest with storage requirements
Step 2:  kube-apiserver validates and stores PVC in etcd
Step 3:  PVC status: Pending
Step 4:  PersistentVolumeController scans for matching PV:
         - For static provisioning: finds best existing matching PV
         - For dynamic provisioning: triggers StorageClass provisioner
Step 5:  Static: PV found → PVC and PV mutually bound → status: Bound
         Dynamic: StorageClass creates new PV → PVC bound → status: Bound
Step 6:  Pod references PVC in spec.volumes
Step 7:  kubelet uses bound PV information to mount storage to container
Step 8:  Application uses storage via mountPath
Step 9:  Pod deleted → volume unmounted, PVC still exists → data preserved
Step 10: PVC deleted → PV transitions to Released state
         - Retain: data preserved, admin must manually clean up
         - Delete: PV and underlying storage automatically deleted
```

---

### 🔷 Architecture Flow

```
Developer creates PVC
        │
        ▼
kube-apiserver validates PVC spec
        │
        ▼
PersistentVolumeController evaluates PVs
        │
        ├── Static: Finds matching PV in Available state
        │          Checks: storageClassName, accessModes,
        │          capacity, volumeMode, selector labels
        │          Best match bound to PVC
        │
        └── Dynamic: No matching PV found
                   StorageClass provisioner invoked
                   CSI driver creates new volume
                   New PV created and bound to PVC
        │
        ▼
PVC status: Bound  ←  PV status: Bound
        │
        ▼
Pod references PVC in spec.volumes[].persistentVolumeClaim
        │
        ▼
kubelet mounts bound PV storage to container via CSI
        │
        ▼
Container accesses storage at mountPath
```

---

### 🔷 YAML Example — PVC with Dynamic Provisioning

```yaml
# PersistentVolumeClaim — developer's storage request
# With dynamic provisioning, this automatically creates a PV
# No manual PV creation needed when StorageClass is configured
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: postgres-data-pvc
  namespace: databases
  labels:
    app: postgres
    environment: production
  annotations:
    # Document for operations team
    storage.company.com/requested-by: "data-platform-team"
    storage.company.com/purpose: "PostgreSQL primary data directory"
spec:
  
  accessModes:
  - ReadWriteOnce
  # ReadWriteOnce: Single node can mount read-write
  # Required for EBS — EBS cannot be attached to multiple nodes
  # For multi-pod shared write access: use ReadWriteMany with NFS/EFS/CephFS
  # PVC stuck in Pending if requested access mode not supported by available PVs
  
  storageClassName: ebs-gp3-encrypted
  # Must exactly match an existing StorageClass name
  # Wrong name: PVC stays Pending forever
  # Check: kubectl get storageclass
  # If storageClassName: "" → only binds to PVs with no StorageClass (static binding)
  # If storageClassName omitted → uses cluster default StorageClass
  
  volumeMode: Filesystem
  # Filesystem (default): mounted as directory, formatted automatically
  # Block: raw block device, used by databases like Cassandra or Oracle
  
  resources:
    requests:
      storage: 100Gi
      # Request exactly what you need
      # Dynamic provisioning creates volume of exactly this size
      # Static binding: PV must have capacity >= this value
      # Cannot decrease storage after PVC creation
      # Can increase if StorageClass has allowVolumeExpansion: true
  
  # Optional: bind to specific PV using label selector
  # Use when you want to explicitly select a pre-existing PV
  # selector:
  #   matchLabels:
  #     app: postgres
  #     environment: production

---
# StatefulSet using PVC template — creates individual PVC per replica
# This is the correct pattern for stateful applications like databases
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: postgres-statefulset
  namespace: databases
spec:
  serviceName: postgres-headless
  replicas: 3
  selector:
    matchLabels:
      app: postgres
  template:
    metadata:
      labels:
        app: postgres
    spec:
      containers:
      - name: postgres
        image: postgres:15
        
        # OOMKilled: PostgreSQL shared_buffers default 128MB
        # In production: set to 25% of container memory limit
        # If app runs out of memory → OOMKilled
        # kubectl describe pod → check Last State: OOMKilled
        # Fix: tune PostgreSQL memory params OR increase memory limit
        resources:
          requests:
            memory: "2Gi"
            cpu: "1000m"
          limits:
            memory: "4Gi"
            cpu: "2000m"
        
        env:
        - name: PGDATA
          value: /data/pgdata
        - name: POSTGRES_PASSWORD
          valueFrom:
            secretKeyRef:
              name: postgres-secret
              key: password
              # CrashLoopBackOff if secret doesn't exist
              # Fix: kubectl get secret postgres-secret -n databases
        
        volumeMounts:
        - name: postgres-data
          mountPath: /data
        
        # Liveness probe to detect hung PostgreSQL process
        livenessProbe:
          exec:
            command:
            - pg_isready
            - -U
            - postgres
          initialDelaySeconds: 30
          periodSeconds: 10
          failureThreshold: 3
  
  # PVC template — creates one PVC per StatefulSet replica
  # postgres-statefulset-0 gets postgres-data-postgres-statefulset-0
  # postgres-statefulset-1 gets postgres-data-postgres-statefulset-1
  # postgres-statefulset-2 gets postgres-data-postgres-statefulset-2
  # Each pod gets its own isolated storage — critical for databases
  volumeClaimTemplates:
  - metadata:
      name: postgres-data
      labels:
        app: postgres
    spec:
      accessModes:
      - ReadWriteOnce
      storageClassName: ebs-gp3-encrypted
      resources:
        requests:
          storage: 100Gi
```

---

### 🔷 PVC Expansion (Resizing Storage)

```bash
# Resize PVC after initial creation (requires allowVolumeExpansion: true in StorageClass)

# Step 1: Edit PVC to increase storage
kubectl edit pvc postgres-data-pvc -n databases
# Change: spec.resources.requests.storage from 100Gi to 200Gi

# Step 2: CSI driver calls ControllerExpandVolume to expand backend volume
# Step 3: If pod is running: NodeExpandVolume called to expand filesystem online
# Step 4: For some drivers: pod must be restarted for filesystem expansion to complete

# Check PVC expansion status
kubectl describe pvc postgres-data-pvc -n databases
# Look for: "Resizing" condition or successful "FilesystemResizePending" → gone

# Verify new size inside container
kubectl exec -it <pod-name> -n databases -- df -h /data
```

---

### 🔷 Debugging PVC Issues

```bash
# Check PVC status — key field is STATUS
kubectl get pvc -n <namespace>
# Pending: no matching PV found or dynamic provisioning failed
# Bound: successfully bound to PV
# Lost: bound PV no longer exists

# Describe PVC for detailed failure reason
kubectl describe pvc <pvc-name> -n <namespace>
# Common messages:
# "no persistent volumes available for this claim" → no matching PV
# "storageclass not found" → wrong storageClassName
# "access mode mismatch" → PV doesn't support requested access mode

# Check StorageClass exists
kubectl get storageclass

# Check PV availability
kubectl get pv
# Look for PV in Available state with matching storageClassName and accessModes

# Check CSI provisioner logs for dynamic provisioning failures
kubectl logs -n kube-system \
  $(kubectl get pod -n kube-system -l app=ebs-csi-controller -o name) \
  -c csi-provisioner

# Check events
kubectl get events -n <namespace> \
  --field-selector involvedObject.name=<pvc-name>
```

---

### 🔷 CKA Exam Tips

- Know that PVCs are **namespaced** while PVs are **cluster-scoped**
- Understand PVC **binding algorithm** — capacity, accessModes, storageClassName, selector must match
- Know how to identify why a PVC is **Pending** — wrong storageClass, no matching PV, access mode issue
- Understand **VolumeClaimTemplates** in StatefulSets — creates individual PVC per replica
- Know how to **resize** a PVC (requires `allowVolumeExpansion: true` in StorageClass)
- Be able to write a complete **PVC YAML** from memory — accessModes, storageClassName, resources

---

### 🔷 Production Best Practices

- Always use **StorageClasses with dynamic provisioning** — manual PV creation doesn't scale
- Use **StatefulSet VolumeClaimTemplates** for stateful applications — never share PVCs across StatefulSet replicas
- Monitor PVC capacity usage and alert before applications fill storage — use Prometheus PV metrics
- Set appropriate storage requests — over-provisioning wastes money, under-provisioning causes crashes
- Use `kubectl get pvc -A` regularly in production to find Pending or Lost PVCs
- Document PVC purpose using labels and annotations for operational clarity
- Test PVC expansion in staging before enabling `allowVolumeExpansion` in production StorageClass

---

### 📌 Topic Summary — Persistent Volume Claims (PVC)

- PVC is a **namespaced developer-facing request** for storage that binds to a cluster-scoped PV
- Kubernetes **PersistentVolumeController** automatically binds PVCs to matching PVs based on capacity, accessModes, storageClass, and selectors
- PVC status: `Pending` (waiting for PV), `Bound` (successfully bound), `Lost` (PV deleted)
- **Dynamic provisioning** via StorageClass creates PV on-demand — eliminates manual PV management
- **StatefulSet VolumeClaimTemplates** create individual PVCs per replica — critical for database StatefulSets
- PVC storage can be **expanded** if StorageClass has `allowVolumeExpansion: true`
- **Interview phrasing:** *"A PVC is a developer's declarative request for storage that abstracts away infrastructure details. Kubernetes binds it to the best matching PV, and with dynamic provisioning via StorageClasses, the entire provisioning process is automated"*
- **Production takeaway:** Every stateful application should use its own dedicated PVC — sharing PVCs between pods or StatefulSet replicas is a common mistake that leads to data corruption

---

## 26. Storage Classes

### 🔷 What Are Storage Classes?

A **StorageClass** is a Kubernetes object that defines a **storage profile** — a named configuration that describes a type of storage available in the cluster. It acts as a template for dynamically provisioning PersistentVolumes. When a PVC references a StorageClass, Kubernetes automatically provisions the right type of storage without any manual PV creation.

StorageClasses enable **dynamic provisioning** — the most important storage feature in modern production Kubernetes clusters. Instead of administrators manually creating PVs ahead of time, StorageClasses allow Kubernetes to create exactly the right storage at exactly the right time.

---

### 🔷 Why Do We Need Storage Classes?

**Problems with static provisioning:**
- Administrators must pre-create PVs before developers can use them
- Easy to mismatch sizes — small PVC binds to large PV, wasting expensive storage
- No automation — every new storage request requires manual administrator action
- Hard to enforce storage policies (encryption, performance tier, replication) consistently
- Time-consuming in fast-moving development environments

**StorageClass solutions:**
- Fully automated provisioning — no manual PV creation needed
- Exact-size volumes provisioned matching PVC request
- Storage policies (encryption, performance, replication) enforced at class level
- Multiple tiers of storage offered (fast SSD, standard HDD, replicated, local)
- Default StorageClass handles all PVCs that don't specify a class

---

### 🔷 Core Components of a StorageClass

| Field | Description | Impact |
|---|---|---|
| `provisioner` | CSI driver name that provisions volumes | Must match installed CSI driver |
| `volumeBindingMode` | When to provision: Immediate or WaitForFirstConsumer | Critical for zone-aware storage |
| `reclaimPolicy` | What happens to PV when PVC deleted: Retain or Delete | Data safety critical choice |
| `allowVolumeExpansion` | Can PVC be resized after creation | Important for growing workloads |
| `parameters` | Storage-specific configuration (type, IOPS, encryption) | Performance and compliance |
| `mountOptions` | Filesystem mount options | Performance tuning |

---

### 🔷 Internal Working — Dynamic Provisioning Flow

```
Step 1:  StorageClass created in cluster by administrator
Step 2:  Developer creates PVC referencing StorageClass name
Step 3:  PVC stored in etcd with status: Pending
Step 4:  external-provisioner sidecar (part of CSI controller pod) watches for new PVCs
Step 5:  external-provisioner sees PVC referencing its StorageClass
Step 6:  external-provisioner calls CSI CreateVolume RPC with PVC parameters
Step 7:  CSI driver calls underlying storage API
         (AWS: CreateVolume → EBS API)
         (Azure: CreateDisk → Azure Disk API)
         (GCP: create → GCE PD API)
Step 8:  Storage volume created with requested size and parameters
Step 9:  CSI driver returns volume_handle to external-provisioner
Step 10: external-provisioner creates PV object bound to the PVC
Step 11: PVC status changes: Pending → Bound
Step 12: Pod can now use the PVC — kubelet mounts the provisioned volume
```

---

### 🔷 Architecture Flow

```
┌────────────────────────────────────────────────────────────────────┐
│                      Kubernetes Cluster                            │
│                                                                    │
│  StorageClass (administrator-defined storage profile)              │
│       provisioner: ebs.csi.aws.com                                 │
│       parameters: type=gp3, encrypted=true                         │
│       reclaimPolicy: Retain                                        │
│       volumeBindingMode: WaitForFirstConsumer                      │
│                │                                                   │
│                │  Referenced by                                    │
│                ▼                                                   │
│  PVC (developer creates with storageClassName)                     │
│       status: Pending                                              │
│                │                                                   │
│                │  Watched by                                       │
│                ▼                                                   │
│  external-provisioner (CSI controller sidecar)                     │
│                │                                                   │
│                │  CreateVolume RPC                                 │
│                ▼                                                   │
│  CSI Controller Driver                                             │
│                │                                                   │
│                │  Storage API call                                 │
│                ▼                                                   │
│  External Storage (AWS EBS, Azure Disk, GCE PD, etc.)             │
│                │                                                   │
│                │  Volume created → PV created → PVC Bound         │
└────────────────────────────────────────────────────────────────────┘
```

---

### 🔷 YAML Example — Multiple Storage Classes for Different Use Cases

```yaml
# StorageClass 1: Standard production workloads
# Balanced performance and cost with automatic encryption
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: standard-encrypted
  annotations:
    storageclass.kubernetes.io/is-default-class: "true"
    # Default class: PVCs without storageClassName use this automatically
    # Only ONE StorageClass should have is-default-class: "true"
    # Multiple defaults cause PVC provisioning failures
provisioner: ebs.csi.aws.com
volumeBindingMode: WaitForFirstConsumer
# WaitForFirstConsumer: delays volume creation until pod is scheduled
# Ensures EBS volume is in same AZ as pod — critical for EBS
# Immediate: creates volume immediately when PVC is created
# Use Immediate only for storage NOT tied to specific AZ (NFS, EFS)
reclaimPolicy: Delete
# Delete: PV and EBS volume auto-deleted when PVC deleted
# Suitable for stateless workloads and non-critical data
allowVolumeExpansion: true
parameters:
  type: gp3
  encrypted: "true"
  throughput: "125"
  iops: "3000"

---
# StorageClass 2: High-performance for databases
# Maximum IOPS for transactional workloads
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: high-performance-database
  annotations:
    # NOT the default class — must be explicitly requested
    description: "High-performance io2 EBS for production databases"
provisioner: ebs.csi.aws.com
volumeBindingMode: WaitForFirstConsumer
reclaimPolicy: Retain
# Retain: data preserved when PVC deleted
# MANDATORY for production databases — prevents accidental data loss
# Admin must manually clean up Released PVs after intentional deletion
allowVolumeExpansion: true
parameters:
  type: io2
  # io2: Highest performance EBS type
  # Up to 64,000 IOPS per volume
  # Use for PostgreSQL, MySQL, MongoDB primary data volumes
  iops: "16000"
  # 16,000 IOPS baseline — good for most production databases
  # For extreme workloads: up to 64,000 IOPS
  encrypted: "true"
  kmsKeyId: "arn:aws:kms:us-east-1:123456789012:key/db-key"
  # Dedicated KMS key for database storage — separate audit trail
  throughput: "1000"
  # High throughput for bulk data operations and backups

---
# StorageClass 3: Shared ReadWriteMany storage via NFS CSI
# Use case: content management systems, shared config, logs
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: shared-nfs
  annotations:
    description: "NFS-backed shared storage for multi-pod read-write access"
provisioner: nfs.csi.k8s.io
# NFS CSI driver — supports ReadWriteMany for multi-pod access
# Pods across multiple nodes can mount same volume simultaneously
volumeBindingMode: Immediate
# Immediate: NFS is not zone-specific — volume can bind immediately
# WaitForFirstConsumer not needed for network-attached shared storage
reclaimPolicy: Retain
allowVolumeExpansion: false
# NFS does not support online volume expansion
parameters:
  server: "10.100.1.50"
  share: "/exports/kubernetes"
  mountPermissions: "0755"
mountOptions:
- hard
# hard: NFS mount retries indefinitely on server unavailability
# soft: returns error after timeout — risk of data corruption under load
- nfsvers=4.1
# NFSv4.1: supports parallel NFS (pNFS) for better performance
- timeo=600
# Timeout in 0.1 seconds — 60 seconds before retry

---
# StorageClass 4: Local SSD for ultra-low latency workloads
# Use case: Redis, Kafka, Elasticsearch index data
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: local-nvme-ssd
  annotations:
    description: "Local NVMe SSD — lowest latency, node-pinned"
provisioner: kubernetes.io/no-provisioner
# no-provisioner: no dynamic provisioning — admin manually creates PVs
# Local volumes cannot be dynamically provisioned
# Admin creates PV for each local disk on each node
volumeBindingMode: WaitForFirstConsumer
# WaitForFirstConsumer: MANDATORY for local storage
# Without this: PVC might bind to PV on a different node than where pod lands
reclaimPolicy: Delete
allowVolumeExpansion: false
```

---

### 🔷 Static vs Dynamic Provisioning Comparison

| Aspect | Static Provisioning | Dynamic Provisioning |
|---|---|---|
| **PV Creation** | Manual by admin | Automatic by StorageClass |
| **Timing** | Before PVC creation | On PVC creation |
| **Size matching** | Manual — can waste space | Exact — provisions requested size |
| **Scale** | Poor — doesn't scale | Excellent — fully automated |
| **Use case** | Pre-existing storage migration | All new workloads |
| **Effort** | High admin overhead | Low admin overhead |
| **StorageClass required** | Optional | Required |

---

### 🔷 Default StorageClass Behavior

```bash
# Check which StorageClass is marked as default
kubectl get storageclass
# Look for "(default)" annotation next to a StorageClass name

# PVC without storageClassName uses default StorageClass
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: auto-class-pvc
spec:
  accessModes: [ReadWriteOnce]
  resources:
    requests:
      storage: 20Gi
  # No storageClassName field → uses cluster default StorageClass

# Set a StorageClass as default
kubectl patch storageclass gp2 \
  -p '{"metadata": {"annotations": \
  {"storageclass.kubernetes.io/is-default-class": "true"}}}'

# Remove default annotation from a StorageClass
kubectl patch storageclass old-default \
  -p '{"metadata": {"annotations": \
  {"storageclass.kubernetes.io/is-default-class": "false"}}}'
```

---

### 🔷 Real-World Production Scenario

**Organization:** Financial services firm running Kubernetes on AWS EKS

**Storage class strategy:**

| StorageClass | Backend | Use Case | Reclaim Policy |
|---|---|---|---|
| `standard-encrypted` (default) | EBS gp3 | General workloads, web apps | Delete |
| `database-io2` | EBS io2 | PostgreSQL, MySQL primaries | Retain |
| `archive-sc1` | EBS sc1 | Cold storage, audit log archive | Retain |
| `shared-efs` | AWS EFS | Shared file storage, content | Retain |
| `fast-local` | Local NVMe | Kafka, Redis, Elasticsearch | Delete |

**Compliance enforcement:**
- All StorageClasses have `encrypted: "true"` — enforced by OPA admission controller
- KMS key rotation policy applied to all keys — automated via AWS KMS
- `database-io2` StorageClass only available in `databases` namespace — RBAC-enforced
- Storage class usage audited monthly — unused PVCs deleted after review

---

### 🔷 Debugging StorageClass Issues

```bash
# List all storage classes
kubectl get storageclass
kubectl describe storageclass <sc-name>

# Check which PVCs use a specific StorageClass
kubectl get pvc -A \
  -o custom-columns=\
  'NAMESPACE:.metadata.namespace,NAME:.metadata.name,CLASS:.spec.storageClassName,STATUS:.status.phase'

# Check if CSI driver is registered for provisioner
kubectl get csidrivers | grep <provisioner-name>

# Check external-provisioner logs for provisioning failures
kubectl logs -n kube-system \
  $(kubectl get pod -n kube-system \
    -l app=ebs-csi-controller -o name | head -1) \
  -c csi-provisioner --tail=50

# Check for multiple default StorageClasses (causes PVC issues)
kubectl get storageclass \
  -o jsonpath='{range .items[?(@.metadata.annotations.storageclass\.kubernetes\.io/is-default-class=="true")]}{.metadata.name}{"\n"}{end}'
```

---

### 🔷 CKA Exam Tips

- Know the difference between `Immediate` and `WaitForFirstConsumer` binding modes clearly
- Know that **only one** StorageClass should be default — multiple defaults cause PVC issues
- Understand that `provisioner: kubernetes.io/no-provisioner` means **no dynamic provisioning**
- Know how to make a StorageClass the **default** using annotation
- Be able to write a complete **StorageClass YAML** from memory
- Know that `reclaimPolicy` in StorageClass determines PV behavior — defaults to `Delete`
- Understand `allowVolumeExpansion` — required for resizing PVCs after creation

---

### 🔷 Production Best Practices

- Define **multiple StorageClasses** for different performance tiers — not one size fits all
- Set `WaitForFirstConsumer` for all cloud-backed storage — prevents zone mismatches
- Set `reclaimPolicy: Retain` for any StorageClass used by databases or critical data
- Enable `allowVolumeExpansion: true` on all StorageClasses — growing workloads will need it
- Use dedicated KMS keys per storage tier — better audit trail and key rotation control
- Enforce encryption via StorageClass `parameters.encrypted: "true"` for all production classes
- Regularly audit StorageClass usage — remove unused classes to reduce complexity

---

### 📌 Topic Summary — Storage Classes

- StorageClass is a **storage profile** that enables automatic dynamic PV provisioning
- `provisioner` field specifies which **CSI driver** handles volume creation
- `volumeBindingMode: WaitForFirstConsumer` is **critical for zone-aware storage** like EBS and Azure Disk
- `reclaimPolicy: Retain` must be set on StorageClasses used by **production databases**
- Only **one default StorageClass** should exist in a cluster — multiple defaults cause PVC provisioning failures
- Multiple StorageClasses enable **storage tiering** — fast SSD for databases, standard HDD for general use
- `allowVolumeExpansion: true` enables **online storage resize** without recreating pods
- **Interview phrasing:** *"A StorageClass defines a type of storage with specific characteristics — performance, encryption, binding behavior — and enables dynamic PV provisioning so developers can request storage without manual administrator intervention"*
- **Production takeaway:** Good StorageClass design is the foundation of storage reliability in Kubernetes. Define classes for each performance tier, set appropriate reclaim policies, enforce encryption, and always use WaitForFirstConsumer for cloud-backed storage to avoid zone-related failures

---

# 🌐 PART III: Kubernetes Networking

---

## 27. Linux Networking — Switching, Routing & Gateways

### 🔷 What Is Linux Networking in Kubernetes Context?

Linux networking fundamentals — **switching**, **routing**, **gateways**, and **IP forwarding** — form the bedrock on which Kubernetes networking is built. Every Kubernetes cluster runs on Linux nodes, and all container networking (pod-to-pod, pod-to-service, external traffic) is ultimately implemented using Linux kernel networking primitives. Understanding these fundamentals is essential for troubleshooting Kubernetes network issues at the deepest level.

---

### 🔷 Why Do We Need to Understand It?

- Kubernetes networking errors often trace back to **Linux routing table issues**, **iptables rules**, or **IP forwarding settings**
- CNI plugins (Flannel, Calico, Weave) implement pod networking using Linux bridges, veth pairs, and routing
- Troubleshooting node-level network failures requires comfort with `ip route`, `ip link`, and `netstat`
- Understanding Linux IP forwarding explains **why kubeadm requires it enabled** before cluster initialization
- Network Policy implementation relies on Linux **iptables/eBPF rules** on each node

---

### 🔷 Core Networking Concepts

**1. Network Interface**

Every Linux host has one or more network interfaces (physical or virtual). Each interface connects the host to a network segment.

```bash
# List all network interfaces and their state
ip link

# Sample output on a Kubernetes worker node
1: lo: <LOOPBACK,UP,LOWER_UP> mtu 65536
    inet 127.0.0.1/8 scope host lo
2: eth0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
    inet 192.168.56.101/24 scope global eth0
3: docker0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
    inet 172.17.0.1/16 scope global docker0
4: cni0: <BROADCAST,MULTICAST,UP,LOWER_UP> mtu 1500
    inet 10.244.0.1/24 scope global cni0    ← Kubernetes pod network bridge
```

**2. Switching — Same Network Communication**

Two hosts on the same subnet communicate directly through a switch. No router needed. The switch uses MAC addresses to forward frames.

```bash
# Add IP address to interface
ip addr add 192.168.1.10/24 dev eth0

# Bring interface up
ip link set eth0 up

# Test connectivity on same subnet
ping 192.168.1.11
```

**3. Routing — Cross-Network Communication**

To communicate between different subnets, traffic must pass through a **router**. The router has one interface in each subnet.

```bash
# View current routing table
ip route
# or
route

# Example routing table on a worker node
# Destination     Gateway         Genmask         Iface
# 10.244.0.0      0.0.0.0         255.255.255.0   cni0     ← local pod subnet
# 10.244.1.0      192.168.56.11   255.255.255.0   eth0     ← pods on master node
# 10.244.2.0      192.168.56.12   255.255.255.0   eth0     ← pods on worker-2
# 0.0.0.0         192.168.56.1    0.0.0.0         eth0     ← default gateway

# Add route to reach another pod subnet via specific gateway
ip route add 10.244.2.0/24 via 192.168.56.12

# Add default gateway (all traffic not matching specific routes)
ip route add default via 192.168.56.1
```

**4. IP Forwarding — Critical for Kubernetes**

By default, Linux does **not forward packets** between network interfaces for security reasons. Kubernetes nodes must have IP forwarding enabled because every node acts as a router — forwarding pod traffic between interfaces.

```bash
# Check current IP forwarding status
cat /proc/sys/net/ipv4/ip_forward
# 0 = disabled, 1 = enabled

# Enable temporarily (lost on reboot)
echo 1 > /proc/sys/net/ipv4/ip_forward

# Enable permanently (survives reboot)
echo "net.ipv4.ip_forward = 1" >> /etc/sysctl.conf
sysctl -p

# kubeadm prerequisite check includes this
# Cluster initialization FAILS if IP forwarding is not enabled
```

---

### 🔷 How This Maps to Kubernetes Networking

```
Linux Network Component → Kubernetes Usage
──────────────────────────────────────────────────────────
Network interfaces       → Node's eth0, pod's eth0 via veth
Routing table            → Pod-to-pod cross-node routing
IP forwarding            → Mandatory — nodes route pod traffic
Linux bridge             → CNI creates bridge (cni0, cbr0) for pod connectivity
iptables rules           → kube-proxy implements Service load balancing
ip route                 → CNI installs routes for pod subnet reachability
veth pairs               → Connect pod network namespace to node bridge
```

---

### 🔷 Architecture Flow — Packet Path in Kubernetes

```
Pod A on Node 1 sends packet to Pod B on Node 2
            │
            ▼
Pod A's eth0 (veth pair end inside pod namespace)
            │ via veth pair
            ▼
Node 1's cni0 bridge (Linux bridge, pod subnet gateway)
            │ routing table lookup: 10.244.2.0/24 via 192.168.56.12
            ▼
Node 1's eth0 (node's physical/VM NIC)
            │ across physical/virtual network
            ▼
Node 2's eth0
            │ routing table lookup: 10.244.2.0 local to cni0
            ▼
Node 2's cni0 bridge
            │ ARP resolution → veth pair for Pod B
            ▼
Pod B's eth0 (veth pair end inside Pod B's network namespace)
            │
            ▼
Pod B receives the packet
```

---

### 🔷 YAML Example — kubeadm Node Preparation Network Settings

```bash
# Required Linux network settings before kubeadm init
# These must be configured on ALL nodes (master and workers)

# Step 1: Load required kernel modules
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

# overlay: required by containerd for overlay filesystem
# br_netfilter: required for bridge traffic to pass through iptables
# Without br_netfilter: pod-to-service traffic via iptables BROKEN

sudo modprobe overlay
sudo modprobe br_netfilter

# Step 2: Set required sysctl parameters
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# bridge-nf-call-iptables: bridge traffic passes through iptables
# Required for kube-proxy iptables rules to work with CNI bridge
# Without this: Services don't work between pods on same node

sudo sysctl --system

# Verify settings applied
sysctl net.ipv4.ip_forward
sysctl net.bridge.bridge-nf-call-iptables
```

---

### 🔷 Key Commands for Kubernetes Network Debugging

```bash
# Check all network interfaces on a node
ip link
ip addr

# Check routing table
ip route
route -n

# Check if specific route exists
ip route get 10.244.2.5
# Shows exact path a packet takes to reach that IP

# Check ARP table (MAC-to-IP mappings)
arp -n
ip neigh

# Check listening ports on node
netstat -tlnp
ss -tlnp

# Check active connections
netstat -anp | grep <port>

# Check iptables rules (kube-proxy rules)
iptables -L -n -t nat | grep -i kube
iptables -L -n -t nat | grep KUBE-SVC

# Trace packet path through iptables rules
iptables -t nat -L PREROUTING -n -v

# Check IPVS rules (if kube-proxy uses IPVS mode)
ipvsadm -L -n
```

---

### 🔷 Common Mistakes

- Not enabling IP forwarding on nodes before kubeadm init — cluster initialization fails
- Not loading `br_netfilter` module — pods on same node cannot communicate via Services
- Incorrect subnet configuration — pod CIDR overlaps with node network, causing routing conflicts
- Firewall blocking inter-node traffic on port 10250 (kubelet) or pod network ports
- Not configuring static routes for pod subnets in on-premises environments without CNI auto-routing

---

### 📌 Topic Summary — Linux Networking: Switching, Routing & Gateways

- Linux networking primitives — **bridges, routing tables, veth pairs, iptables** — are the foundation of all Kubernetes networking
- **IP forwarding** must be enabled on every Kubernetes node — nodes act as packet routers for pod traffic
- `br_netfilter` kernel module is **mandatory** for kube-proxy iptables rules to work with CNI bridges
- Linux routing table determines **how packets travel** between pod subnets across nodes
- `ip route`, `ip link`, `ip addr`, `iptables` are the **essential debugging tools** for Kubernetes network issues
- **Interview phrasing:** *"Kubernetes networking is built entirely on Linux kernel primitives. Understanding routing tables, IP forwarding, veth pairs, and iptables is essential for diagnosing and resolving complex network issues in production clusters"*
- **Production takeaway:** Before deploying a Kubernetes cluster, verify all nodes have IP forwarding enabled, br_netfilter loaded, and no network policy or firewall blocking inter-node communication on required ports

---

# 28. DNS Prerequisites

## 🔷 What Is DNS in the Kubernetes Context?

DNS (Domain Name System) is the system that translates human-readable hostnames into IP addresses. In Kubernetes, DNS is foundational to **service discovery** — how pods find and communicate with services without hardcoding IP addresses. Understanding DNS at the Linux system level is a prerequisite for understanding how Kubernetes **CoreDNS** works and how to troubleshoot DNS resolution failures inside pods.

Before CoreDNS handles Kubernetes-internal resolution, the underlying Linux networking stack on each node must be correctly configured with DNS resolution mechanisms. This section explores those foundational building blocks.

---

## 🔷 Why Do We Need DNS?

In any distributed system, services talk to each other. In a Kubernetes cluster with hundreds of pods and services, IP addresses change constantly — pods restart, scale up/down, and get rescheduled. **Hardcoding IPs is impossible and fragile.** DNS provides a stable naming layer that abstracts away IP changes.

Without DNS:
- Every pod would need environment variable injection of every other service's IP
- Any pod restart or service recreation would break connectivity
- Multi-namespace communication would be unmanageable
- Blue/green deployments and canary releases would require manual IP management

With DNS:
- A pod simply calls `curl http://web-service` and DNS resolves the current IP automatically
- Services can move, scale, and be replaced without disrupting callers

---

## 🔷 Core Components Involved

| Component | Role |
|---|---|
| `/etc/hosts` | Local static hostname-to-IP mapping on each Linux host |
| `/etc/resolv.conf` | Configures which DNS server to query, search domains |
| `/etc/nsswitch.conf` | Defines resolution order: files first, then DNS |
| `nameserver` entry | IP of the DNS server (e.g., `8.8.8.8` or CoreDNS ClusterIP) |
| `search` domains | Suffixes appended when a short hostname can't be resolved |
| `nslookup` / `dig` | DNS querying tools for debugging |
| CoreDNS (in-cluster) | The Kubernetes DNS server that resolves service/pod names |

---

## 🔷 Internal Working — Step-by-Step DNS Resolution on Linux

### Step 1 — Check Local `/etc/hosts` First
When a process inside a pod or a node tries to resolve a hostname, the Linux resolver checks `/etc/hosts` first (controlled by `/etc/nsswitch.conf` order: `files dns`).

```bash
cat /etc/nsswitch.conf
# hosts: files dns
```

If an entry exists in `/etc/hosts`, resolution stops here — no DNS query is made.

```bash
# /etc/hosts example
192.168.1.11    db
192.168.1.11    www.google.com   # This would intercept ALL google lookups!
```

### Step 2 — Query the Configured DNS Server
If no match is found in `/etc/hosts`, the resolver queries the nameserver specified in `/etc/resolv.conf`:

```bash
cat /etc/resolv.conf
nameserver  192.168.1.100       # Internal DNS server
search      default.svc.cluster.local svc.cluster.local cluster.local
```

The `nameserver` line points to either:
- An enterprise internal DNS server
- Google's public DNS (`8.8.8.8`)
- Kubernetes CoreDNS ClusterIP (inside pods: `10.96.0.10`)

### Step 3 — Search Domain Expansion
When a short hostname like `web-service` is queried, the resolver appends each `search` domain in sequence:

```
web-service → web-service.default.svc.cluster.local → resolved ✅
```

This is exactly how Kubernetes pods can call `curl http://web-service` without the full FQDN.

### Step 4 — Hierarchical DNS Resolution for External Names
For external domains (e.g., `www.google.com`), the internal DNS server forwards to:
- A root DNS server → `.com` TLD server → Google's authoritative server
- Result is cached locally (TTL-based)

---

## 🔷 Architecture Flow

```
Pod Process
    │
    ▼
/etc/nsswitch.conf  ──► "files" → check /etc/hosts
    │
    ▼ (not found in /etc/hosts)
/etc/resolv.conf  ──► nameserver 10.96.0.10 (CoreDNS ClusterIP)
    │
    ▼
CoreDNS Pod (kube-system namespace)
    │
    ├──► Kubernetes internal? → Resolve from etcd-backed service registry
    │
    └──► External domain? → Forward to upstream DNS (/etc/resolv.conf of node)
              │
              ▼
          Public Internet DNS (8.8.8.8 → Root → TLD → Authoritative)
```

---

## 🔷 DNS Record Types

| Record Type | Purpose | Example |
|---|---|---|
| **A** | Hostname → IPv4 address | `web-server → 192.168.1.10` |
| **AAAA** | Hostname → IPv6 address | `web-server → 2001:db8::1` |
| **CNAME** | Alias → another hostname | `food.web-server → eat.web-server` |
| **PTR** | Reverse DNS (IP → hostname) | `10.1.2.3 → pod-name.namespace` |
| **SRV** | Service discovery with port info | Used by some service meshes |

---

## 🔷 DNS Debugging Tools

### `nslookup` — Queries DNS server only (ignores `/etc/hosts`)
```bash
nslookup www.google.com
# Server:    8.8.8.8
# Address:   8.8.8.8#53
# Name:      www.google.com
# Address:   172.217.0.132
```

> ⚠️ **Critical CKA Tip**: `nslookup` does NOT check `/etc/hosts`. Use `ping` or `getent hosts` to check local resolution. This distinction matters for troubleshooting.

### `dig` — Detailed DNS query analysis
```bash
dig www.google.com
# Shows: query time, server used, TTL, answer section
```

### `ping` — Tests both DNS resolution AND network reachability
```bash
ping db
# PING db (192.168.1.11): 56 bytes of data...
```

---

## 🔷 Real-World Production Scenario

**Scenario**: A microservices e-commerce platform where the `payment-service` pod cannot reach `fraud-detection-service`.

**Debugging Flow**:
```bash
# Step 1: Exec into the payment-service pod
kubectl exec -it payment-service-xxx -- /bin/sh

# Step 2: Check resolv.conf — is CoreDNS configured?
cat /etc/resolv.conf

# Step 3: Try full FQDN
nslookup fraud-detection-service.fraud-ns.svc.cluster.local

# Step 4: If FQDN works but short name fails → search domain misconfiguration
# Step 5: If FQDN fails → CoreDNS issue → check CoreDNS pods
kubectl get pods -n kube-system | grep coredns
kubectl logs -n kube-system coredns-xxx
```

---

## 🔷 Common Mistakes

| Mistake | Impact |
|---|---|
| Not understanding `search` domains | Misdiagnose "DNS broken" when it's actually a namespace issue |
| Using `nslookup` to test `/etc/hosts` | Will miss local overrides |
| Forgetting that `/etc/hosts` takes precedence | Security risk if compromised |
| Misconfiguring nameserver in custom pods | Pod can't resolve any services |
| Not checking CoreDNS logs during DNS failures | Miss root cause entirely |

---

## 🔷 CKA Exam Tips

- Know the order: **files → DNS** (from `/etc/nsswitch.conf`)
- Know what `/etc/resolv.conf` does and what `search` domains mean
- Know that `nslookup` bypasses `/etc/hosts`
- Be able to explain why `curl web-service` works (search domain expansion)
- Understand FQDN format: `<service>.<namespace>.svc.cluster.local`

---

## 🔎 Topic Summary — DNS Prerequisites

- **DNS translates hostnames to IPs**, enabling stable service communication despite dynamic pod IPs
- **Resolution order** is controlled by `/etc/nsswitch.conf`: local `/etc/hosts` first, then DNS server
- **`/etc/resolv.conf`** configures the DNS server IP and search domain suffixes
- **Search domains** allow short names like `web-service` to be expanded to full FQDNs automatically
- **`nslookup`** only queries DNS — it ignores `/etc/hosts`; use `ping` for full resolution testing
- **Inside Kubernetes pods**, `/etc/resolv.conf` points to CoreDNS's ClusterIP (`10.96.0.10`)
- **Production takeaway**: Every DNS failure troubleshooting session starts with checking these Linux-level primitives before blaming Kubernetes

---

# 29. Network Namespaces

## 🔷 What Are Network Namespaces?

A **Linux network namespace** is a kernel-level isolation mechanism that provides a completely independent network stack for a process group. Each namespace has its own:
- Network interfaces
- IP addresses
- Routing tables
- ARP cache
- iptables rules
- Sockets

This is the **foundational technology** that Docker and Kubernetes use to isolate container networking. When a container is created, it gets its own network namespace — it cannot see or directly access the host's network interfaces or those of other containers.

---

## 🔷 Why Do We Need Network Namespaces?

Without network namespaces:
- All containers on a host would share the same network stack
- Port conflicts would occur constantly (two containers can't both listen on port 80)
- One container could intercept or inspect another container's traffic
- Security isolation would be impossible

With network namespaces:
- Each container believes it has its own network interface (typically `eth0`)
- Port 80 in container A doesn't conflict with port 80 in container B
- Network traffic is isolated by default
- Kubernetes network policies can enforce inter-pod communication rules

---

## 🔷 Core Components

| Component | Role |
|---|---|
| `ip netns` | Linux command to create/manage/inspect network namespaces |
| `veth pair` | Virtual Ethernet cable — connects a namespace to a bridge |
| `bridge` | Virtual switch on the host connecting multiple namespaces |
| ARP table | Maps IP→MAC within each namespace independently |
| Routing table | Per-namespace routes (created with `ip route`) |
| `ip link` | Shows/modifies network interfaces |
| `iptables / NAT` | Used to enable external connectivity from namespaces |

---

## 🔷 Internal Working — Step-by-Step

### Step 1 — Create Network Namespaces
```bash
ip netns add red
ip netns add blue
```

Each namespace is completely isolated — no interfaces, no routes.

### Step 2 — Inspect Isolation
```bash
# Host sees its interfaces:
ip link
# eth0, lo

# Red namespace sees NOTHING initially:
ip netns exec red ip link
# lo (only loopback)
```

### Step 3 — Connect Two Namespaces with a veth Pair
```bash
# Create virtual cable with two ends
ip link add veth-red type veth peer name veth-blue

# Attach each end to its namespace
ip link set veth-red netns red
ip link set veth-blue netns blue

# Assign IPs
ip -n red addr add 192.168.15.1/24 dev veth-red
ip -n blue addr add 192.168.15.2/24 dev veth-blue

# Bring interfaces up
ip -n red link set veth-red up
ip -n blue link set veth-blue up
```

### Step 4 — Test Connectivity
```bash
ip netns exec red ping 192.168.15.2
# 64 bytes from 192.168.15.2: icmp_seq=1 ttl=64
```

### Step 5 — Scale with a Bridge (Virtual Switch)
For more than 2 namespaces, use a bridge:

```bash
# Create bridge
ip link add v-net-0 type bridge
ip link set v-net-0 up

# Assign IP to bridge (allows host to communicate with namespaces)
ip addr add 192.168.15.5/24 dev v-net-0

# Create veth pairs for each namespace connecting to bridge
ip link add veth-red type veth peer name veth-red-br
ip link set veth-red netns red
ip link set veth-red-br master v-net-0

ip link add veth-blue type veth peer name veth-blue-br
ip link set veth-blue netns blue
ip link set veth-blue-br master v-net-0
```

### Step 6 — Enable External Connectivity (NAT)
```bash
# Add default route in namespace
ip netns exec blue ip route add default via 192.168.15.5

# Enable IP forwarding on host
echo 1 > /proc/sys/net/ipv4/ip_forward

# NAT masquerade — translate namespace IPs to host's external IP
iptables -t nat -A POSTROUTING -s 192.168.15.0/24 -j MASQUERADE
```

---

## 🔷 Architecture Flow — How This Becomes Kubernetes Pod Networking

```
Kubernetes Node
┌──────────────────────────────────────────────────────┐
│                                                        │
│  Pod A (netns-a)          Pod B (netns-b)              │
│  ┌──────────────┐         ┌──────────────┐            │
│  │ eth0: 10.x.x │         │ eth0: 10.x.y │            │
│  └──────┬───────┘         └──────┬───────┘            │
│         │ veth-a                 │ veth-b              │
│         └──────────┬─────────────┘                    │
│                    │                                    │
│             ┌──────▼──────┐                            │
│             │  cni0/cbr0  │ (Bridge / Virtual Switch)  │
│             │  Node Bridge│                            │
│             └──────┬──────┘                            │
│                    │                                    │
│             ┌──────▼──────┐                            │
│             │    eth0     │ (Host Physical Interface)   │
│             │ 192.168.1.x │                            │
│             └──────┬──────┘                            │
└────────────────────┼───────────────────────────────────┘
                     │
              Physical Network / VPC
```

Each pod gets its own **network namespace** with a **veth pair** connecting to the node's **bridge interface**. This is exactly what CNI plugins (Weave, Calico, Flannel) implement automatically.

---

## 🔷 How Processes Are Isolated

```bash
# Inside a container — sees only its own processes
ps aux
# PID 1: nginx

# On the host — sees ALL processes including containers
ps aux
# PID 1: systemd
# PID 3816: nginx (same nginx, different PID from host perspective)
```

This demonstrates PID namespace isolation working alongside network namespace isolation.

---

## 🔷 Real-World Production Scenario

**Scenario**: Security team requires complete network isolation between a payment processing pod and a logging pod on the same node.

**How Kubernetes achieves this**:
1. Each pod gets its own network namespace at creation time
2. The CNI plugin creates a veth pair connecting the pod namespace to the node bridge
3. Network policies are enforced via iptables rules in the host namespace
4. Even though both pods are on the same physical machine, they cannot communicate unless explicitly permitted

**Verification**:
```bash
# Check pod's network namespace on the node
crictl pods
# Find the container ID, then:
nsenter -t <PID> -n ip addr
# Shows the pod's isolated network interfaces
```

---

## 🔷 Common Mistakes

| Mistake | Impact |
|---|---|
| Forgetting to enable IP forwarding | Namespace-to-external communication fails silently |
| Not adding default route in namespace | Namespace can only reach its local subnet |
| Deleting veth pair without cleanup | Orphaned bridge entries causing IP conflicts |
| Not understanding that container restarts create new veth pairs | Stale iptables rules can block new pods |

---

## 🔷 CKA Exam Tips

- Understand that **each pod = one network namespace** (by default; sidecar containers share it)
- Know that `ip netns exec <ns> <cmd>` is how you inspect/operate inside a namespace
- Understand the **veth pair → bridge → node eth0** chain
- Know that ARP and routing tables are **per-namespace**
- Understand why `kubectl exec pod -- ip addr` shows a different IP than the host's `ip addr`

---

## 🔎 Topic Summary — Network Namespaces

- **Network namespaces** provide complete kernel-level network isolation for containers
- **Each pod** in Kubernetes runs in its own network namespace with isolated interfaces, routes, and ARP tables
- **veth pairs** act as virtual cables connecting a pod's namespace to the node's bridge network
- **Bridge networks** (like `cni0`) act as virtual switches aggregating all pod connections on a node
- **NAT/iptables** enables external connectivity from isolated namespaces
- **This is the foundation of ALL Kubernetes pod networking** — CNI plugins automate what we did manually above
- **Production takeaway**: Understanding namespaces is critical for debugging pod networking issues and understanding how CNI plugins work

---

# 30. Docker Networking

## 🔷 What Is Docker Networking?

Docker networking defines how containers communicate with each other, with the host, and with the external world. Docker implements networking using Linux network namespaces, bridge networks, veth pairs, and iptables — the same primitives we explored in the previous section. Understanding Docker networking is a direct prerequisite for understanding Kubernetes pod networking.

---

## 🔷 Docker Networking Modes

### Mode 1: None Network
```bash
docker run --network none nginx
```
- Container has **no network interfaces** (except loopback `lo`)
- Complete network isolation
- Use case: batch processing jobs, security-sensitive workloads

### Mode 2: Host Network
```bash
docker run --network host nginx
```
- Container **shares the host's network namespace entirely**
- No isolation — container's port 80 IS the host's port 80
- Use case: performance-critical applications where network overhead matters
- **Risk**: Port conflicts between containers and host services

### Mode 3: Bridge Network (Default)
```bash
docker run nginx
# Automatically connects to default "bridge" network
```
- Docker creates a virtual bridge `docker0` (172.17.0.1/16 by default)
- Each container gets its own network namespace
- Connected to bridge via veth pair
- Containers can communicate with each other via the bridge
- External access requires **port mapping (NAT)**

---

## 🔷 Architecture Flow — Bridge Network

```
External User (port 8080)
        │
        ▼
   Host eth0 (192.168.1.10:8080)
        │
        ▼ iptables DNAT rule
   docker0 bridge (172.17.0.1)
        │
   ┌────┴────────────────┐
   │                     │
veth pair A          veth pair B
   │                     │
Container A          Container B
(172.17.0.2)         (172.17.0.3)
```

---

## 🔷 Port Mapping (NAT)

When a container runs a web server on port 80 but needs to be accessible externally:

```bash
docker run -p 8080:80 nginx
```

Docker adds an **iptables DNAT rule**:
```bash
iptables -t nat -A PREROUTING -j DNAT --dport 8080 --to-destination 172.17.0.2:80
```

This translates:
- Incoming traffic on `host:8080` → Container `172.17.0.2:80`

Verify the NAT rules:
```bash
iptables -nvL -t nat
# Chain DOCKER
# DNAT tcp -- anywhere anywhere tcp dpt:8080 to:172.17.0.2:80
```

---

## 🔷 How Kubernetes Extends Docker Networking

Kubernetes doesn't use Docker's default bridge network directly. Instead:
1. Kubernetes creates a **per-pod network namespace** (same as Docker containers)
2. A **CNI plugin** (not Docker) manages the veth pairs and bridge connections
3. The CNI plugin assigns IPs from a cluster-wide CIDR (e.g., `10.244.0.0/16`)
4. Kubernetes uses **kube-proxy** (not Docker's iptables) for service traffic management

The key difference: **Docker networking is single-host; Kubernetes networking spans the entire cluster.**

---

## 🔷 Real-World Scenario

**Scenario**: Developer runs multiple microservices locally with Docker and notices service A can't reach service B.

**Root Cause Investigation**:
```bash
# Check which network containers are on
docker inspect container_a | grep NetworkMode
docker inspect container_b | grep NetworkMode

# If on different user-defined networks → they can't communicate by default
# Solution: Connect both to same network
docker network connect my-network container_a
docker network connect my-network container_b
```

**Production Insight**: In Kubernetes, this problem doesn't exist — **all pods share one flat network** (enforced by CNI plugins) and can reach each other by IP unless blocked by NetworkPolicy.

---

## 🔷 CKA Exam Tips

- Know that `docker0` is the default bridge interface created by Docker installation
- Understand that **port mapping = iptables DNAT rules**
- Know the difference between `kube-proxy` (Kubernetes service traffic) and `kubectl proxy` (API server access)
- Understand that **Kubernetes pods don't use Docker's networking** — they use CNI plugins

---

## 🔎 Topic Summary — Docker Networking

- Docker provides **three main networking modes**: none (isolation), host (shared), bridge (default with isolation)
- **Bridge mode** uses `docker0` virtual switch + veth pairs + network namespaces
- **Port mapping** works via iptables DNAT rules translating host ports to container ports
- **Kubernetes does not use Docker networking** — it uses CNI plugins for cluster-wide pod networking
- The **same Linux primitives** (veth, bridge, iptables, namespaces) power both Docker and Kubernetes networking
- **Production takeaway**: Mastering Docker networking concepts makes Kubernetes CNI troubleshooting significantly easier

---

# 31. Cluster Networking

## 🔷 What Is Cluster Networking?

Cluster networking refers to the network configuration required for all nodes in a Kubernetes cluster to communicate correctly. This includes the physical/virtual network interfaces on each node, the IP address assignments, required open ports for Kubernetes components, and the routing configuration that allows the cluster to function.

---

## 🔷 Node Network Requirements

Every node in a Kubernetes cluster must have:
- At least **one network interface** configured with an IP address
- A **unique hostname** (cannot have two nodes with the same name)
- A **unique MAC address** (critical when cloning VMs — clone generates a new MAC but may reuse the same hostname)

---

## 🔷 Required Ports — Master Node (Control Plane)

| Port | Component | Description |
|---|---|---|
| **6443** | kube-apiserver | All cluster communication goes through here |
| **10250** | kubelet | API for node health monitoring |
| **10259** | kube-scheduler | Internal scheduler communication |
| **10257** | kube-controller-manager | Controller manager operations |
| **2379** | etcd client | API server reads/writes to etcd |
| **2380** | etcd peer | etcd cluster member-to-member communication (HA) |

### Required Ports — Worker Nodes

| Port Range | Component | Description |
|---|---|---|
| **10250** | kubelet | Same as master — node management |
| **30000–32767** | NodePort Services | External traffic to exposed services |

---

## 🔷 Architecture Flow — Network Communication Paths

```
External Client
      │
      ▼ (port 30000–32767)
Worker Node eth0
      │
      ▼ kube-proxy / iptables
NodePort Service
      │
      ▼
Pod Network (CNI: 10.244.0.0/16)
      │
      ▼
Individual Pod

Admin / CI-CD System
      │
      ▼ (port 6443 - TLS)
kube-apiserver (Master Node)
      │
      ├──► etcd (port 2379) — state storage
      │
      ├──► kubelet (port 10250) — node management
      │
      └──► kube-scheduler (port 10259) — pod placement
           kube-controller-manager (port 10257) — reconciliation
```

---

## 🔷 Key Network Verification Commands

```bash
# List all network interfaces
ip link

# Show IP addresses assigned
ip addr

# Assign IP (temporary)
ip addr add 192.168.1.10/24 dev eth0

# View routing table
route
# or
ip route

# Add a route
ip route add 192.168.1.0/24 via 192.168.2.1

# Check if IP forwarding is enabled (required for routing between pods)
cat /proc/sys/net/ipv4/ip_forward
# Should return: 1

# Check ARP table
arp

# Check listening ports and active connections
netstat -plnt
# -p: show process name
# -l: show only LISTENING ports
# -n: show numeric IPs (don't resolve)
# -t: TCP only

# Useful for verifying kube-apiserver, etcd, kubelet are listening
netstat -plnt | grep 6443
```

---

## 🔷 Real-World Production Scenario

**Scenario**: New worker node added to cluster but `kubectl get nodes` shows it as `NotReady`.

**Systematic Network Check**:
```bash
# On the new worker node:
# 1. Check interface is up and has IP
ip addr show eth0

# 2. Can it reach the master's API server port?
curl -k https://<master-ip>:6443

# 3. Is kubelet running?
systemctl status kubelet

# 4. Check if required ports are open in firewall
netstat -plnt | grep 10250

# 5. Check for hostname conflicts
hostname
# On master: kubectl get nodes

# 6. Check kubelet logs for API server connectivity issues
journalctl -u kubelet -f
```

---

## 🔷 Common Mistakes

| Mistake | Impact |
|---|---|
| Duplicate hostnames when cloning VMs | Node registration conflicts |
| Firewall blocking port 6443 | kubectl commands fail from all clients |
| Firewall blocking port 10250 | kube-apiserver can't get node metrics |
| Not enabling IP forwarding | Pod-to-pod routing across nodes fails |
| Using overlapping CIDRs for pods and services | Routing chaos, silent packet drops |

---

## 🔷 CKA Exam Tips

- **Memorize the port table** — exam questions directly test this
- Know that `netstat -plnt` shows listening ports with process names
- Know that `ip route` / `route` shows the routing table
- Understand that port **6443** = kube-apiserver (HTTPS)
- Understand that port **2379** = etcd client, **2380** = etcd peer (HA clusters)
- Know that **NodePort range** is 30000–32767

---

## 🔎 Topic Summary — Cluster Networking

- Every node needs **unique IP, hostname, and MAC** — VM cloning is a common source of conflicts
- **kube-apiserver on port 6443** is the central communication hub for the entire cluster
- **etcd uses ports 2379 (client) and 2380 (peer)** — port 2380 only matters in multi-master HA setups
- **Worker nodes need port 10250** (kubelet) open for the control plane to manage them
- **NodePort range 30000–32767** is where services are exposed externally on worker nodes
- Key diagnostic commands: `ip addr`, `ip route`, `netstat -plnt`, `arp`, `ip link`
- **Production takeaway**: Always verify network requirements and firewall rules before adding nodes to a cluster

---

# 32. Pod Networking

## ���� What Is Pod Networking?

Pod networking is the system that enables every pod in a Kubernetes cluster to:
1. Have a **unique IP address** (no two pods share an IP, even across nodes)
2. **Communicate with every other pod** on any node without NAT
3. **Communicate with services** using stable IP/DNS names

This is the **Kubernetes networking model** — sometimes called the "flat network" model — and it is the most critical networking concept for the CKA exam.

---

## 🔷 Kubernetes Networking Model Requirements

Kubernetes **mandates** (does not implement itself) the following:
1. Every pod gets its own IP address
2. All pods can reach all other pods using their IP addresses (no NAT between pods on different nodes)
3. Agents on a node (kubelet, system daemons) can communicate with all pods on that node

**Kubernetes does NOT implement pod networking itself.** It delegates this to **CNI plugins**.

---

## 🔷 How Pod Networking Works — Step by Step

### Phase 1: Single Node Pod Communication

When two pods are on the **same node**:

```
Pod A (10.244.1.2)          Pod B (10.244.1.3)
     │                           │
  veth-a                      veth-b
     └──────────────────────────┘
              cni0 bridge
              (10.244.1.1)
                   │
              Node eth0
```

1. Pod A sends packet to `10.244.1.3`
2. Packet goes through veth-a to cni0 bridge
3. Bridge performs ARP lookup for `10.244.1.3`
4. Packet delivered to veth-b → Pod B

### Phase 2: Cross-Node Pod Communication

When pods are on **different nodes**:

```
Node 1                              Node 2
─────────────────                   ─────────────────
Pod A (10.244.1.2)                  Pod C (10.244.2.2)
     │                                   │
  cni0 (10.244.1.1)               cni0 (10.244.2.1)
     │                                   │
  Node eth0                         Node eth0
  (192.168.1.11)                    (192.168.1.12)
         │                                │
         └──────── Physical Network ──────┘
```

For Pod A to reach Pod C:
1. Pod A sends packet to `10.244.2.2`
2. Node 1's routing table: "For `10.244.2.0/24`, route via `192.168.1.12`"
3. Packet sent from Node 1 `eth0` to Node 2 `eth0` (via physical/VPC network)
4. Node 2 routing: "For `10.244.2.0/24`, send to cni0"
5. cni0 bridge on Node 2 delivers to Pod C

**This routing table setup is exactly what CNI plugins automate.**

---

## 🔷 Manual CNI Script (Understanding What CNI Does)

The CNI plugin executes a script with parameters at pod creation:

```bash
# CNI "add" command — called when a pod is created
./net-script.sh add <container-id> <namespace>

# Inside the script:
# 1. Create veth pair
ip link add veth-in-pod type veth peer name veth-on-host

# 2. Move one end into the pod's namespace
ip link set veth-in-pod netns <pod-namespace>

# 3. Connect the other end to the bridge
ip link set veth-on-host master cni0

# 4. Assign IP to pod interface
ip -n <pod-namespace> addr add 10.244.1.5/24 dev veth-in-pod

# 5. Add default route in pod
ip -n <pod-namespace> route add default via 10.244.1.1

# 6. Bring up interfaces
ip -n <pod-namespace> link set veth-in-pod up
ip link set veth-on-host up
```

---

## 🔷 Architecture Flow — Full Pod Networking Stack

```
kubectl create pod nginx
      │
      ▼
kube-apiserver stores in etcd
      │
      ▼
kube-scheduler assigns pod to Node 2
      │
      ▼
kubelet on Node 2 receives pod spec
      │
      ▼
kubelet calls container runtime (containerd)
      │
      ▼
Container runtime creates container
      │
      ▼
kubelet calls CNI plugin with "add" command
      │
      ▼
CNI plugin:
  1. Creates network namespace for pod
  2. Creates veth pair
  3. Assigns IP from IPAM (IP Address Management)
  4. Connects to bridge (cni0)
  5. Sets up routes
      │
      ▼
Pod has IP 10.244.2.5, can communicate cluster-wide
```

---

## 🔷 YAML — Understanding CNI Bridge Config

```yaml
# /etc/cni/net.d/10-bridge.conf
# This file tells the container runtime which CNI plugin to use
{
  "cniVersion": "0.2.0",
  "name": "mynet",
  "type": "bridge",           # Use the bridge CNI plugin
  "bridge": "cni0",           # Name of the Linux bridge to use
  "isGateway": true,          # Bridge gets an IP (acts as default gateway for pods)
  "ipMasq": true,             # Enable NAT for pod-to-external traffic
  "ipam": {
    "type": "host-local",     # IP management: allocate from local file
    "subnet": "10.244.0.0/16",
    "routes": [
      { "dst": "0.0.0.0/0" } # Default route: all traffic goes to bridge
    ]
  }
}
```

---

## 🔷 Real-World Production Scenario

**Application**: A 3-tier application (frontend, backend API, database) spread across 3 nodes.

**Infrastructure**:
- Node 1: Frontend pods (10.244.1.x)
- Node 2: Backend API pods (10.244.2.x)
- Node 3: Database pods (10.244.3.x)

**Communication Flow**:
```
Browser → NodePort (Node1:30080) → Frontend Pod
                                       │
                           HTTP to backend-service (ClusterIP)
                                       │
                                       ▼ kube-proxy routes
                               Backend API Pod (Node 2)
                                       │
                           TCP to database-service (ClusterIP)
                                       │
                                       ▼ kube-proxy routes
                                Database Pod (Node 3)
```

**Troubleshooting cross-node connectivity**:
```bash
# Verify pod IPs
kubectl get pods -o wide

# Test direct pod-to-pod connectivity (bypass services)
kubectl exec -it frontend-pod -- curl http://10.244.2.5:8080

# If direct pod IP works but service doesn't → kube-proxy issue
# If direct pod IP fails → CNI/routing issue

# Check node routes
ip route show | grep 10.244
```

---

## 🔷 Common Mistakes

| Mistake | Impact |
|---|---|
| Overlapping pod CIDR with service CIDR | Routing ambiguity, packet drops |
| Overlapping pod CIDR with host network | ARP conflicts |
| CNI plugin not installed | Pods stuck in `ContainerCreating` forever |
| Wrong CNI config file permissions | CNI plugin not invoked |
| Pod CIDR too small for cluster size | IP exhaustion as cluster grows |

---

## 🔷 CKA Exam Tips

- Know the Kubernetes networking model: **every pod gets unique IP, no NAT between pods**
- Understand CNI plugin role: **kubelet calls CNI, CNI sets up networking**
- Know CNI binary location: `/opt/cni/bin/`
- Know CNI config location: `/etc/cni/net.d/`
- Understand that **kubelet parameter `--network-plugin=cni`** enables CNI
- Be able to identify why pods are stuck in `ContainerCreating` (often CNI not configured)

---

## 🔎 Topic Summary — Pod Networking

- **Every pod gets a unique IP** — this is a hard requirement of the Kubernetes networking model
- **Pods communicate without NAT** — direct IP-to-IP across the entire cluster
- **CNI plugins** (Calico, Flannel, Weave) automate the veth/bridge/route setup that we explored manually
- **Pod CIDR** (e.g., `10.244.0.0/16`) must not overlap with node IPs or service CIDR
- **CNI binaries** live in `/opt/cni/bin/`, **CNI config** in `/etc/cni/net.d/`
- **Troubleshooting**: `ContainerCreating` forever = CNI not configured; cross-node failure = routing issue
- **Production takeaway**: Choose your CNI plugin carefully based on scale, network policy needs, and cloud provider compatibility

---

# 33. CNI in Kubernetes

## 🔷 What Is CNI?

The **Container Network Interface (CNI)** is a specification and a set of libraries that defines how container runtimes (like containerd or CRI-O) should configure networking for containers. It standardizes the interface between container orchestrators and networking solutions, allowing any CNI-compliant plugin to work with any CNI-compliant orchestrator.

---

## 🔷 Why CNI Exists

Before CNI, every container runtime had its own networking implementation baked in. Docker had its own network model, rkt had another, and Kubernetes initially used Docker's networking. As multiple container runtimes and networking solutions emerged, maintaining compatibility was impossible.

CNI solves this by defining:
1. A standard configuration file format
2. Standard command-line arguments (ADD, DEL, CHECK)
3. Standard return values

Now a networking vendor (like Calico) only needs to write **one CNI plugin** that works with **all CNI-compliant runtimes**.

---

## 🔷 How CNI Works in Kubernetes

### The Flow:
```
Pod creation requested
      │
      ▼
kubelet creates the container (via containerd/CRI-O)
      │
      ▼
kubelet reads CNI config from /etc/cni/net.d/
      │
      ▼ (selects first config alphabetically)
kubelet calls CNI plugin binary from /opt/cni/bin/
with "ADD" command + container namespace + container ID
      │
      ▼
CNI plugin sets up networking (veth, IP, routes)
      │
      ▼
kubelet receives success response with pod IP
      │
      ▼
Pod is Running with configured IP
```

---

## 🔷 CNI Configuration File Structure

```json
# /etc/cni/net.d/10-bridge.conf
{
  "cniVersion": "0.2.0",
  "name": "mynet",
  "type": "bridge",        # References binary: /opt/cni/bin/bridge
  "bridge": "cni0",
  "isGateway": true,
  "ipMasq": true,
  "ipam": {
    "type": "host-local",  # IP allocation plugin
    "subnet": "10.22.0.0/16",
    "routes": [
      { "dst": "0.0.0.0/0" }
    ]
  }
}
```

**File naming convention**: The file starting with the lowest number is used first (alphabetical order within same prefix numbers).

---

## 🔷 CNI Plugin Directories

```bash
# CNI plugin binaries
ls /opt/cni/bin/
# bridge  dhcp  flannel  host-local  ipvlan  loopback
# macvlan  portmap  ptp  sample  tuning  vlan
# weave-net  calico  calico-ipam  ...

# CNI configuration files
ls /etc/cni/net.d/
# 10-calico.conflist
# 10-flannel.conflist
```

---

## 🔷 Popular CNI Plugins Compared

| Plugin | Key Feature | Use Case |
|---|---|---|
| **Flannel** | Simple overlay network | Small clusters, simplicity |
| **Calico** | Network policies + BGP routing | Enterprise, large-scale |
| **Weave Net** | Encrypted overlay, simple setup | Multi-cloud |
| **Cilium** | eBPF-based, L7 policies | High-performance, observability |
| **AWS VPC CNI** | Native VPC IPs for pods | AWS EKS |
| **Azure CNI** | Native Azure VNet IPs | AKS |

> ⚠️ **Critical**: **Flannel does NOT support Kubernetes NetworkPolicy**. If you need network policies, you must use Calico, Cilium, or Weave Net.

---

## 🔷 Architecture Flow

```
                    Kubernetes Node
┌─────────────────────────────────────────────────────────┐
│                                                          │
│  kubelet                                                 │
│  (--network-plugin=cni)                                  │
│     │                                                    │
│     ▼                                                    │
│  Reads: /etc/cni/net.d/10-bridge.conf                    │
│     │                                                    │
│     ▼                                                    │
│  Executes: /opt/cni/bin/bridge ADD ...                   │
│     │                                                    │
│     ▼                                                    │
│  CNI Plugin creates:                                     │
│  ┌──────────────────────────────────────────────────┐   │
│  │  Pod Network Namespace (eth0: 10.244.x.y)        │   │
│  │  ←→ veth pair ←→ cni0 bridge (10.244.x.1)        │   │
│  └──────────────────────────────────────────────────┘   │
└─────────────────────────────────────────────────────────┘
```

---

## 🔷 Checking CNI Configuration in a Running Cluster

```bash
# Find which CNI plugin is being used
ls /etc/cni/net.d/

# Check kubelet's CNI configuration
ps -ef | grep kubelet
# Look for --network-plugin=cni and --cni-conf-dir

# Check if CNI plugin pods are running
kubectl get pods -n kube-system
# Should see: calico-node, weave-net, or flannel daemonsets

# Verify CNI is working by checking pod IPs
kubectl get pods -o wide
# All pods should have non-empty IP addresses
```

---

## 🔷 Common Mistakes

| Mistake | Symptom |
|---|---|
| No CNI plugin installed | All pods stuck in `ContainerCreating` |
| Multiple CNI configs | Unpredictable behavior — only first alphabetically is used |
| CNI plugin pods crashing | Pods on that node get no IPs |
| Wrong CIDR in CNI config | IP conflicts with existing infrastructure |
| Using Flannel but expecting NetworkPolicy | Policies created but not enforced |

---

## 🔷 CKA Exam Tips

- Know the two key directories: `/opt/cni/bin/` and `/etc/cni/net.d/`
- Know that **kubelet reads CNI config** and executes the binary
- Know that **Flannel doesn't support NetworkPolicy**
- If asked why pods are `ContainerCreating` → check if CNI is installed
- Know how to identify which CNI plugin is in use: `ls /etc/cni/net.d/`

---

## 🔎 Topic Summary — CNI in Kubernetes

- **CNI standardizes** how Kubernetes configures pod networking, decoupling orchestrators from network implementations
- **kubelet calls the CNI plugin** at pod creation/deletion using binaries in `/opt/cni/bin/`
- **CNI config files** in `/etc/cni/net.d/` define which plugin to use and with what parameters
- **Only one CNI config is active** — the first alphabetically in `/etc/cni/net.d/`
- **Different plugins have different capabilities**: Flannel = simple, Calico = policies + BGP, Cilium = eBPF
- **Missing CNI = pods stuck in ContainerCreating** — this is a very common exam scenario
- **Production takeaway**: Choose CNI based on your requirements — network policies, scale, cloud provider, and observability needs

---

# 34. Service Networking

## 🔷 What Is Service Networking?

Service networking in Kubernetes provides a stable, virtual IP address (ClusterIP) for a group of pods. While pods have ephemeral IPs that change every time they restart, **services provide a consistent IP and DNS name** that clients use to reach pods. The actual traffic routing from the service IP to the backend pod IPs is handled by **kube-proxy** on every node.

---

## 🔷 Why Services Exist

Without services:
- Pod restarts = new IP = all callers break
- Load balancing across pod replicas is manual
- External access to pods requires knowing their exact IPs
- Scaling pods breaks existing connections

With services:
- Clients call `web-service:80` forever — Kubernetes handles the routing
- kube-proxy load-balances across all healthy pods automatically
- Services survive pod restarts, rescheduling, and scaling

---

## 🔷 Service Types

| Type | Accessibility | Use Case |
|---|---|---|
| **ClusterIP** (default) | Internal to cluster only | Microservice-to-microservice |
| **NodePort** | External via `<NodeIP>:<NodePort>` | Direct external access (dev/testing) |
| **LoadBalancer** | External via cloud load balancer | Production external access on cloud |
| **ExternalName** | DNS CNAME to external service | Routing to external services |
| **Headless** | No ClusterIP, direct pod IPs | StatefulSets, direct DNS discovery |

---

## 🔷 How kube-proxy Implements Service Networking

### kube-proxy Modes:

| Mode | Implementation | Default? |
|---|---|---|
| **iptables** | iptables DNAT rules | Yes (most clusters) |
| **IPVS** | Linux IP Virtual Server | High performance (many services) |
| **userspace** | Proxy in userspace | Legacy, deprecated |

### iptables Mode — How It Works:

When a service is created (ClusterIP: `10.103.132.104`, port 3306):

1. kube-proxy on every node adds iptables rules
2. Any packet destined for `10.103.132.104:3306` is DNAT'd to a real pod IP

```bash
# View kube-proxy generated iptables rules
iptables -L -t nat | grep db-service

# Output:
KUBE-SVC-XA5OGUC7YRHOS3PU  tcp  -- anywhere  10.103.132.104  tcp dpt:3306
DNAT  tcp  -- anywhere  anywhere  to:10.244.1.2:3306
```

---

## 🔷 Service IP Range vs Pod IP Range

```bash
# Check service CIDR (set on kube-apiserver)
cat /etc/kubernetes/manifests/kube-apiserver.yaml | grep service-cluster-ip-range
# --service-cluster-ip-range=10.96.0.0/12

# Check pod CIDR (set during kubeadm init)
kubectl cluster-info dump | grep -m 1 cluster-cidr
# --cluster-cidr=10.244.0.0/16
```

> ⚠️ **Critical**: Service CIDR and Pod CIDR **must not overlap**. If they do, routing becomes ambiguous and connectivity breaks.

---

## 🔷 Architecture Flow — ClusterIP Service

```
Pod A (10.244.1.5)
     │
     │ sends packet to 10.96.1.100:80 (ClusterIP)
     ▼
iptables on Node 1 (installed by kube-proxy)
     │
     │ DNAT: 10.96.1.100:80 → 10.244.2.3:80 (random pod selection)
     ▼
Pod B (10.244.2.3) on Node 2 receives packet
```

The packet appears to come from Pod A's IP — no NAT on the source side.

---

## 🔷 YAML — ClusterIP Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: db-service
  namespace: production
spec:
  selector:
    app: mysql          # Routes to pods with this label
    tier: database
  type: ClusterIP       # Internal only
  ports:
    - protocol: TCP
      port: 3306        # Service port (what clients call)
      targetPort: 3306  # Container port (what pods listen on)
  # ClusterIP is auto-assigned from --service-cluster-ip-range
  # Can be specified: clusterIP: 10.96.10.20
```

---

## 🔷 YAML — NodePort Service

```yaml
apiVersion: v1
kind: Service
metadata:
  name: frontend-service
spec:
  selector:
    app: frontend
  type: NodePort
  ports:
    - port: 80          # ClusterIP port
      targetPort: 8080  # Pod/container port
      nodePort: 30080   # External port (range: 30000-32767)
      # If nodePort not specified, Kubernetes auto-assigns one
```

---

## 🔷 Verifying Service Networking

```bash
# Check service exists and has ClusterIP
kubectl get svc db-service
# NAME         TYPE        CLUSTER-IP      PORT(S)    AGE
# db-service   ClusterIP   10.103.132.104  3306/TCP   5m

# Check endpoints (pods selected by service)
kubectl get endpoints db-service
# NAME         ENDPOINTS              AGE
# db-service   10.244.1.2:3306       5m
# If ENDPOINTS is <none> → label selector doesn't match any pods!

# Check kube-proxy mode
kubectl logs -n kube-system kube-proxy-xxx | head -5
# "Using iptables Proxier"

# View iptables rules for service
iptables -t nat -L KUBE-SERVICES | grep 10.103.132.104
```

---

## 🔷 Real-World Production Scenario

**Scenario**: Microservices application where `order-service` calls `inventory-service` but gets connection refused.

**Systematic Debugging**:
```bash
# Step 1: Does the service exist?
kubectl get svc inventory-service -n production

# Step 2: Does it have endpoints?
kubectl get endpoints inventory-service -n production
# If no endpoints → pod labels don't match service selector

# Step 3: Do pods have matching labels?
kubectl get pods -n production --show-labels | grep inventory

# Step 4: Is the pod actually running?
kubectl get pods -n production | grep inventory

# Step 5: Test service connectivity from another pod
kubectl exec -it order-service-xxx -n production -- \
  curl http://inventory-service:8080/health

# Step 6: Check kube-proxy logs for errors
kubectl logs -n kube-system -l k8s-app=kube-proxy
```

---

## 🔷 Common Mistakes

| Mistake | Symptom |
|---|---|
| Label selector mismatch | Service has no Endpoints, all traffic fails |
| Wrong `targetPort` | Connection refused at pod |
| CIDR overlap (service/pod) | Intermittent routing failures |
| Not using `--service-cluster-ip-range` on apiserver | Services get IPs outside expected range |
| Manually setting a ClusterIP already in use | Service creation fails |

---

## 🔷 CKA Exam Tips

- **Endpoints = which pods are selected by the service** — always check endpoints when service isn't working
- Know the difference: `port` (service port) vs `targetPort` (pod port) vs `nodePort` (external port)
- Know that kube-proxy default mode is **iptables**
- Know the NodePort range: **30000–32767**
- Know that ClusterIP is virtual — it exists only in iptables rules, not as a real interface
- `kubectl get endpoints` is your most powerful service debugging command

---

## 🔎 Topic Summary — Service Networking

- **Services provide stable virtual IPs (ClusterIP)** for dynamic pods — the IP survives pod restarts
- **kube-proxy** on every node implements service routing using iptables DNAT rules
- **ClusterIP** = internal only; **NodePort** = external via node ports; **LoadBalancer** = cloud load balancer
- **Endpoints** object lists the actual pod IPs behind a service — always check this when debugging
- **Service CIDR and Pod CIDR must not overlap** — this is a critical configuration requirement
- **iptables is the default proxy mode** — IPVS offers better performance at large scale
- **Production takeaway**: The most common service failure cause is a label selector mismatch — always check `kubectl get endpoints` first

---

# 35. DNS in Kubernetes

## 🔷 What Is DNS in Kubernetes?

Kubernetes DNS provides automatic name resolution for services and pods within the cluster. When a service is created, Kubernetes automatically creates a DNS record mapping the service name to its ClusterIP. This allows any pod to reach any service using a predictable, human-readable name without knowing the service's IP address.

---

## 🔷 DNS Record Format

### For Services:
```
<service-name>.<namespace>.svc.cluster.local
```

Examples:
```
web-service.default.svc.cluster.local
db-service.production.svc.cluster.local
redis.cache.svc.cluster.local
```

From within the **same namespace**, pods can use just the service name:
```bash
curl http://web-service        # Works in same namespace
curl http://web-service.production  # Works from any namespace
curl http://web-service.production.svc.cluster.local  # Full FQDN always works
```

### For Pods (when enabled):
Pod IP addresses are converted to hostnames by replacing dots with dashes:
```
<pod-ip-with-dashes>.<namespace>.pod.cluster.local

# Example: Pod IP 10.244.2.5 in namespace "default"
10-244-2-5.default.pod.cluster.local → 10.244.2.5
```

> Note: Pod DNS records are not enabled by default. Service DNS records ARE created automatically.

---

## 🔷 How It Works — DNS Resolution Flow in a Pod

```
Pod tries: curl http://web-service
     │
     ▼
/etc/resolv.conf in the pod:
  nameserver 10.96.0.10          ← CoreDNS ClusterIP
  search default.svc.cluster.local svc.cluster.local cluster.local
     │
     ▼
Query sent to CoreDNS: "web-service"
CoreDNS appends search domains:
  → web-service.default.svc.cluster.local ← matches! Returns ClusterIP
     │
     ▼
Pod connects to the returned ClusterIP
```

---

## 🔷 Architecture Flow

```
Pod's /etc/resolv.conf
  nameserver: 10.96.0.10 (kube-dns Service ClusterIP)
      │
      ▼
kube-dns Service (ClusterIP: 10.96.0.10)
      │
      ▼
CoreDNS Pods (Deployment in kube-system namespace)
      │
      ├──► Kubernetes Plugin: Resolves .cluster.local names from etcd/API
      │
      └──► Forward Plugin: Forwards external names to upstream DNS
               (configured in CoreDNS ConfigMap)
```

---

## 🔷 CoreDNS Configuration

CoreDNS is configured via a **ConfigMap** in `kube-system`:

```bash
kubectl get configmap coredns -n kube-system -o yaml
```

```yaml
# CoreDNS Corefile — explains each plugin's role
apiVersion: v1
kind: ConfigMap
metadata:
  name: coredns
  namespace: kube-system
data:
  Corefile: |
    .:53 {
        errors              # Log DNS errors
        health              # Health check endpoint
        ready               # Readiness probe support
        kubernetes cluster.local in-addr.arpa ip6.arpa {
            pods insecure   # Enable pod DNS records (insecure = no verification)
            fallthrough in-addr.arpa ip6.arpa
        }
        prometheus :9153    # Metrics for Prometheus
        forward . /etc/resolv.conf  # Forward external names to node's DNS
        cache 30            # Cache responses for 30 seconds
        loop                # Detect forwarding loops
        reload              # Watch for ConfigMap changes
        loadbalance         # Round-robin DNS load balancing
    }
```

---

## 🔷 How CoreDNS Pod Gets Configured in Each Pod

Kubelet is responsible for populating `/etc/resolv.conf` in each pod:

```bash
# Check kubelet configuration for DNS settings
cat /var/lib/kubelet/config.yaml | grep -A3 clusterDNS
# clusterDNS:
# - 10.96.0.10
# clusterDomain: cluster.local
```

Kubelet injects these into every pod's `/etc/resolv.conf`:
```bash
# Inside any pod:
cat /etc/resolv.conf
# nameserver 10.96.0.10
# search default.svc.cluster.local svc.cluster.local cluster.local
# options ndots:5
```

---

## 🔷 DNS Troubleshooting Commands

```bash
# Check CoreDNS pods are running
kubectl get pods -n kube-system -l k8s-app=kube-dns

# Check CoreDNS logs for errors
kubectl logs -n kube-system coredns-xxx

# Test DNS from within a pod
kubectl exec -it test-pod -- nslookup web-service
kubectl exec -it test-pod -- nslookup web-service.default.svc.cluster.local
kubectl exec -it test-pod -- cat /etc/resolv.conf

# Check the kube-dns service exists and has correct ClusterIP
kubectl get svc kube-dns -n kube-system

# Test cross-namespace DNS
kubectl exec -it test-pod -n app-ns -- \
  nslookup db-service.production.svc.cluster.local
```

---

## 🔷 Real-World Production Scenario

**Scenario**: Application pods can't resolve service names after a cluster upgrade.

**Investigation Steps**:
```bash
# Step 1: Are CoreDNS pods running?
kubectl get pods -n kube-system | grep coredns
# If CrashLoopBackOff → check logs

# Step 2: Check CoreDNS logs
kubectl logs -n kube-system coredns-xxx
# Look for: "plugin/loop: Loop detected"
# This means the forward plugin is creating a DNS loop!

# Step 3: Fix DNS loop (common after certain cluster setups)
kubectl edit configmap coredns -n kube-system
# Change: forward . /etc/resolv.conf
# To: forward . 8.8.8.8 8.8.4.4
# (avoid forwarding to a nameserver that forwards back to CoreDNS)

# Step 4: Verify pod's resolv.conf is correct
kubectl exec -it app-pod -- cat /etc/resolv.conf
# nameserver should be 10.96.0.10

# Step 5: Test resolution
kubectl exec -it app-pod -- nslookup kubernetes.default
```

---

## 🔷 Common Mistakes

| Mistake | Symptom |
|---|---|
| CoreDNS pods not running | All DNS resolution fails cluster-wide |
| DNS loop in CoreDNS config | `plugin/loop: Loop detected`, high CPU on CoreDNS |
| Wrong `clusterDomain` in kubelet | Service names with cluster.local suffix fail |
| Custom DNS server blocking UDP/TCP 53 | Pods can't resolve external names |
| ndots:5 misunderstood | Short names cause 5 DNS lookups before resolution |

---

## 🔷 CKA Exam Tips

- Know CoreDNS lives in **`kube-system` namespace** as a **Deployment**
- Know the **kube-dns Service** at `10.96.0.10` is what pods use as nameserver
- Know that **kubelet configures `/etc/resolv.conf`** in each pod
- FQDN format: `<service>.<namespace>.svc.cluster.local`
- Know how to edit CoreDNS ConfigMap to fix DNS issues
- Know that pod DNS records use dashes: `10-244-2-5.default.pod.cluster.local`

---

## 🔎 Topic Summary — DNS in Kubernetes

- **CoreDNS** is Kubernetes' built-in DNS server, running as a Deployment in `kube-system`
- **Every pod's `/etc/resolv.conf`** points to CoreDNS's ClusterIP (typically `10.96.0.10`)
- **Service DNS format**: `<service>.<namespace>.svc.cluster.local`
- **Pod DNS format** (when enabled): `<ip-with-dashes>.<namespace>.pod.cluster.local`
- **Search domains** in resolv.conf allow short names within the same namespace
- **CoreDNS ConfigMap** controls behavior: Kubernetes plugin resolves internal names, forward plugin handles external
- **Production takeaway**: DNS failures affect the entire cluster; always check CoreDNS pod health and logs as the first step in any service connectivity investigation

---

# 36. Ingress

## 🔷 What Is Ingress?

Ingress is a Kubernetes API object that manages **external HTTP/HTTPS access** to services within a cluster. It provides:
- **URL-based routing** (path-based and host-based)
- **TLS/SSL termination**
- **Load balancing**
- **Virtual hosting** (multiple domains → single entry point)
- **Rewrite rules and redirects**

Ingress is essentially a **Layer 7 (application layer) load balancer** deployed inside the cluster, in contrast to LoadBalancer services which are Layer 4 (transport layer).

---

## 🔷 Why Ingress Instead of LoadBalancer Services?

**Without Ingress** (using LoadBalancer services):
```
app1.company.com ──► Cloud LB 1 ($$) ──► Service A
app2.company.com ──► Cloud LB 2 ($$) ──► Service B
app3.company.com ──► Cloud LB 3 ($$) ──► Service C
# Each LB costs money and has a different external IP!
```

**With Ingress**:
```
app1.company.com ──┐
app2.company.com ──┤──► Single Cloud LB ──► Ingress Controller ──► Routes to Services
app3.company.com ──┘
# ONE load balancer, ONE external IP, MULTIPLE applications
```

Additionally, Ingress handles:
- SSL termination centrally (no need for SSL in each service)
- URL path routing (e.g., `/api` → backend-service, `/` → frontend-service)
- Authentication
- Rate limiting

---

## 🔷 Two Components of Ingress

1. **Ingress Controller** — The actual software that implements the ingress rules (NGINX, Traefik, HAProxy, Contour, Istio, GKE, etc.). **NOT included by default in Kubernetes.** Must be deployed separately.

2. **Ingress Resource** — The Kubernetes API object (YAML) that defines routing rules.

> ⚠️ **Critical**: Creating Ingress resources without an Ingress Controller has NO effect. The resources are stored in etcd but nothing acts on them.

---

## 🔷 Architecture Flow

```
External User
     │
     ▼ HTTPS request to company.com
Cloud Load Balancer (port 80/443)
     │
     ▼ (NodePort or LoadBalancer Service targeting Ingress Controller)
Ingress Controller Pod (NGINX/Traefik running in cluster)
     │
     ├──► Path: /api/* ──► backend-service:8080
     │
     ├──► Path: /auth/* ──► auth-service:3000
     │
     └──► Default (/) ──► frontend-service:80
              │
              ▼
         Backend Pod
```

---

## 🔷 Deploying NGINX Ingress Controller

```yaml
# ingress-controller-deployment.yaml
# This deploys the NGINX Ingress Controller — the brains that processes Ingress rules
apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx-ingress-controller
  namespace: ingress-nginx
spec:
  replicas: 2             # Run 2 replicas for HA
  selector:
    matchLabels:
      app: nginx-ingress
  template:
    metadata:
      labels:
        app: nginx-ingress
    spec:
      serviceAccountName: nginx-ingress-serviceaccount  # Needs RBAC to read Ingress resources
      containers:
        - name: nginx-ingress-controller
          image: quay.io/kubernetes-ingress-controller/nginx-ingress-controller:1.3.0
          args:
            - /nginx-ingress-controller
            - --configmap=$(POD_NAMESPACE)/nginx-configuration   # ConfigMap for NGINX tuning
            - --tcp-services-configmap=$(POD_NAMESPACE)/tcp-services
            - --udp-services-configmap=$(POD_NAMESPACE)/udp-services
          env:
            - name: POD_NAME         # Passes pod identity to controller
              valueFrom:
                fieldRef:
                  fieldPath: metadata.name
            - name: POD_NAMESPACE
              valueFrom:
                fieldRef:
                  fieldPath: metadata.namespace
          ports:
            - name: http
              containerPort: 80
            - name: https
              containerPort: 443
          # OOMKilled risk: NGINX can use significant memory at high traffic
          # Set appropriate limits: memory: 512Mi, cpu: 500m
          # CrashLoopBackOff: check ConfigMap exists and is correct
```

---

## 🔷 YAML — Ingress Resource (Path-Based Routing)

```yaml
# ingress-path-based.yaml
# Routes different URL paths to different backend services
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: app-ingress
  namespace: production
  annotations:
    # NGINX-specific annotations for behavior customization
    nginx.ingress.kubernetes.io/rewrite-target: /
    nginx.ingress.kubernetes.io/ssl-redirect: "true"
    nginx.ingress.kubernetes.io/force-ssl-redirect: "true"
spec:
  ingressClassName: nginx      # Specifies which Ingress Controller to use
  tls:
    - hosts:
        - company.com
      secretName: company-tls  # Secret containing TLS certificate and key
  rules:
    - host: company.com
      http:
        paths:
          - path: /api
            pathType: Prefix   # /api, /api/v1, /api/users all match
            backend:
              service:
                name: backend-service
                port:
                  number: 8080
          - path: /            # Default: catch-all
            pathType: Prefix
            backend:
              service:
                name: frontend-service
                port:
                  number: 80
```

---

## 🔷 YAML — Ingress Resource (Host-Based Routing)

```yaml
# ingress-host-based.yaml
# Routes different hostnames to different backend services
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: multi-domain-ingress
  namespace: production
spec:
  ingressClassName: nginx
  tls:
    - hosts:
        - wear.company.com
        - watch.company.com
      secretName: multi-domain-tls
  rules:
    - host: wear.company.com          # Domain 1
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: wear-service
                port:
                  number: 80
    - host: watch.company.com         # Domain 2
      http:
        paths:
          - path: /
            pathType: Prefix
            backend:
              service:
                name: watch-service
                port:
                  number: 80
```

---

## 🔷 Ingress Debugging

```bash
# Check Ingress Controller is running
kubectl get pods -n ingress-nginx

# Check Ingress resource
kubectl get ingress -n production
kubectl describe ingress app-ingress -n production

# Check Ingress Controller logs
kubectl logs -n ingress-nginx nginx-ingress-controller-xxx

# Check IngressClass
kubectl get ingressclass

# Common issues:
# 1. No ADDRESS on ingress → Controller not running or not watching this namespace
# 2. 502 Bad Gateway → Backend service/pods not reachable
# 3. TLS errors → Secret missing or wrong format
# 4. 404 for all paths → Path rules misconfigured
```

---

## 🔷 Real-World Production Scenario

**Application**: Multi-tenant SaaS platform with `api.saas.com`, `app.saas.com`, and `admin.saas.com`.

**Architecture**:
```
Route 53 (DNS) → *.saas.com → ELB (single)
                                    │
                            NGINX Ingress Controller
                         (Deployment, 3 replicas, HPA)
                                    │
              ┌────────────────────┬┴─────────────────┐
              ▼                    ▼                   ▼
        api-service           app-service        admin-service
        (ClusterIP)           (ClusterIP)        (ClusterIP)
              │                    │                   │
        API pods (10)         Frontend pods (5)   Admin pods (2)
```

**Security Considerations**:
- Wildcard TLS certificate from Let's Encrypt, auto-renewed via cert-manager
- Rate limiting annotations on API endpoints
- IP whitelisting on admin endpoints: `nginx.ingress.kubernetes.io/whitelist-source-range`
- OAuth2 authentication proxy for admin routes

---

## 🔷 Common Mistakes

| Mistake | Impact |
|---|---|
| No Ingress Controller deployed | Ingress resources do nothing |
| Wrong `ingressClassName` | Rules not processed |
| Path ordering wrong | More specific paths shadowed by catch-all |
| TLS secret in wrong namespace | 404/SSL errors |
| Missing `pathType: Exact/Prefix` | Ambiguous routing behavior |
| Default backend not configured | Unmatched paths return 404 without explanation |

---

## 🔷 CKA Exam Tips

- Know that **Ingress Controller is NOT included by default** — must be deployed
- Know the difference between **path-based** and **host-based** routing
- Know that `ingressClassName` connects the Ingress resource to the controller
- Know how to create a simple Ingress: `kubectl create ingress` command
- Know that `kubectl describe ingress` shows rules and events
- Understand **annotations** (controller-specific) vs **spec** (universal)

---

## 🔎 Topic Summary — Ingress

- **Ingress provides Layer 7 routing** for external HTTP/HTTPS traffic — path and host based
- **Two components**: Ingress Controller (software) + Ingress Resource (rules YAML)
- **Ingress Controller is NOT deployed by default** — popular choices: NGINX, Traefik, Contour
- **Path-based routing**: `/api` → service A, `/` → service B on the same domain
- **Host-based routing**: `api.domain.com` → service A, `app.domain.com` → service B
- **TLS termination** at the Ingress layer removes SSL management from individual services
- **Production takeaway**: Ingress is the standard way to expose production web applications — it consolidates external access, TLS, and routing into one manageable layer

---

# 37. Gateway API (2025 Updates)

## 🔷 What Is the Gateway API?

The **Kubernetes Gateway API** is the next-generation Kubernetes API for managing external traffic, designed to replace and significantly enhance the capabilities of the Ingress resource. It was developed as an official Kubernetes project (under `gateway.networking.k8s.io`) to address fundamental limitations of Ingress:

| Ingress Limitation | Gateway API Solution |
|---|---|
| Single resource, coordination required | Split into roles: infrastructure admin, cluster operator, app developer |
| Controller-specific annotations | Standardized spec (no annotations needed) |
| HTTP only | Supports HTTP, HTTPS, TCP, UDP, gRPC, TLS |
| No traffic splitting natively | Built-in traffic splitting/canary |
| No CORS natively | Built-in response header modification |
| Single multi-tenant resource | Independent HTTPRoute per team |

---

## 🔷 Gateway API Objects

The Gateway API separates concerns into three distinct objects:

| Object | Managed By | Purpose |
|---|---|---|
| **GatewayClass** | Infrastructure provider | Defines the type of gateway (NGINX, Traefik, GKE, etc.) |
| **Gateway** | Cluster operator | Instance of a GatewayClass with listener configuration |
| **HTTPRoute** | Application developer | Traffic routing rules for HTTP/HTTPS |
| **TCPRoute** | Application developer | TCP traffic routing |
| **TLSRoute** | Application developer | TLS passthrough routing |
| **GRPCRoute** | Application developer | gRPC traffic routing |

---

## 🔷 Architecture Flow

```
GatewayClass (infrastructure provider configures once)
      │ defines type of infrastructure
      ▼
Gateway (cluster operator creates per environment)
      │ configures listeners (ports, protocols, TLS)
      │
      ├──► HTTPRoute (team A manages their routes independently)
      │
      ├──► HTTPRoute (team B manages their routes independently)
      │
      └──► TCPRoute (team C manages database routes)
```

This separation enables **multi-tenancy**: Team A can update their routing rules without affecting Team B, and neither team can access each other's configuration.

---

## 🔷 YAML — Complete Gateway API Configuration

```yaml
# Step 1: GatewayClass — configured by infrastructure team
apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: nginx-gateway-class
spec:
  controllerName: k8s.nginx.org/nginx-gateway-controller
  # This references the Gateway Controller implementation
---
# Step 2: Gateway — configured by cluster operators
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: production-gateway
  namespace: gateway-system
spec:
  gatewayClassName: nginx-gateway-class
  listeners:
    - name: https
      port: 443
      protocol: HTTPS
      tls:
        mode: Terminate             # Gateway terminates TLS
        certificateRefs:
          - kind: Secret
            name: wildcard-tls     # TLS cert stored as Secret
      allowedRoutes:
        kinds:
          - kind: HTTPRoute        # Only HTTPRoutes can attach
        namespaces:
          from: Selector           # Only from labeled namespaces
          selector:
            matchLabels:
              gateway-access: "true"
    - name: http
      port: 80
      protocol: HTTP
      allowedRoutes:
        namespaces:
          from: All
---
# Step 3: HTTPRoute — configured by application teams independently
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: wear-route
  namespace: wear-team            # Each team owns their namespace
spec:
  parentRefs:
    - name: production-gateway
      namespace: gateway-system
  hostnames:
    - "wear.company.com"
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /api
      backendRefs:
        - name: wear-api-service
          port: 8080
          weight: 90               # 90% to stable version
        - name: wear-api-service-v2
          port: 8080
          weight: 10               # 10% canary traffic
    - matches:
        - path:
            type: PathPrefix
            value: /
      filters:
        - type: ResponseHeaderModifier
          responseHeaderModifier:
            add:
              - name: X-Team-Owner
                value: "wear-team"
      backendRefs:
        - name: wear-frontend
          port: 80
```

---

## 🔷 Traffic Splitting (Canary Deployment)

```yaml
# Gateway API native canary — no annotations needed!
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: canary-route
spec:
  parentRefs:
    - name: production-gateway
  rules:
    - backendRefs:
        - name: app-v1        # Stable version
          port: 80
          weight: 80          # 80% of traffic
        - name: app-v2        # Canary version
          port: 80
          weight: 20          # 20% of traffic
```

**Ingress equivalent** (requires controller-specific annotations):
```yaml
# Ingress canary — controller-specific, not portable
metadata:
  annotations:
    nginx.ingress.kubernetes.io/canary: "true"
    nginx.ingress.kubernetes.io/canary-weight: "20"
```

---

## 🔷 Supported Gateway API Controllers (2025)

| Platform | Status |
|---|---|
| Amazon EKS (AWS Load Balancer Controller) | GA |
| Google GKE | GA |
| Azure Application Gateway for Containers | GA |
| NGINX Kubernetes Gateway | GA |
| Contour | GA |
| Istio | GA |
| Traefik | GA |
| Cilium | GA |
| Kong | GA |

---

## 🔷 Key Differences: Ingress vs Gateway API

| Feature | Ingress | Gateway API |
|---|---|---|
| Protocols | HTTP/HTTPS only | HTTP, HTTPS, TCP, UDP, gRPC, TLS |
| Traffic splitting | Via annotations (controller-specific) | Native spec (portable) |
| CORS | Via annotations | Native response header modifier |
| Multi-tenancy | Single resource, coordination needed | Independent HTTPRoutes per team |
| TLS configuration | `spec.tls` + annotations | Built into Gateway listener spec |
| Canary deployments | Via annotations | Native `weight` on backendRefs |
| Portability | Low (annotation-dependent) | High (standardized spec) |

---

## 🔷 CKA Exam Tips (2025)

- Understand the **three-layer hierarchy**: GatewayClass → Gateway → HTTPRoute
- Know that Gateway API is **NOT a replacement for Ingress** in existing clusters — it's the future direction
- Understand **traffic splitting is native** in Gateway API (no annotations)
- Know that different **teams can own their HTTPRoute** objects independently
- Gateway API supports **multiple protocols** — not just HTTP

---

## 🔎 Topic Summary — Gateway API

- **Gateway API addresses Ingress limitations** by separating infrastructure, platform, and application concerns
- **Three objects**: GatewayClass (type definition), Gateway (instance), HTTPRoute/TCPRoute (routing rules)
- **Multi-tenancy**: Each team manages their own HTTPRoute independently without coordination
- **Native traffic splitting**: Weight-based routing is built into the spec, not via annotations
- **Protocol support**: HTTP, HTTPS, TCP, UDP, gRPC — unlike Ingress which is HTTP only
- **Portability**: Gateway API specs are controller-agnostic — same YAML works with different controllers
- **Production takeaway**: For new cluster deployments and greenfield applications, Gateway API is the recommended approach; it will eventually supersede Ingress

---

# 38. Network Policies

## 🔷 What Are Network Policies?

A **Kubernetes NetworkPolicy** is a specification of how groups of pods are allowed to communicate with each other and with other network endpoints. By default, all pods in a Kubernetes cluster can communicate with all other pods — there is no network isolation. NetworkPolicy resources define **allow rules** that restrict which traffic is permitted.

> ⚠️ **Key Concept**: NetworkPolicy is **additive and allow-only**. You cannot explicitly deny traffic with a NetworkPolicy rule — you can only allow specific traffic. All non-matching traffic is implicitly denied **once a policy applies to a pod**.

---

## 🔷 Default Behavior

**Without any NetworkPolicy**:
- All pods can reach all other pods (complete mesh communication)
- Any pod can reach any external IP
- Any external source can reach any pod on open ports

**When a NetworkPolicy selects a pod**:
- ALL traffic to/from that pod is **denied by default**
- Only explicitly allowed traffic (matching policy rules) is permitted

---

## 🔷 Core Concepts

| Concept | Description |
|---|---|
| **podSelector** | Which pods this policy applies to (the "target" pod) |
| **policyTypes** | `Ingress`, `Egress`, or both |
| **ingress rules** | What incoming traffic is allowed TO the target pod |
| **egress rules** | What outgoing traffic is allowed FROM the target pod |
| **from/to** | Source/destination selectors (pod, namespace, IP block) |
| **ports** | Which ports are allowed |

---

## 🔷 Architecture Flow — Traffic Enforcement

```
NetworkPolicy YAML ──► kube-apiserver ──► etcd (stored)
                                              │
                                              ▼
                              CNI Plugin on each node
                              (Calico/Cilium/Weave reads policy)
                                              │
                                              ▼
                              iptables / eBPF rules configured
                              on node for each pod
```

> ⚠️ **CRITICAL**: NetworkPolicy enforcement depends on the **CNI plugin**. **Flannel does NOT enforce NetworkPolicies**. You must use **Calico**, **Cilium**, **Weave Net**, or another policy-supporting CNI.

---

## 🔷 YAML — Deny All Ingress (Default Deny Policy)

```yaml
# This is the recommended starting point for zero-trust networking
# Apply this first, then add allow rules for what you need
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: default-deny-ingress
  namespace: production
spec:
  podSelector: {}          # Applies to ALL pods in this namespace
  policyTypes:
    - Ingress              # Only affects ingress traffic
  # No ingress rules = all ingress traffic denied
```

---

## 🔷 YAML — Allow Specific Traffic

```yaml
# db-network-policy.yaml
# Allows only API pod → DB pod communication on port 3306
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: db-policy
  namespace: production
spec:
  podSelector:
    matchLabels:
      role: db             # This policy applies to pods labeled role=db
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        # Rule 1: Allow from API pods in production namespace (AND condition)
        - podSelector:
            matchLabels:
              name: api-pod      # Must match this pod label
          namespaceSelector:
            matchLabels:
              name: production   # AND must be in production namespace
        # Rule 2: Allow from backup server IP (OR condition - separate list item)
        - ipBlock:
            cidr: 192.168.5.10/32
      ports:
        - protocol: TCP
          port: 3306
  egress:
    # DB pod needs to send backups to external server
    - to:
        - ipBlock:
            cidr: 192.168.5.10/32     # Backup server
      ports:
        - protocol: TCP
          port: 80
```

### ⚠️ AND vs OR in NetworkPolicy — Critical Distinction

```yaml
# AND condition (both selectors must match — they're in the same list item)
from:
  - podSelector:
      matchLabels:
        name: api-pod
    namespaceSelector:          # NOTE: at same indentation level
      matchLabels:
        env: production

# OR condition (either selector matches — they're separate list items)
from:
  - podSelector:
      matchLabels:
        name: api-pod
  - namespaceSelector:          # NOTE: separate list item with "-"
      matchLabels:
        env: production
```

**This is one of the most common mistakes in NetworkPolicy writing!**

---

## 🔷 YAML — Complete Production Network Policy

```yaml
# Complete zero-trust policy for a 3-tier application
---
# Frontend policy: allow ingress from internet, egress to API
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: frontend-policy
  namespace: production
spec:
  podSelector:
    matchLabels:
      tier: frontend
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - ports:
        - port: 80
        - port: 443
      # No 'from' → allows from anywhere (0.0.0.0/0)
  egress:
    - to:
        - podSelector:
            matchLabels:
              tier: api
      ports:
        - port: 8080
    - ports:
        - port: 53            # Allow DNS resolution!
          protocol: UDP       # Critical: often forgotten in policies
        - port: 53
          protocol: TCP
---
# API policy: allow from frontend, egress to DB
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: api-policy
  namespace: production
spec:
  podSelector:
    matchLabels:
      tier: api
  policyTypes:
    - Ingress
    - Egress
  ingress:
    - from:
        - podSelector:
            matchLabels:
              tier: frontend
      ports:
        - port: 8080
  egress:
    - to:
        - podSelector:
            matchLabels:
              tier: database
      ports:
        - port: 5432
    - ports:              # DNS
        - port: 53
          protocol: UDP
        - port: 53
          protocol: TCP
```

---

## 🔷 Real-World Production Scenario

**Application**: Financial services platform with strict PCI-DSS compliance requirements.

**Requirements**:
- Payment pods can only communicate with fraud-detection service
- Database pods cannot be reached by anything except the payment pods
- No pod can reach the internet (egress blocked)
- Only the ingress controller can reach frontend pods

**Implementation**:
```bash
# Apply default deny to all namespaces
kubectl apply -f default-deny-all.yaml -n payments
kubectl apply -f default-deny-all.yaml -n fraud-detection
kubectl apply -f default-deny-all.yaml -n data

# Apply specific allow policies
kubectl apply -f payment-to-fraud-policy.yaml
kubectl apply -f fraud-to-database-policy.yaml
kubectl apply -f ingress-to-frontend-policy.yaml

# Verify policies are applied
kubectl get networkpolicies -n payments

# Test connectivity (should fail)
kubectl exec -it payment-pod-xxx -- curl http://external.internet.com
# Connection refused/timeout ✅ (blocked by egress policy)

# Test connectivity (should succeed)
kubectl exec -it payment-pod-xxx -- curl http://fraud-detection-service:8080
# 200 OK ✅ (allowed by policy)
```

---

## 🔷 Common Mistakes

| Mistake | Impact |
|---|---|
| Using Flannel (no policy support) | All NetworkPolicies silently ignored |
| Forgetting DNS port 53 in egress | Pods can't resolve service names |
| AND vs OR confusion with from selectors | Wrong pods allowed/blocked |
| Not applying default-deny first | Policy has gaps where traffic sneaks through |
| Applying policy to wrong namespace | Intended pods not protected |
| Empty podSelector without Egress type | No egress restriction |

---

## 🔷 Debugging NetworkPolicies

```bash
# List all NetworkPolicies
kubectl get networkpolicies -A

# Describe a specific policy
kubectl describe networkpolicy db-policy -n production

# Check if CNI supports NetworkPolicy
kubectl get pods -n kube-system | grep -E "calico|cilium|weave"

# Test connectivity between pods
kubectl exec -it source-pod -- nc -zv destination-pod-ip 3306
# or
kubectl exec -it source-pod -- wget -qO- http://destination-service:port

# Calico-specific: Check if policy is being enforced
kubectl exec -n kube-system calico-node-xxx -- iptables -L | grep CALICO

# Cilium-specific: Monitor policy enforcement
kubectl exec -n kube-system cilium-xxx -- cilium policy get
```

---

## 🔷 CKA Exam Tips

- Know that **NetworkPolicy is allow-only** — no deny rules
- Know that **Flannel doesn't enforce NetworkPolicies** — this is a frequent exam trap
- Understand the **AND vs OR** distinction in `from`/`to` selectors
- Know that `podSelector: {}` matches **all pods** in the namespace
- Know that **once any policy selects a pod, all non-matching traffic is denied**
- Remember **DNS port 53** in egress rules — easy to forget, breaks service resolution
- Know the three selector types: `podSelector`, `namespaceSelector`, `ipBlock`

---

## 🔎 Topic Summary — Network Policies

- **NetworkPolicy implements zero-trust networking** — define what's allowed, everything else is blocked
- **Once a pod is selected by any policy**, all unlisted traffic is **implicitly denied**
- **CNI plugin must support NetworkPolicy** — Flannel does NOT; Calico, Cilium, Weave do
- **AND vs OR**: Combined selectors in same list item = AND; separate list items = OR
- **Always allow DNS (port 53 UDP/TCP)** in egress policies or pods lose service resolution
- **Default-deny-all + explicit allows** is the production-recommended zero-trust approach
- **Production takeaway**: Implement NetworkPolicy from day one; retrofitting it into an existing cluster is much harder and riskier

---

# 39. Troubleshooting — Application Failures

## 🔷 What Is Application Failure Troubleshooting?

Application failure troubleshooting in Kubernetes is the systematic process of identifying why an application is not functioning correctly. Unlike traditional server debugging, Kubernetes adds multiple layers of abstraction — pods, services, deployments, ConfigMaps, Secrets — each of which can be the source of a failure. A structured, layer-by-layer approach is essential.

---

## 🔷 Troubleshooting Framework — Start from the User-Facing Layer

The golden rule: **start from where the user experiences the failure and work backward toward the root cause**.

```
User → Service → Pod → Container → Application
         ↑        ↑       ↑            ↑
      Check    Check   Check         Check
      first   second   third         fourth
```

---

## 🔷 Step-by-Step Troubleshooting Process

### Step 1 — Test the Front End

```bash
# Test direct service accessibility
curl http://web-service-ip:node-port
# or
curl http://<node-ip>:<nodeport>

# Expected: HTML/JSON response
# If timeout: firewall or pod not running
# If "connection refused": service misconfigured or pod not listening
```

### Step 2 — Check the Service

```bash
# Does the service exist?
kubectl get svc web-service -n production

# Does the service have endpoints? (MOST IMPORTANT CHECK)
kubectl get endpoints web-service -n production
# NAME          ENDPOINTS              AGE
# web-service   10.244.1.5:8080       5m  ← Good
# web-service   <none>                5m  ← Bad: no pods selected!

# If no endpoints → label mismatch between service selector and pod labels
kubectl describe svc web-service | grep Selector
kubectl get pods --show-labels | grep <expected-label>
```

### Step 3 — Check Pod Status

```bash
# Get pod status
kubectl get pods -n production
# NAME              READY   STATUS             RESTARTS   AGE
# webapp-xxx        0/1     CrashLoopBackOff   5          10m  ← Problem!
# webapp-xxx        1/1     Running            0          10m  ← Good

# Get detailed pod information including events
kubectl describe pod webapp-xxx -n production
# Look in the Events section at the bottom — this is the most useful info
```

### Step 4 — Check Pod Logs

```bash
# Current logs
kubectl logs webapp-xxx -n production

# Previous container's logs (before restart — critical for CrashLoopBackOff)
kubectl logs webapp-xxx -n production --previous

# Live streaming logs
kubectl logs webapp-xxx -n production -f

# Logs from specific container in a multi-container pod
kubectl logs webapp-xxx -c nginx -n production
```

### Step 5 — Check Database/Dependency Services

Apply the same checks to each downstream service that the application depends on.

---

## 🔷 Common Failure States and Their Causes

| Status | Common Cause | Fix |
|---|---|---|
| `Pending` | No node with sufficient resources | Check node capacity, resource requests |
| `ContainerCreating` | Image pull issue or CNI problem | Check image name/tag, registry credentials |
| `CrashLoopBackOff` | App crashes on startup | Check logs, ConfigMaps, environment variables |
| `OOMKilled` | Container exceeded memory limit | Increase memory limit or fix memory leak |
| `ImagePullBackOff` | Wrong image tag or registry credentials | Check image name, imagePullSecrets |
| `Error` | Command failed or init container failed | Check command, entrypoint, init containers |
| `Evicted` | Node running out of resources | Add nodes, increase limits, check node pressure |

---

## 🔷 YAML — Pod with All Common Issue Patterns

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: webapp
  namespace: production
spec:
  containers:
    - name: webapp
      image: webapp:v1.2.3
      # ImagePullBackOff: wrong tag "v1.2.3" doesn't exist
      # Fix: kubectl describe pod webapp | grep "Image:" and verify tag

      ports:
        - containerPort: 8080

      env:
        - name: DB_PASSWORD
          valueFrom:
            secretKeyRef:
              name: db-credentials
              key: password
              # CrashLoopBackOff: if secret "db-credentials" doesn't exist
              # Fix: kubectl get secrets | grep db-credentials
              # kubectl describe pod webapp | grep "Error: secret not found"

        - name: DB_HOST
          valueFrom:
            configMapKeyRef:
              name: db-config
              key: DB_HOST
              # CrashLoopBackOff: ConfigMap missing or wrong key name
              # Fix: kubectl get configmap db-config -o yaml

      resources:
        requests:
          memory: "128Mi"
          cpu: "100m"
        limits:
          memory: "256Mi"    # OOMKilled if app uses more than 256Mi
          cpu: "500m"        # CPU throttling if consistently hitting limit
          # OOMKilled: kubectl describe pod webapp | grep "OOMKilled"
          # Fix: increase limit or profile memory usage

  imagePullSecrets:
    - name: registry-secret
      # ImagePullBackOff from private registry: secret missing or wrong
      # Fix: kubectl get secret registry-secret
      # kubectl describe pod webapp | grep "Failed to pull image"
```

---

## 🔷 Debugging Commands Cheat Sheet

```bash
# Overview of all pods and their status
kubectl get pods -A -o wide

# Watch pod status changes in real-time
kubectl get pods -w -n production

# Get all events (ordered by time — very useful!)
kubectl get events -n production --sort-by='.lastTimestamp'

# Describe pod (includes events, resource limits, volume mounts)
kubectl describe pod <pod-name> -n production

# Get logs from crashed container
kubectl logs <pod-name> --previous -n production

# Execute command in running pod for manual debugging
kubectl exec -it <pod-name> -n production -- /bin/bash

# Check if environment variables are set correctly
kubectl exec <pod-name> -- env | grep DB_

# Test network connectivity from inside pod
kubectl exec <pod-name> -- curl http://other-service:8080

# Check resource usage
kubectl top pods -n production
kubectl top nodes

# Force delete a stuck pod (use with caution)
kubectl delete pod <pod-name> --grace-period=0 --force
```

---

## 🔷 Real-World Production Scenario

**Scenario**: `payment-api` service is returning 503 errors to customers.

**Investigation**:
```bash
# 1. Check if service exists and has endpoints
kubectl get endpoints payment-api -n production
# <none> → no pods selected

# 2. Check pods
kubectl get pods -n production -l app=payment-api
# No resources found → deployment has 0 replicas?

# 3. Check deployment
kubectl get deployment payment-api -n production
# AVAILABLE: 0 → why?

kubectl describe deployment payment-api -n production
# Events: "Failed create pod: insufficient cpu"

# 4. Check node resources
kubectl describe nodes | grep -A5 "Allocated resources"

# 5. Resolution: Scale down other non-critical deployments
# or add a new node to the cluster

# Root cause: Cluster resource exhaustion during high-traffic period
```

---

## 🔷 CKA Exam Tips

- **Check endpoints first** when service isn't working — it reveals label mismatches
- **`kubectl logs --previous`** is essential for `CrashLoopBackOff` debugging
- **`kubectl describe pod`** Events section reveals the actual failure reason
- **`kubectl get events --sort-by='.lastTimestamp'`** is your cluster-level diagnostic tool
- Know all pod status states and their common causes
- Practice: `kubectl exec -it pod -- /bin/sh` for interactive debugging

---

## 🔎 Topic Summary — Application Failure Troubleshooting

- **Work from user-facing layer inward**: Service → Endpoints → Pods → Logs → Application
- **Endpoints is the most critical check**: `<none>` means service selector doesn't match pod labels
- **Pod status reveals the failure category**: CrashLoopBackOff, OOMKilled, ImagePullBackOff each have different root causes
- **`kubectl logs --previous`** is essential for diagnosing pods that crash on startup
- **`kubectl describe`** Events section is the richest source of failure information
- **Resource limits misconfiguration** (OOMKilled, CPU throttling) is a common silent production issue
- **Production takeaway**: Instrument your applications with proper liveness/readiness probes and structured logs to dramatically reduce mean time to recovery (MTTR)

---

# 40. Troubleshooting — Control Plane Failures

## 🔷 What Are Control Plane Failures?

Control plane failures are failures in the Kubernetes master node components: **kube-apiserver**, **kube-scheduler**, **kube-controller-manager**, and **etcd**. When these components fail, the cluster becomes partially or fully unmanageable — existing workloads may continue running, but new deployments, scaling, and healing stop working.

---

## 🔷 Impact of Each Component Failure

| Component | Failure Impact |
|---|---|
| **kube-apiserver** | kubectl stops working; all cluster management fails |
| **kube-scheduler** | New pods get stuck in `Pending` — not scheduled |
| **kube-controller-manager** | No pod healing, no scaling, Deployments don't create pods |
| **etcd** | Data loss risk; all components dependent on cluster state fail |

---

## 🔷 Two Types of Control Plane Deployments

### Type 1: kubeadm-based (Static Pods)
Components run as **static pods** in `kube-system` namespace. Managed by kubelet (not kube-apiserver itself).

```bash
# Pod manifest files — kubelet watches this directory
ls /etc/kubernetes/manifests/
# kube-apiserver.yaml  kube-scheduler.yaml  kube-controller-manager.yaml  etcd.yaml
```

### Type 2: Binary/Systemd Services
Components run as OS services (non-kubeadm setups).

```bash
# Check service status
systemctl status kube-apiserver
systemctl status kube-scheduler
systemctl status kube-controller-manager
systemctl status etcd
```

---

## 🔷 Step-by-Step Troubleshooting

### Step 1 — Check Node Health First

```bash
kubectl get nodes
# If this command hangs → kube-apiserver is down
# If this command returns but shows NotReady → node issue
```

### Step 2 — Check Control Plane Pods (kubeadm)

```bash
kubectl get pods -n kube-system
# NAME                                READY   STATUS    RESTARTS
# kube-apiserver-master               1/1     Running   0
# kube-scheduler-master               0/1     CrashLoopBackOff  5   ← Problem!
# kube-controller-manager-master      1/1     Running   0
# etcd-master                         1/1     Running   0
```

### Step 3 — Check Component Logs

For kubeadm (static pods):
```bash
# View pod logs
kubectl logs kube-scheduler-master -n kube-system

# If kube-apiserver is down and kubectl doesn't work:
# Static pod containers are still running — use crictl or docker logs
crictl ps -a | grep scheduler
crictl logs <container-id>
```

For systemd services:
```bash
journalctl -u kube-apiserver -f
journalctl -u kube-scheduler -f
journalctl -u kube-controller-manager -f
journalctl -u etcd -f
```

### Step 4 — Check Static Pod Manifests (kubeadm)

```bash
# The most common cause of control plane issues:
# Wrong certificate paths, wrong flags, port conflicts

cat /etc/kubernetes/manifests/kube-scheduler.yaml

# Common issues found here:
# - --kubeconfig pointing to wrong file
# - Certificate file doesn't exist at specified path
# - Wrong API version or flag names
```

---

## 🔷 Common Control Plane Failure Scenarios

### Scenario 1: kube-scheduler Crash
```bash
kubectl get pods -n kube-system | grep scheduler
# kube-scheduler-master   0/1   CrashLoopBackOff   8   25m

kubectl logs -n kube-system kube-scheduler-master --previous
# Error: failed to load configuration: unable to load config file
# "/etc/kubernetes/scheduler.conf": no such file or directory

# Fix: Check the kubeconfig path in scheduler manifest
cat /etc/kubernetes/manifests/kube-scheduler.yaml | grep kubeconfig
# Correct path: /etc/kubernetes/scheduler.conf
ls /etc/kubernetes/scheduler.conf    # Verify it exists
```

### Scenario 2: kube-apiserver Not Responding
```bash
# kubectl hangs → API server down
# Go directly to logs
crictl logs $(crictl ps -a | grep kube-apiserver | awk '{print $1}')

# Common causes:
# 1. etcd connection failed (check etcd is running)
# 2. Certificate expired (check dates in manifest flags)
# 3. Port 6443 conflict (another process using port)
# 4. Wrong etcd endpoint in manifest

# Check etcd connection from apiserver perspective
openssl s_client -connect localhost:2379 \
  -cert /etc/kubernetes/pki/apiserver-etcd-client.crt \
  -key /etc/kubernetes/pki/apiserver-etcd-client.key \
  -CAfile /etc/kubernetes/pki/etcd/ca.crt
```

### Scenario 3: etcd Data Corruption
```bash
# Check etcd health
ETCDCTL_API=3 etcdctl \
  --endpoints https://127.0.0.1:2379 \
  --cacert /etc/kubernetes/pki/etcd/ca.crt \
  --cert /etc/kubernetes/pki/etcd/server.crt \
  --key /etc/kubernetes/pki/etcd/server.key \
  endpoint health

# If cluster member is unhealthy:
ETCDCTL_API=3 etcdctl member list \
  --endpoints https://127.0.0.1:2379 \
  --cacert /etc/kubernetes/pki/etcd/ca.crt \
  --cert /etc/kubernetes/pki/etcd/server.crt \
  --key /etc/kubernetes/pki/etcd/server.key
```

---

## 🔷 Control Plane Certificate Issues

```bash
# Check certificate expiration
openssl x509 -in /etc/kubernetes/pki/apiserver.crt -text -noout | grep "Not After"

# List all kubeadm-managed certs and their expiry
kubeadm certs check-expiration

# Renew all certificates
kubeadm certs renew all

# After renewal: restart control plane pods
# For static pods: touch the manifest file to trigger restart
# or: move yaml out and back in
mv /etc/kubernetes/manifests/kube-apiserver.yaml /tmp/
mv /tmp/kube-apiserver.yaml /etc/kubernetes/manifests/
```

---

## 🔷 CKA Exam Tips

- Know the static pod manifest directory: `/etc/kubernetes/manifests/`
- Know that **modifying a static pod manifest restarts it automatically** (kubelet detects the change)
- Know how to check logs when `kubectl` isn't working: `crictl logs <container-id>`
- Know the difference between kubeadm setup (static pods) and binary setup (systemd)
- Know that `journalctl -u <service>` is for systemd-based components
- Know how to use `etcdctl` with all required certificate flags

---

## 🔎 Topic Summary — Control Plane Failure Troubleshooting

- **Control plane failures stop cluster management** but don't immediately kill running workloads
- **kubeadm clusters** use static pods in `/etc/kubernetes/manifests/` — editing YAML restarts the component
- **Binary/systemd clusters** use `systemctl status` and `journalctl -u <service>` for diagnostics
- **kube-apiserver down** = kubectl doesn't work; use `crictl` for container logs
- **kube-scheduler down** = new pods stuck in `Pending` forever
- **etcd issues** = highest severity; can cause data loss and full cluster failure
- **Certificate expiration** is a common production failure; use `kubeadm certs check-expiration` proactively
- **Production takeaway**: Monitor control plane component health with Prometheus/alertmanager and set up certificate expiry alerts at 60-day and 30-day thresholds

---

# 41. Troubleshooting — Worker Node Failures

## 🔷 What Are Worker Node Failures?

Worker node failures occur when a node that runs application pods becomes unhealthy or loses connectivity to the control plane. This causes pods on the affected node to be evicted and rescheduled elsewhere (after a timeout period), causing temporary service disruption. Understanding how to diagnose and recover worker node failures is critical for maintaining cluster reliability.

---

## 🔷 How Kubernetes Detects Node Failures

The control plane uses **Node Conditions** updated by kubelet every few seconds. If a node doesn't report for `node-monitor-grace-period` (default: 40 seconds), the node is marked `Unknown`. After `pod-eviction-timeout` (default: 5 minutes), pods are evicted.

---

## 🔷 Node Condition Types

```bash
kubectl describe node worker-1
# Under "Conditions":
Type                Status   Reason              Message
OutOfDisk           False    KubeletHasSufficientDisk
MemoryPressure      False    KubeletHasSufficientMemory
DiskPressure        False    KubeletHasNoDiskPressure
PIDPressure         False    KubeletHasSufficientPID
Ready               True     KubeletReady

# Problem states:
# OutOfDisk: True → Node is out of disk space
# MemoryPressure: True → Node is running low on memory
# DiskPressure: True → Node is running low on disk
# PIDPressure: True → Too many processes
# Ready: False or Unknown → Node is not healthy
```

---

## 🔷 Step-by-Step Worker Node Troubleshooting

### Step 1 — Identify Unhealthy Node

```bash
kubectl get nodes
# NAME       STATUS      ROLES    AGE   VERSION
# worker-1   Ready       <none>   8d    v1.29.0
# worker-2   NotReady    <none>   8d    v1.29.0  ← Problem!
```

### Step 2 — Get Node Details

```bash
kubectl describe node worker-2
# Check:
# - Node conditions (MemoryPressure, DiskPressure, etc.)
# - LastHeartbeatTime (when did kubelet last report?)
# - Events section
# - Taints added by system (node.kubernetes.io/not-ready:NoExecute)
```

### Step 3 — SSH to the Node

```bash
ssh worker-2

# Check system resources
df -h          # Disk space
free -m        # Memory
top            # CPU and process list
uptime         # System load and uptime

# Check if node has network connectivity to master
ping <master-ip>
curl -k https://<master-ip>:6443
```

### Step 4 — Check kubelet Status

```bash
# Is kubelet running?
systemctl status kubelet
# Active: active (running) ← Good
# Active: failed ← Problem

# Start if not running
systemctl start kubelet
systemctl enable kubelet  # Ensure it starts on reboot

# View kubelet logs
journalctl -u kubelet -f
# Look for:
# "Failed to connect to API server"
# "certificate has expired"
# "node not found"
```

### Step 5 — Check kubelet Certificates

```bash
# View the kubelet's client certificate
openssl x509 -in /var/lib/kubelet/pki/kubelet-client-current.pem \
  -text -noout | grep -A2 "Validity"

# Check certificate details
openssl x509 -in /var/lib/kubelet/worker-2.crt -text -noout
# Subject: CN=system:node:worker-2, O=system:nodes
# Verify: CN matches node name, Org is system:nodes
# Verify: Not expired

# If certificate expired → renew using kubeadm
kubeadm token create --print-join-command
# Re-run join command on the worker node
```

---

## 🔷 kubelet Configuration

```bash
# kubelet config file location
cat /var/lib/kubelet/config.yaml

# kubelet systemd unit file
cat /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

# Key configuration to verify:
# - --kubeconfig: points to /etc/kubernetes/kubelet.conf
# - --config: /var/lib/kubelet/config.yaml
# - --container-runtime-endpoint: unix:///run/containerd/containerd.sock
# - --cni-bin-dir: /opt/cni/bin
# - --cni-conf-dir: /etc/cni/net.d
```

---

## 🔷 Common Worker Node Failure Scenarios

| Scenario | Symptoms | Fix |
|---|---|---|
| kubelet crashed | `NotReady`, `systemctl status kubelet` shows failed | `systemctl start kubelet`, check logs |
| Disk full | `DiskPressure: True`, pods evicted | Clean up logs/images: `crictl rmi --prune` |
| Out of memory | `MemoryPressure: True`, OOM kills | Add memory, reduce pod density |
| Certificate expired | kubelet can't authenticate to API server | Renew cert, rejoin cluster |
| Network partition | `Unknown` status, can't SSH | Check network hardware, routing |
| containerd crashed | Pods running but new ones don't start | `systemctl restart containerd` |
| Clock skew | TLS handshake failures | `timedatectl` or `chronyc tracking`, sync NTP |

---

## 🔷 CKA Exam Tips

- Know the **5 Node Condition types** and what they mean
- Know that `NotReady` can be diagnosed with `kubectl describe node`
- Know that **kubelet is the most critical component on worker nodes** — check it first
- Know the kubelet certificate location and format
- Know that `journalctl -u kubelet` shows kubelet system logs
- Know that kubelet must be able to reach kube-apiserver on **port 6443**

---

## 🔎 Topic Summary — Worker Node Failure Troubleshooting

- **Node conditions** (OutOfDisk, MemoryPressure, DiskPressure, Ready) indicate health status
- **NotReady node** → check kubelet status, resource pressure, and network connectivity to master
- **kubelet is the heart of a worker node** — it manages all pods and communicates with the control plane
- **Certificate expiration** is a common production issue — monitor proactively with `kubeadm certs check-expiration`
- **Clock skew** causes TLS failures — ensure NTP is configured on all nodes
- **Recovery order**: Restore connectivity → Start kubelet �� Verify node becomes Ready → Verify pods rescheduled
- **Production takeaway**: Configure node-level monitoring (disk, memory, kubelet health) with alerting to detect issues before they become outages

---

# 42. Kubernetes Infrastructure Choices

## 🔷 What Are Kubernetes Infrastructure Options?

Kubernetes can be deployed on various types of infrastructure, ranging from a developer's laptop to massive multi-region cloud clusters. Understanding the options helps you choose the right platform for your use case — development, testing, or production.

---

## 🔷 Local Development Options

| Tool | Use Case | How It Works |
|---|---|---|
| **Minikube** | Single-node local cluster | Creates a VM (VirtualBox/KVM) with a single Kubernetes node |
| **kind** | Multi-node local cluster | Uses Docker containers as cluster nodes |
| **k3s** | Lightweight production/edge | Stripped-down Kubernetes binary |
| **kubeadm** | Realistic multi-node local cluster | Requires pre-provisioned VMs |

---

## 🔷 Production Deployment Options

### Turnkey Solutions (You manage VMs, tool manages Kubernetes)
| Solution | Provider | Notes |
|---|---|---|
| **kubeadm** | Self-managed | Manual setup on pre-provisioned VMs |
| **kops** | AWS-focused | Automates cluster lifecycle on AWS |
| **Kubespray** | Any cloud/on-prem | Ansible-based, highly flexible |
| **OpenShift** | Red Hat | Enterprise Kubernetes with extras |
| **Rancher** | SUSE | Multi-cluster management |

### Hosted/Managed Solutions (Provider manages control plane)
| Service | Provider | Notes |
|---|---|---|
| **GKE** (Google Kubernetes Engine) | Google Cloud | Fully managed, autopilot mode available |
| **EKS** (Elastic Kubernetes Service) | AWS | Managed control plane, you manage workers |
| **AKS** (Azure Kubernetes Service) | Microsoft Azure | Free control plane, pay for workers |
| **OKE** (Oracle Container Engine) | Oracle | Strong networking capabilities |
| **OpenShift Online** | Red Hat | Managed OpenShift |

---

## 🔷 Decision Framework

```
Is this for development/testing?
    │
    ├── Yes, single developer → Minikube or kind
    ├── Yes, team CI/CD → kind in Docker or k3s
    └── Yes, realistic env → kubeadm on VMs

Is this for production?
    │
    ├── On public cloud (AWS/GCP/Azure)?
    │       ├── Want fully managed? → EKS/GKE/AKS
    │       └── Want more control? → kops (AWS) or Kubespray
    │
    ├── On-premises?
    │       ├── Enterprise support needed? → OpenShift or Rancher
    │       └── Community tools → kubeadm or Kubespray
    │
    └── Edge/IoT/Resource-constrained?
            └── k3s or MicroK8s
```

---

## 🔎 Topic Summary — Infrastructure Choices

- **Minikube** = easiest single-node local development; **kind** = multi-node using Docker
- **kubeadm** = production-grade setup tool; requires VMs but gives full control
- **Managed services** (GKE/EKS/AKS) handle control plane HA, updates, and scaling automatically
- **Turnkey solutions** (kops, Kubespray) automate cluster setup while you retain control
- **OpenShift** adds enterprise features (RBAC presets, integrated CI/CD, developer tools) on top of Kubernetes
- **Production takeaway**: For most organizations, a managed service (EKS/GKE/AKS) reduces operational burden significantly; use kubeadm or kops when you need deeper control or are on-premises

---
