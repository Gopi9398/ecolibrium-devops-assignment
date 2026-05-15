aws eks cluster

<img width="1815" height="821" alt="eks-cluster" src="https://github.com/user-attachments/assets/e24e8f2c-bd00-4307-9914-d8d7d91b19af" />

node-group

<img width="1840" height="742" alt="node-group" src="https://github.com/user-attachments/assets/99871440-6554-4ccf-9eca-230cdc901bfa" />

ecr - repository

<img width="1882" height="687" alt="ecr-repo" src="https://github.com/user-attachments/assets/38fcc61e-5360-4cab-9948-410ede689847" />

deployement

<img width="1475" height="666" alt="deployement" src="https://github.com/user-attachments/assets/ac94aaba-9330-4bc6-926a-765167e1dfc6" />

Application validation output

<img width="1578" height="1056" alt="Screenshot 2026-05-15 143110" src="https://github.com/user-attachments/assets/1eb86679-12c7-4232-a135-d830829f2e5a" />


Jenkins pipeline output
```
Started by user gopi
Obtained Jenkinsfile from git https://github.com/Gopi9398/ecolibrium-devops-assignment.git
[Pipeline] Start of Pipeline
[Pipeline] node
Running on Jenkins in /var/lib/jenkins/workspace/devops-assignment-pipeline
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Declarative: Checkout SCM)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
No credentials specified
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/devops-assignment-pipeline/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/Gopi9398/ecolibrium-devops-assignment.git # timeout=10
Fetching upstream changes from https://github.com/Gopi9398/ecolibrium-devops-assignment.git
 > git --version # timeout=10
 > git --version # 'git version 2.50.1'
 > git fetch --tags --force --progress -- https://github.com/Gopi9398/ecolibrium-devops-assignment.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision 627eef2c23b12d4bdcfc73acc60912426f3d44db (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 627eef2c23b12d4bdcfc73acc60912426f3d44db # timeout=10
Commit message: "modified values.yaml in helm chart for ecr"
 > git rev-list --no-walk 4df72005079b9e706026481f8bea7563fb52c21f # timeout=10
[Pipeline] }
[Pipeline] // stage
[Pipeline] withEnv
[Pipeline] {
[Pipeline] stage
[Pipeline] { (Checkout Code)
[Pipeline] checkout
Selected Git installation does not exist. Using Default
The recommended git tool is: NONE
No credentials specified
 > git rev-parse --resolve-git-dir /var/lib/jenkins/workspace/devops-assignment-pipeline/.git # timeout=10
Fetching changes from the remote Git repository
 > git config remote.origin.url https://github.com/Gopi9398/ecolibrium-devops-assignment.git # timeout=10
Fetching upstream changes from https://github.com/Gopi9398/ecolibrium-devops-assignment.git
 > git --version # timeout=10
 > git --version # 'git version 2.50.1'
 > git fetch --tags --force --progress -- https://github.com/Gopi9398/ecolibrium-devops-assignment.git +refs/heads/*:refs/remotes/origin/* # timeout=10
 > git rev-parse refs/remotes/origin/main^{commit} # timeout=10
Checking out Revision 627eef2c23b12d4bdcfc73acc60912426f3d44db (refs/remotes/origin/main)
 > git config core.sparsecheckout # timeout=10
 > git checkout -f 627eef2c23b12d4bdcfc73acc60912426f3d44db # timeout=10
Commit message: "modified values.yaml in helm chart for ecr"
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Configure AWS Credentials)
[Pipeline] withCredentials
Masking supported pattern matches of $AWS_ACCESS_KEY_ID or $AWS_SECRET_ACCESS_KEY
[Pipeline] {
[Pipeline] script
[Pipeline] {
[Pipeline] sh
+ aws sts get-caller-identity --query Account --output text
[Pipeline] echo
AWS Account ID: 980921721078
[Pipeline] echo
ECR Repository: 980921721078.dkr.ecr.ap-south-2.amazonaws.com/demo-app
[Pipeline] }
[Pipeline] // script
[Pipeline] sh
+ aws sts get-caller-identity
{
    "UserId": "AIDA6IY35UD3IFMHDQZQ4",
    "Account": "980921721078",
    "Arn": "arn:aws:iam::980921721078:user/Krishna"
}
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Init)
[Pipeline] dir
Running in /var/lib/jenkins/workspace/devops-assignment-pipeline/terraform
[Pipeline] {
[Pipeline] sh
+ terraform init

[0m[1mInitializing the backend...[0m

[0m[1mInitializing provider plugins...[0m
- Reusing previous version of hashicorp/aws from the dependency lock file
- Using previously-installed hashicorp/aws v5.100.0

[0m[1m[32mTerraform has been successfully initialized![0m[32m[0m
[0m[32m
You may now begin working with Terraform. Try running "terraform plan" to see
any changes that are required for your infrastructure. All Terraform commands
should now work.

If you ever set or change modules or backend configuration for Terraform,
rerun this command to reinitialize your working directory. If you forget, other
commands will detect it and remind you to do so if necessary.[0m
[Pipeline] }
[Pipeline] // dir
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Terraform Apply)
[Pipeline] withCredentials
Masking supported pattern matches of $AWS_ACCESS_KEY_ID or $AWS_SECRET_ACCESS_KEY
[Pipeline] {
[Pipeline] dir
Running in /var/lib/jenkins/workspace/devops-assignment-pipeline/terraform
[Pipeline] {
[Pipeline] sh
+ terraform apply -auto-approve
[0m[1maws_iam_role.eks_cluster_role: Refreshing state... [id=eks-cluster-role][0m
[0m[1maws_vpc.main: Refreshing state... [id=vpc-0d4baaa2c10103954][0m
[0m[1maws_iam_role.eks_node_role: Refreshing state... [id=eks-node-role][0m
[0m[1maws_ecr_repository.demo_app: Refreshing state... [id=demo-app][0m
[0m[1maws_eip.nat_eip: Refreshing state... [id=eipalloc-0fb3136435de656aa][0m
[0m[1maws_subnet.private_subnet_2: Refreshing state... [id=subnet-06270b7a01c35bc02][0m
[0m[1maws_subnet.public_subnet_1: Refreshing state... [id=subnet-0e3d92692e1cdee4e][0m
[0m[1maws_subnet.private_subnet_1: Refreshing state... [id=subnet-0631d76bba44d11db][0m
[0m[1maws_internet_gateway.igw: Refreshing state... [id=igw-09a40566bd78c9568][0m
[0m[1maws_subnet.public_subnet_2: Refreshing state... [id=subnet-00134eeb024bfd5ef][0m
[0m[1maws_route_table.public_rt: Refreshing state... [id=rtb-0059349e1f03f385c][0m
[0m[1maws_nat_gateway.nat: Refreshing state... [id=nat-0b0e938dfdaf6ebd0][0m
[0m[1maws_route_table_association.public_assoc_1: Refreshing state... [id=rtbassoc-029b4344cc95fb664][0m
[0m[1maws_route_table_association.public_assoc_2: Refreshing state... [id=rtbassoc-01055ee58e81d92cd][0m
[0m[1maws_route_table.private_rt: Refreshing state... [id=rtb-03246c91d8962b183][0m
[0m[1maws_route_table_association.private_assoc_2: Refreshing state... [id=rtbassoc-0ad714ec4907ad236][0m
[0m[1maws_route_table_association.private_assoc_1: Refreshing state... [id=rtbassoc-084579a01cf595e1d][0m
[0m[1maws_iam_role_policy_attachment.cni_policy: Refreshing state... [id=eks-node-role-20260515080036215400000003][0m
[0m[1maws_iam_role_policy_attachment.worker_node_policy: Refreshing state... [id=eks-node-role-20260515080036398600000004][0m
[0m[1maws_iam_role_policy_attachment.ecr_readonly: Refreshing state... [id=eks-node-role-20260515080036096400000002][0m
[0m[1maws_iam_role_policy_attachment.eks_cluster_policy: Refreshing state... [id=eks-cluster-role-20260515080035926200000001][0m
[0m[1maws_eks_cluster.eks: Refreshing state... [id=demo-eks-cluster][0m
[0m[1maws_eks_node_group.node_group: Refreshing state... [id=demo-eks-cluster:demo-node-group][0m

[0m[1m[32mNo changes.[0m[1m Your infrastructure matches the configuration.[0m

[0mTerraform has compared your real infrastructure against your configuration
and found no differences, so no changes are needed.
[0m[1m[32m
Apply complete! Resources: 0 added, 0 changed, 0 destroyed.
[0m[0m[1m[32m
Outputs:

[0mcluster_endpoint = "https://4D1EEB3FB31E15DA8DA24F1BB2E35D91.gr7.ap-south-2.eks.amazonaws.com"
cluster_name = "demo-eks-cluster"
ecr_repository_url = "980921721078.dkr.ecr.ap-south-2.amazonaws.com/demo-app"
vpc_id = "vpc-0d4baaa2c10103954"
[Pipeline] }
[Pipeline] // dir
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Docker Build)
[Pipeline] dir
Running in /var/lib/jenkins/workspace/devops-assignment-pipeline/app
[Pipeline] {
[Pipeline] sh
+ docker build -t demo-app .
#0 building with "default" instance using docker driver

#1 [internal] load build definition from Dockerfile
#1 transferring dockerfile: 168B done
#1 DONE 0.0s

#2 [internal] load metadata for docker.io/library/nginx:latest
#2 DONE 0.9s

#3 [internal] load .dockerignore
#3 transferring context: 2B done
#3 DONE 0.0s

#4 [1/2] FROM docker.io/library/nginx:latest@sha256:06aa3d7be10bc6307990c81bdca075793132e9163391abc370c015e344e23128
#4 DONE 0.0s

#5 [internal] load build context
#5 transferring context: 85B done
#5 DONE 0.0s

#6 [2/2] COPY index.html /usr/share/nginx/html/index.html
#6 CACHED

#7 exporting to image
#7 exporting layers done
#7 writing image sha256:3ceb626436e88d21706c5d92185f8bf2c28fdf34c4e1439d08aa6cd9cc818fbb done
#7 naming to docker.io/library/demo-app done
#7 DONE 0.0s
[Pipeline] }
[Pipeline] // dir
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (ECR Login)
[Pipeline] withCredentials
Masking supported pattern matches of $AWS_ACCESS_KEY_ID or $AWS_SECRET_ACCESS_KEY
[Pipeline] {
[Pipeline] sh
+ aws ecr get-login-password --region ap-south-2
+ docker login --username AWS --password-stdin 980921721078.dkr.ecr.ap-south-2.amazonaws.com
WARNING! Your password will be stored unencrypted in /var/lib/jenkins/.docker/config.json.
Configure a credential helper to remove this warning. See
https://docs.docker.com/engine/reference/commandline/login/#credentials-store

Login Succeeded
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Docker Tag)
[Pipeline] sh
+ docker tag demo-app:latest 980921721078.dkr.ecr.ap-south-2.amazonaws.com/demo-app:latest
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Docker Push)
[Pipeline] sh
+ docker push 980921721078.dkr.ecr.ap-south-2.amazonaws.com/demo-app:latest
The push refers to repository [980921721078.dkr.ecr.ap-south-2.amazonaws.com/demo-app]
005c7e999e5a: Preparing
8a834a5e7d53: Preparing
552857a6a5cf: Preparing
7cdb71e5aadd: Preparing
78a032919b52: Preparing
bca2e78b2199: Preparing
2aa8619bf33a: Preparing
79dd1f4c855c: Preparing
bca2e78b2199: Waiting
2aa8619bf33a: Waiting
79dd1f4c855c: Waiting
78a032919b52: Layer already exists
8a834a5e7d53: Layer already exists
7cdb71e5aadd: Layer already exists
005c7e999e5a: Layer already exists
552857a6a5cf: Layer already exists
2aa8619bf33a: Layer already exists
bca2e78b2199: Layer already exists
79dd1f4c855c: Layer already exists
latest: digest: sha256:1fb2df2d656fb17f522879ff692064e2d188f5b7b9e1bc9e5e71a889964c1212 size: 1985
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Configure Kubeconfig)
[Pipeline] withCredentials
Masking supported pattern matches of $AWS_ACCESS_KEY_ID or $AWS_SECRET_ACCESS_KEY
[Pipeline] {
[Pipeline] sh
+ aws eks update-kubeconfig --region ap-south-2 --name demo-eks-cluster
Updated context arn:aws:eks:ap-south-2:980921721078:cluster/demo-eks-cluster in /var/lib/jenkins/.kube/config
[Pipeline] }
[Pipeline] // withCredentials
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Install NGINX Ingress Controller)
[Pipeline] sh
+ kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/main/deploy/static/provider/cloud/deploy.yaml
namespace/ingress-nginx unchanged
serviceaccount/ingress-nginx unchanged
serviceaccount/ingress-nginx-admission unchanged
role.rbac.authorization.k8s.io/ingress-nginx unchanged
role.rbac.authorization.k8s.io/ingress-nginx-admission unchanged
clusterrole.rbac.authorization.k8s.io/ingress-nginx unchanged
clusterrole.rbac.authorization.k8s.io/ingress-nginx-admission unchanged
rolebinding.rbac.authorization.k8s.io/ingress-nginx unchanged
rolebinding.rbac.authorization.k8s.io/ingress-nginx-admission unchanged
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx unchanged
clusterrolebinding.rbac.authorization.k8s.io/ingress-nginx-admission unchanged
configmap/ingress-nginx-controller configured
service/ingress-nginx-controller unchanged
service/ingress-nginx-controller-admission unchanged
deployment.apps/ingress-nginx-controller configured
job.batch/ingress-nginx-admission-create created
job.batch/ingress-nginx-admission-patch created
ingressclass.networking.k8s.io/nginx unchanged
validatingwebhookconfiguration.admissionregistration.k8s.io/ingress-nginx-admission configured
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Wait For Ingress Controller)
[Pipeline] sh
+ kubectl wait --namespace ingress-nginx --for=condition=ready pod --selector=app.kubernetes.io/component=controller --timeout=300s
pod/ingress-nginx-controller-7d65c586d6-gfwlq condition met
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Helm Deploy)
[Pipeline] dir
Running in /var/lib/jenkins/workspace/devops-assignment-pipeline/nginx-chart
[Pipeline] {
[Pipeline] sh
+ helm upgrade --install demo-app .
Release "demo-app" has been upgraded. Happy Helming!
NAME: demo-app
LAST DEPLOYED: Fri May 15 08:27:02 2026
NAMESPACE: default
STATUS: deployed
REVISION: 2
TEST SUITE: None
NOTES:
1. Get the application URL by running these commands:
  http://demo-app.local/
[Pipeline] }
[Pipeline] // dir
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Verify Deployment)
[Pipeline] sh
+ kubectl get nodes
NAME                                       STATUS   ROLES    AGE   VERSION
ip-10-0-3-33.ap-south-2.compute.internal   Ready    <none>   15m   v1.35.4-eks-7fcd7ec
ip-10-0-4-11.ap-south-2.compute.internal   Ready    <none>   15m   v1.35.4-eks-7fcd7ec
[Pipeline] sh
+ kubectl get pods
NAME                                    READY   STATUS              RESTARTS   AGE
demo-app-nginx-chart-5f595fb869-tlvck   0/1     ContainerCreating   0          2s
demo-app-nginx-chart-9cb68b94b-2hv8f    0/1     ImagePullBackOff    0          7m17s
demo-app-nginx-chart-9cb68b94b-c74b6    0/1     ImagePullBackOff    0          7m17s
[Pipeline] sh
+ kubectl get svc
NAME                   TYPE           CLUSTER-IP       EXTERNAL-IP                                                                PORT(S)        AGE
demo-app-nginx-chart   LoadBalancer   172.20.213.232   ab104dea00ea14a99a697e591731f290-1462947305.ap-south-2.elb.amazonaws.com   80:30940/TCP   7m19s
kubernetes             ClusterIP      172.20.0.1       <none>                                                                     443/TCP        17m
[Pipeline] sh
+ kubectl get ingress
NAME                   CLASS   HOSTS            ADDRESS                                                                    PORTS   AGE
demo-app-nginx-chart   nginx   demo-app.local   af093992d955546a89ad7db979830fbc-1348112390.ap-south-2.elb.amazonaws.com   80      7m19s
[Pipeline] }
[Pipeline] // stage
[Pipeline] stage
[Pipeline] { (Declarative: Post Actions)
[Pipeline] echo
Application deployed successfully!
[Pipeline] }
[Pipeline] // stage
[Pipeline] }
[Pipeline] // withEnv
[Pipeline] }
[Pipeline] // node
[Pipeline] End of Pipeline
Finished: SUCCESS
```

