;;-------------------------
;; Solución práctica 4
;--------------------------

#lang r6rs
(import (rnrs)
        (schemeunit))


;--------------------------
; Ejercicio 1
;--------------------------
; a)
(define (suma-lista-nums lista1 lista2)
  (if (null? lista1)
      '()
      (cons (+ (car lista1) (car lista2))
            (suma-lista-nums (cdr lista1) (cdr lista2)))))

(define (divide-lista-nums lista1 lista2)
  (if (null? lista1)
      '()
      (cons (/ (car lista1) (car lista2))
            (divide-lista-nums (cdr lista1) (cdr lista2)))))

; Demostración
(display "Ejercicio 1.a\n")
(display "(suma-lista-nums '(10 8 4 6)) '(2 5 3 4) : ")
(display (suma-lista-nums '(10 8 4 6) '(2 5 3 4)))
(newline)
(display "(divide-lista-nums '(10 8 1 8) '(2 16 3 4)) : ")
(display (divide-lista-nums '(10 8 1 8) '(2 16 3 4)))
(newline)

; Pruebas
(check-equal? (suma-lista-nums '(10 8 4 6) '(2 5 3 4)) '(12 13 7 10))
(check-equal? (suma-lista-nums '(2 -3 1) '(10 8 4)) '(12 5 5))
(check-equal? (suma-lista-nums '(0 -3 0) '(10 8 4)) '(10 5 4))
(check-equal? (divide-lista-nums '(10 8 1 8) '(2 16 3 4)) '(5 1/2 1/3 2))
(check-equal? (divide-lista-nums '(0 5 10) '(2 5 10)) '(0 1 1))
(check-equal? (divide-lista-nums '(10 -5 10) '(-2 5 10)) '(-5 -1 1))


; b)
(define (aplica-op-lista-nums op lista1 lista2)
    (if (null? lista1)
      '()
      (cons (op (car lista1) (car lista2))
            (aplica-op-lista-nums op (cdr lista1) (cdr lista2)))))


; Demostración
(display "Ejercicio 1.b\n")
(display "(aplica-op-lista-nums + '(10 8 4 6) '(2 5 3 4)) : ")
(display (aplica-op-lista-nums + '(10 8 4 6) '(2 5 3 4)))
(newline)


; Pruebas
(check-equal? (aplica-op-lista-nums + '(10 8 4 6) '(2 5 3 4)) '(12 13 7 10))
(check-equal? (aplica-op-lista-nums + '(2 -3 1) '(10 8 4)) '(12 5 5))
(check-equal? (aplica-op-lista-nums + '(0 -3 0) '(10 8 4)) '(10 5 4))
(check-equal? (aplica-op-lista-nums / '(10 8 1 8) '(2 16 3 4)) '(5 1/2 1/3 2))
(check-equal? (aplica-op-lista-nums / '(0 5 10) '(2 5 10)) '(0 1 1))
(check-equal? (aplica-op-lista-nums / '(10 -5 10) '(-2 5 10)) '(-5 -1 1))



;--------------------------
; Ejercicio 2
;--------------------------
;a )
(define (aplica-func pareja)
  ((car pareja) (cdr pareja)))

(define (aplica-funciones  lista-parejas)
  (if (null?  lista-parejas)
      '()
      (cons (aplica-func (car lista-parejas))
            (aplica-funciones (cdr lista-parejas)))))

; Demostración 
(display "Ejercicio 2.a\n")
(display "(aplica-funciones (list (cons even? 6) (cons null? '(4)) (cons list 8) (cons car '(1 2 3)))) : ")
(display (aplica-funciones (list (cons even? 6) (cons null? '(4)) (cons list 8) (cons car '(1 2 3)))))
(newline)

; Pruebas
(check-equal? (aplica-funciones (list (cons even? 6) (cons null? '(4)) (cons list 8) (cons car '(1 2 3)))) 
              '(#t #f (8) 1))
(check-equal? (aplica-funciones (list (cons number? 'a) (cons symbol->string 'abc) (cons string->list "hola") (cons pair? '()))) 
              '(#f "abc" (#\h #\o #\l #\a) #f))
(check-equal? (aplica-funciones (list (cons abs -10) (cons zero? 0.2) (cons cdr '(1 2 3)) (cons string-length "esto es un string"))) 
              '(10 #f (2 3) 17))


; b)
; Versión construyendo la función auxiliar usando lambda
;(define (aplica-funciones-FOS lista-parejas)
;  (map (lambda (pareja) ((car pareja) (cdr pareja)))
;       lista-parejas))

(define (aplica-funciones-FOS lista-parejas)
 (map aplica-func lista-parejas))


; Demostración 
(display "Ejercicio 2.b\n")
(display "(aplica-funciones-FOS (list (cons even? 6) (cons null? '(4)) (cons list 8) (cons car '(1 2 3)))) : ")
(display (aplica-funciones-FOS (list (cons even? 6) (cons null? '(4)) (cons list 8) (cons car '(1 2 3)))))
(newline)

; Pruebas
(check-equal? (aplica-funciones-FOS (list (cons even? 6) (cons null? '(4)) (cons list 8) (cons car '(1 2 3)))) 
              '(#t #f (8) 1))
(check-equal? (aplica-funciones-FOS (list (cons number? 'a) (cons symbol->string 'abc) (cons string->list "hola") (cons pair? '()))) 
              '(#f "abc" (#\h #\o #\l #\a) #f))
(check-equal? (aplica-funciones-FOS (list (cons abs -10) (cons zero? 0.2) (cons cdr '(1 2 3)) (cons string-length "esto es un string"))) 
              '(10 #f (2 3) 17))



;--------------------------
; Ejercicio 3
;--------------------------
; a)
(define (aplana-lista lista)
  (fold-right append  '()  lista))

; Demostración 
(display "Ejercicio 3.a\n")
(display "(aplana-lista '((1 2 3) (4 5 6) (7))) : ")
(display (aplana-lista '((1 2 3) (4 5 6) (7))))
(newline)

; Pruebas
(check-equal? (aplana-lista '((1 2 3) (4 5 6) (7))) '(1 2 3 4 5 6 7))
(check-equal? (aplana-lista '((1 2 3) () (7))) '(1 2 3 7))
(check-equal? (aplana-lista '((7))) '(7))


; b)
; Función definida en la práctica anterior
(define (expande-pareja pareja)
  (if (= (cdr pareja) 0)
      '()
      (cons (car pareja)
            (expande-pareja (cons (car pareja) 
                                  (- (cdr pareja) 1))))))

(define (expande lista-parejas)
  (aplana-lista (map  expande-pareja  lista-parejas)))


;; Demostración
(display "\nEjercicio 3.b\n")
(display "(expande (list (cons #t 3) (cons \"LPP\" 2) (cons 'b 4)))  : ")
(display (expande (list (cons #t 3) (cons "LPP" 2) (cons 'b 4))))
(newline)

;; Pruebas
(check-equal? (expande (list (cons #t 3) (cons "LPP" 2) (cons 'b 4))) '(#t #t #t "LPP" "LPP" b b b b))
(check-equal? (expande (list)) '())
(check-equal? (expande (list (cons 4 3))) '(4 4 4))


; c)
(define (suma-impar-par x pareja)
  (if (odd? x)
      (suma-izq x pareja)
      (suma-der x pareja)))

; Funciones auxiliares definidas en la práctica anterior
(define (suma-izq n pareja)
  (cons (+ n (car pareja))
        (cdr pareja)))

(define (suma-der n pareja)
  (cons (car pareja)
        (+ n (cdr pareja))))


(define (suma-impares-pares lista-num)
  (fold-right suma-impar-par (cons 0  0) lista-num))


;; Demostración
(display "\nEjercicio 3.c\n")
(display "(suma-impares-pares '(3 2 1 4 8 7 6 5))) : ")
(display (suma-impares-pares '(3 2 1 4 8 7 6 5)))
(newline)
         
;; Pruebas
(check-equal? (suma-impares-pares '(3 2 1 4 8 7 6 5)) '(16 . 20))
(check-equal? (suma-impares-pares '(3 1 5))  '(9 . 0))
(check-equal? (suma-impares-pares '(2))  '(0 . 2))
(check-equal? (suma-impares-pares '(2 4 6))  '(0 . 12))




;--------------------------
; Ejercicio 4
;--------------------------
(define (igual-longitud? pareja)
  ( = (string-length (symbol->string (car pareja))) 
      (cdr pareja)))
  
(define (filtra-cadenas lista-cadenas lista-num)
  (filter igual-longitud?
          (map (lambda (cadena num)
                 (cons cadena num)) lista-cadenas lista-num)))
         

;; Demostración
(display "\nEjercicio 4\n")
(display "(filtra-cadenas '(este es un ejercicio de examen) '(2 1 2 9 1 6))  : ")
(display (filtra-cadenas '(este es un ejercicio de examen) '(2 1 2 9 1 6)))
(newline)

;; Pruebas
(check-equal? (filtra-cadenas '(este es un ejercicio de examen) '(2 1 2 9 1 6)) '((un . 2) (ejercicio . 9) (examen . 6)))
(check-equal? (filtra-cadenas '( este es un ejercicio de examen) '(2 1 3 4 1 5)) '())
(check-equal? (filtra-cadenas '(ejercicio) '(9)) '((ejercicio . 9)))




;--------------------------
; Ejercicio 5
;--------------------------
; a)
(define (generar-cartas n palo)
  (if (= n 0)
      '()
      (append (generar-cartas (- n  1) palo)
              (list (cons n palo)))))

; Demostración
(display "Ejercicio 5.a\n")
(display "Las cartas del palo oros son: ")
(display (generar-cartas 12 'oros))
(newline)

; Pruebas
(check-equal? (generar-cartas 12 'oros) ' ((1 . oros) (2 . oros) (3 . oros) (4 . oros) (5 . oros) (6 . oros) (7 . oros) (8 . oros) (9 . oros) (10 . oros) (11 . oros) (12 . oros)))
(check-equal? (generar-cartas 6 'copas) ' ((1 . copas) (2 . copas) (3 . copas) (4 . copas) (5 . copas) (6 . copas)))
(check-equal? (generar-cartas 1 'bastos) ' ((1 . bastos)))


; b)
(define (construye-baraja n lista-palos)
  (fold-right append  '() (map (lambda (palo) (generar-cartas n palo)) lista-palos)))

; Demostración
(display "Ejercicio 5.b\n")
(display "La baraja española es: ")
(display (construye-baraja 12 '(oros espadas copas bastos)))
(newline)

; Pruebas
(check-equal? (construye-baraja 3 '(copas espadas)) ' ((1 . copas) (2 . copas) (3 . copas) (1 . espadas) (2 . espadas) (3 . espadas)))
(check-equal? (construye-baraja 12 '(oros)) ' ((1 . oros) (2 . oros) (3 . oros) (4 . oros) (5 . oros) (6 . oros) (7 . oros) (8 . oros) (9 . oros) (10 . oros) (11 . oros) (12 . oros)))


