;;Jorge Espinosa Campello
#lang r6rs
(import (rnrs base)
        (rnrs io simple)
        (schemeunit))


                          ;;;;Ejercicio 1;;;;
;;Definición de las funciones
(define (mayor-de-tres n1 n2 n3)
  (if (>= n1 n2)
      (if (>= n1 n3)
          n1
          n3)
      (if (>= n2 n3)
          n2
          n3)))

;;Ejemplos del enunciado
(display "\n\n Ejercicio 1\n")
(display "El mayor número entre 2, 8 y 1 es: ")
(display (mayor-de-tres 2 8 1))
;;Pruebas
(check-equal? (mayor-de-tres 3 0 3) 3)
(check-equal? (mayor-de-tres 2 0 -1) 2)
(check-equal? (mayor-de-tres -1 -6 -5) -1)

                          ;;;;Ejercicio 2;;;;
;;Definición de las funciones
(define (cuadrado n)
  (* n n))
(define (distancia-euclidea p1 p2)
  (sqrt (+ (cuadrado (- (car p2) (car p1))) (cuadrado (- (cdr p2) (cdr p1))))))
  
(define precision 0.000001)
(define (iguales-reales? x y)
  (< (abs (- x y)) precision))
;;Ejemplos del enunciado
(display "\n\n Ejercicio 2\n")
(display "La distancia entre los puntos(0, 4) y (0, 10) es:")
(display (distancia-euclidea (cons 0 4) (cons 0 10)))

;;Pruebas
(check-true (iguales-reales? (distancia-euclidea(cons 0 4) (cons 0 10)) 6.0))
(check-true (iguales-reales? (distancia-euclidea(cons -2 5) (cons 9 7)) 11.180339))
(check-true (iguales-reales? (distancia-euclidea(cons -8 4) (cons 0 -7)) 13.601470508735444))
(check-true (iguales-reales? (distancia-euclidea(cons 8 4) (cons 8 4)) 0))

                          ;;;;Ejercicio 3;;;;
;;Definición de las funciones
    ;;Siempre se cumple que a1<=a2 y b1<=b2;;
(define (engloba? a1 a2 b1 b2)
  (cond
    ((and (<= a1 b1) (>= a2 b2)))
    ((and (>= a1 b1) (<= a2 b2)))
    (else #f)))

  

;;Ejemplos del enunciado
(display "\n\n Ejercicio 3 \n")
(display "¿EL intervalo [4-10] engloba a [5-9]? ")
(display (engloba? 4 10 5 9))

;;Pruebas
  (check-true (engloba? 4 10 5 9))
  (check-true (engloba? 4 9 4 15))
  (check-false (engloba? 2 6 4 8))
  (check-false (engloba? -4 1 -5 0))
  (check-true (engloba? 15 16 11 16))

                          ;;;;Ejercicio 4;;;;
;;Definición de las funciones
  (define (intersectan? a1 a2 b1 b2)
    (if (and (<= b1 a2) (<= a1 b2))
    #t
    #f))

;;Ejemplos del enunciado
(display "\n\n Ejercicio 4 \n")
(display "¿Intersectan los intervalos [4-7] [5-12]? ")
(display (intersectan? 4 7 5 12))

;;Pruebas
 (check-true (intersectan? 4 7 5 12))
 (check-false (intersectan? 4 9 12 15))
 (check-true (intersectan? 2 5 5 8))
 (check-true (intersectan? 2 6 3 5))
 (check-true (intersectan? -2 4 -6 -1))


                          ;;;;Apartado b;;;;
;;Definición de las funciones
  (define (interseccion a1 a2 b1 b2)
   (if (intersectan? a1 a2 b1 b2)
       (cons (max a1 b1) (min a2 b2))
       '()))
        

;;Ejemplos del enunciado
(display "\n\n Apartado b \n")
(display "El intervalo de intersección entre [4,7] [5,12] es: ")
(display (interseccion 4 7 5 12))
;;Pruebas
(check-equal? (interseccion 4 7 5 12) (cons 5 7))
(check-equal? (interseccion 4 9 12 15) ())
(check-equal? (interseccion 2 5 5 8) (cons 5 5))
(check-equal? (interseccion -2 4 -6 -1) (cons -2 -1))
(check-equal? (interseccion 2 6 3 5) (cons 3 5))

                          ;;;;Ejercicio 5;;;;
;;Definición de las funciones
(define (cWhite r g b)
  (/ (max r g b) 255))
(define (cCyan r g b)
      (/ (- (cWhite r g b) (/ r 255)) (cWhite r g b)))
(define (cMagenta r g b)
      (/ (- (cWhite r g b) (/ g 255)) (cWhite r g b)))
(define (cYellow r g b)
      (/ (- (cWhite r g b) (/ b 255)) (cWhite r g b)))
(define (cBlack r g b)
  (- 1 (cWhite r g b)))
(define (rgb->cmyk r g b)
  (if (= r g b 0)
      (list 0 0 0 1)
      (list (cCyan r g b) (cMagenta r g b) (cYellow r g b) (cBlack r g b))))

;;Ejemplos del enunciado
(display "\n\n Ejercicio 5 \n")

;;Pruebas
 (check-equal? (rgb->cmyk 75 0 130) (list 11/26 1 0 25/51))
 (check-equal? (rgb->cmyk 150 10 255) (list 7/17 49/51 0 0))
 (check-equal? (rgb->cmyk 255 255 255) (list 0 0 0 0))
 (check-equal? (rgb->cmyk 0 0 0) (list 0 0 0 1))