#/!bin/bash

avgfile() {
	DIRNAME=$1
	SUM=0
	q=0
		if [[ -d $DIRNAME ]];then
			for file in  $DIRNAME/*;do
				if [[ -f $file && ! -h $file ]];then
					((SUM += $(stat -c %s $file)))
					((q++))
				fi
			done
			if [[ $q -eq 0 ]];then
				echo fuck_zero
			else
			echo $SUM
			echo $q
			echo $((SUM/q))
			fi
		else
			return 1
		fi

}

avgfile /home/docz/

