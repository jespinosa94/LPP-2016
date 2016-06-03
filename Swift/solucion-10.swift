//////////////////////
// Solución práctica 10
//////////////////////



//////////////
// Ejercicio 1
//////////////

// 1.a)
func sumaParejas(parejas: ArraySlice<(Int,Int)>) -> Int {
    if parejas.isEmpty {
        return 0
    } else {
        let primero = parejas[parejas.startIndex]
        let resto = parejas[parejas.startIndex+1..<parejas.endIndex]
        return(primero.0 + primero.1 + sumaParejas(resto))
    }
}

// Pruebas
let parejas = [(1, 1), (2, 2), (3, 3)]
print("Ejercicio 1.a")
print("La suma de las parejas: \(parejas) es \(sumaParejas(ArraySlice(parejas)))\n")


// 1.b)
func sumaParejasArray(parejas: ArraySlice<(Int,Int)>) -> [Int] {
    if parejas.isEmpty {
        return []
    } else {
        let primero = parejas[parejas.startIndex]
        let resto = parejas[parejas.startIndex+1..<parejas.endIndex]
        return([primero.0 + primero.1] + sumaParejasArray(resto))
    }
}

// Pruebas
print("Ejercicio 1.b")
print("La suma de parejas de \(parejas) es \(sumaParejasArray(ArraySlice(parejas)))\n")



//////////////
// Ejercicio 2
//////////////
enum Coord {
   case X, Y, Z
}

func aplica3D(puntos: ArraySlice<(Int,Int,Int)>, funcion f: (Int) -> Int, coord:Coord) -> [(Int,Int,Int)] {
  if puntos.isEmpty {
    return []
  } else {
    var primero = puntos[puntos.startIndex]
    let resto = puntos[puntos.startIndex+1..<puntos.endIndex]
    switch coord {
      case .X : primero.0 = f(primero.0)
      case .Y : primero.1 = f(primero.1)
      case .Z : primero.2 = f(primero.2)
    }
    return([primero] + aplica3D(resto, funcion:f, coord:coord))
  }
}

// Pruebas
let puntos3D = [(1,2,3), (4,5,6), (7,8,9), (10,11,12)]
let coordenada = Coord.Y
func suma2(x: Int) -> Int {
   return x + 2
}
print("Ejercicio 2")
print("Los puntos \(puntos3D) transformados la coordenada \(coordenada) son \(aplica3D(ArraySlice(puntos3D), funcion: suma2, coord: coordenada))\n")



//////////////
// Ejercicio 3
//////////////
func compruebaParejas(numeros: ArraySlice<Int>, funcion f : (Int) -> Int) -> [(Int,Int)] {
  if numeros.count == 1 {
    return []
  } else {
    let primero = numeros[numeros.startIndex]
    let segundo = numeros[numeros.startIndex+1]
    let resto = numeros[numeros.startIndex+1..<numeros.endIndex]
    if f(primero) == segundo {
      return([(primero, segundo)] + compruebaParejas(resto, funcion: f))
    } else {
      return compruebaParejas(resto, funcion: f)
    }
  }
}

// Pruebas
let numeros = [2, 4, 16, 5, 10, 100, 105]
func cuadrado(x: Int) -> Int {
   return x * x
}
print("Ejercicio 3")
print("Elementos de \(numeros) que cumplen la función son \(compruebaParejas(ArraySlice(numeros), funcion: cuadrado))\n")



//////////////
// Ejercicio 4
//////////////
enum Intervalo {
    case Limites(Int, Int)
    case Vacio
}

func union(intervalo1: Intervalo, con intervalo2: Intervalo) -> Intervalo {
  switch (intervalo1, intervalo2) {
    case (.Vacio, _) :
      return intervalo2
    case (_, .Vacio) :
      return intervalo1
    case let (Intervalo.Limites(a1, a2), Intervalo.Limites(b1, b2)) :
      return(Intervalo.Limites(min(a1, b1), max(a2, b2)))
    default :
      return Intervalo.Vacio
  }
}

// función auxiliar
func hay_interseccion(intervalo: (Int, Int), con intervalo2: (Int, Int)) -> Bool {
  return(intervalo2.0 <= intervalo.1 && intervalo.0 <= intervalo2.1)
}

func interseccion(intervalo1: Intervalo, con intervalo2: Intervalo) -> Intervalo {
  switch (intervalo1, intervalo2) {
    case (.Vacio, _) :
      return Intervalo.Vacio
    case (_, .Vacio) :
      return Intervalo.Vacio
    case let (Intervalo.Limites(a1, a2), Intervalo.Limites(b1, b2)) :
      if !hay_interseccion((a1,a2), con: (b1,b2)) {
        return Intervalo.Vacio
      } else {
        return(Intervalo.Limites(max(a1, b1), min(a2, b2)))
      }
    default :
      return Intervalo.Vacio
  }
}


// Pruebas
let intervalo1 = Intervalo.Limites(10, 20)
let intervalo2 = Intervalo.Limites(15, 30)
let intervalo3 = Intervalo.Limites(25, 30)
let intervalo4 = Intervalo.Vacio

print("Ejercicio 4")
print("La union de \(intervalo1) y \(intervalo2) es \(union(intervalo1, con: intervalo2))")
print("La union de \(intervalo1) y \(intervalo4) es \(union(intervalo1, con: intervalo4))")
print("La interseccion de \(intervalo1) y \(intervalo2) es \(interseccion(intervalo1, con: intervalo2))")
print("La interseccion de \(intervalo1) y \(intervalo3) es \(interseccion(intervalo1, con: intervalo3))\n")



//////////////
// Ejercicio 5
//////////////
indirect enum BinaryTree {
    case Node(Int, BinaryTree, BinaryTree)
    case Empty
}

func suma(arbol : BinaryTree) -> Int {
  switch arbol {
    case .Empty :
      return 0
    case let .Node(dato, hijoIzq, hijoDer) :
      return(dato + suma(hijoIzq) + suma(hijoDer))
  }
}

// Pruebas
let arbol: BinaryTree = .Node(8, .Node(2, .Empty, .Empty), .Node(12, .Empty, .Empty))
print("Ejercicio 5")
print("La suma del arbol \(arbol) es \(suma(arbol))\n")
