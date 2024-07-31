# **GCP 3-Tier Web Architecture Deployment with Terraform**

![GCP Logo](https://img.shields.io/badge/Google%20Cloud-4285F4?logo=google-cloud&logoColor=white)
![Terraform Logo](https://img.shields.io/badge/Terraform-623CE4?logo=terraform&logoColor=white)

## **Project Overview**

This project demonstrates the deployment of a **3-tier web architecture** in **Google Cloud Platform (GCP)** using **Terraform**. It includes the following components:

- **Virtual Private Cloud (VPC)** with multiple subnets
  - 2 public subnets
  - 2 private subnets
  - 1 proxy subnet for private load balancer
- **Virtual Machines (VMs)**
  - A VM in a public subnet running **Pritunl** for secure access
- **Load Balancers**
  - Public load balancer
  - Private load balancer
- **Back-end Services**
  - Public back-end service
  - Private back-end service
- **WordPress Deployment**
  - WordPress image stored in **Google Container Registry (GCR)**
  - Deployment on **Cloud Run**
  - Database on **CloudSQL** within the private subnet
- **DNS Configuration**
  - Public hosted zone
  - DNS records for public and private load balancers

## **Architecture Diagram**

![gcp drawio (1)](https://github.com/user-attachments/assets/66204f78-91dc-4b02-a4d7-bb9090eb505a)

## **Features**

- **VPC Setup**: Creating a robust VPC with necessary subnets for isolation and security.
- **Pritunl VM**: A VM running Pritunl in the public subnet for secure access to private resources.
- **Load Balancing**: Setting up both public and private load balancers to manage traffic effectively.
- **WordPress Deployment**: Utilizing Cloud Run for scalable WordPress deployment and CloudSQL for database management.
- **DNS Configuration**: Creating DNS records for easy access to public and private WordPress instances.

## **Prerequisites**

- **Google Cloud Account**
- **gcloud CLI** installed and configured
- **Terraform** for infrastructure as code
- **Docker** for building and managing container images

## **Installation**

1. **Clone the repository**:
    ```sh
    git clone https://github.com/paawanyadav/terraform-gcp-project.git
    cd terraform-gcp-project
    ```

2. **Set up the GCP environment**:
    ```sh
    gcloud init
    gcloud auth application-default login
    ```

3. **Deploy the Infrastructure with Terraform**:
    ```sh
    cd wordpress/
    terraform init
    terraform plan
    terraform apply
    ```

## **DNS Configuration**

1. **Public Hosted Zone**:
    - A public hosted zone will be created with the following records:
      - **public.wordpress.com**: Points to the public load balancer.
      - **private.wordpress.com**: Points to the private load balancer.

## **Usage**

1. **Access WordPress**:
    - Use Pritunl VM to securely access the private load balancer.
    - Visit the WordPress URLs provided by the DNS configuration:
      - **public.wordpress.com** for the public instance.
      - **private.wordpress.com** for the private instance.

## **Contributing**

We welcome contributions! Please read our [Contributing Guide](CONTRIBUTING.md) for details on our code of conduct and the process for submitting pull requests.

## **License**

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
