<?php

# alias dps="docker ps -a --format \"{{.ID}}\t{{.State}}\t{{.Status}}\t\t\t{{.Names}}\""
$containers = "docker ps -a --format \"{{.ID}}\"";
$ids = explode("\n",shell_exec($containers));
array_pop($ids);

for($i=0;$i<=count($ids)-1;$i++) {
		$data = shell_exec("docker inspect ".$ids[$i]);
		$container = json_decode($data,true)[0];

		// if($container['State']['Status'] == "running" && $container['Name']=="/backends-balerion-1") {
		// 	var_dump($container);
		// }

		$runningSince = fuzzytime($container['State']['StartedAt']);
		$health = isset($container['State']['Health']['Status']) ? healthCheck($container['State']['Health']['Status']) : colorize("Unknown","info");

		$line = printf(
			"%s %s %s %s\t%s \n",
			substr($container['Id'],0,12),
			str_pad($container['State']['Status'],8),
			str_pad($runningSince,24),
			str_pad(substr($container['Name'],1),34),
			str_pad($health,11),
		);
}

function healthCheck(string $health): string {
	
	if($health === "") {
		return "Unknown";
	}

	$health = strtolower($health);

	if($health == "healthy") {
		return colorize("Healthy","success");
	}

	if($health == "unhealthy") {
		return colorize("Unhealthy","error");
	}

	return colorize(ucfirst($health),"warning");
}

function colorize(string $message,$color = 'info') {
    switch ($color) {
        case 'error': //error
            return "\033[31m$message \033[0m";
        break;
        case 'success': //success
            return "\033[32m$message \033[0m";
        break;
        case 'warning': //warning
            return "\033[33m$message \033[0m";
        break;  
        case 'info': //info
            return "\033[36m$message \033[0m";
        break;      
    }
}

function fuzzytime(string $time): string {
	$epoch = strtotime($time);
	$now      = new DateTime('now');
    $date     = new DateTime(date('Y-m-d H:i:s', $epoch), $now->getTimezone());
    $interval = $date->diff($now);

    if (($i = $interval->y) > 0)
    {
    	$i_str = $i + 1 . ' years';
    }
    elseif (($i = $interval->m) > 0) 
    {
    	$i_str = ($i > 10) ? '1 year' : $i + 1 . ' months';
    }
    elseif (($i = $interval->d) > 0)
    {
    	$i_str = ($i > 29) ? '1 month' : $i + 1 . ' days';
    }
    elseif (($i = $interval->h) > 0) 
    {
    	$i_str = ($i > 22) ? '1 day' : $i + 1 . ' hours';
    }
    elseif (($i = $interval->i) > 0)
    {   
    	$i_str = ($i > 58) ? '1 hour' : $i + 1 . ' minutes';
    }
    elseif (($i = $interval->s) > 0)
    {   
    	$i_str = ($i > 58) ? '1 minute' : $i + 1 . ' seconds';
    }
    else 
    {
    	return 'just now';
    }

    return (($i < 11) ? 'less than ' : '') . $i_str . ' ago';
}