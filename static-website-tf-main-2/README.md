# Subscripcion a Carro

Este proyecto implementa una aplicación web de subscripción a carros, permitiendo a los usuarios registrarse, iniciar sesión, ver información y realizar acciones de subscripción. Todo el entorno, incluyendo la infraestructura, se puede desplegar fácilmente utilizando Terraform.

## Despliegue con Terraform
terraform init
terraform plan \
  -var 'aws_access_key_id=YOUR_ACCESS_KEY' \
  -var 'aws_secret_access_key=YOUR_SECRET_KEY' \
  -var 'region=us-east-1'

terraform apply \
  -var 'aws_access_key_id=YOUR_ACCESS_KEY' \
  -var 'aws_secret_access_key=YOUR_SECRET_KEY' \
  -var 'region=us-east-1'

### Requisitos previos
1. Asegúrate de tener Terraform instalado en tu máquina local. Puedes descargarlo [aquí](https://www.terraform.io/downloads.html).

2. Configura tus credenciales de AWS en tu entorno. Puedes hacerlo configurando el archivo `~/.aws/credentials` o mediante variables de entorno.

    ```ini
    # ~/.aws/credentials

    [default]
    aws_access_key_id = TU_ACCESS_KEY_ID
    aws_secret_access_key = TU_SECRET_ACCESS_KEY
    ```

### Pasos para desplegar

1. Clona este repositorio en tu máquina local.

    ```bash
    git clone https://url-del-repositorio.git
    cd nombre-del-repositorio
    ```

2. En el directorio del proyecto, crea un archivo `terraform.tfvars` con las variables necesarias.

    ```hcl
    # terraform.tfvars

    aws_access_key = "TU_ACCESS_KEY_ID"
    aws_secret_key = "TU_SECRET_ACCESS_KEY"
    ```

3. Inicializa Terraform en el directorio del proyecto.

    ```bash
    terraform init
    ```

4. Aplica la configuración de Terraform para crear la infraestructura en AWS.

    ```bash
    terraform apply
    ```

    A lo largo de este proceso, Terraform te preguntará si estás seguro de aplicar los cambios. Ingresa `yes` para continuar.

5. Después de la aplicación exitosa, Terraform proporcionará información sobre los recursos creados.

    ```bash
    Apply complete! Resources: 2 added, 0 changed, 0 destroyed.

    Outputs:

    instance_public_ip = "X.X.X.X"
    ```

6. Accede a la aplicación web utilizando la dirección IP pública proporcionada en el paso anterior. Abre tu navegador y visita `http://X.X.X.X` (sustituye `X.X.X.X` con la dirección IP real).

¡Listo! La aplicación Subscripcion a Carro debería estar desplegada y accesible.

### Estructura del Proyecto

La estructura del proyecto se organiza de la siguiente manera:

```plaintext
.
├── Dockerfile            # Configuración de la imagen de Docker
├── Node
│   ├── css               # Carpeta de hojas de estilos
│   ├── html              # Carpeta de archivos HTML
│   ├── img               # Carpeta de imágenes
│   ├── index.js          # Configuración del servidor de Node
│   ├── package.json      # Configuración de paquetes y dependencias
├── README.md             # Documentación detallada del proyecto
├──  script.sh            # Script para desplegar todo automáticamente
├── main.tf               #para el despliegue de aws
├── appmovilllave.pem     #llave normal para abrir proyecto si se requiere

# telematics
# telematics
