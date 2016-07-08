func ordenado (array: [Int]) -> Bool {
  var orden = true
  var i = 1
  while orden && i < array.count {
    if(array[i-1] > array[i])
      {
        orden = false
      }
      i = i+1
  }
  return orden
}

func union(intervalo: (Int, Int), con intervalo2: (Int, Int)) -> (Int, Int) {
  return ((min(intervalo.0, intervalo2.0), max(intervalo.1, intervalo2.1)))
}
func hayInterseccion(intervalo: (Int, Int), intervalo2: (Int, Int)) -> Bool {
  return(intervalo2.0 <= intervalo.1 && intervalo.0 <= intervalo2.1)
}
func inerseccion(intervalo: (Int, Int), intervalo2: (Int, Int)) -> (Int, Int)? {
  if !hayInterseccion(intervalo, intervalo2) {
    return nil
  } else {
    return(max(intervalo.0, intervalo2.0), min(intervalo.1, intervalo2.1))
  }
}

func buscaValores(claves: [Int], diccionario dic: [Int:String]) -> [String] {
  var valores = [String]()

  for c in claves {
    if let valor = dic[c] {
      valores.append(valor)
    }
  }
  return valores
}

enum Respuesta: Int {
  case Nada = 0, Regular, Medio, Bastante, Todo
}

func buscarRespuestaMasFrecuente(contadores: [Int]) -> Respuesta {
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
  var contadores [0, 0, 0, 0, 0]
  var total = 0

  for res in respuestas {
    contadores[res.rawValue] = contadores[res.rawValue] + 1
    total = total + Double(res.rawValue)
  }
  return (buscarRespuestaMasFrecuente(contadores), total/5)
}

func ocurrencias(elemento: String, _ array: [String]) -> Int {
  var veces = 0
  for elem in array {
    if elemento == elem {
      veces = veces + 1
    }
  }
  return veces
}

func cuentaOcurrencias(array1: [String], _ array2: [String]) -> [(String, Int, Int)] {
  let elementosSinRepetir = Array(Set(array1 + array2))
  var resultado = [(String, Int, Int)]()
  for elem in elementosSinRepetir {
    resultado.append((elem, ocurrencias(elem, array1), ocurrencias(elem, array2)))
  }
  return resultado
}
