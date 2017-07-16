<?php
$opauth_lib_dir = dirname(__FILE__) . '/Opauth/';
require $opauth_lib_dir . 'Opauth.php';

class Opauth_lib {

    private $configurations;
    private $opauth_obj;

    public function __construct($configurations) {
           $this->configurations = $configurations;
    }

    public function initialize() {
       $this->opauth_obj = new Opauth();
       $this->opauth_obj->run();
   }
}
