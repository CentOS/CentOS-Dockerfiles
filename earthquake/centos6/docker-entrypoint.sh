#!/bin/bash

earthquake_bin=$(scl enable ruby193 'gem contents earthquake | grep bin')
exec scl enable ruby193 "$earthquake_bin"
