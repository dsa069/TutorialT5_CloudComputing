#Crear nodo tf_vm
#Creación de un recurso instancia (máquina virtual) en OpenStack. El objeto recurso creado es asignado a la variable tf_vm.
resource "openstack_compute_instance_v2" "tf_vm" {
  name              = "tf_vm"
  image_name        = "jammy"
  availability_zone = "nova"
  flavor_name       = "medium"
  key_pair          = var.openstack_keypair
  security_groups   = ["default"]
  network {
    #Red a la que se conectará la instancia creada. Usamos una variable de entrada almacenada en variables.tf con el nombre de la red.
    name = var.openstack_network_name
  }
}

#Creación de un recurso dirección IP flotante. El objeto recurso creado es asignado a la variable tf_vm_ip.
resource "openstack_networking_floatingip_v2" "tf_vm_ip" {
  pool = "ext-net"
}

#Asociación de la IP flotante a la instancia
#Acceso a la dirección del recurso IP flotante creado
#Acceso al id la instancia creada
resource "openstack_compute_floatingip_associate_v2" "tf_vm_ip" {
  floating_ip = openstack_networking_floatingip_v2.tf_vm_ip.address
  instance_id = openstack_compute_instance_v2.tf_vm.id
}


#Acceso a la dirección del recurso IP flotante creado
#Esperar a que esté creado el recurso de la IP flotante
output tf_vm_Floating_IP {
  value      = openstack_networking_floatingip_v2.tf_vm_ip.address
  depends_on = [openstack_networking_floatingip_v2.tf_vm_ip]
}