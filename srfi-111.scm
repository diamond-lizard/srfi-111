;;;; srfi-111.scm  -*- Scheme -*-
;;;; Kon Lovett, Apr '20

;; Issues
;;

(module srfi-111

(;export
  box box? unbox set-box!
  immutable-box)

(import scheme
  (chicken base)
  (only (chicken platform) register-feature!)
  (only box-core box? make-box-mutable make-box-immutable box-ref box-set!))

;;

(define box           make-box-mutable)
(define immutable-box make-box-immutable)
(define unbox         box-ref)
(define set-box!      box-set!)

;;

(register-feature! 'srfi-111)

) ;module srfi-111
