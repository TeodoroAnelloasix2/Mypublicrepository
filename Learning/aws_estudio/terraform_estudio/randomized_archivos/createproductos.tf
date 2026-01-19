resource "local_file" "products" {
    count = 5 #Con count indicamos el numero de recursos a crear
  content = "Producto ${random_integer.prod-id[count.index].result}"
  filename = "products-${random_string.prefix[count.index].id}"
  directory_permission = 0750
}

#To create random string
resource "random_string" "prefix" {
    count = 5 #Numero de recursos a crear (es como un bucle for de 5 vueltas )
    length = 4
    special = false
    upper = false
    lower = true
    numeric = false
}


#To create 5 random integer from 1 to 10
resource "random_integer" "prod-id" {
    count = 5
    min = 1
    max = 10
}