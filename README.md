# ChambaApp Terraform Infrastructure

Este repositorio contiene la infraestructura como código (IaC) para el proyecto **ChambaApp**, utilizando **Terraform** para desplegar y gestionar los recursos necesarios en **DigitalOcean**.

## ☁️ Infraestructura Provisionada

- Droplet con Ubuntu Server 24.04
- Firewall configurado con puertos HTTP, HTTPS y SSH
- Configuración de red y reglas básicas
- Conexión al backend de DigitalOcean para gestión remota del estado

## 📁 Estructura del Proyecto

```
chambaApp-Terraform/
├── main.tf              # Configuración principal del Droplet y red
├── variables.tf         # Variables reutilizables (como token, nombre, etc.)
├── outputs.tf           # Salidas útiles como IP pública
├── terraform.tfvars     # Valores concretos de tus variables
└── README.md            # Documentación del proyecto
```

## ⚙️ Requisitos

- [Terraform](https://www.terraform.io/) >= 1.3
- Cuenta de [DigitalOcean](https://www.digitalocean.com/)
- Token de API de DigitalOcean con permisos de escritura

## 🚀 Cómo usar

1. Clona el repositorio:

   ```bash
   git clone https://github.com/Kuripipeer/chambaApp-Terraform.git
   cd chambaApp-Terraform
   ```

2. Crea un archivo `terraform.tfvars` con tu configuración:

   ```hcl
   do_token = "tu_token_de_digitalocean"
   droplet_name = "chamba-back"
   region = "nyc3"
   ```

3. Inicializa el proyecto y despliega:

   ```bash
   terraform init
   terraform apply
   ```

4. Una vez desplegado, la IP pública estará disponible como salida en consola.

## 🌐 Proyecto Relacionado

Este entorno sirve como backend para la app móvil [ChambaApp-Front](https://github.com/angx7/chambaApp-Front) y el API REST en [ChambaApp-Back](https://github.com/angx7/chambaApp-Back).

## 👨‍💻 Autores

- **Christian Axel Moreno Flores** – [@Kuripipeer](https://github.com/kuripipeer)
- **Angel Alejandro Becerra Rojas** – [@angx7](https://github.com/angx7)

## 📄 Licencia

Distribuido bajo la licencia MIT.
