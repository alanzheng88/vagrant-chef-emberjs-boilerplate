# Ember.js Framework [Website](http://emberjs.com)

### Terms (used below)
Host: Your Computer
Guest: The VM (accessed through terminal)

### Getting Started
1. Run vagrant up (Note that it may seem to hang after "==> default:  minimatch@2.0.10: Please update to minimatch 3.0.2 or higher to avoid a RegExp DoS issue" but this is because it is installing in the background)
2. vagrant ssh
3. cd /home/ubuntu/project/webroot/
4. ember server (This takes 2-3 minutes to load)
5. From your host, access: http://localhost:8000
6. If you see "Congratulations, you made it", you're all set.

### Making Changes
- after updating the VagrantFile, 'vagrant reload' needs to be run
- after updating any Chef files, 'vagrant provision' needs to be run

### Change Logs

##### October 9
- configure Vagrant file to install ember.js and its dependencies
