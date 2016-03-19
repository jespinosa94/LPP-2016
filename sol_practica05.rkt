;;-------------------------
;; Solución práctica 5
;--------------------------

#lang r6rs
(import (rnrs)
        (schemeunit))


;--------------------------
; Ejercicio 1
;--------------------------
; a)
(define (prueba x)
  (lambda (y)
    (+ x y)))

(display "Ejercicio 1.a\n")

(define f (prueba 10))
(display "(f 3) : ")
(display (f 3)) ; => 13
(newline)
(define g (prueba 5))
(display "(g 3) : ")
(display (g 3)) ; => 8
(newline)


; b)
; b.1)
(define g1 (lambda (x)
              (+ x 8)))

(display "Ejercicio 1.b1\n")
(display (g1 4))
(newline)

; b.2)
(define (g2 x)
 (lambda (y)
  (* x y)))

(display "Ejercicio 1.b2\n")
(display ((g2 3) 4))
(newline)



;--------------------------
; Ejercicio 2
;--------------------------

;(define x 10)
;(define y 3)
;(define (prueba x)
;   (let ((y (+ x 4))
;         (z (+ y 3)))
;      (lambda (str)
;         (+ (string-length str) x y z))))
;(define f (prueba 2))
;(f "hola")

(display "La invocación a (f \"hola\") evalúa la expresión (+ (string-length str) x y z)

En esta expresión las variables que intervienen son:

'str' - toma el valor \"hola\" y es local
'x' - toma el valor 2 y es capturada
'y' - toma el valor 6 y es capturada
'z' - toma el valor 6 y es capturada

El resultado final es (+ 4 2 6 6) => 18
")


;--------------------------
; Ejercicio 3
;--------------------------
; a)
(define (construye-conversores lista)
  (if (null? lista)
      '()
      (cons (lambda (euro) (cons (* euro (caar lista))
                                 (cdar lista)))
           (construye-conversores (cdr lista)))))


; Demostración
(display "\nEjercicio 3.a\n")
(define lista-monedas (list (cons 1.11072 'Dólar-estadounidese)
                            (cons 0.77444 'Libra-esterlina)
                            (cons 125.774 'Yen-japonés)))
(define lista-conversores (construye-conversores lista-monedas))
(display "(construye-conversores lista-monedas) : ")
(display lista-conversores)  ; ⇒ (#<procedure> #<procedure> #<procedure>)
(newline)

; Pruebas
;; Fijamos el margen de error (precisión) para comparar números reales
(define precision 0.000001)

;; función auxiliar que compara números reales teniendo en cuenta una determinada precisión
(define (iguales-reales? x y)
  (< (abs (- x y)) precision))

;; función auxiliar que compara monedas
(define (iguales-monedas? x y)
  (and (iguales-reales? (car x) (car y))
       (equal? (cdr x) (cdr y))))


(check-true (iguales-monedas? ((cadr lista-conversores) 10) (cons 7.7444 'Libra-esterlina)))
(check-true (iguales-monedas? ((list-ref lista-conversores 2) 10) (cons 1257.74 'Yen-japonés)))


; b)
(define (construye-conversor pareja)
  (lambda (euro)
    (cons (* euro (car pareja))
          (cdr pareja))))

(define (construye-conversores-FOS lista)
  (map  construye-conversor lista))


; Demostración
(display "\nEjercicio 3.b\n")
(define lista-conversores-FOS (construye-conversores-FOS lista-monedas))
(display "(construye-conversores-FOS lista-monedas) : ")
(display lista-conversores-FOS)  ; ⇒ (#<procedure> #<procedure> #<procedure>)
(newline)


; Pruebas
(check-true (iguales-monedas? ((cadr lista-conversores-FOS) 10) (cons 7.7444 'Libra-esterlina)))
(check-true (iguales-monedas? ((list-ref lista-conversores-FOS 2) 10) (cons 1257.74 'Yen-japonés)))



;--------------------------
; Ejercicio 4
;--------------------------
;a)
(define (suma-iter lista)
    (suma-iter-aux lista 0))

(define (suma-iter-aux lista result)
    (if (null? lista)
        result
        (suma-iter-aux (cdr lista)  (+ result (car lista)))))

; Demostración
(display "\nEjercicio 4.a\n")
(display "(suma-iter '(1 2 3 4 5)) : ")
(display (suma-iter '(1 2 3 4 5)))
(newline)

; Pruebas
(check-equal? (suma-iter '(1 2 3 4 5)) 15)
(check-equal? (suma-iter '(1 -2 3 -4 5)) 3)
(check-equal? (suma-iter '(1 0)) 1)


; b)
(define (cuadrado-lista-iter lista)
    (cuadrado-lista-iter-aux lista '()))

(define (cuadrado-lista-iter-aux lista result)
    (if (null? lista)
        result
        (cuadrado-lista-iter-aux (cdr lista)
                            (append result
                                    (list (* (car lista)
                                             (car lista)))))))

; Demostración
(display "\nEjercicio 4.b\n")
(display "(cuadrado-lista-iter '(2 3 4 5)) : ")
(display (cuadrado-lista-iter '(2 3 4 5)))
(newline)

; Pruebas
(check-equal? (cuadrado-lista-iter '(2 3 4 5)) '(4 9 16 25))
(check-equal? (cuadrado-lista-iter '(-2 -3 -4 -5)) '(4 9 16 25))
(check-equal? (cuadrado-lista-iter '(-2 0 -4)) '(4 0 16))



;--------------------------
; Ejercicio 5
;--------------------------
(define (crea-sublista-iter n)
  (crea-sublista-iter-aux n '()))

(define (crea-sublista-iter-aux n result)
  (if (= n 0)
      result
      (crea-sublista-iter-aux (- n 1)
                              (cons  '* result))))

(define (asteriscos-iter n)
  (asteriscos-iter-aux n '()))

(define (asteriscos-iter-aux n result)
  (if (= n 0)
      result
      (asteriscos-iter-aux (- n 1)
                           (cons  (crea-sublista-iter n)
                                  result))))

; Demostración
(display "\nEjercicio 5\n")
(display "(asteriscos-iter 5) : ")
(display (asteriscos-iter 5))
(newline)

; Pruebas
(check-equal? (asteriscos-iter 5) '((*) (* *) (* * *) (* * * *) (* * * * *)))
(check-equal? (asteriscos-iter 1) '((*)))
(check-equal? (asteriscos-iter 0) '())
