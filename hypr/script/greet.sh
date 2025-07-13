#!/usr/bin/env bash

# sapa berdasarkan waktu
hour=$(date +%H)

if (( 10#$hour < 6 )); then
    greet="malam"
elif (( 10#$hour < 12 )); then
    greet="pagi"
elif (( 10#$hour < 15 )); then
    greet="siang"
elif (( 10#$hour < 18 )); then
    greet="sore"
else
    greet="malam"
fi

echo "$greet, $1"