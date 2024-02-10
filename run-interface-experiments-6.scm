(load "mk-vicare.scm")
(load "mk.scm")

(define appendo
  (lambda (l s ls)
    (conde
      ((== '() l) (== s ls))
      ((fresh (a d res)
         (== (cons a d) l)
         (== (cons a res) ls)
         (appendo d s res))))))

(run* (l s) (appendo l s '(a b c)))
'((() (a b c)) ((a) (b c)) ((a b) (c)) ((a b c) ()))


(define my-stream #f)

;; () -> 'done | value
;; effect: mutates my-stream
(define (next)
  (unless my-stream
    (error 'next "whoops!"))
  (let-values (((new-stream result) (take-1-k my-stream)))
    (set! my-stream new-stream)
    result))

(define (take-1-k stream)
  (case-inf (stream)
    (() (values (lambda () #f) 'done))
    ((f) (take-1-k f))
    ((c) (values (lambda () #f) c))
    ((c f) (values f c))))

(define (reify-as-a-goal q)
  (lambda (st)
    (let ((st (state-with-scope st nonlocal-scope)))
      (let ((z ((reify q) st)))
        (cons z (lambda () (lambda () #f)))))))

(define (run-a-little-rt goal)  
  (set! my-stream (suspend (goal empty-state)))
  (next))

(define-syntax run-a-little
  (syntax-rules ()
    [(_ (q) g0 g ...)
     (run-a-little-rt
      (fresh (q) g0 g ...
        (reify-as-a-goal q)))]
    [(_ (x x* ...) g0 g* ...)
     (run-a-little (q)
       (fresh (x x* ...)
         (== (list x x* ...) q)
         g0 g* ...))]))

#!eof

(load "run-interface-experiments-6.scm")

(run-a-little (l s) (appendo l s '(1 2 3)))
'(() (1 2 3))

(next)
'((1) (2 3))

(next)
'((1 2) (3))

(next)
'((1 2 3) ())

(next)
'done

(next)
'done
