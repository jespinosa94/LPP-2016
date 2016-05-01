//Jorge Espinosa Campello

//////////////////
///Ejercicio 1///
/////////////////
func ordenado(array: [Int]) -> Bool {
  for (index, elem) in array.enumerate() {
    if((index + 1) < array.count) && (elem > array[index + 1]) {
          return false
    }
  }
return true
}

let aOrdenado = [10, 20, 30]
let aDesordenado = [20, 10, 30]
print("Ejercicio 1: ")
print(" ¿El array \(aOrdenado) esta ordenado?: \(ordenado(aOrdenado))")
print(" ¿El array \(aDesordenado) esta ordenado?: \(ordenado(aDesordenado))")

/////////////////
///Ejercicio 2///
/////////////////
func union(intervalo: (Int, Int), con intervalo2: (Int, Int)) -> (Int, Int) {
  return (min(intervalo.0, intervalo2.0), max(intervalo.1, intervalo2.1))
}
func interseccion(intervalo: (Int, Int), con intervalo2: (Int, Int)) -> (Int, Int)? {
  if intervalo2.0 <= intervalo.1 && intervalo.0 <= intervalo2.1 {
    return (max(intervalo.0, intervalo2.0), min(intervalo.1, intervalo2.1))
  }
  return nil
}

let intervalo1 = (4, 10)
let intervalo2 = (3, 8)
print("Ejercicio 2: ")
print(" La unión de \(intervalo1) y \(intervalo2) es \(union(intervalo1, con: intervalo2))")

let intervalo3 = (8, 15)
let intervalo4 = (12, 20)

print(" La intersección de \(intervalo1) y \(intervalo3) es \(interseccion(intervalo1, con: intervalo3))")
print(" La intersección de \(intervalo1) y \(intervalo4) es \(interseccion(intervalo1, con: intervalo4))")

/////////////////
///Ejercicio 3///
/////////////////
func buscaValores(claves: [Int], _ mapa: [Int: String]) -> [String] {
  var resultado = [String]()
  for clave in claves {
    let auxiliar: String! = mapa[clave]
    resultado.append(auxiliar)
  }
  return resultado
}
print("Ejercicio 3: ")

print(" El ejercicio 3 DEVUELVE el valor: \(buscaValores([1,2,2,1,3], [1: "patatas", 2: "huevos", 3: "leche"]))")

/////////////////
///Ejercicio 4///
/////////////////
enum Respuesta: Int {
  case Nada = 0, Regular, Medio, Bastante, Todo
}

func estadisticas(respuestas: [Respuesta]) -> (Respuesta, Double) {
  var media: Double = 0
  var repeticiones = [Respuesta: Int]()
  var masRepetido: (Respuesta , Int) = (respuestas[0] , -1)  //valor de inicialización para poder compararlo más adelante
  //Se analiza el array y se almacena en un diccionario junto a las veces que se repite cada elemento
  for respuesta in respuestas {
    if(repeticiones[respuesta] != nil) {
      let aux: Int! = repeticiones[respuesta]
      repeticiones[respuesta] = aux+1
    } else
      {
        repeticiones[respuesta] = 0
      }
  }

  //Se extraen el elemento más frecuente y la media de todos
  for elemento in repeticiones {
    media += Double(elemento.0.rawValue)
    if(elemento.1 > masRepetido.1) {
      masRepetido = elemento
    }
  }

  return (masRepetido.0, media/Double(respuestas.count))
}

print("Ejercicio 4")
let contestaciones = [Respuesta.Nada, Respuesta.Nada, Respuesta.Todo, Respuesta.Medio, Respuesta.Regular]
print(" \(estadisticas(contestaciones))")

/////////////////
///Ejercicio 5///
/////////////////
func cuentaOcurrencias(array1: [String], _ array2: [String]) -> [(String, Int, Int)] {
  var resultado = [(String, Int, Int)]()
  var elemAlmacenados = [String]()
  var n1 = 0
  var n2 = 0
  /*Se busca el elemento en el array resultado, si no está se crea una nueva instancia
    y si ya se encuentra en el array "resultado" se le suma 1 al elemento de la primera cadena*/
  for elemento in array1 {
    var encontrado = false
    for (index, resul) in resultado.enumerate() {
      if resul.0 == elemento {
        resultado[index].1++
        encontrado = true
      }
    }
    if(!encontrado) {
      resultado.append((elemento, 1, 0))
    }
  }
  /*Se busca el elemento en el array resultado, si no está se crea una nueva instancia
    y si ya se encuentra en el array "resultado" se le suma 1 al elemento de la segunda cadena*/
  for elemento in array2 {
    var encontrado = false
    for (index, resul) in resultado.enumerate() {
      if resul.0 == elemento {
        resultado[index].2++
        encontrado = true
      }
    }
    if(!encontrado) {
      resultado.append((elemento, 0, 1))
    }
  }
  return resultado
}
print("Ejercicio 5: ")
print(cuentaOcurrencias(["pera", "melón", "pera", "manzana", "orégano"],
                        ["perejil", "pera", "hierbabuena", "orégano", "perejil"]))
