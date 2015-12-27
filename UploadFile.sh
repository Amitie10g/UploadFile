#!/usr/bin/php
<?php

// Set the Error reporting if you need
//error_reporting(E_ERROR | E_WARNING | E_PARSE /*| E_NOTICE */);
error_reporting(E_ALL ^ E_NOTICE);

$user = '';
$password = '';
$project = ''; // http(s)://<wiki_url>/w/api.php
$homepath = ''; // For security reasons, only for Web version
$alias = '';

// Set bold text in the console. Comment these lines in non-vt100-compatible terminal (like Windows cmd)
$bs="\033[1m"; // \033[1m
$be="\033[m"; // \033[m

require_once('lib/cli.php');
?>