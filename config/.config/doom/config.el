(setq doom-font (font-spec :family "monospace" :size 16 :weight 'Regular)
      doom-big-font (font-spec :family "monospace" :size 24 :weight 'Regular)
      doom-variable-pitch-font (font-spec :family "sans" :size 20 :weight 'Regular))

(setq doom-theme 'doom-nord)

(setq display-line-numbers-type 'relative)

(setq user-full-name "Lydien SANDANASAMY"
      user-mail-address "s.lydien@icloud.com")

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(defun lydien/org-mode-setup ()
  (org-indent-mode)
  (mixed-pitch-mode 1)
  (visual-line-mode 1)
  (display-line-numbers-mode 0))

(defun lydien/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(add-hook! org-mode
      (load-theme 'doom-nord t)
      (custom-set-faces!
        '(outline-1 :weight Medium :height 200)
        '(outline-2 :weight Medium :height 190)
        '(outline-3 :weight Medium :height 180)
        '(outline-4 :weight Medium :height 170)
        '(outline-5 :weight Medium :height 160)
        '(outline-6 :weight Medium :height 160))
      (lydien/org-mode-setup)
      (lydien/org-mode-visual-fill))

(setq org-directory "~/MEGA/org/"
      org-archive-location (concat org-directory ".archive/%s::")
      org-roam-directory (concat org-directory "notes/")
      org-roam-db-location (concat org-roam-directory ".org-roam.db")
      org-journal-encrypt-journal t
      org-journal-file-format "%d%m%Y.org"
      org-startup-folded 'overview
      org-ellipsis " ▾" )

(setq org-superstar-headline-bullets-list '("◉" "○" "●" "○" "●" "○" "●"))

(require 'org-tempo)
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("el" . "emacs-lisp"))
(add-to-list 'org-structure-template-alist '("py" . "python"))

(after! ivy-posframe
(setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-window-center))))
;; (setq ivy-posframe-display-functions-alist '((t . ivy-posframe-display-at-frame-center)))
