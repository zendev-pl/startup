<?php

require("vendor/autoload.php");
$config['beanstalkd']['host'] = 'localhost';
$config['beanstalkd']['port'] = 11300;

$queue =  new Pheanstalk_Pheanstalk($config['beanstalkd']['host'] . ":" . $config['beanstalkd']['port']);
$queue->watch("mytube");


$vendors = scandir('./vendor', 1);
var_dump($vendors);