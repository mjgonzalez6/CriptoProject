# Smart contract: PopCornSortium

## Introducción
Este smart contract es un consorcio desarrollado sobre el lenguaje de programación solidity dirigido al uso entre un grupo de amigos que desean organizar una salida al cine proponiendo y votando entre un conjunto de películas, definiendo el respectivo pago.

## Reglas
* Filtro de entrada al contrato: Cada persona que ingresa al contrato deberá realizar un pago que será definido por quien crea el contrato y que posteriormente será devuelto sólo a los amigos por el organizador durante la salida al cine.
* Generar propuesta:
* Para proponer una película el usuario organizador debe definir los parámetros nombre de pelicula y el valor de la entrada realizando el pago de esta misma.
* Votar propuesta: 
* Para votar por una película se debe pagar el valor de su entrada, perdiendo el derecho de votar por otra.
* Concluir votación:
* El organizador de cada propuesta puede concluir su propuesta antes de que todos hayan votado, si la propuesta que se concluye tiene el 50%+1 de votos, entonces esta es la propuesta ganadora. Si la propuesta que se concluye no tiene el 50%+1 de votos, entonces es una propuesta perdedora.
* Si todos votaron, la votación se concluye y la propuesta que tenga 50%+1 de votos es la propuesta ganadora. De no haber una propuesta que tenga 50%+1 de votos entonces no se logra decidir y todas las propuestas son perdedoras.
* El organizador que generó la propuesta ganadora recibe el dinero de ingreso al smart contract para devolverlo a sus amigos y además recibe el dinero recolectado por su propuesta correspondiente a los pagos de entrada realizado por sus votantes.
* Finalmente el contrato le devuelve el dinero de las entradas a las personas que votaron por cada propuesta perdedora.

## Supuestos
* Es labor del amigo organizador terminar la votación antes de que pase la hora de inicio.
* Es labor del amigo organizador devolver el dinero de ingreso al contrato a sus amigos.
* Es labor del amigo organizador realizar el pago de las entradas en el cine utilizando el dinero recolectado con las votaciones.
