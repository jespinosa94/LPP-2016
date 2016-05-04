#Jorge Espinosa Campello

/////////////////////
/////Ejercicio 1/////
/////////////////////
                    /**********Apartado a**********/
func sumaParejas(parejas: ArraySlice<(Int, Int)>) -> Int {
  //Función recursiva que suma todas las tuplas de cada pareja
  if parejas.isEmpty {
    return 0
  } else {
    let primero = parejas[parejas.startIndex]
    let resto = parejas[parejas.startIndex+1..<parejas.endIndex]
    return primero.0 + primero.1 + sumaParejas(resto)
  }
}


let parejas = [(1, 1), (2, 2), (3, 3)]
print("Ejercicio 1: ")
print("La suma de las parejas: \(parejas) es \(sumaParejas((ArraySlice(parejas)))")
