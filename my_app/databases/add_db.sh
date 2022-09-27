#!/bin/sh
SQLITE="sqlite3 /db/music_bank"
DATA="CREATE TABLE 'music_bank' ( 'id' number primary key,'titre' varchar(255) default NULL,'artiste' varchar(255) default NULL,'chemin_music' varchar(255)) AUTO_INCREMENT=1;"
QUI=".quit"

$SQLITE; $DATA; $QUI