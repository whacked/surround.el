;;; surround.el -- add simple surround.vim functionality without evil/vimpulse dependencies
;;;
;;; This file is under the Gnu Public License.
;;;

;;; Commentary:

;; Currently provides a change-surrounding function that copies surround.vim
;; I eval (load-file "surround.el") for this single function now.
;;
;; `surround-change-wrap'  ...  change a surrounding from one wrap to another
;;                              supposed to emulate `ci)` etc. keystroke
;;
;;             'the brown lazy fox jumps o|ver the quick red dog.'
;; C-ci '" ... "the brown lazy fox jumps o|ver the quick red dog."
;; C-ci ") ... (the brown lazy fox jumps o|ver the quick red dog.)
;; C-ci )} ... {the brown lazy fox jumps o|ver the quick red dog.}
;; etc.
;;
;; for things like `ds)` behavior, paredit does the trick
;; 
;; -- natto 2012-07-16 23:47:46
;;
;; do something like this after load
;; (global-set-key "\C-cs" 'surround-change-wrap)

(defun surround-change-wrap ()
  (interactive)
  (flet ((get-match (R)
                    (cond ((string= R ")") "(")
                          ((string= R "]") "[")
                          ((string= R "}") "{")
                          (t R))))
    (let* ((wrap-R (char-to-string (read-char "from what: ' \" ) ] } >")))
           (wrap-L (get-match wrap-R))
           (wrap-R+ (char-to-string (read-char (concat "from [" wrap-R "] to: ' \" ) ] } >"))))
           (wrap-L+ (get-match wrap-R+))
           )
      (save-excursion
        (forward-char)
        (search-backward wrap-L)
        (delete-char 1)
        (insert wrap-L+)
        (search-forward wrap-R)
        (backward-delete-char 1)
        (insert wrap-R+)
        )
      ))
  )

