> src: https://www.theurbanpenguin.com/using-vagrant-to-provision-terraform-using-ansible/



##### 

```shell
vagrant up
```

ssh into control-tf

```shell
vagrant ssh control-tf
```



```yaml
cat << EOF | tee playbook.yml
---
- name: Setup Terraform on New Ubuntu 20.04 System
  hosts: localhost
  gather_facts: true
  tasks:
  
    - name: Update the APT Package Cache
      become: true
      apt:
        update_cache: true
        cache_valid_time: 3600
        
    - name: Before we add the Hashicorp Repo - we add the signing key
      become: true
      apt_key:
        url: "https://apt.releases.hashicorp.com/gpg"
        state: present
        
    - name: We now add the Hashicorp Repo to Ubuntu
      become: true
      apt_repository:
        repo: "deb [arch=amd64] https://apt.releases.hashicorp.com focal main"
        state: present
        
    - name: Install software from standard repos and hashicorp
      become: true
      package:
        name:
          - docker.io
          - gnupg
          - software-properties-common
          - curl
          - terraform
          
    - name: We add the local USER to the Docker group
      become: true
      user:
        name: "{{ lookup('env', 'USER') }}"
        groups: docker
        append: true
        
    #- name: We clone the course git repository
    #  git:
    #    repo: "https://github.com/theurbanpenguin/comptia-automation.git"
    #    dest: "{{ lookup('env', 'HOME') }}/comptia-automation"
    #    version: main 
        
    #- name: We create the directory for terraform project
    #  file:
    #    path: "{{ lookup('env', 'HOME') }}/terraform/"
    #    state: directory
        
    #- name: We create the web directory to store content
    #  file:
    #    path: "{{ lookup('env', 'HOME') }}/terraform/web"
    #    state: directory
    
    #- name: We copy the main.tf terraform file from the course repo
    #  copy:
    #    src: "{{ lookup('env', 'HOME') }}/comptia-automation/terraform/main.tf"
    #    dest: "{{ lookup('env', 'HOME') }}/terraform/main.tf"
    
    #- name: Create the index page for the website
    #  copy:
    #    dest: "{{ lookup('env', 'HOME') }}/terraform/web/index.html"
    #    content: This is my web page
EOF
```

```shell
ansible-playbook playbook.yml
```

 verify

```shell
terraform version
```



install on my laptop


https://developer.hashicorp.com/terraform/downloads


```shell
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```




