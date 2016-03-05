;;Jorge Espinosa Campello
#lang r6rs
(import (rnrs)
        (schemeunit))

                          ;-----------------;
                          ;;;;Ejercicio 1a;;;;
                          ;-----------------;
;;Definición de las funciones
(define (prueba x)
  (lambda (y)
    (+ x y)))
(define f (prueba 10))

(define g (prueba 5))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 1a________________ \n")
(display "La evaluación de la función (f 3) es: ")
(display (f 3))

;;Pruebas
(check-equal? (f 3) 13)
(check-equal? (g 3) 8)

                          ;-----------------;
                          ;;;;Ejercicio 1b;;;;
                          ;-----------------;
;;Definición de las funciones
(define g1 (lambda (x)
             (+ x 8)))
(define (g2 x)
  (lambda (y)
    (* x y)))
;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 1b________________ \n")
(display "La evaluación de la expresión g1 es: ")
(display (g1 4))
;;Pruebas
(check-equal? (g1 4) 12)
(check-equal? ((g2 6) 2) 12)

                          ;-----------------;
                          ;;;;Ejercicio 2;;;;
                          ;-----------------;  
;;Argumentación de las soluciones
(display "\n\n               ________________Ejercicio 2________________ \n")
(display "Antes de comprobar en Scheme se llega a la conclusión de que el resultado final de f=18 porque 
analizando el problema se llega al siguiente esquema de variables globales y locales: \n")
(display "x(global) : 10 
y(global) : 3
y(local-capturada) : 6 -> (x(local)=2 + 4)
z(local) : 6 -> (y(global) + 3)\n
Se llega a la conclusión de que f = ((longitud palabra) + x(local) + y(local) + z(local) = 18
Después de haber probado la función se muestra el resultado esperado por lo que suponemos que el razonamiento de ámbitos de la variable es correcto.")

                          ;-----------------;
                          ;;;;Ejercicio 3a;;;;
                          ;-----------------;
;;Definición de las funciones
(define precision 0.000001)
(define (iguales-reales? x y)
  (< (abs (- x y)) precision))
(define (iguales-monedas? x y)
  (and (iguales-reales? (car x) (car y))
       (equal? (cdr x) (cdr y))))
(define (construye-conversores lista)
  (if (null? lista)
      '()
      (cons (lambda (x)
              (cons (* x (caar lista)) (cdar lista)))
            (construye-conversores (cdr lista)))))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 3a________________ \n")
(define lista-conversores (construye-conversores (list (cons 1.11072 'Dólar-estadounidense) (cons 0.77444 'Libra-esterlina)
                                                       (cons 125.74 'Yen-japonés))))
(display "La conversión de 10 libras esterlinas a euros es: ")
(display lista-conversores)
(display "\n")
(display ((cadr lista-conversores) 10))

;;Pruebas
(check-equal? ((cadr lista-conversores) 10) (cons 7.744400000000001 'Libra-esterlina))
(check-equal? ((list-ref lista-conversores 2) 10) (cons 1257.3999999999999 'Yen-japonés))
(check-equal? (iguales-monedas? ((list-ref lista-conversores 0) 5) (cons 5.553599999999999 'Dólar-estadounidense)) #t)
(check-equal? (iguales-monedas? ((list-ref lista-conversores 1) 7) (cons 5.42108 'Libra-esterlina)) #t)

                          ;-----------------;
                          ;;;;Ejercicio 3b;;;;
                          ;-----------------;
;;Definición de las funciones
(define (construye-conversores-FOS lista)
  (map (lambda (x)
         (lambda (y)
           (cons (* (car x) y) (cdr x))))
       lista))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 3b________________ \n")
(define lista-conversores2 (construye-conversores-FOS (list (cons 1.11072 'Dólar-estadounidense) (cons 0.77444 'Libra-esterlina)
                                                       (cons 125.74 'Yen-japonés))))
(display "La conversión de 10 libras esterlinas a euros es: ")
(display lista-conversores2)
(display "\n")
(display ((cadr lista-conversores2) 10))
;;Pruebas
(check-equal? ((cadr lista-conversores2) 10) (cons 7.744400000000001 'Libra-esterlina))
(check-equal? ((list-ref lista-conversores2 2) 10) (cons 1257.3999999999999 'Yen-japonés))
(check-equal? (iguales-monedas? ((list-ref lista-conversores2 0) 5) (cons 5.553599999999999 'Dólar-estadounidense)) #t)
(check-equal? (iguales-monedas? ((list-ref lista-conversores2 1) 7) (cons 5.42108 'Libra-esterlina)) #t)

                          ;-----------------;
                          ;;;;Ejercicio 4a;;;;
                          ;-----------------;
;;Definición de las funciones
(define (suma-iter lista)
  (if (null? lista)
      0
      (+ (suma-iter (cdr lista)) (car lista))))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 4a________________ \n")
(display "El resultado de sumar por la cola la lista {1, 2, 3, 4, 5} es: ")
(display (suma-iter '(1 2 3 4 5)))

;;Pruebas
(check-equal? (suma-iter '(1 2 3 4 5)) 15)
(check-equal? (suma-iter '(-1 -5 1 5)) 0)
(check-equal? (suma-iter '(20 -10 5 5)) 20)

                          ;-----------------;
                          ;;;;Ejercicio 4b;;;;
                          ;-----------------;
;;Definición de las funciones
(define (cuadrado-lista-iter lista)
  (if (null? lista)
      '()
      (append (list (* (car lista) (car lista)))
              (cuadrado-lista-iter (cdr lista)))))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 4b________________ \n")
(display "El resultado de elevar al cuadrado la lista {2 3 4 5} es: ")
(display (cuadrado-lista-iter '(2 3 4 5)))
;;Pruebas
(check-equal? (cuadrado-lista-iter '(2 3 4 5)) '(4 9 16 25))
(check-equal? (cuadrado-lista-iter '(1 5 1 2 2)) '(1 25 1 4 4))
(check-equal? (cuadrado-lista-iter '()) '())

                          ;-----------------;
                          ;;;;Ejercicio 5;;;;
                          ;-----------------;
;;Definición de las funciones
(define (pinta-asteriscos n)
  (if (= n 0)
      '()
      (append (pinta-asteriscos (- n 1)) (list '*))))
(define (asteriscos-iter n)
  (if (= n 0)
      '()
      (append (asteriscos-iter (- n 1))
              (list (pinta-asteriscos n)))))

;;Ejemplos del enunciado
(display "\n\n               ________________Ejercicio 5________________ \n")
(display "El resultado de hacer listas con asteriscos de hasta 5 unidades es: ")
(display (asteriscos-iter 5))
;;Pruebas
(check-equal? (asteriscos-iter 5) (list '(*) '(* *) '(* * *) '(* * * *) '(* * * * *)))
(check-equal? (asteriscos-iter 2) (list '(*) '(* *)))
(check-equal? (asteriscos-iter 0) '())