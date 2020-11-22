(setq doom-font (font-spec :family "Iosevka Term SS04" :size 16 :weight 'Regular)
      doom-big-font (font-spec :family "Iosevka Term SS04" :size 24 :weight 'Regular)
      doom-variable-pitch-font (font-spec :family "SF Pro Text"))

(setq doom-theme 'doom-nord)

(setq display-line-numbers-type 'relative)

(setq user-full-name "Lydien SANDANASAMY"
      user-mail-address "s.lydien@icloud.com")

(add-hook! org-mode 'writeroom-mode)

(setq org-directory "~/MEGA/org/")

(setq org-roam-directory "~/MEGA/org/roam/")
