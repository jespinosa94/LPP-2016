//////////////////////
// Solución práctica 12
//////////////////////


import Glibc

func rand(n: Int) -> Int {
    return random() % n
}


/////////////////////////////////////////////////////////
// Ejercicio 1
/////////////////////////////////////////////////////////

enum MarcaCoche: Int {
    case Mercedes=0, Ferrari, RedBull, McLaren
    
    static func random() -> MarcaCoche {
        let maxValue = McLaren.rawValue
        
        let r = rand(maxValue+1)
        return MarcaCoche(rawValue: r)!
    }

}


enum TipoCambio: Int {
    case Automatico=0, Manual
    
    static func random() -> TipoCambio {
        let maxValue = Manual.rawValue
        
        let r = rand(maxValue+1)
        return TipoCambio(rawValue: r)!
    }
}



class Coche {
    var velocidadActual = 0.0 
    var distanciaRecorrida = 0.0

    var marca : MarcaCoche
    init(marca: MarcaCoche) {
        self.marca = marca
    }
    var marcha = 1

    var descripcion: String {
        return "\(marca)"
    }
    
    func seguimientoCarrera() {
        print("\(descripcion) viajando a \(velocidadActual) kilómetros por hora con la marcha \(marcha)")
        distanciaRecorrida += velocidadActual
    }

    static let velocidadMaxima = 150.0
    static let marchasMaxima = 6
}



class CocheAutomatico: Coche {
    override var velocidadActual: Double {
        didSet {
            marcha = min(Int(velocidadActual / 25.0) + 1, Coche.marchasMaxima)
            seguimientoCarrera()
        }
    }
    override var descripcion: String {
        return super.descripcion + " Automatico"
    }
}




class CocheManual: Coche {
    override var marcha: Int {
        didSet {
            velocidadActual = 25.0 * Double(marcha)
            seguimientoCarrera()
        }
    }
    override var descripcion: String {
        return super.descripcion + " Manual"
    }
}




class Carrera {
    var coches: [Coche] = []
    let numCoches: Int
    let tiempoFinal : Int
    var tiempoActual: Int = 0 {
        didSet {
            print("\nHoras transcurridas \(tiempoActual)")
        }
    }
    
    init(numCoches: Int, horas:Int) {
        self.numCoches = numCoches
        tiempoFinal = horas
        for _ in 0..<numCoches {
            switch TipoCambio.random() {
            case .Automatico :
                coches.append(CocheAutomatico(marca: MarcaCoche.random()))
            case.Manual :
                coches.append(CocheManual(marca: MarcaCoche.random()))
            }
        }
    }
    
    func empezar() {
        for t in 1...tiempoFinal {
            tiempoActual = t
            for coche in coches {
                if coche is CocheAutomatico {
                    coche.velocidadActual = Double(rand(Int(Coche.velocidadMaxima)) + 1)
                }
                else if coche is CocheManual {
                    coche.marcha = rand(Coche.marchasMaxima) + 1
                }
            }
        }
    }
    
    func clasificacion() {
        let clasif = coches.sort {$0.distanciaRecorrida > $1.distanciaRecorrida}
        var i = 1
        for coche in clasif {
            print("\(i). \(coche.descripcion) (\(coche.distanciaRecorrida) kilómetros recorridos)")
            i+=1
        }
    }
    
    func descripcion() {
        print("\(numCoches) coches con una duración de \(tiempoFinal) horas")
        for coche in coches {
            print("    \(coche.descripcion)")
        }
    }

}


// Pruebas
print("\nEjercicio 1\n")

let carrera = Carrera(numCoches: 2, horas: 3)
print("\nDescripción de la carrera:")
carrera.descripcion()
print("\n!!! Comienza la carrera !!!")
carrera.empezar()
print("\n!!! Clasificación !!!")
carrera.clasificacion()





/////////////////////////////////////////////////////////
// Ejercicio 2
/////////////////////////////////////////////////////////

struct Punto {
    var x = 0.0, y = 0.0
    
    mutating func traslada(tx tx: Double, ty: Double) {
        x += tx
        y += ty
    }
    
    func vectorDirector(p: Punto) -> Punto {
        return Punto(x: p.x-self.x, y: p.y-self.y)
    }
    
    func vectorNormal() -> Punto {
        return Punto(x: self.y, y: -self.x)
    }

}

struct Tamaño {
    var ancho = 0.0, alto = 0.0
}


class Rectangulo {
    var origen = Punto()
    var tamaño = Tamaño()
    
    init(origen o:Punto, tamaño t:Tamaño) {
        origen = o
        tamaño = t
    }
    
    var centro: Punto {
        get {
            let centroX = origen.x + (tamaño.ancho / 2)
            let centroY = origen.y + (tamaño.alto / 2)
            return Punto(x: centroX, y: centroY)
        }
        set(centroNuevo) {
            origen.x = centroNuevo.x - (tamaño.ancho / 2)
            origen.y = centroNuevo.y - (tamaño.alto / 2)
        }
    }
    
    var area: Double {
        return tamaño.ancho * tamaño.alto
    }
}


class Circulo {
    var centro = Punto()
    var radio = 0.0
    
    init(centro c:Punto, radio r:Double) {
        centro = c
        radio = r
    }
    
    var area: Double {
        get {
            return M_PI * radio * radio
        }
        set {
            radio = sqrt(newValue / M_PI)
        }
    }
}


class Triangulo {
    var p1 = Punto()
    var p2 = Punto()
    var p3 = Punto()
    
    init(vertice1 v1:Punto, vertice2 v2:Punto, vertice3 v3:Punto) {
        p1 = v1
        p2 = v2
        p3 = v3
    }

    var centro: Punto {
        get {
            let centroX = (p1.x + p2.x + p3.x) / 3
            let centroY = (p1.y + p2.y + p3.y) / 3
            return Punto(x: centroX, y: centroY)
        }
        set {
            let traslacionX = centro.x - newValue.x
            let traslacionY = centro.y - newValue.y
            p1.traslada(tx: traslacionX, ty: traslacionY)
            p2.traslada(tx: traslacionX, ty: traslacionY)
            p3.traslada(tx: traslacionX, ty: traslacionY)
        }
    }

    // El área de un triángulo conocidos sus 3 vértices A, B, C, se puede calcular
    // como la mitad del valor absoluto del producto escalar de 2 vectores:
    // el vector normal de AB y el vector AC
    var area: Double {
        get {
            let vectorAB = p1.vectorDirector(p2)
            let vectorAC = p1.vectorDirector(p3)
            let normalAB = vectorAB.vectorNormal()
            return 1/2.0 * abs(normalAB.x * vectorAC.x + normalAB.y * vectorAC.y)
        }
    }
}



// Pruebas
print("\nEjercicio 2\n")

let r = Rectangulo(origen:Punto(x:3, y:4), tamaño:Tamaño(ancho:10, alto:5))
print("Rectángulo con origen \(r.origen) y tamaño \(r.tamaño)")
print("centro: \(r.centro)   area: \(r.area)")
r.centro = Punto()
print("Con el nuevo centro \(r.centro) el nuevo origen es \(r.origen)")
print()

let c = Circulo(centro:Punto(x:5, y:0), radio:10.0)
print("Círculo con centro \(c.centro) y radio \(c.radio)")
print("Area del círculo: \(c.area)")
c.area = 30.0
print("Con la nueva área \(c.area) el nuevo radio es \(c.radio)")
print()


let t = Triangulo(vertice1:Punto(x:2, y:0), vertice2:Punto(x:3, y:4), vertice3:Punto(x:-2, y:5))
print("Triángulo con vértices \(t.p1)  \(t.p2)  \(t.p3)")
print("centro: \(t.centro)   area: \(t.area)")
t.centro = Punto()
print("Con el nuevo centro \(t.centro) los nuevos vértices son \(t.p1)  \(t.p2)  \(t.p3)")
print()




/////////////////////////////////////////////////////////
// Ejercicio 3
/////////////////////////////////////////////////////////

protocol Figura {
    var centro : Punto { get set }
    var area : Double { get }
    var tamaño : Tamaño { get }
}

extension Rectangulo: Figura { }

extension Circulo: Figura {
    var tamaño: Tamaño { return Tamaño(ancho: self.radio, alto: self.radio) }
}

extension Triangulo: Figura {
    var tamaño: Tamaño {
        get {
            let minX = min(self.p1.x, self.p2.x, self.p3.x)
            let minY = min(self.p1.y, self.p2.y, self.p3.y)
            let maxX = max(self.p1.x, self.p2.x, self.p3.x)
            let maxY = max(self.p1.y, self.p2.y, self.p3.y)
            return Tamaño(ancho: abs(maxX - minX), alto: abs(maxY - minY))
        }
    }
}


func doubleIguales(d1: Double, igualA d2:Double) -> Bool {
    return abs(d1 - d2) <= 0.001
}

func == (p1: Punto, p2: Punto) -> Bool {
    return doubleIguales(p1.x, igualA:p2.x) && doubleIguales(p1.y, igualA:p2.y)
}

func == (t1: Tamaño, t2: Tamaño) -> Bool {
    return doubleIguales(t1.ancho, igualA:t2.ancho) && doubleIguales(t1.alto, igualA:t2.alto)
}

func == (r1: Rectangulo, r2: Rectangulo) -> Bool {
    return r1.origen == r2.origen && r1.tamaño == r2.tamaño
}

func == (c1: Circulo, c2: Circulo) -> Bool {
    return c1.centro == c2.centro && doubleIguales(c1.radio, igualA:c2.radio)
}

func == (t1: Triangulo, t2: Triangulo) -> Bool {
    return t1.p1 == t2.p1 && t1.p2 == t2.p2 && t1.p3 == t2.p3
}




func cuentaTipos(figuras: [Figura]) -> (Int, Int, Int) {
    var contador = (0,0,0)
    for figura in figuras {
        if figura is Rectangulo {
            print("Rectangulo con origen \(r.origen) y tamaño \(r.tamaño)")
            contador = (1+contador.0, contador.1, contador.2)
        } else if figura is Circulo {
            print("Circulo con centro \(c.centro) y radio \(c.radio)")
            contador = (contador.0, 1+contador.1, contador.2)
        } else if figura is Triangulo {
            print("Triangulo con vértices \(t.p1) \(t.p2) \(t.p3)")
            contador = (contador.0, contador.1, 1+contador.2)
        }
    }
    return contador
}


// Pruebas
print("\nEjercicio 3\n")

let r1 = Rectangulo(origen:Punto(x:2, y:1), tamaño:Tamaño(ancho:10, alto:5))
print("Rectángulo con origen \(r1.origen) y tamaño \(r1.tamaño)")
let c1 = Circulo(centro:Punto(x:0, y:2), radio:5.0)
print("Círculo con centro \(c1.centro) radio \(c1.radio) y tamaño:\(c1.tamaño)")
let t1 = Triangulo(vertice1:Punto(x:0, y:0), vertice2:Punto(x:10, y:0), vertice3:Punto(x:5, y:6))
print("Triángulo con vértices \(t1.p1)  \(t1.p2)  \(t1.p3)  y tamaño: \(t1.tamaño)")

print("el punto \(r1.origen) es igual al punto (2,1) : \(r1.origen == Punto(x:2, y:1))")
print("el punto \(r1.origen) es igual al punto \(c1.centro) : \(r1.origen == c1.centro)")
print("el tamaño \(r1.tamaño) es igual al tamaño (10,5) : \(r1.tamaño == Tamaño(ancho:10, alto:5))")
print("el tamaño \(r1.tamaño) es igual al tamaño \(c1.tamaño) : \(r1.tamaño == c1.tamaño)")
print("el rectangulo \(r1) es igual al rectangulo (2,1) (10,5) : \(r1 == Rectangulo(origen:Punto(x:2, y:1), tamaño:Tamaño(ancho:10, alto:5)))")
print("el rectangulo \(r1) es igual al rectangulo \(r) : \(r1 == r)")
print("el circulo \(c1) es igual al circulo (0,2) 5 : \(c1 == Circulo(centro:Punto(x:0, y:2), radio:5.0))")
print("el circulo \(c1) es igual al circulo \(c) : \(c1 == c)")
print("el triangulo \(t1) es igual al triangulo (0,0)  (10,0)  (5,6) : \(t1 == Triangulo(vertice1:Punto(x:0, y:0), vertice2:Punto(x:10, y:0), vertice3:Punto(x:5, y:6)))")
print("el triangulo \(t1) es igual al triangulo \(t) : \(t1 == t)")


let figuras: [Figura] = [r1, c, t1, t, c1]
print("cuentaTipos:")
let contador = cuentaTipos(figuras)
print("contador: \(contador)")