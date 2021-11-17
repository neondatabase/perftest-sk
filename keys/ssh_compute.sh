#!/bin/bash

ssh -A admin@$(cd ../terraform && terraform output -raw compute_public_ip)
