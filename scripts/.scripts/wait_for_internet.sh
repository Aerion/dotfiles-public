#!/bin/sh

while ! ping -c 1 1.1.1.1; do
    sleep 1
done
