//Jorge Espinosa Campello

/////////////////////
/////Ejercicio 1/////
/////////////////////
                    /**********Apartado a**********/
func sumaParejas(parejas: ArraySlice<(Int, Int)>) -> Int {
  if parejas.isEmpty {
    return 0
  } else {
    let primero = parejas[parejas.startIndex]
    let resto = parejas[parejas.startIndex+1..<parejas.endIndex]
    return primero.0 + primero.1 + sumaParejas(resto)
  }
}


let parejas = [(1, 1), (2, 2), (3, 3)]
print("Ejercicio 1a: ")
print(" La suma de las parejas: \(parejas) es \(sumaParejas((ArraySlice(parejas))))")

                  /*****Apartado b*****/
func sumaParejasArray(parejas: ArraySlice<(Int, Int)>) -> [Int] {
  if parejas.isEmpty {
    return []
  } else {
    let primero = parejas[parejas.startIndex]
    let resto = parejas[parejas.startIndex+1..<parejas.endIndex]
    return [primero.0 + primero.1] + sumaParejasArray(resto)
  }
}

print("Ejercicio 1b: ")
print(" La suma de cada una de las parejas \(parejas) es \(sumaParejasArray(ArraySlice(parejas)))")

/////////////////////
/////Ejercicio 2/////
/////////////////////
func suma2(x: Int) -> Int {
  return x + 2
}

enum Coord: String {
  case X, Y, Z
}
//función unaria es de tipo entero o de cualquier tipo?
//hay alguna forma de llamar al primero.coord.rawValue siendo primero una tupla que solo acepta 0,1,2?
func aplica3D(array: ArraySlice<(Int,Int,Int)>, funcion: (Int) -> Int, coord: Coord) -> [(Int, Int, Int)] {
  if(array.isEmpty) {
    return []
  } else {
    var primero = array[array.startIndex]
    let resto = array[array.startIndex+1..<array.endIndex]
    switch coord {
      case Coord.X: primero.0 = suma2(primero.0)
      case Coord.Y: primero.1 = suma2(primero.1)
      case Coord.Z: primero.2 = suma2(primero.2)
    }
    return [primero] + aplica3D(resto, funcion: suma2, coord: coord)
  }
}

print("Ejercicio 2: ")
print("El resultado de aplicar suma2 de la coordenada Y al array dado es: \(aplica3D([(1,2,3), (4,5,6), (7,8,9), (10,11,12)], funcion: suma2, coord: Coord.Y))")
