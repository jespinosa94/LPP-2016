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
print(" El resultado de aplicar suma2 de la coordenada Y al array dado es: \(aplica3D([(1,2,3), (4,5,6), (7,8,9), (10,11,12)], funcion: suma2, coord: Coord.Y))")

/////////////////////
/////Ejercicio 3/////
/////////////////////
func cuadrado(x: Int) -> Int {
  return x * x
}
func compruebaParejas(array: ArraySlice<Int>, funcion: (Int)-> Int) -> [(Int, Int)] {
  if(array.isEmpty) {
    return []
  } else if array.count>1 {
    let primero = array[array.startIndex]
    let segundo = array[array.startIndex+1]
    let resto = array[array.startIndex+1..<array.endIndex]
    if(funcion(primero) == segundo) {
      return [(primero, segundo)] + compruebaParejas(resto, funcion: cuadrado)
    } else {
      return compruebaParejas(resto, funcion: cuadrado)
    }
  } else {
    return []
  }
}
print("Ejercicio 3: ")
print(" El resultado de comprobar las parejas del array dado en el enunciado es: \(compruebaParejas([2, 4, 16, 5, 10, 100, 105], funcion: cuadrado))")

/////////////////////
/////Ejercicio 4/////
/////////////////////
enum Intervalo {
  case Limites (Int, Int)
  case Vacio
}
let intervalo1 = Intervalo.Limites(10, 20)
let intervalo2 = Intervalo.Limites(15, 30)
let intervalo3 = Intervalo.Limites(25, 30)
let intervalo4 = Intervalo.Vacio

func union(intervalo1: Intervalo, _ intervalo2: Intervalo) -> Intervalo {
  switch intervalo1 {
    case .Vacio:
      return intervalo2
    case let .Limites(primero, segundo):
      switch intervalo2 {
        case .Vacio:
          return intervalo1
        case let .Limites(primero2, segundo2):
          return Intervalo.Limites(min(primero, primero2) , max(segundo, segundo2))
      }
  }
}
func intersectanIntervalos(primero: Int, _ segundo: Int, _ primero2: Int, _ segundo2: Int) -> Bool {
  return (primero2<=segundo && primero <= segundo2)
}
func interseccion(intervalo1: Intervalo, _ intervalo2: Intervalo) -> Intervalo {
  switch intervalo1 {
    case .Vacio:
      return Intervalo.Vacio
    case let .Limites(primero, segundo):
      switch intervalo2 {
        case .Vacio:
          return Intervalo.Vacio
        case let .Limites(primero2, segundo2):
          if intersectanIntervalos(primero, segundo, primero2, segundo2) {
            return Intervalo.Limites(max(primero, primero2), min(segundo, segundo2))
          } else {
            return Intervalo.Vacio
          }
      }
  }
}

print("Ejercicio 4: ")
print(" La unión de los intervalos 1 y 2 es: \(union(intervalo1, intervalo2))")
print(" La unión de los intervalos 1 y 4 es: \(union(intervalo1, intervalo4))")
print(" La intersección de los intervalos 1 y 2 es: \(interseccion(intervalo1, intervalo2))")
print(" La intersección de los intervalos 1 y 3 es: \(interseccion(intervalo1, intervalo3))")

/////////////////////
/////Ejercicio 4/////
/////////////////////
indirect enum BinaryTree {
  case Node (Int, BinaryTree, BinaryTree)
  case Empty
}
//Se crea el arbol mediante el enumerado recursivo
let arbol: BinaryTree = .Node(8, .Node(2, .Empty, .Empty), .Node(12, .Empty, .Empty))

func suma(instancia: BinaryTree) -> Int {
  switch instancia {
    case .Empty:
      return 0
    case let .Node(raiz, izquierdo, derecho):
      return raiz + suma(izquierdo) + suma(derecho)
  }
}

print("Ejercicio 5: ")
print(" Se crea el árbol propuesto...")
print(" La suma de los nodos del árbol es: \(suma(arbol))")
