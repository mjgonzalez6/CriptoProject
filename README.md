# Smart contract: PopCornSortium

* Filtro de entrada al contrato: Un pago que será devuelto en persona en el cine (Para que no ingrese cualquier persona se le devuelve solo a los amigos)
* Generar propuesta: el que la genera define parámetros y paga su entrada.
* Votar propuesta:
se vota por una película pagando la entrada
se puede votar una sola vez
* Concluir votación:
* Es labor de quien propone la pelicula terminar la votación antes de que pase la hora de inicio de la película de esa propuesta.
* Si la propuesta que se concluye tiene el 50+1 entonces esta es ganadora.
* Si la propuesta que se concluye no tiene el 50+1 entonces es perdedora.
* Si todos votaron la votación se concluye y la propuesta que tenga 50+1 es ganadora.
* El que generó la propuesta ganadora recibe el dinero de ingreso al smart contract (para devolverlo a sus amigos), recibe también el dinero de su propuesta y compra las entradas.
* Los que votaron por propuestas perdedoras el smart contract les devuelve el dinero.
