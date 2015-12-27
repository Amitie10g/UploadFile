<?php

// Set the Error reporting if you need
//error_reporting(E_ERROR | E_WARNING | E_PARSE /*| E_NOTICE */);
error_reporting(E_ALL ^ E_NOTICE);

$user = '';
$password = '';
$project = ''; // http(s)://<wiki_url>/w/api.php
$homepath = ''; // For security reasons, only for Web version
$alias = '';
$font-size='14pt'

require_once('lib/web.php');
?>