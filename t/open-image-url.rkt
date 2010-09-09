#lang racket/base

(require "../require-permission.rkt"
         net/url
         racket/list
         racket/file
         racket/path
         racket/port
         racket/class
         racket/gui/base
         racket/contract
         (for-syntax racket/base))


(require-permission "permission:network")


(begin-for-syntax
  (printf "open-image-url compile time!\n"))

(printf "open-image-url run time\n")


(provide/contract [open-image-url (string? . -> . (is-a?/c image-snip%))])
(define (open-image-url a-url-string)
  (let* ([url (string->url a-url-string)]
         [ip (get-pure-port url)]
         [filename (path/param-path (last (url-path url)))]
         [temp-file-path (normalize-path (make-temporary-file (format "~~a-~a" filename)))])
    (dynamic-wind
     (lambda ()
       (copy-port ip (open-output-file temp-file-path #:exists 'truncate)))
     (lambda ()
       (make-object image-snip% (make-object bitmap% temp-file-path)))
     (lambda ()
       (delete-file temp-file-path)))))

