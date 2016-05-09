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
func hijosTree(arbol: Arbol) -> [Arbol]? {
  switch arbol {
    case let .Nodo(_, hijos):
      return hijos
    case Arbol.Hoja:
      return nil
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
//print(" Mostrando el dato de la Hoja 2: \(datoTree(hijosTree(arbol1)[0]))")
