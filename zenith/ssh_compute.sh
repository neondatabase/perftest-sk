#!/bin/bash

ssh -A admin@$(cd ../tf && terraform output -raw compute_public_ip)
