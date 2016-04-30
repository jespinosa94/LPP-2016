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
print("¿El array \(aOrdenado) esta ordenado?: \(ordenado(aOrdenado))")
print("¿El array \(aDesordenado) esta ordenado?: \(ordenado(aDesordenado))")

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
print("La unión de \(intervalo1) y \(intervalo2) es \(union(intervalo1, con: intervalo2))")

let intervalo3 = (8, 15)
let intervalo4 = (12, 20)
print("La intersección de \(intervalo1) y \(intervalo3) es \(interseccion(intervalo1, con: intervalo3))")
print("La intersección de \(intervalo1) y \(intervalo4) es \(interseccion(intervalo1, con: intervalo4))")

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

buscaValores([1,2,2,1,3], [1: "patatas", 2: "huevos", 3: "leche"])

/////////////////
///Ejercicio 4///
/////////////////
