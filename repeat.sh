# An alternative to `watch` command in bash with logging for recording change.

# watch bash call.sh |tee outputs.log

#bash call.sh | sed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g"

# set -ex

# on MacOS:
# brew install gnu-sed
# sed -> gsed

# set -ex


#watch bash call.sh  | tee -a outputs.log
#| gsed -r "s/\x1B\[([0-9]{1,3}(;[0-9]{1,2})?)?[mGK]//g"   \

#watch -d -c bash call.sh  | tee -a outputs.log
#watch -d -c bash call.sh  >>  outputs.log
#watch -d -c bash call.sh  | bash killcolors.sh | tee -a outputs.log
#watch -d -c bash call.sh  | tee -a outputs.log

# #!/bin/bash

# external commands: grc
COMMAND="bash call.sh"
DELAY_SEC="0.4"

# clean up
rm -f outputs.log
touch outputs.log
rm -f changes.log
touch changes.log

# init temp files
rm -f last-out.temp
rm -f curr-out.temp
touch last-out.temp
touch curr-out.temp

while true
do
  echo . # keep runnning

  $COMMAND >curr-out.temp
  #date >>curr-out.temp

  cat curr-out.temp

  grc diff last-out.temp curr-out.temp
  diff last-out.temp curr-out.temp >diff.temp
  [ -s diff.temp ] && date >>changes.log
  cat diff.temp >>changes.log
  cp curr-out.temp last-out.temp

  date >>outputs.log
  cat curr-out.temp >>outputs.log
  rm -f curr-out.temp

  sleep $DELAY_SEC
done
