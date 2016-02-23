;;
;; Solución práctica 1
;;

#lang r6rs
(import (rnrs base)
        (rnrs io simple)
        (schemeunit))

;--------------------------
; Ejercicio 1 (versión 1)
;--------------------------
; Versión 1 con 3 comparaciones; también se podría hacer con un "cond"
;(define (mayor-de-tres n1 n2 n3)
;  (if (and (> n1 n2)
;           (> n1 n3))
;      n1
;      (if (> n2 n3)
;          n2
;          n3)))

;--------------------------
; Ejercicio 1 (versión 2)
;--------------------------
; Versión 2 con llamadas anidadas a una función "mayor" definida por nosotros
; que devuelve el mayor de 2 números
(define (mayor n1 n2)
  (if (> n1 n2)
      n1
      n2))

(define (mayor-de-tres n1 n2 n3)
  (mayor n1 (mayor n2 n3)))


;; Demostración
(display "\nEjercicio 1\n")
(display "El número mayor de 2 8 y 1 es: ")
(display (mayor-de-tres 2 8 1))

;; Pruebas
(check-equal? (mayor-de-tres 2 8 1) 8)
(check-equal? (mayor-de-tres 3 0 3) 3)
(check-equal? (mayor-de-tres 1 2 8) 8)
(check-equal? (mayor-de-tres -10 -5 -12) -5)




;--------------------------
; Ejercicio 2
;--------------------------
(define (distancia-euclidea p1 p2)
  (sqrt(+ (expt (- (car p1)
                   (car p2))
                2)
          (expt (- (cdr p1)
                   (cdr p2))
                2))))


;; Demostración
(display "\n\nEjercicio 2\n")
(display "La distancia euclídea entre los puntos (0, 4) y (0, 10) es: ")
(display (distancia-euclidea (cons 0 4) (cons 0 10)))

;; Pruebas
;; Fijamos el margen de error (precisión) para comparar números reales
(define precision 0.000001)

;; función auxiliar que compara números reales teniendo en cuenta una determinada precisión
(define (iguales-reales? x y)
  (< (abs (- x y)) precision))

(check-true (iguales-reales? (distancia-euclidea (cons 0 4) (cons 0 10)) 6.0))
(check-true (iguales-reales? (distancia-euclidea (cons -2 5) (cons 9 7)) 11.180339))
(check-true (iguales-reales? (distancia-euclidea (cons 2 -7) (cons 12 -7)) 10.0))
(check-true (iguales-reales? (distancia-euclidea (cons -3 4) (cons -3 10)) 6.0))


;--------------------------
; Ejercicio 3
;--------------------------

(define (engloba? a1 a2 b1 b2)
  (or (and (>= a1 b1) (<= a2 b2))
      (and (>= b1 a1) (<= b2 a2))))


; Esto es equivalente:
;
; (define (engloba? a1 a2 b1 b2)
;    (if (or (and (>= a1 b1) (<= a2 b2))
;            (and (>= b1 a1) (<= b2 a2)))
;       #t
;       #f))



;; Demostración
(display "\n\nEjercicio 3\n")
(display "¿El intervalo [4,10] engloba al intervalo [5,9]? ")
(display (engloba? 4 10 5 9))

;; Pruebas
(check-true (engloba? 4 10 5 9))
(check-true (engloba? 4 9 4 15))
(check-false (engloba? 2 6 4 8))
(check-true (engloba? 12 15 10 20))
;    [---]
;    12  15
;  [----------]
;  10         20
(check-false (engloba? 10 15 12 20))
;  [-----]
;  10    15
;    [--------]
;    12       20
(check-true (engloba? 7 7 7 7))
;  []
;  7
;  []
;  7




;--------------------------
; Ejercicio 4
;--------------------------

;            |----------|
;            a1         a2
;                   |----------|
;                   b1         b2
;      |----------|
;      b1         b2

;; a)
; Función auxiliar intersectan?
; Versión 1: comprueba si b1 está entre a1 y a2 o
; b2 está entre a1 y a2

;(define (intersectan? a1 a2 b1 b2)
;  (or (and (>= b1 a1) (<= b1 a2))
;      (and (>= b2 a1) (<= b2 a2))))

; Versión 2: comprueba si los intervalos están completamente
; separados y devuelve el "not" de eso

;(define (intersectan? a1 a2 b1 b2)
;  (not (or (< a2 b1) (< b2 a1))))

; Versión 3: sin utilizar not,
; se obtiene simplificando la
; expresión (not (or (< a2 b1) (< b2 a1))

(define (intersectan? a1 a2 b1 b2)
   (and (<= b1 a2) (<= a1 b2)))


;; Demostración
(display "\n\nEjercicio 4.a\n")
(display "¿El intervalo [4,7] intersecta con intervalo [5,12]? ")
(display (intersectan? 4 7 5 12))

;; Pruebas
(check-true (intersectan? 4 7 5 12))
(check-false (intersectan? 4 9 12 15))
(check-true (intersectan? 2 5 5 8))
(check-true (intersectan? 2 8 3 5))
;  [------]
;  2      8
;   [--]
;   3  5
(check-false (intersectan? 2 4 7 10))
;  [--]
;  2  4
;        [----]
;        7    10
(check-true (intersectan? 4 9 2 6))
;    [-----]
;    4     9
;  [----]
;  2    6


;; b)
; Función principal: intersección
(define (interseccion a1 a2 b1 b2)
  (if (intersectan? a1 a2 b1 b2)
      (cons (max a1 b1) (min a2 b2))
      '()))

;; Demostración
(display "\n\nEjercicio 4.b\n")
(display "La intersección entre los intervalos [4,7] y [5,12] es: ")
(display (interseccion 4 7 5 12))

;; Pruebas
(check-equal? (interseccion 4 7 5 12) (cons 5 7))
(check-equal? (interseccion 4 9 12 15) '())
(check-equal? (interseccion 2 5 5 8)  (cons 5 5))
(check-equal? (interseccion 2 8 3 5) (cons 3 5))
(check-equal? (interseccion 2 4 7 10) '())
(check-equal? (interseccion 4 9 2 6) (cons 4 6))



;--------------------------
;; Ejercicio 5
;--------------------------

; Versión 1: Las funciones cyan, magenta y yellow se
; definen con 2 argumentos, valor de blanco y valor de
; r, g o b. La llamada a white para calcular el valor
; de blanco se hace antes de llamar a cyan, magenta o yellow

;(define (white red green blue)
;  (max (/ red 255) (/ green 255) (/ blue 255)))
;
;(define (cyan red white)
;  (if (= white 0) 0
;      (/ (- white (/ red 255)) white)))
;
;(define (magenta green white)
;  (if (= white 0) 0
;      (/ (- white (/ green 255)) white)))
;
;(define (yellow blue white)
;  (if (= white 0) 0
;      (/ (- white (/ blue 255)) white)))
;
;(define (black white)
;  (- 1 white))
;
;(define (rgb->cmyk red green blue)
;  (list
;      (cyan red (white red green blue))
;      (magenta green (white red green blue))
;      (yellow blue (white red green blue))
;      (black (white red green blue))))


; Versión 2: definimos las funciones cyan, magenta, yellow y black
; con 3 argumentos (red, gree, blue) y se define una función
; auxiliar que realiza la operación del cálculo de la componente
(define (white r g b)
  (max (/ r 255) (/ g 255) (/ b 255)))

(define (componente comp-rgb w)
  (if (= w 0)
      0
      (/ (- w (/ comp-rgb 255)) w)))

(define (cyan r g b)
  (componente r (white r g b)))

(define (magenta r g b)
  (componente g (white r g b)))

(define (yellow r g b)
  (componente b (white r g b)))

(define (black r g b)
  (- 1 (white r g b)))

(define (rgb->cmyk red green blue)
  (list
      (cyan red green blue)
      (magenta red green blue)
      (yellow red green blue)
      (black red green blue)))


;; Demostración
(display "\n\nEjercicio 5\n")
(display "La conversión del color RGB (75,0,130) al modelo de color CMYK es: ")
(display (rgb->cmyk 75 0 130))

;; Pruebas
(check-equal? (rgb->cmyk 75 0 130) (list (/ 11 26) 1 0 (/ 25 51)))
(check-equal? (rgb->cmyk 150 10 255) (list (/ 7 17) (/ 49 51) 0 0))
(check-equal? (rgb->cmyk 255 255 255) (list 0 0 0 0))
(check-equal? (rgb->cmyk 0 0 0) (list 0 0 0 1))
