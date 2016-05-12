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
print(" Creando el arbol binario [2, 3, 4, 5] mostrado en Inorden...")
let arbol1: Arbol = .Nodo(4, [.Nodo(3, [.Hoja(2)]), .Hoja(5)])
print(" Mostrando la raiz del arbol: \(datoTree(arbol1))")
print(" Mostrando el dato del hijo izquierda de la raiz (dato 3): \(datoTree(hijosTree(arbol1)[0]))")
print(" Mostrando el dato del hijo izquierdo de la raiz (la hoja 5): \(datoTree(hijosTree(arbol1)[1]))")
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
print(" [FOS] La suma de los elementos del arbol propuesto es: \(sumaArbolFOS(arbol2))")

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
print(" Busqueda del numero de veces del numero 2 en el arbol dado en la practica: \(vecesArbol(arbol2, dato: 2))")
print(" [FOS] Busqueda del numero 12 en el arbol propuesto: \(vecesArbolFOS(arbol2, dato: 12))")

/////////////////////
/////Ejercicio 4/////
/////////////////////

func sumaHijosArbol(arbol: Arbol) -> Bool {
  if esHojatree(arbol) {
    return true;
  } else {
    return (datoTree(arbol)==hijosTree(arbol).map({datoTree($0)}).reduce(0, combine: +)
            && sumaHijosBosque(hijosTree(arbol)))
  }
}

func sumaHijosBosque(bosque: [Arbol]) -> Bool {
  if bosque.isEmpty {
    return true
  } else {
    let primero = bosque[0]
    let resto = Array(bosque[1..<bosque.endIndex])
    return sumaHijosArbol(primero) && sumaHijosBosque(resto)
  }
}

func sumaHijosArbolFOS(arbol: Arbol) -> Bool {
  if esHojatree(arbol) {
    return true
  } else {
    return (datoTree(arbol)==hijosTree(arbol).map({datoTree($0)}).reduce(0, combine: +)
            && (hijosTree(arbol).map({(rama: Arbol) -> Bool in
                                      sumaHijosArbolFOS(rama)}).reduce(true,
                                      combine: {(x: Bool, y: Bool) -> Bool in
                                                return x && y})))
  }
}

let arbolExamen: Arbol = .Nodo(35, [.Hoja(5), .Nodo(20, [.Hoja(13), .Hoja(7)]), .Nodo(10, [.Hoja(10)])])
print("Ejercicio 4:")
print(" El resultado de ejecutar sumaHijosArbol en el arbol dado en el enunciado es: \(sumaHijosArbol(arbol2))")
print(" Prueba de la funcion en el ejemplo dado en el examen con el arbol (35(5)(20(13)(7))(10(10))): \(sumaHijosArbol(arbolExamen))")
print(" [FOS] El resultado de ejecutar sumaHijosArbol en el arbol dado en el enunciado es: \(sumaHijosArbolFOS(arbol2))")
print(" [FOS] Prueba de la funcion en el ejemplo dado en el examen con el arbol (35(5)(20(13)(7))(10(10))): \(sumaHijosArbol(arbolExamen))")

/////////////////////
/////Ejercicio 5/////
/////////////////////
indirect enum ArbolG<A> {
  case Node(A, [ArbolG<A>])
  case Hoja(A)
}

func datoArbolG<A>(arbol: ArbolG<A>) -> A {
  switch arbol {
    case let .Node(dato, _):
      return dato
    case let .Hoja(dato):
      return dato
  }
}

func hijosArbolG<A>(arbol: ArbolG<A>) -> [ArbolG<A>] {
  switch arbol {
    case let .Node(_, hijos):
      return hijos
    case .Hoja:
      return []
  }
}

func esHojaArbolG<A>(arbol: ArbolG<A>) -> Bool {
  switch arbol {
    case .Node:
      return false
    case .Hoja:
      return true
  }
}

func sumaArbolG<A>(arbol: ArbolG<A>, suma: (A, A) -> A, neutro: A) -> A {
  print(hijosArbolG(arbol))
  let hijos = hijosArbolG(arbol)
  return suma(datoArbolG(arbol), sumaBosqueG(hijos, suma, neutro))
}

func sumaBosqueG<B>(bosque: [ArbolG<B>], _ suma: (B, [B]) -> B, _ neutro: B) -> B {
  return neutro;
  /*if bosque.isEmpty {
    return neutro
  } else {
    let primero = bosque[0]
    let resto = Array(bosque[1..<bosque.endIndex])
    return suma(sumaArbolG(primero, suma: suma, neutro: neutro), sumaBosqueG(resto, suma, neutro))
  }*/
}

print("Ejercicio 5:")
let arbolInt: ArbolG<Int> = .Node(8, [.Hoja(2), .Hoja(12)])
print(sumaArbolG(arbolInt, suma: +, neutro: 0))
/*let sumaInt = sumaArbolG(arbolInt, suma: +, neutro: 0)
print("La suma del arbol \(arbolInt) es \(sumaInt)")*/
