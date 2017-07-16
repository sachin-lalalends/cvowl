<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

/**
 * getGUID 
 *
 * @return	GUID
 *
 */
 if(! function_exists('getGUID'))
 {
	function getGUID()
	{
		mt_srand((double)microtime()*10000);
		$charid = strtoupper(md5(uniqid(rand(), true)));
		$uuid = substr($charid, 0, 8)
			.substr($charid, 8, 4)
			.substr($charid,12, 4)
			.substr($charid,16, 4);
		return $uuid;
	}
 }
 ?>