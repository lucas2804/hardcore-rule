# Hypervisor: The software process provide infrasstructure
#     contain virtual machine
# Host machine: A computer that runs a Hypervisor
# Guest machine:
#     A virtual machine that runs within the hypervisor
#     "that we define with Vagrant"
#     "often entirely different OS and environments"
#
# Vagrant: tool that makes managing these virtual machines simplers and available in code
#     Simply a framework to manage virtual machine
#
#
# ------------ Init Environment ----------------
# 1) Run in your specific directory
# vagrant init puppetlabs/ubuntu-14.04-32-nocm
#
# 2) If exist an image
# -> To run default machine is being started with VirtualBox provider
# vagrant up
# vagrant halt #keeping the env for later use
# vagrant destroy #discarding the entire working env
#

# ---------- Vargant ---------------------------
# 1) Command line Utility enable to people who want cho manage VM
# 2)
#
# ----------  Fix error vagrant 1.8.5 ---------
# vargrant ssh
# #password : vargrant
# vargrant
# chmod 700 ~/.ssh
# chmod 600 ~/.ssh/authorized_keys
# chown -R vagrant:vagrant ~/.ssh
#
#
#
#
