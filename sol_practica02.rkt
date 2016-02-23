;;
;; Solución práctica 2
;;

#lang r6rs
(import (rnrs base)
        (rnrs io simple)
        (schemeunit))

;--------------------------
; Ejercicio 1
;--------------------------

;
; En el ejercicio se muestra que las funciones y las formas
; especiales se evalúan de distinta forma.
;

;------------
; Apartado a)
;------------
; Definimos una función "new-cond" que toma 5 argumentos y
; llama a la forma especial "cond"
;

(define (new-cond c1 x c2 y z)
    (cond
        (c1 x)
        (c2 y)
        (else z)))

(new-cond (= 2 1) (+ 1 1) (< 3 2) (+ 2 3) (- 10 3))  ; => 7
(cond ((= 2 1) (+ 1 1))
       ((< 3 2) (+ 2 3))
       (else (- 10 3)))                              ; => 7

;
; Las expresiones anteriores, aunque devuelven el mismo resultado,
; se evalúan de forma distinta.
; En el caso de "new-cond", al ser una función se evalúan todos
; los argumentos antes de invocar a la propia función:
;
; (= 2 1) => #f
; (+ 1 1) => 2
; (< 3 2) => #f
; (+ 2 3) => 5
; (- 10 3) => 7
;
; La llamada a "new-cond" se hace entonces con los siguientes
; parámetros:
;
; (new-cond #f 2 #f 5 7)
;
; Sin embargo, "cond" es una forma especial y la evaluación de sus
; expresiones se realiza según la definición vista en teoría.
; En este caso, se evalúan únicamente las expresiones:
;
; (= 2 1) => #f
; (> 3 2) => #f
; (- 10 3) => 7

;;(new-cond (< 2 2) 1 (> 3 2) 2 (/ 3 0))  ; => /: division by zero
(cond ((< 2 2) 1)
       ((> 3 2) 2)
       (else (/ 3 0)))                     ; => 2


(newline)
(display "Ejercicio 1.a\n")
(display "En el ejemplo anterior se puede comprobar que 'cond' es una forma especial.
En la llamada a la función 'new-cond' que hemos definido, como en cualquier otra función en Scheme,
se evalúan primero todos sus argumentos y se realiza la invocación a la propia función.
En este caso al evaluarse el argumento (/ 3 0), aparece un error de división por cero.
El uso de 'cond' en el cuarto ejemplo no provoca error porque no llega a evaluarse (/ 3 0),
ya que la segunda condición (> 3 2) es cierta.

En concreto, en la expresión 'cond' se evalúan las siguientes expresiones:
(< 2 2) ; => #f
(> 3 2) ; => #t
2       ; => 2")
(newline)


;------------
; Apartado b)
;------------
(newline)
(display "Ejercicio 1.b\n")
(display (and (= 1 2) (= 1 (/ 2 0))))  ; => #f
(newline)
(display (or (= 1 1) (= 1 (/ 2 0))))   ; => #t
(newline)

(display "'and' y 'or' también son formas especiales ya que no necesariamente
evalúan todos sus argumentos como se ilustra en los ejemplos anteriores.
Ambas expresiones devuelven un valor y no lanzan ningún error, debido
a que las expresiones en las que hay una división por cero
no llegan a evaluarse: con la forma especial 'and' si una condición
se evalúa a falso, el resto de argumentos (condiciones) no se evalúa,
mientras que con la forma especial 'or', si un argumento es cierto,
no sigue evaluando el resto")
(newline)


;------------------------------------
; Ejercicio 2
;------------------------------------

; Función auxiliar "menor"
(define (menor a b)
  (if (< a b) a b))

; Definición recursiva del caso general:
; "El mínimo de los elementos de una lista es el menor entre
; el mínimo del resto de la lista y el primer elemento"

(define (minimo lista)
  (if (null? (cdr lista))
      (car lista)
      (menor (car lista) (minimo (cdr lista)))))

;; Demostración
(newline)
(display "Ejercicio 2\n")
(display "El mínimo de la lista (9 8 6 4 3) es: ")
(display (minimo '(9 8 6 4 3)))
(newline)

;Pruebas
(check-equal? (minimo '(9 8 6 4 3)) 3)
(check-equal? (minimo '(9 8 3 6 4)) 3)
(check-equal? (minimo '(1 2 3 4 5)) 1)
(check-equal? (minimo '(8 5 2 9 7)) 2)


;------------------------------------
; Ejercicio 3
;------------------------------------
(define (ordenada-decreciente? lista-nums)
  (if (null? (cdr lista-nums))
      #t
      (and (> (car lista-nums) (cadr lista-nums))
           (ordenada-decreciente? (cdr lista-nums)))))


(newline)
(display "Ejercicio 3\n")
(display "Definición recursiva del caso general: Una lista está ordenada
 si sus dos primeros elementos están ordenados y el resto de la lista también lo está")
(newline)
(newline)

;; Demostración
(display "La lista (99 59 45 23 -1) ¿está ordenada de forma decreciente?: ")
(display (ordenada-decreciente? '(99 59 45 23 -1)))

;; Pruebas
(check-true (ordenada-decreciente? '(99 59 45 23 -1)))
(check-false (ordenada-decreciente? '(12 50 -1 293 1000)))
(check-true (ordenada-decreciente? '(3)))
(check-false (ordenada-decreciente? '(-1 23 45 59 99)))
(check-true (ordenada-decreciente? '(-12 -50 -200 -293 -1000)))



;------------------------------------
; Ejercicio 4
;------------------------------------

; Funciones de la práctica anterior
(define (engloba? a1 a2 b1 b2)
  (or (and (>= a1 b1) (<= a2 b2))
      (and (>= b1 a1) (<= b2 a2))))

(define (intersectan-intervalos? a1 a2 b1 b2)
  (and (<= b1 a2) (<= a1 b2)))


;------------
; Apartado a)
;------------
(define (engloban-intervalos? a b)
  (or (equal? a 'vacio)
      (equal? b 'vacio)
      (engloba? (car a) (cdr a) (car b) (cdr b))))


;; Demostración
(newline)
(newline)
(display "Ejercicio 4.a\n")
(display "Los intervalos [5,9] [4,8] ¿se engloban?: ")
(display (engloban-intervalos? (cons 5  9) (cons 4 8)))
(newline)

; Pruebas
(define i1 (cons 4 9))
(define i2 (cons 3 10))
(define i3 (cons 12 15))
(define i4 (cons 8 19))
(check-false (engloban-intervalos? (cons 5 9) (cons 4 8)))
(check-true (engloban-intervalos? i1 i2))
(check-true (engloban-intervalos? i3 'vacio))
(check-false (engloban-intervalos? i3 i2))
(check-true (engloban-intervalos? i2 i2))
(check-true (engloban-intervalos? 'vacio i4))


;------------
; Apartado b)
;------------
(define (union-intervalos a b)
  (cond ((equal? a 'vacio) b)
        ((equal? b 'vacio) a)
        (else (cons (min (car a) (car b))
                    (max (cdr a) (cdr b))))))

;; Demostración
(newline)
(display "Ejercicio 4.b\n")
(display "La unión de los intervalos [4,10] [3,8] es: ")
(display (union-intervalos (cons 4 10) (cons 3 8)))
(newline)

;; Pruebas
(check-equal? (union-intervalos (cons 4 10) (cons 3 8)) (cons 3 10))
(check-equal? (union-intervalos i2 i3) (cons 3 15))
(check-equal? (union-intervalos 'vacio i4) (cons 8 19))
(check-equal? (union-intervalos i3 i1) '(4 . 15))
(check-equal? (union-intervalos i2 'vacio) (cons 3 10))
(check-equal? (union-intervalos 'vacio 'vacio) 'vacio)



;------------
; Apartado c)
;------------
(define (interseccion-intervalos a b)
  (cond ((or (equal? a 'vacio)
             (equal? b 'vacio))  'vacio)
        ((not (intersectan-intervalos? (car a) (cdr a) (car b) (cdr b))) 'vacio)
        (else (cons (max (car a) (car b))
                    (min (cdr a) (cdr b))))))

;; Demostración
(newline)
(display "Ejercicio 4.c\n")
(display "La intersección de los intervalos [4,10] [8,15] es: ")
(display (union-intervalos (cons 4 10) (cons 8 15)))
(newline)

;; Pruebas
(check-equal? (interseccion-intervalos (cons 4 10) (cons 8 15)) (cons 8 10))
(check-equal? (interseccion-intervalos i2 i3) 'vacio)
(check-equal? (interseccion-intervalos 'vacio i4) 'vacio)
(check-equal? (interseccion-intervalos i3 i4) (cons 12 15))
(check-equal? (interseccion-intervalos 'vacio i1) 'vacio)
(check-equal? (interseccion-intervalos 'vacio 'vacio) 'vacio)





;------------------------------------
; Ejercicio 5
;------------------------------------
(newline)
(display "Ejercicio 5\n")

; Formulación recursiva del caso general:
(display "La unión de intervalos se define como la unión de un
intervalo con la unión del resto de intervalos")

(define (union-lista-intervalos lista-intervalos)
  (if (null? lista-intervalos)
      'vacio
      (union-intervalos (car lista-intervalos)
                        (union-lista-intervalos (cdr lista-intervalos)))))

; Formulación recursiva del caso general:
(newline)
(newline)
(display "La intersección de intervalos se define como la intersección
de un intervalo con la intersección del resto de intervalos")
(newline)
(newline)

(define (interseccion-lista-intervalos lista-intervalos)
  (if (null? (cdr lista-intervalos))
      (car lista-intervalos)
      (interseccion-intervalos (car lista-intervalos)
                              (interseccion-lista-intervalos (cdr lista-intervalos)))))

;; Demostración
(display "La unión de los intervalos [2,12] [-1,10] [8,20] es: ")
(display (union-lista-intervalos (list (cons 2 12) (cons -1 10) (cons 8 20))))
(newline)
(display "La intersección de los intervalos [2,12] [-1,10] [8,20] es: ")
(display (interseccion-lista-intervalos (list (cons 12 30) (cons -8 20) (cons 13 35))))
(newline)


;; Pruebas
(check-equal? (union-lista-intervalos (list (cons 2 12) (cons -1 10) (cons 8 20))) (cons -1 20))
(check-equal? (interseccion-lista-intervalos (list (cons 12 30) (cons -8 20) (cons 13 35))) (cons 13 20))
(check-equal? (union-lista-intervalos (list (cons 2 12) 'vacio (cons 8 20))) (cons 2 20))
(check-equal? (interseccion-lista-intervalos (list (cons 25 30) (cons -8 20) (cons 13 35))) 'vacio)
