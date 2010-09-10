#lang racket/base

(require racket/contract
         racket/runtime-path
         syntax/modresolve)

(provide/contract [query-module-permissions
                   (module-path? . -> . (listof string?))])

(define-runtime-path record.rkt "record.rkt")


;; query-module-permissions: module-path -> (listof string)
;; Given a module, see what permissions it is declaring.
(define (query-module-permissions a-module-path)
  (let ([resolved-path (resolve-module-path a-module-path #f)])
    (parameterize ([current-namespace (make-base-empty-namespace)])
      (dynamic-require a-module-path (void)) ;; get the compile-time code running.
      ((dynamic-require-for-syntax record.rkt 'lookup) resolved-path))))
  

#;(query-module-permissions "t/open-image-url.rkt")
#;(query-module-permissions "t/foo.rkt")
#;(query-module-permissions "t/play-sound.rkt")