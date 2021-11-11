#!/bin/bash

ssh admin@$(cd ../tf && terraform output -raw compute_public_ip)
