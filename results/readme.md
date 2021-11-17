## Create report

```bash
# Download results from instances
ansible-playbook -i ../inventory/aws -v ./report.yml

# Upload results to GitHub Gist
./create_report.sh
```
