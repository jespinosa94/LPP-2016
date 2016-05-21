//Jorge Espinosa Campello
import Glibc

func rand(n: Int) -> Int {
  return random() % n
}
enum MarcaCoche: Int {
  case Mercedes=0, Ferrari, RedBull, McLaren

  static func random() -> MarcaCoche {
    let valorMax = McLaren.rawValue
    let r = rand(valorMax+1)
    return MarcaCoche(rawValue: r)!
  }
}

enum TipoCambio: Int {
  case Automatico=0, Manual

  static func random() -> TipoCambio {
    let valorMax = Manual.rawValue
    let r = rand(valorMax+1)
    return TipoCambio(rawValue: r)!
  }
}

class Coche {
  var velocidadActual: Double = 0.0
  var marcha: Int = 0
  var distanciaRecorrida: Double = 0.0
  var marca: MarcaCoche = MarcaCoche.random()
  var descripcion: String {
    get {
      switch marca {
        case .Mercedes: return "Mercedes"
        case .Ferrari: return "Ferrari"
        case .RedBull: return "RedBull"
        case .McLaren: return "McLaren"
      }
    }
  }
  let velocidadMaxima: Double = 150.0
  let marchaMaxima: Int = 6

  static func random() -> Coche{
    let valorMax = 2  //Numero de subtipos de la clase cocheAutomatico
    let r = rand(valorMax)
    if(r == 0) {
      return cocheAutomatico()
    } else {
      return cocheManual()
    }
  }
}

class cocheAutomatico: Coche {
  override var velocidadActual: Double {
    didSet {
      marcha = min(Int(velocidadActual / 25.0) + 1, 5)
      distanciaRecorrida = distanciaRecorrida + velocidadActual
      print(" \(descripcion) viajando a \(velocidadActual) kilometros por hora con la marcha \(marcha)")
    }
  }

  override var descripcion: String {
    switch marca {
      case .Mercedes: return "Mercedes Automatico"
      case .Ferrari: return "Ferrari Automatico"
      case .RedBull: return "RedBull Automatico"
      case .McLaren: return "McLaren Automatico"
    }
  }
}

class cocheManual: Coche {
  override var marcha: Int {
    didSet {
      velocidadActual = 25.0 * Double(marcha)
    }
  }

  override var velocidadActual: Double {
    didSet {
      distanciaRecorrida = distanciaRecorrida + velocidadActual
      print(" \(descripcion) viajando a \(velocidadActual) kilometros por hora con la marcha \(marcha)")
    }
  }

  override var descripcion: String {
    switch marca {
      case .Mercedes: return "Mercedes Manual"
      case .Ferrari: return "Ferrari Manual"
      case .RedBull: return "RedBull Manual"
      case .McLaren: return "McLaren Manual"
    }
  }
}

class Carrera {
  let numCoches: Int
  let horas: Int
  var cochesEnCarrera: [Coche]
  init(numCoches: Int, horas: Int) {
    self.numCoches = numCoches
    self.horas = horas
    cochesEnCarrera = [Coche.random()]  //se inicializa el array con el primer coche y se añaden los siguientes
    for _ in 2...numCoches {
      cochesEnCarrera.append(Coche.random())
    }
  }

  func descripcion() {
    print(" \(numCoches) coches con una duración de \(horas) horas")
    for coche in cochesEnCarrera {
      print(" \(coche.descripcion)")
    }
  }

  func empezar() {
    for hora in 1...horas {
      print(" \nHoras transcurridas \(hora)")
      for coche in cochesEnCarrera {
        if coche is cocheAutomatico {
          coche.velocidadActual = Double(rand(Int(coche.velocidadMaxima)))
        } else if coche is cocheManual {
          coche.marcha = rand(coche.marchaMaxima)
        }
      }
    }
  }

  func clasificacion() {
    for (index, coche) in cochesEnCarrera.enumerate() {
      print("\(index + 1). \(coche.descripcion) (\(coche.distanciaRecorrida) kilometros recorridos)")
    }
  }
}

let carrera = Carrera(numCoches: 5, horas: 3)
print("\nDescripción de la carrera: ")
carrera.descripcion()
print("\n!!! Comienza la carrera !!!")
carrera.empezar()
print("\n !!! Clasificacion !!!")
carrera.clasificacion()
