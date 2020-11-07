; Copyright (C) 2009-2018 Kon Lovett. All rights reserved.
;
; Permission is hereby granted, free of charge, to any person
; obtaining a copy of this software and associated documentation files
; (the Software), to deal in the Software without restriction,
; including without limitation the rights to use, copy, modify, merge,
; publish, distribute, sublicense, and/or sell copies of the Software,
; and to permit persons to whom the Software is furnished to do so,
; subject to the following conditions:
;
; The above copyright notice and this permission notice shall be
; included in all copies or substantial portions of the Software.
;
; THE SOFTWARE IS PROVIDED ASIS, WITHOUT WARRANTY OF ANY KIND, EXPRESS
; OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
; MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
; NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
; BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
; ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
; CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
; SOFTWARE.

(define EGG-NAME "box")

;chicken-install invokes as "<csi> -s run.scm <eggnam> <eggdir>"

(use files)

;no -disable-interrupts
(define *csc-options* "-inline-global -scrutinize -optimize-leaf-routines -local -inline -specialize -unsafe -no-trace -no-lambda-info -clustering -lfa2")

(define *args* (argv))

(define (test-name #!optional (eggnam EGG-NAME))
  (string-append eggnam "-test") )

(define (egg-name #!optional (def EGG-NAME))
  (cond
    ((<= 4 (length *args*))
      (cadddr *args*) )
    (def
      def )
    (else
      (error 'test "cannot determine egg-name") ) ) )

;;;

(set! EGG-NAME (egg-name))

(define (run-test #!optional (eggnam EGG-NAME) (cscopts *csc-options*))
  (let ((tstnam (test-name eggnam)))
    (print "*** csi ***")
    (system (string-append "csi -s " (make-pathname #f tstnam "scm")))
    (newline)
    (print "*** csc (" cscopts ") ***")
    (system (string-append "csc" " " cscopts " " (make-pathname #f tstnam "scm")))
    (system (make-pathname (cond-expand (unix "./") (else #f)) tstnam)) ) )

(define (run-tests eggnams #!optional (cscopts *csc-options*))
  (for-each (cut run-test <> cscopts) eggnams) )

;;;

(run-test)
