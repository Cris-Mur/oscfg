#!/bin/bash

wget https://raw.githubusercontent.com/oneKelvinSmith/monokai-emacs/master/monokai-theme.el
mkdir -p ~/.emacs.d/themes/
mv monokai-theme.el ~/.emacs.d/themes/
