# SPASE-Machine

Instructions for setting up the main SMWT-IHDEA machine.

## Summary

The machine contains several repositories and miscellaneous files related to certain tasks:
### Needed for everything
- Overall ubuntu environment package-lock.json
- The <a href="https://github.com/spase-group/spase-scripts" target="_blank">spase-scripts</a> repo

### Generating the landing pages and backing up all SPASE records to the cloud.
- The landing page repo, <a href="https://github.com/hpde/hpde.io" target="_blank">hpde.io</a>
- The <a href="https://github.com/spase-group/spase-generate-pages" target="_blank">spase-generate-pages</a> repo
- Cron file specifying automated jobs
- The <a href="https://github.com/hpde/NASA" target="_blank">NASA SPASE records</a> repo
- The <a href="https://github.com/hpde/SMWG" target="_blank">SMWG SPASE records</a> repo

### All repositories related to updating the SPASE Schema
- The <a href="https://github.com/spase-group/spase-base-model" target="_blank">spase-base-model</a> repo
- The <a href="https://github.com/spase-group/spase-model-tools" target="_blank">spase-model-tools</a> repo
- The <a href="https://github.com/spase-group/website" target="_blank">website</a> repo
- The <a href="https://github.com/spase-group/spase-model-tools-node" target="_blank">spase-model-tools-node</a> repo

## Prerequisites
Setup a Ubuntu EC2 instance using <a href="https://portal.hsdcloud.org/" target="_blank">HelioCloud's Daskhub</a> with size >= "m5a.2xlarge", along with a matching key pair. Then, follow the instructions provided to SSH into the machine.


## Installation
1. Clone all the above repositories by downloading and running the clone_repos.sh script: 
    - `wget https://github.com/spase-group/spase-machine/blob/main/clone_repos.sh` followed by `bash clone_repos.sh`.
2. Download the crontab.job and package-lock.json files to the same location on your machine where these repos were cloned.
    - `wget https://github.com/spase-group/spase-machine/blob/main/crontab.job`
    - `wget https://github.com/spase-group/spase-machine/blob/main/package-lock.json`
3. Install necessary Node packages from the package-lock.json file using the `npm ci` command.
4. Install Python 3.8 or later
    - `sudo apt update && sudo apt upgrade -y`
    - `sudo apt install python3 python3-pip python3-venv python3-dev -y`


## Additional Setup
- Move the spase-base-model, spase-model-tools, and website repos to be within a single directory called 'spase-model'
    - `mkdir spase-model`
    - `mv spase-base-model spase-model/`
    - `mv spase-model-tools spase-model/`
    - `mv website spase-model/`

- Link the EC2 machine to the SPASE Backups s3 bucket:
    - Use the `aws sts get-caller-identity` command within the machine to get the necessary info needed for the below steps.
    - On the AWS Dashboard:
        - Create a new IAM role for EC2 access
        - Grant the role ListBucket, Get, Put, Delete object permissions over the bucket (bucket policy)
        - Assign the newly created role to the EC2 machine via "Modify IAM role"

- Verify that cron is installed and automatically activates upon startup
    - `sudo apt update && sudo apt install cron -y`
    - `sudo systemctl enable cron`
    - `sudo systemctl start cron`
- Ensure that the backup and generation of the landing pages jobs are properly defined in the crontab file using the `crontab -l` command. If they do not match what is found in the crontab file from this repo, use `crontab -e` to add them (via vim).