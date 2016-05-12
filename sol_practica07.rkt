;;-------------------------
;; Solución práctica 7
;--------------------------

#lang r6rs
(import (rnrs)
        (rnrs mutable-pairs)
        (schemeunit))


; Barrera de abstracción de los árboles
(define (dato-tree arbol) 
    (car arbol))

(define (hijos-tree arbol) 
    (cdr arbol))

(define (hoja-tree? arbol) 
   (null? (hijos-tree arbol)))  



;--------------------------
; Ejercicio 1
;--------------------------
; 1.a)
(define (to-string-tree tree)
   (string-append (symbol->string (dato-tree tree))
                  (to-string-bosque (hijos-tree tree))))

(define (to-string-bosque bosque)
   (if (null? bosque)
       ""
       (string-append (to-string-tree (car bosque))
                      (to-string-bosque (cdr bosque)))))
                              
                              
; Demostración
(display "\nEjercicio 1.a\n")
(define tree '(a (b (c (d)) (e)) (f)))
(display "(to-string-tree '(a (b (c (d)) (e)) (f)))) : ")
(display (to-string-tree tree))
(newline)

; Pruebas
(check-equal? (to-string-tree tree) "abcdef")
(define tree1 '(a (b) (c)))
(define tree2 '(a (b (c) (d) (e)) (f) (g)))
(check-equal? (to-string-tree tree1) "abc")
(check-equal? (to-string-tree tree2) "abcdefg")


; 1.b)
(define (to-string-tree-FOS tree)
    (string-append (symbol->string (dato-tree tree))
                   (fold-right string-append "" (map to-string-tree-FOS (hijos-tree tree)))))


; Demostración
(display "\nEjercicio 1.b\n")
(display "(to-string-tree-FOS '(a (b (c (d)) (e)) (f)))) : ")
(display (to-string-tree-FOS tree))
(newline)

; Pruebas
(check-equal? (to-string-tree-FOS tree) "abcdef")
(check-equal? (to-string-tree-FOS tree1) "abc")
(check-equal? (to-string-tree-FOS tree2) "abcdefg")




;--------------------------
; Ejercicio 2
;--------------------------

; 2.a)
; función auxiliar
(define (ordenada-lista lista)
  (if (null? (cdr lista))
      #t
      (and (< (car lista) (cadr lista))
           (ordenada-lista (cdr lista)))))

; Versión con recursión mútua
(define (ordenado-tree? tree)
  (and (ordenada-lista (append (map dato-tree (hijos-tree tree))
                               (list (dato-tree tree))))
       (ordenado-bosque? (hijos-tree tree))))

(define (ordenado-bosque? bosque)
  (if (null? bosque)
      #t
      (and (ordenado-tree? (car bosque))
           (ordenado-bosque? (cdr bosque)))))


; Demostración
(display "\nEjercicio 2.a\n")
(display "(ordenado-tree? '(10 (5) (7)))): ")
(display (ordenado-tree? '(10 (5) (7))))
(newline)

; Pruebas
(check-true (ordenado-tree? '(10 (5) (7))))
(check-true (ordenado-tree? '(50 (10 (4) (6) (8)) (25 (15)))))
(check-false (ordenado-tree? '(10 (8) (7))))
(check-false (ordenado-tree? '(6 (5) (7))))
(check-false (ordenado-tree? '(50 (10 (4) (6) (11)) (25) (15))))


; función auxiliar
(define (and-lista lista)
  (fold-right (lambda(x y) (and x y)) #t lista))

; versión FOS
(define (ordenado-tree-FOS? tree)
  (and (ordenada-lista (append (map dato-tree (hijos-tree tree))
                               (list (dato-tree tree))))
       (and-lista (map ordenado-tree-FOS? (hijos-tree tree)))))

; Pruebas
(check-true (ordenado-tree-FOS? '(10 (5) (7))))
(check-true (ordenado-tree-FOS? '(50 (10 (4) (6) (8)) (25 (15)))))
(check-false (ordenado-tree-FOS? '(10 (8) (7))))
(check-false (ordenado-tree-FOS? '(6 (5) (7))))
(check-false (ordenado-tree-FOS? '(50 (10 (4) (6) (11)) (25) (15))))


; 2.b)
(define (operator op)
      (cond
          ((equal? op '+) +)
          ((equal? op '-) -)
          ((equal? op '*) *)
          ((equal? op '/) /)
          (else (error "Operador desconocido: " op))))


(define (calcula-tree tree)
  (if (hoja-tree? tree)
      (dato-tree tree)
      ((operator (dato-tree tree)) (calcula-tree (car (hijos-tree tree)))
                                   (calcula-tree (cadr (hijos-tree tree))))))

; Demostración
(display "\nEjercicio 2.b\n")
(display "(calcula-tree '(+ (- (5) (2)) (3)))): ")
(display (calcula-tree '(+ (- (5) (2)) (3))))
(newline)

; Pruebas
(check-equal? (calcula-tree '(+ (- (5) (2)) (3))) 6)
(check-equal? (calcula-tree '(* (- (2) (+ (3) (* (4) (- (6) (2))))) (1))) -17)





;--------------------------
; Ejercicio 3
;--------------------------



(define (nivel-dato-tree dato tree)
  (aux-nivel-dato-tree dato tree 1))

(define (aux-nivel-dato-tree dato tree n)
  (cond ((equal? (dato-tree tree) dato) n)
        (else (nivel-dato-bosque dato (hijos-tree tree) n))))

(define (nivel-dato-bosque dato bosque n)
  (if (null? bosque)
      0
      (max (aux-nivel-dato-tree dato (car bosque) (+ n 1))
           (nivel-dato-bosque dato (cdr bosque) n))))


; Demostración
(display "\nEjercicio 3.a\n")
(display "(nivel-dato-tree 30 '(20 (18) (19 (30) (32)) (4))): ")
(display (nivel-dato-tree 30 '(20 (18) (19 (30) (32)) (4))))
(newline)

; Pruebas
(check-equal? (nivel-dato-tree 30 '(20 (18) (19 (30) (32)) (4))) 3)
(check-equal? (nivel-dato-tree 'g '(a (b) (c (d) (e)) (f))) 0)
(check-equal? (nivel-dato-tree 4 '(20 (18) (19 (30) (32)) (4))) 2)


; 3.b)
; función auxiliar
(define (inicio-palabras pal lista)
  (map (lambda(elem) (string-append pal elem)) lista))

; Versión con recursión mútua
(define (palabras-tree tree)
  (if (hoja-tree? tree)
      (list (symbol->string (dato-tree tree)))
      (inicio-palabras (symbol->string (dato-tree tree)) 
                       (palabras-bosque (hijos-tree tree)))))

(define (palabras-bosque bosque)
  (if (null? bosque)
      '()
      (append (palabras-tree (car bosque)) (palabras-bosque (cdr bosque)))))


; Demostración
(display "\nEjercicio 3.b\n")
(display "(palabras-tree '(c (a (s (a) (o))) (o (l (a)) (m (o))) (e (n (a))))): ")
(display (palabras-tree '(c (a (s (a) (o))) (o (l (a)) (m (o))) (e (n (a))))))
(newline)

; Pruebas
(check-equal? (palabras-tree '(c (a (s (a) (o))) (o (l (a)) (m (o))) (e (n (a))))) 
              '("casa" "caso" "cola" "como" "cena"))


; Versión FOS
(define (palabras-tree-FOS tree)
  (if (hoja-tree? tree)
      (list (symbol->string (dato-tree tree)))
      (inicio-palabras (symbol->string (dato-tree tree)) 
                       (fold-right append '() (map palabras-tree-FOS (hijos-tree tree))))))

; Pruebas
(check-equal? (palabras-tree-FOS '(c (a (s (a) (o))) (o (l (a)) (m (o))) (e (n (a))))) 
              '("casa" "caso" "cola" "como" "cena"))


;--------------------------
; Ejercicio 4
;--------------------------

; 4.a)
; Una posible solución (hay muchas):
(define p1 (cons (cons 'a
                       (cons 'c
                             (cons 'borrar 'd)))
                 'e))
(define x (cons p1 (cdr (cdr (car p1)))))
(set-car! (cdr x) (cdr (car (car x))))


; 4.b)
(set-car! (cdr x) x)
(set-cdr! (car x) (cdr x))
(set-car! (cdr (car (car x))) (cdr x))




;--------------------------
; Ejercicio 5
;--------------------------

; 5.a)
(define (rellena-lista! lista dato)
  (if (not (null? lista))
      (begin
        (set-car! lista dato)
        (rellena-lista! (cdr lista) dato))))

; Demostración
(display "\nEjercicio 5.a\n")
(define lista '(1 2 3 4))
(rellena-lista! lista 'a)
(display "(rellena-lista! '(1 2 3 4) 'a): ")
(display lista)
(newline)

; Pruebas
(check-equal? lista '(a a a a))


; 5.b)
(define (intercambia-listas! lista1 lista2)
  (if (and (not (null? lista1))
           (not (null? lista2)))
      (let ((aux (car lista1)))
        (set-car! lista1 (car lista2))
        (set-car! lista2 aux)
        (intercambia-listas! (cdr lista1) (cdr lista2)))))
                                              
  
; Demostración
(display "\nEjercicio 5.b\n")
(define lista1 '(1 2 3 4 5))
(define lista2 '(a b c))
(intercambia-listas! lista1 lista2)
(display "(intercambia-listas! '(1 2 3 4 5) '(a b c)): ")
(newline)
(display "lista1:")
(display lista1)
(newline)
(display "lista2:")
(display lista2)
(newline)

; Pruebas
(check-equal? lista1 '(a b c 4 5))
(check-equal? lista2 '(1 2 3))
