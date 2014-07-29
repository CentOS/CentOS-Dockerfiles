#!/bin/bash

__run_supervisor() {
supervisord -n
}

# Call all functions
__run_supervisor

