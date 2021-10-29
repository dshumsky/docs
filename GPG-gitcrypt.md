### GPG
gpg --list-keys
gpg --export-secret-keys <key_id> > exportedKeyFilename.asc


##### List of git-crypt keys 
for key in .git-crypt/keys/default/0/* ; do gpg -k $(echo $(basename $key) | sed -e 's/.gpg//') ; done ;


