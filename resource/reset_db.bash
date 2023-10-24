#!/bin/bash


rm db.sqlite3
sqlite3 db.sqlite3 < resource/create_db.sql
