**Acest schelet de proiect si acest README.MD sunt orientative.** 
**Aveti libertatea de a aduga alte fisiere si a modifica acest schelet cum doriti. Important este sa implementati proiectul conform cerintelor primite.**
**Acest text si tot textul ajutator de mai jos trebuiesc sterse inainte de a preda proiectul.**

**Pentru a clona acest proiect creati propriul vostru proiect EMPTY in gihub si rulati:**
```bash
git clonegit@github.com:gabiadaf07/monitoring-platform.git
```


# Platforma de Monitorizare a Starii unui Sistem

## Scopul Proiectului
- [Proiectul este un monitoring-platform ce poate deservi la monitorizarea sistemelor si utilizarea eficienta a resurselor hardware , pentru a maximiza durata de functionare a aplicatiilor fara a exista perioade de downtime ale aplicatiilor. ]

### Arhitectura proiectului
Acest subpunct este BONUS.
- [Desenati in excalidraw sau in orice tool doriti arhitectura generala a proiectului si includeti aici poza cu descrierea pasilor]

- Acesta este un exemplu de inserare de imagine in README.MD. Puneti imagine in directorul de imagini si o inserati asa:

![Jenkins Logo](imagini/jenkins-logo.png)

Consultati si [Sintaxa Markdown](https://www.markdownguide.org/cheat-sheet/)

## Structura Proiectului
[Aici descriem rolul fiecarui director al proiectului. Descrierea trebuie sa fie foarte pe scurt la acest pas. O sa intrati in detalii la pasii urmatori.]
- `/scripts`: [Aici avem directorul de scripts: unde avem scriptul de backup.py si scriptul de monitoring.sh]
- `/docker`: [Descriere Dockerfiles și docker-compose.yml . Avem 3 imagini Docker :
    - imaginea pentru partea de backup care copiaza, instaleaza librariile necesare si variabilele de mediu .
    - imaginea pentru partea de monitoring care copiaza fisierul de bash, asigura drept de executie a fisierului si ruleaza fisierul monitoring.sh
    - imaginea pentru jenkins pentru create containerului de jenkins pentru a rula pipeline-urile]
- `/ansible`: [Descriere rolurilor playbook-urilor și inventory:
    - install_docker.yml reprezinta un playbook ce automatizează procesul de instalare a Docker pe o mașină virtuală remote, asigurând configurarea corectă a surselor, pachetelor și permisiunilor necesare.
    - deploy_playform.yml reprezinta un playbook ce automatizează
    procesul de instalare a docker compose.
- `/jenkins`: [Aici regasim folderul pentru jenkins in care avem]:
    `-/pipelines`: [Folderul de pipelines deserveste la urmatoarele doua pipeline-uri : ]
        - `/backup`: Acest Jenkinsfile definește un pipeline complet pentru gestionarea aplicației de backup, folosind containere Docker și integrare cu Docker Hub. Pipeline-ul este împărțit în mai multe etape care acoperă verificarea codului, construirea imaginii Docker, publicarea acesteia și lansarea aplicației.
        -`/monitoring`:  Acest Jenkinsfile definește un pipeline complet pentru gestionarea aplicației de monitoring, folosind containere Docker și integrare cu Docker Hub. Pipeline-ul este împărțit în mai multe etape care acoperă  construirea imaginii Docker, publicarea acesteia și lansarea aplicației.
- `/terraform`: [Descriere rol fiecare fisier Terraform folosit]

    - main.tf : Fișierul principal care definește resursele infrastructurii. Aici sunt declarate instanțele EC2, grupurile de securitate, bucket-urile S3, key pair-urile și orice altă resursă AWS sau LocalStack.
    - backend.tf : Configurează backend-ul Terraform — adică locul unde se salvează fișierul `terraform.tfstate`. 
    - variables.tf : Conține toate variabilele de intrare utilizate în proiect. Aici sunt definite valorile parametrizabile precum `ami_id`, `instance_type`, `region`, etc. Permite reutilizarea și flexibilitatea configurației.
    - outputs.tf : Definește valorile care vor fi afișate după rularea comenzii `terraform apply`. De exemplu, IP-ul instanței EC2, numele bucketului S3 sau orice altă informație utilă pentru pașii următori (Ansible, Jenkins, etc.).
    - versions : Specifică versiunea minimă de Terraform necesară .
         



## Setup și Rulare
- [Instrucțiuni de setup local și remote. Aici trebuiesc puse absolut toate informatiile necesare pentru a putea instala si rula proiectul. De exemplu listati aici si ce tool-uri trebuiesc instalate (Ansible, SSH config, useri, masini virtuale noi daca este cazul, etc) pasii de instal si comenzi].
- [Dependinte necesare]
    ```bash
        # Terraform
    sudo apt update && sudo apt install -y terraform

    # Ansible
    sudo apt install -y ansible

    # Docker & Docker Compose
    sudo apt install -y docker.io
    sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.5/docker-compose-linux-x86_64" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose

    # Python (pentru scripturi)
    sudo apt install -y python3 python3-pip
    ```
- [Creeare cheie SSH :] 
```bash
    ssh-keygen -t rsa -f ~/.ssh/ansible_key
    cat /home/admin0103/.ssh/ansible_key.pub
```

- [Instalarea serviciului ssh pe masina remote  sau masina 2]

```bash
su - (ne logăm ca root)
apt update
apt install -y openssh-server
systemctl status sshd

```

- [Adăugați un user nou cu numele eu pe mașina 2 si adăugati cheia lui publică generată anterior (la pasul 1) în lista de chei autorizate.]

```bash
adduser theansible
su - theansible
mkdir ~/.ssh
echo public_key >> ~/.ssh/authorized_keys
chmod -R go= ~/.ssh  
ls -ld ~/.ssh
```
- [Observatii: ]
- [În loc de public_key trebuie să puneți între ghilimele cheia publică generată la pasul 1.]
- [În Linux, directorul .ssh și conținutul său trebuie să aibă drepturi restricționate pentru group și others. Dacă nu sunt restricționate, protocolul SSL nu le ia în considerare din motive de securitate]

- [Pasul X: ]
    - Setați un network bridge între cele două mașini pentru a putea accesa mașina 2 (remote) din masina 1 (Ubuntu2204). Pentru a face acest lucru trebuie să: 
    opriți ambele mașini (cu shutdown, nu save state) 
    pentru fiecare mașină
    dați click pe Settings > Network > Adapter 2 (NU modificati Adapter 1. Acela este folosit pentru accesul la internet al mașinilor)
    Bifati Enable Network Adapter
    Selectati Attached to: Bridge Adapter și dați click pe ok
    După ce ați făcut acest lucru pentru ambele masini, le dați start]

- [Pasul Y: ]
    - [Verificați IP-ul mașinii remote folosind comanda:]
```bash
ip addr
```
    [- IP-ul căutat este cel mai de jos,  din dreptul adresei inet.]

-   [!Inet Imagine ]
- [Pasul Z:]
    - [Executați comanda de ssh de pe mașina 1 folosind IP-ul obținut mai sus:
    Dacă setup-ul a fost făcut cu success, ar trebui să vedeți un rezultat similar cu acesta:
    ]
- [!inet Imagine 2]
- [Descrieti cum ati pornit containerele si cum ati verificat ca aplicatia ruleaza corect.]

- [Includeti aici pasii detaliati de configurat si rulat Ansible pe masina noua]
    Intrati pe masina noua si folositi comanda folosita la pasul anterior pentru a vedea IP-ul masinii remote.
    Folositi ip-ul masinii remote si adaugati-l in fisierul inventory.ini din proiect din folder-ul ansible .

- [!ip inventory ini]
- [Descrieti cum verificam ca totul a rulat cu succes? Cateva comenzi prin care verificam ca Ansible a instalat ce trebuia]

- [Exemplu de fisier inventory.ini]
```yml
[dockerhost]
54.214.59.124 ansible_user=eu ansible_ssh_private_key_file=~/.ssh/id_rsa_jenkins
```
```bash
ansible-playbook -i inventory.ini install_docker.yml
ansible-playbook -i inventory.ini deploy_platform.yml
```
- [Dupa rularea comenzilor , intrati in masina remote si executati comanda :]
```bash
docker ps
docker logs
```
- [Aici veti putea observa daca procesele docker ruleaza :]
- [Verificarea fisierelor copiate : ]
```bash
ls -l /home/eu/docker/
ls -l /home/eu/docker/scripts/
```

## Setup și Rulare in Kubernetes
- [Comenezi pentru rularea aplicatiei in Kubernetes]
```bash
#!/bin/bash

set -e

# 1. Activăm mediul Docker din Minikube
echo "🔧 Activare mediu Docker Minikube..."
eval $(minikube docker-env)

# 2. Build imagini locale
echo "🐳 Construim imaginile Docker..."
docker build -t local/backup:latest -f docker/backup/Dockerfile .
docker build -t local/monitoring:latest -f docker/monitoring/Dockerfile .

# 3. Aplicăm manifestele Kubernetes
echo "🚀 Aplicăm manifestele Kubernetes..."
kubectl apply -f k8s/deployment.yaml
kubectl apply -f k8s/nginx-service.yaml
kubectl apply -f k8s/hpa.yaml

# 4. Verificăm statusul
echo "📦 Poduri în namespace-ul 'monitoring':"
kubectl get pods -n monitoring

echo "🌐 Servicii disponibile:"
kubectl get svc -n monitoring

echo "📈 HPA status:"
kubectl get hpa -n monitoring
```

## CI/CD și Automatizari
- [Descriere pipeline-uri Jenkins. Puneti aici cat mai detaliat ce face fiecare pipeline de jenkins cu poze facute la pipeline in Blue Ocean. Detaliati cat puteti de mult procesul de CI/CD folosit.]

📦 Etape detaliate
1. Checkout
	• Preia codul sursă din repository-ul Git configurat în Jenkins.
2. Lint
	• Rulează un container Python (python:3.12-slim) care:
		○ Instalează flake8
		○ Rulează analiza statică (linting) pe toate fișierele .py
	• Scopul este să detecteze erori de stil sau sintaxă înainte de build.
3. (Comentată) Unit Tests
	• Etapa este momentan dezactivată.
	• Ar rula testele unitare cu pytest într-un container Python.
4. Build Docker Image
	• Construiește imaginea Docker pentru backup folosind fișierul docker/backup/Dockerfile.
	• Etichetează imaginea cu gabiadaf07/backup:latest.
5. Push to Docker Hub
	• Publică imaginea Docker în Docker Hub folosind credentialele stocate în Jenkins (DOCKER_CREDENTIALS_ID).
6. Deploy
	• Rulează docker-compose pentru a lansa aplicația definită în docker/docker-compose.yml.
🔐 Variabile de mediu
groovy
environment {
    DOCKER_IMAGE = 'gabiadaf07/backup:latest'
    DOCKER_CREDENTIALS_ID = 'credentiale-dockerhub'
}
🧠 Scopul pipeline-ului
	• Automatizează verificarea calității codului
	• Construiește și publică imaginea de backup
Lansează aplicația într-un mediu Docker orchestrat cu docker-compose




📊 Ce face pipeline-ul Jenkins pentru monitoring
Acest Jenkinsfile automatizează procesul de verificare, construire, publicare și lansare a serviciului de monitorizare într-un mediu Docker orchestrat cu docker-compose.

🧩 Etape ale pipeline-ului
1. Checkout
Preia codul sursă din repository-ul Git configurat în Jenkins.

2. Lint
Rulează un container python:3.12-slim care:

Instalează flake8

Rulează analiza statică pe fișierele .py din proiect

Scopul este să detecteze erori de stil sau sintaxă în codul de monitorizare.

3. (Opțională) Unit Tests
Etapa este comentată, dar poate fi activată pentru a rula teste automate cu pytest.

4. Build Docker Image
Construiește imaginea Docker pentru serviciul de monitorizare folosind fișierul docker/monitoring/Dockerfile.

Etichetează imaginea cu ceva de genul gabiadaf07/monitoring:latest (dacă este configurat astfel).

5. Push to Docker Hub
Publică imaginea în Docker Hub folosind credentialele definite în Jenkins (DOCKER_CREDENTIALS_ID).

6. Deploy
Rulează docker-compose pentru a lansa serviciul de monitorizare împreună cu celelalte componente (ex: backup, nginx).

🔐 Variabile de mediu (exemplu)
groovy
environment {
    DOCKER_IMAGE = 'gabiadaf07/monitoring:latest'
    DOCKER_CREDENTIALS_ID = 'credentiale-dockerhub'
}
🧠 Scopul pipeline-ului
Automatizează verificarea calității codului

Construiește și publică imaginea de monitorizare

Lansează aplicația într-un mediu Docker orchestrat

Poate fi extins cu testare, validare și notificări

- [Detalii cu restul cerintelor de CI/CD (cum ati creat userul nou ce are access doar la resursele proiectului, cum ati creat un View now pentru proiect, etc)]
imagini

- [Daca ati implementat si punctul E optional atunci detaliati si setupul de minikube.]


## Terraform și AWS
- [Prerequiste]
- [Instrucțiuni pentru rularea Terraform și configurarea AWS]
⚙️ - [Setup LocalStack + Terraform
🧩 1. Configurare AWS CLI
bash
aws configure
Ai introdus:
	• Access Key ID: test
	• Secret Access Key: test
	• Region: us-east-1
	• Output format: json
	Aceste valori sunt standard pentru LocalStack și nu necesită autentificare reală.
🪣 2. Creare bucket S3 în LocalStack
bash
aws --endpoint-url=http://localhost:4566 s3 mb s3://terraform-state-dev
	Creează bucket-ul terraform-state-dev în LocalStack, care va fi folosit ca backend pentru fișierul terraform.tfstate.
📦 3. Inițializare Terraform
bash
terraform init
	Inițializează directorul Terraform, descarcă providerii și configurează backend-ul (dacă ai backend.tf).
✅ 4. Validare configurație
bash
terraform validate]
📐 4.1 Planificare infrastructură
bash
terraform plan
	Generează un plan detaliat cu toate acțiunile pe care Terraform le va executa. Nu modifică nimic încă.
🚀 5. Aplicare infrastructură
bash
terraform apply
	Aplică modificările și creează resursele definite în fișierele .tf. Vei fi întrebat să confirmi cu yes.
📤 6. Verificare resurse create
După aplicare, poți verifica:
bash
terraform output

