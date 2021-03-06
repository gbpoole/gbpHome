
# Set-up some generic UNIX stuff
umask 22
limit coredumpsize 0
unset autologout

# It is possible to install this repo somewhere
# other than the home directory.  Set the path
# to the repo directory here.
setenv GBP_HOME ${PWD}

# Make sure the DISPLAY variable is set
if (!(${?DISPLAY}) && ${?REMOTEHOST}) then
   setenv DISPLAY ${REMOTEHOST}:0.0
endif

# Set all system-specific stuff
source ${GBP_HOME}/.system.csh

# These lines set-up gbpCode
setenv GBP_SRC  ${GBP_HOME}'/gbpCode/'
if ( -f ${GBP_SRC}/.cshrc.myCode ) then
  source ${GBP_SRC}/.cshrc.myCode
else if ( -f ${GBP_SRC}/.cshrc.gbpCode ) then
  source ${GBP_SRC}/.cshrc.gbpCode
endif
setenv PATH  ${GBP_SRC}/my_code/bin/:$PATH

# Add 3rd_Party binary directory to the PATH
setenv PATH ${GBP_HOME}/3rd_Party/bin/:$PATH

# Create all my aliases
source ${GBP_HOME}/.alias.csh

# Set the prompt
setprompt

