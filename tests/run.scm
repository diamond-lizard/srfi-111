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

(import test)

(import srfi-111)

(test-group "Box Mutable"
	(let ((tbox #f))
    (test-assert (make-box (void)))
    (set! tbox (make-box (void)))
    (test-assert (box? tbox))
    (box-set! tbox #t)
    (test-assert (box-ref tbox))
    (test-assert (not (box? 3))) )
)

(test-group "Box Immutable"
	(let ((tbox #f))
    (test-assert (make-box #f #t))
    (set! tbox (make-box #f #t))
    (test-assert (box? tbox))
    (test-assert (not (box-ref tbox)))
    (test-error (box-set! tbox #t)) )
)

(test-group "Box References"
	(let ((var (void))
        (tbox #f))
    (test-assert (make-box-variable var))
    (set! tbox (make-box-variable var))
    (test-assert (box? tbox))
    (test-assert (box-variable? tbox))
    (test-assert (not (box-location? tbox)))
    (test "Unbound Box" (void) (box-ref tbox))
    (set! (box-ref tbox) #t)
    (test-assert "Bound Box" (box-ref tbox))
    (test-assert "Bound Var" var)
    (test-assert (not (box? 3))) )
)

(test-group "Box Swap"
	(let ((tbox #f))
    (test-assert (make-box (void)))
    (set! tbox (make-box 0))
    (test-assert (box? tbox))
    (test 1 (box-swap! tbox + 1))
    (test 1 (box-ref tbox))
    (test 2 (box-swap! tbox add1))
    (test 2 (box-ref tbox)) )
)

(test-exit)
