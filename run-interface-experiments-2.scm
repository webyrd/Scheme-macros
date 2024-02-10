;; abandoned--mutation was making it hard to refactor,
;; so first tame the mutation before pulling out
;; helpers from the macro

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


(define (make-next my-stream-box)
  (lambda ()
    (let ((old-stream (unbox my-stream-box)))
      (set-box! my-stream-box (old-stream))
      (case-inf (unbox my-stream-box)
        (()
         (begin
           (set-box! my-stream-box old-stream)
           'done))
        ((f) (next))
        ((c) c)
        ((c f)
         (begin
           (set-box! my-stream-box f)
           c))))))

(define-syntax run-a-little
  (syntax-rules ()
    [(_ next (q) g0 g ...)
     (begin
       (make-next)
       (define my-stream
         (suspend
          ((fresh (q) g0 g ...
             (lambda (st)
               (let ((st (state-with-scope st nonlocal-scope)))
                 (let ((z ((reify q) st)))
                   (cons z (lambda () (lambda () #f)))))))
           empty-state)))       
       (next))]
    [(_ next (x x* ...) g0 g* ...)
     (run-a-little next (q)
       (fresh (x x* ...)
         (== (list x x* ...) q)
         g0 g* ...))]))

#|
> (load "run-interface-experiments-2.scm")
> (run* (l s) (appendo l s '(a b c)))
((() (a b c)) ((a) (b c)) ((a b) (c)) ((a b c) ()))
> (run-a-little my-next (l s) (appendo l s '(1 2 3)))
(() (1 2 3))
> (my-next)
((1) (2 3))
> (my-next)
((1 2) (3))
> (my-next)
((1 2 3) ())
> (my-next)
done
> (my-next)
done
|#
