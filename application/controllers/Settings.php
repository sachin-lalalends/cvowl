<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Settings extends CI_Controller {
    
    public function __construct() {
        parent::__construct();
        if(!$this->session->userdata('user_id'))
        {
            redirect("/Home");
        }
    }
    
    public function index(){
        $this->load->view('loginheader_view',$data = array('tab' => 'settings'));
        $this->load->view('settings_view');
        $this->load->view('loginfooter_view');
        
    }
    
    public function changepassword(){
        if($this->input->is_ajax_request() && $this->input->method(TRUE) == 'POST'){
            
            $old_pass = $this->input->post('old_password', true);
            $new_pass = $this->input->post('new_password', true);
            $this->load->model("data_model","data");
            if(($old_pass != $new_pass) && (strlen($new_pass) > 5)){
                
                $user = $this->data->get(array('table'=>'user_logins','where'=>array('id'=>$this->session->userdata('user_id'),'is_active'=>1)));
                if($user && $user->login_pass == md5($old_pass)){
                    $upd = $this->data->upd(array("table"=>"user_logins", "data"=>array("login_pass"=>md5($new_pass)), "where"=>array("id"=>$user->id, "is_active"=>1)));
                    die(json_encode(array("resp"=>1,"msg"=>"Password changed successfully")));
                }else{
                    die(json_encode(array("resp"=>0,"msg"=>"Invalid password")));
                }
                
            }else{
              die(json_encode(array("resp"=>0,"msg"=>"Old and new passwords should be different and more than 5 characters")));
            }
        }else{
            redirect("/");
        }
      }
    
    
    public function resendConfEmail(){
        if($this->input->is_ajax_request() && $this->input->method(TRUE) == 'POST'){
            $this->load->model("data_model",'data');
            $this->load->helper('general_helper');
            $this->load->library('encryption');
            $this->load->library('Aws','','aws');
            $guid = getGUID();
            $this->data->upd(array("table"=>"auth_token",'where'=>['email_id'=>$this->session->userdata('email'),"action"=>'VERIFYEMAIL'],"data"=>array("is_active"=>"0")));
            $set = $this->data->set(array("table"=>"auth_token","data"=>array("token"=>$guid, "action"=>'VERIFYEMAIL','email_id'=>$this->session->userdata('email'), "is_active"=>"1")));
            // insert this guid in db;
            if($set){
              $mail = $this->aws->signupmail([$this->session->userdata('email')],$guid,"");
              die(json_encode(array('resp'=>1,'msg'=>'Email Sent')));
            }else{
                die(json_encode(array('resp'=>0,'msg'=>'Unable to send Email')));
            }
            
        }else{
            redirect("/");
        }
    }
}