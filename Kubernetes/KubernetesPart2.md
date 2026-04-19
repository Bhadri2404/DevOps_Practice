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

