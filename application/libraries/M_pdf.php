<?php if (!defined('BASEPATH')) exit('No direct script access allowed');
class M_pdf {

    public function __construct() {
        $CI = & get_instance();
        log_message('Debug', 'mPDF class is loaded.');
        
    }
 
    function load($param=NULL)
    {

    	include_once APPPATH.'/third_party/mpdf/mpdf.php';
    	if($param == 'Letter'){
			return new mPDF('','LETTER',0,'',2,2,10,10,0);
    	}else{
    		return new mPDF('','A4',0,'',2,2,10,10,0);
    	}
        
        
    }
}   