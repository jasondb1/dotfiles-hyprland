for ((i=1; i<=100; i++))
{
    echo $i
    echo "# Remaining $((100-i))% to finish the job"
    sleep 0.2
} | yad --progress --pulsate --center --percentage=0 --log-expanded --enable-log --width=500 --height=200 --size=fit --text="testing..." --button=cancel:0 --auto-kill --auto-close
