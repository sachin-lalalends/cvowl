<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Share extends CI_Controller {
    
    public function __construct() {
        parent::__construct();
        if(!$this->session->userdata('user_id'))
        {
            redirect("/Home");
        }
        
    }
    
    public function index(){
        if($this->input->is_ajax_request() && $this->input->method(TRUE) == 'POST'){
        
            $email = $this->input->post('proposedEmails');
            if(!filter_var($email, FILTER_VALIDATE_EMAIL))
            {
                die(json_encode(array("resp"=>0,"msg"=>"Invalid Input")));
            }
            
            $this->load->model("data_model","data");
            
            // check if its already shared
            $isShared = $this->data->get(array("table"=>"cv_share","where"=>array("user_id"=>$this->session->userdata('user_id'),"share_email"=>$email),"select"=>array("created_dt")));
            
            if($isShared)
            {
                die(json_encode(array("resp"=>1,"msg"=>"You CV is already shared at ".$isShared->created_dt)));
            }
            
            $result = $this->data->get(array("table"=>"user_logins","where"=>array("login_email"=>$email)));
            
            if($result)
            {
                
                if($result->is_active)
                {
                    $shareID = $this->data->set(array("table"=>"cv_share","data"=>array("user_id"=>$this->session->userdata("user_id"),"share_email"=>$email,"is_cloneable"=>1)));
                    
                    if($shareID)
                    {
                        die(json_encode(array("resp"=>1,"msg"=>"Shared Successfully")));
                    }
                    else
                    {
                        die(json_encode(array("resp"=>0,"msg"=>"Technical Error")));
                    }
                }
                else
                {
                    // send mail with share notification
                    die(json_encode(array("resp"=>0,"msg"=>"User is blacklisted")));
                    
                }
            }
            else
            {
                die(json_encode(array("resp"=>0,"msg"=>"No result found")));
            }
        }else{
            redirect('/');
        }
    }
    
    public function get(){
        if($this->input->is_ajax_request() && $this->input->method(TRUE) == 'POST'){
            $this->load->model('data_model','data');
            $isShared = $this->data->get(array("table"=>"cv_share","where"=>array("user_id"=>$this->session->userdata("user_id")),"select"=>array("share_email","created_dt")));
            $isShared = $this->data->result;
            $this->data->result = false;
            $isClonable = $this->data->get(array("table"=>"cv_share","where"=>array("share_email"=>$this->session->userdata("email_id"))));
            $isClonable = $this->data->result;
            die(json_encode(array("resp"=>1,"sharedTo"=>$isShared,"sharedFrom"=>$isClonable)));
        }else{
            redirect('/');
        }
    }
}