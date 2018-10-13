# Spelling Bee CLI

Inspired by https://www.nytimes.com/puzzles/spelling-bee

## About

A project to learn more about Ruby and CLI. Based on the New York Times Spelling Bee game. 

## Word Lists

The current configuration uses the word list provided here: https://diginoodles.com/The_English_Open_Word_List_%28EOWL%29

A list of valid words is saved in [validwords.txt](words/validwords.txt). The list of valid pangrams (generated from the list of valid words) is also saved at [validpangrams.txt](words/validpangrams.txt). The word lists can be re-generated using `spellingbee -b` when running the application.
