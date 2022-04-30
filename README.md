# Elk-Stack-Project
### Week 13 Project 1 - Elk Stack - Gabriel DiGiamberardino ###


## Automated ELK Stack Deployment

The files in this repository were used to configure the network depicted below.

![TODO: Update the path with the name of your diagram](Images/diagram_filename.png)

(Diagrams/Elk-Stack-Project-Diagram.png)

These files have been tested and used to generate a live ELK deployment on Azure. They can be used to either recreate the entire deployment pictured above. Alternatively, select portions of the YML and Config file may be used to install only certain pieces of it, such as Filebeat.

  - _TODO: Enter the playbook file._
  - My First Playbook
  - Hosts
  - Ansible Configuration
  - Ansible Elk Installation and VM Configuration
  - Filebeat Config
  - Filebeat Playbook
  - Metricbeat Config
  - Metricbeat Playbook

This document contains the following details:
- Description of the Topology
- Access Policies
- ELK Configuration
  - Beats in Use
  - Machines Being Monitored
- How to Use the Ansible Build


### Description of the Topology

The main purpose of this network is to expose a load-balanced and monitored instance of DVWA, the D*mn Vulnerable Web Application.

Load balancing ensures that the application will be highly available, in addition to restricting traffic to the network.
- What aspect of security do load balancers protect? 
    Load Balancers protect against server overload by distributing traffic across multple servers. They protect availability. 
- What is the advantage of a jump box?
    The major advantage of a jump box is that it prevents the VMs from being exposed to the public. It gives you the option to restict access to certain IP addresses or via certain methods (such as SSH or HTTP). They can also be setup fairly easily.  

Integrating an ELK server allows users to easily monitor the vulnerable VMs for changes to the logs and system metrics.
- What does Filebeat watch for?
    Filebeat is a log management tool that watches for system logs and is a way to centralize the logs and files. 
- What does Metricbeat record?
    Metricbeat is a monitoring tool that records metrcis from the systems or services and can send that output where neccessary. 


The configuration details of each machine may be found below.
    Note: Use the [Markdown Table Generator](http://www.tablesgenerator.com/markdown_tables) to add/remove values from the table.

| Name     |   Function   |        IP Address          | Operating System |
|----------|--------------|----------------------------|------------------|
| Jump Box | Gateway      | 10.0.0.4 / 20.211.16.108   | Linux            |
| Web-1    | Web Server   | 10.0.0.5 / 20.213.54.143   | Linux            |
| Web-2    | Web Server   | 10.0.0.6 / 20.213.54.143   | Linux            |
| ElkVM    | Monitoring   | 10.1.0.4 / 20.216.16.108   | Linux            |

### Access Policies

The machines on the internal network are not exposed to the public Internet. 

Only the Jump Box machine can accept connections from the Internet. Access to this machine is only allowed from the following IP addresses:
    My workstation's public IP address (using a VPN so IP changes)

Machines within the network can only be accessed by SSH through the Jump Box.
- Which machine did you allow to access your ELK VM? 
    JumpBox VM (IP: 10.0.0.4) through SSH (p 22)
- What was its IP address?
    IP address of my Workstation could access through TCP 5601


A summary of the access policies in place can be found in the table below.

| Name      | Publicly Accessible |  Allowed IP Addresses     |
|-----------|---------------------|---------------------------|
| Jump-Box  | Yes                 | Workstation IP (SSH p 22) |
| Web 1     | No                  | 10.0.0.4 (p 22)           |
| Web 2     | No                  | 10.0.0.4 (p 22)           |
| Elk-VM    | No                  | Workstation IP (TCP 5601) |

### Elk Configuration

Ansible was used to automate configuration of the ELK machine. No configuration was performed manually, which is advantageous because it lets you quickly deploy the ELK stack through playbooks 
- What is the main advantage of automating configuration with Ansible?
    In addition to being able to quickly deploy, it also can prevent human errors and simplifies the deployment process. 

The playbook implements the following tasks:
- In 3-5 bullets, explain the steps of the ELK installation play. E.g., install Docker; download image; etc._
    - Installs docker.io on the elk machine, which was specified as 'hosts:  elk'
    - Intalls python3-pip
    - pip installs docker
    - Runs command sysctl -w vm.max_map_count=262144 to increase virtual memory
    - Downloads and launches a docker elk container (image sebp/elk:761) with publised ports 5601, 9200, 5044
    - uses systemd to enable docker on boot


The following screenshot displays the result of running `docker ps` after successfully configuring the ELK instance.

![TODO: Update the path with the name of your screenshot of docker ps output](Images/docker_ps_output.png)

(Diagrams/Images/Docker_ps.png)

### Target Machines & Beats
This ELK server is configured to monitor the following machines:
- List the IP addresses of the machines you are monitoring
    Web-1 (10.0.0.5)
    Web-2 (10.0.0.6)

We have installed the following Beats on these machines:
- Specify which Beats you successfully installed
    Filebeat
    (Diagrams/Images/Filebeat.png)
    *add screenshot*
    Metricbeat
    (Diagrams/Images/Metricbeat.png)
    *add screenshot*

These Beats allow us to collect the following information from each machine:
- In 1-2 sentences, explain what kind of data each beat collects, and provide 1 example of what you expect to see. E.g., `Winlogbeat` collects Windows logs, which we use to track user logon events, etc._
    Filebeat collects logs from files and can be used to track and monitor log messages
    Metricbeat collects metric data and can be used to track system metrics. For example, CPU usage and Memory usage. 

### Using the Playbook
In order to use the playbook, you will need to have an Ansible control node already configured. Assuming you have such a control node provisioned: 

SSH into the control node and follow the steps below:
- Copy the configureation file to the /etc/ansible/files folder and make any necessary configuration changes.
- Update the /etc/ansible/hosts file to include the IP addresses required (Web-1 and Web-2 for wenservers, and ElkVM for elk)
- Create the playbook.yml file with the deisred tasks for the ansible playbook
- Run the playbook, and navigate to ELK VMs localhost:5601 (Kibana) to check that the installation worked as expected.

Answer the following questions to fill in the blanks:
- Which file is the playbook? Where do you copy it?
   The playbook is the '*-playbook.yml' file. It is written in YAML and copies the config file from the source to the webserver VMs (Web-1 and Web-2) in the /etc/filebeat folder or /etc/metricbeat depending on the playbook

- Which file do you update to make Ansible run the playbook on a specific machine? How do I specify which machine to install the ELK server on versus which to install Filebeat on?
    Update the playbook to make sure it runs on a specific server. Within the playbook YAML file, you must define the hosts in which the playbook will run. In our situation for Filebeat, the hosts was defined as 'webservers' which is our Web-1 and Web-2 machine. However, our install_elk.yml playbook defined the hosts as elk, which specifies our ELK server rather than our webservers. 

- Which URL do you navigate to in order to check that the ELK server is running?
    localhost:5601/app/kibana
    localhost of ELK Server is 20.216.16.108

As a **Bonus**, provide the specific commands the user will need to run to download the playbook, update the files, etc.

+-------------------------------------------------+--------------------------------------------------------+
| COMMAND                                         | PURPOSE                                                |
+-------------------------------------------------+--------------------------------------------------------+
| ssh-keygen                                      | generate SSH key                                       |
+-------------------------------------------------+--------------------------------------------------------+
| sudo cat .ssh/id_rsa.pub                        | to view the ssh public key                             |
+-------------------------------------------------+--------------------------------------------------------+
| ssh azureuser@ IP Address                       | to log into a machine                                  |
+-------------------------------------------------+--------------------------------------------------------+
| sudo docker container list -a                   | list the docker containers                             |
+-------------------------------------------------+--------------------------------------------------------+
| sudo docker start sharp_curran                  | start docker container                                 |
+-------------------------------------------------+--------------------------------------------------------+
| sudo docker ps -a                               | list active/inactive containers                        |
+-------------------------------------------------+--------------------------------------------------------+
| sudo docker attach sharp_curran                 | get a shell in the container                           |
+-------------------------------------------------+--------------------------------------------------------+
| nano *filename*                                 | to edit a file                                         |
+-------------------------------------------------+--------------------------------------------------------+
| ansible-playbook *filename*                     | to run the playbook (in the same directory)            |
+-------------------------------------------------+--------------------------------------------------------+
| sudo docker pull cyberxsecurity/ansible         | to pull the docker container file                      |
+-------------------------------------------------+--------------------------------------------------------+
| sudo docker run -ti cyberxsecurity/ansible bash | run and create the docker container image              |
+-------------------------------------------------+--------------------------------------------------------+
| ansible -m ping all                             | to check the connection                                |
+-------------------------------------------------+--------------------------------------------------------+
| curl -L -O *link to the file*                   | to download a file from the internet                   |
+-------------------------------------------------+--------------------------------------------------------+
| dpkg -i *filename*                              | to install the file, used with filebeat and metricbeat |
+-------------------------------------------------+--------------------------------------------------------+
| http://20.216.16.108:5601//app/kibana           | navigate to Kibana via ELK server IP address           |
+-------------------------------------------------+--------------------------------------------------------+

