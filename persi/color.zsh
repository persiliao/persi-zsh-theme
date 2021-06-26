# Command Colors

echo=echo
for cmd in echo /bin/echo; do
    $cmd >/dev/null 2>&1 || continue
    if ! $cmd -e "" | grep -qE '^-e'; then
        echo=$cmd
        break
    fi
done
export CLISTART=$($echo -e "\033[")
export CLIEND="${CLISTART}0m"
export CLIDGREEN="${CLISTART}32m"
export CLIRED="${CLISTART}1;31m"
export CLIGREEN="${CLISTART}1;32m"
export CLIYELLOW="${CLISTART}1;33m"
export CLIBLUE="${CLISTART}1;34m"
export CLIMAGENTA="${CLISTART}1;35m"
export CLICYAN="${CLISTART}1;36m"
export CLISUCCESS="$CLIGREEN"
export CLIFAILURE="$CLIRED"
export CLIQUESTION="$CLIMAGENTA"
export CLIWARNING="$CLIYELLOW"
export CLIMSG="$CLICYAN"

function showSuccessMessage()
{
    local message=$1
    if [ -n ${message} ]; then
        echo -e "${CLISTART}${CLISUCCESS}${message}${CLIEND}"
    fi
}

function showFailureMessage()
{
    local message=$1
    if [ -n ${message} ]; then
        echo -e "${CLISTART}${CLIFAILURE}${message}${CLIEND}"
    fi
}