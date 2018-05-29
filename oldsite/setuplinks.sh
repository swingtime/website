#!/bin/sh

cd members/
ln -s -f ../create.pl .
ln -s -f ../global.css .
ln -s -f ../icons .
ln -s -f ../.cvsignore .

cd TEMPLATES/
ln -s -f ../../TEMPLATES/MENU_TEMPLATE.HTML .
ln -s -f ../../TEMPLATES/SUBMENU_TEMPLATE.HTML .
ln -s -f ../../TEMPLATES/HOME_TEMPLATE.HTML .
ln -s -f ../../TEMPLATES/MAIN_TEMPLATE.HTML .

cd ../DATA/
ln -s -f ../../DATA/CAL_Current_Season.TXT CAL_Calendar.TXT

cd ../TMP/
ln -s -f ../../TMP/.cvsignore .

cd ../GIGS/
ln -s -f ../../.cvsignore .
