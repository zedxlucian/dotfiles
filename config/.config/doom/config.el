(setq doom-font (font-spec :family "monospace" :size 16)
      doom-variable-pitch-font (font-spec :family "sans"))

(setq doom-theme 'doom-one-light)

(setq display-line-numbers-type 'relative)

(setq user-full-name "Lydien SANDANASAMY"
      user-mail-address "s.lydien@icloud.com")

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(defun lydien/org-mode-setup ()
  (org-indent-mode)
  (visual-line-mode 1)
  (hide-mode-line-mode 1)
  (display-line-numbers-mode 0))

(defun lydien/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(add-hook! org-mode
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
(add-to-list 'org-structure-template-alist '("el" . "src emacs-lisp"))
(add-to-list 'org-structure-template-alist '("sh" . "src shell"))
(add-to-list 'org-structure-template-alist '("py" . "src python"))
