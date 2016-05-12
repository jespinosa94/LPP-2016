//Jorge Espinosa Campello

/////////////////////
/////Ejercicio 1/////
/////////////////////
indirect enum Arbol {
  case Nodo(Int, [Arbol])
  case Hoja(Int)
}

func datoTree(arbol: Arbol) -> Int {
  switch arbol {
    case let .Nodo(dato, _):
      return dato
    case let .Hoja(dato):
      return dato
  }
}

//Cuando se hace hijosTree de una hoja hay que devolver un valor nulo?
func hijosTree(arbol: Arbol) -> [Arbol] {
  switch arbol {
    case let .Nodo(_, hijos):
      return hijos
    case Arbol.Hoja:
      return []
  }
}

func esHojatree(arbol: Arbol) -> Bool {
  switch arbol {
    case Arbol.Nodo:
      return false
    case Arbol.Hoja:
      return true
  }
}

print("Ejercicio 1: ")
print(" Creando el árbol binario [2, 3, 4, 5] mostrado en Inorden...")
let arbol1: Arbol = .Nodo(4, [.Nodo(3, [.Hoja(2)]), .Hoja(5)])
print(" Mostrando la raíz del árbol: \(datoTree(arbol1))")
print(" Mostrando el dato del hijo izquierda de la raíz (dato 3): \(datoTree(hijosTree(arbol1)[0]))")
print(" Mostrando el dato del hijo izquierdo de la raíz (la hoja 5): \(datoTree(hijosTree(arbol1)[1]))")
print(" Mostrando el arbol izquierdo de la raiz ([3, 2]): \(hijosTree(arbol1)[0])")

/////////////////////
/////Ejercicio 2/////
/////////////////////
func sumaArbol(arbol: Arbol) -> Int {
  return (datoTree(arbol) + sumaBosque(hijosTree(arbol)))
}

func sumaBosque(bosque: [Arbol]) -> Int {
  if bosque.isEmpty {
    return 0
  } else {
    let primero = bosque[0]
    let resto = Array(bosque[1..<bosque.endIndex])
    return (sumaArbol(primero) + sumaBosque(resto))
  }
}

func sumaArbolFOS(arbol: Arbol) -> Int {
  return datoTree(arbol) + hijosTree(arbol).map({(rama: Arbol) -> Int in
                                                return (sumaArbolFOS(rama))}).reduce(0, combine: +)
}

print("Ejercicio 2:")
let arbol2: Arbol = .Nodo(10, [.Hoja(2), .Nodo(12, [.Hoja(4), .Hoja(2)]), .Nodo(10, [.Hoja(5)])])
print(" La suma recursiva de los elementos del arbol propuesto es: \(sumaArbol(arbol2))")
print(" La suma con FOS de los elementos del arbol propuesto es: \(sumaArbolFOS(arbol2))")

/////////////////////
/////Ejercicio 3/////
/////////////////////
func vecesArbol(arbol: Arbol, dato: Int) -> Int {
  if datoTree(arbol) == dato {
    return 1 + vecesBosque(hijosTree(arbol), dato)
  } else {
    return vecesBosque(hijosTree(arbol), dato)
  }
}

func vecesBosque(bosque: [Arbol], _ dato: Int) -> Int {
  if bosque.isEmpty {
    return 0
  } else {
    let primero = bosque[0]
    let resto = Array(bosque[1..<bosque.endIndex])
    return vecesArbol(primero, dato: dato) + vecesBosque(resto, dato)
  }
}

func compruebaRaiz(arbol: Arbol, dato: Int) -> Int {
  if datoTree(arbol)==dato {
    return 1
  } else {
    return 0
  }
}

func vecesArbolFOS(arbol: Arbol, dato: Int) -> Int {
  return compruebaRaiz(arbol, dato: dato) + hijosTree(arbol).map({(rama: Arbol) -> Int in
                                                                  return vecesArbolFOS(rama, dato: dato)}).reduce(0, combine: +)
}



print("Ejercicio 3:")
print(" Búsqueda del número de veces del número 2 en el arbol dado en la práctica (forma recursiva): \(vecesArbol(arbol2, dato: 2))")
print(" Búsqueda del numero 12 en el arbol propuesto (funciones de orden superior): \(vecesArbolFOS(arbol2, dato: 12))")
