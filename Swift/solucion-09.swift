//////////////////////
// Solución práctica 9
//////////////////////



//////////////
// Ejercicio 1
//////////////
func ordenado(array: [Int]) -> Bool {
  var orden = true
  var i = 1
  while orden && i < array.count {
    if (array[i-1] > array[i]) {
      orden = false
    }
    i = i+1
  }
  return orden
}

// Pruebas
let aOrdenado = [10, 20, 30]
let aDesordenado = [20, 10, 30]
print("Ejercicio 1")
print("¿El array \(aOrdenado) está ordenado?: \(ordenado(aOrdenado))")
print("¿El array \(aDesordenado) está ordenado?: \(ordenado(aDesordenado))\n")


//////////////
// Ejercicio 2
//////////////
func union(intervalo: (Int, Int), con intervalo2: (Int, Int)) -> (Int, Int) {
  return((min(intervalo.0, intervalo2.0), max(intervalo.1, intervalo2.1)))
}

// función auxiliar
func hay_interseccion(intervalo: (Int, Int), con intervalo2: (Int, Int)) -> Bool {
  return(intervalo2.0 <= intervalo.1 && intervalo.0 <= intervalo2.1)
}

func interseccion(intervalo:(Int, Int), con intervalo2: (Int, Int)) -> (Int, Int)? {
  if !hay_interseccion(intervalo, con: intervalo2) {
    return(nil)
  }
  else {
    return((max(intervalo.0, intervalo2.0), min(intervalo.1, intervalo2.1)))
  }
}

// Pruebas
let intervalo1 = (4, 10)
let intervalo2 = (3, 8)
print("Ejercicio 2")
print("La union de \(intervalo1) y \(intervalo2) es \(union(intervalo1, con: intervalo2))")

let intervalo3 = (8, 15)
let intervalo4 = (12, 20)
print("La interseccion de \(intervalo1) y \(intervalo3) es \(interseccion(intervalo1, con: intervalo3))")
print("La interseccion de \(intervalo1) y \(intervalo4) es \(interseccion(intervalo1, con: intervalo4))\n")



//////////////
// Ejercicio 3
//////////////
func buscaValores(claves:[Int], diccionario dic:[Int:String]) -> [String] {
  var valores = [String]()  // array vacio

  for c in claves {
    if let valor = dic[c] {
      valores.append(valor)
    }
  }
  return valores
}

// Pruebas
let claves = [1,2,2,1,3]
let dic = [1: "patatas", 2: "huevos", 3: "leche"]
print("Ejercicio 3")
print("Los valores de las claves \(claves) del diccionario \(dic) son \(buscaValores(claves,diccionario: dic))\n")



//////////////
// Ejercicio 4
//////////////
enum Respuesta: Int {
   case Nada = 0, Regular, Medio, Bastante, Todo
}

// función auxiliar
func buscarRespuestaMasFrecuente(contadores:[Int]) -> Respuesta {
  var indice = 0
  var mayor = contadores[indice]
  for i in 1..<contadores.count {
    if contadores[i] > mayor {
      mayor = contadores[i]
      indice = i
    }
  }
  return (Respuesta(rawValue: indice)!)
}

func estadisticas(respuestas: [Respuesta]) -> (Respuesta, Double) {
  var contadores = [0,0,0,0,0]
  var total = 0.0
  for res in respuestas {
    contadores[res.rawValue] = contadores[res.rawValue]+1
    total = total + Double(res.rawValue)
  }
  return((buscarRespuestaMasFrecuente(contadores),total/5))
}


// Pruebas
let contestaciones = [Respuesta.Nada, Respuesta.Nada, Respuesta.Todo, Respuesta.Medio, Respuesta.Regular]
print("Ejercicio 4")
print("La respuesta mas frecuente y el valor medio de \(contestaciones) es \(estadisticas(contestaciones))\n")



//////////////
// Ejercicio 5
//////////////
// función auxiliar
func ocurrencias(elemento:String, _ array: [String]) -> Int {
  var veces = 0
  for elem in array {
    if elemento == elem {
      veces = veces+1
    }
  }
  return(veces)
}

func cuentaOcurrencias(array1: [String], _ array2: [String]) -> [(String, Int, Int)] {
  let elementosSinRepetir = Array(Set(array1 + array2))
  var resultado = [(String, Int, Int)]()
  for elem in elementosSinRepetir {
    resultado.append((elem, ocurrencias(elem, array1), ocurrencias(elem, array2)))
  }
  return(resultado)
}


// Pruebas
let array1 = ["pera", "melón", "pera", "manzana", "orégano"]
let array2 = ["perejil", "pera", "hierbabuena", "orégano", "perejil"]
print("Ejercicio 5")
print ("Las ocurrencias de cada cadena en los arrays \(array1) y \(array2) son \(cuentaOcurrencias(array1, array2))\n")
