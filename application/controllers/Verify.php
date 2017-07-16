<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Verify extends CI_Controller {
	
	public function __construct() {
        parent::__construct();
    }

	
	public function index()
	{
	    $guid = $this->input->get('guid',true);
	    $this->load->model('data_model','data');
    	if($guid != null && $guid != ""){
    	    $rec = $this->data->get(['table'=>'auth_token','where'=>['token'=>$guid,'is_active'=>1]]);
    	    if($rec){
    	        $upd = $this->data->upd(['table'=>'auth_token','where'=>['token'=>$guid],'data'=>['is_active'=>0]]);
    	        if($upd){
    	            
    	                switch($rec->action){

    	                    case 'VERIFYEMAIL': 
    	                        $upd = $this->data->upd(['table'=>'user_logins','where'=>['login_email'=>$rec->email_id],'data'=>['email_verified'=>1]]);
	                            $this->session->sess_destroy();
	                            redirect('');
    	                        break;

    	                    case 'FORGOTPASS': 
                                $upd = $this->data->upd(['table'=>'user_logins','where'=>['login_email'=>$rec->email_id],'data'=>['email_verified'=>1]]);
                                $this->session->set_userdata(array('forgot_email'=>$rec->email_id));
                                $this->load->view('forgotpass_view');
                                break;

    	                    default : die('Default');
    	                }
    	            
    	        }else{
	                die("something went wrong #2");
	            }
    	    }else{
                redirect('');
            }
    	}else{
    	    redirect('');
    	}
    }
}
