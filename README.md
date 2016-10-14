# Ember.js Framework [Website](http://emberjs.com)

### Terms (used below)
- Host: Your Computer
- Guest: The VM (accessed through terminal)

### Usage Instructions
1. Call vagrant up
2. vagrant ssh
3. ember server (This takes 2-3 minutes to load)
4. From your host, go to http://localhost:8000
5. If you see "Congratulations, you made it", you're all set.

### Commit Message Format
- \<#task | #issue-number\> \[\<initials\>\] \<Descriptive Message\> 

###### examples:
- #task [az] Update Readme
- #12 [az] minor bug fix in survey.js

### Making Changes
- after updating the VagrantFile, 'vagrant reload' needs to be run
- after updating any Chef files, 'vagrant provision' needs to be run

