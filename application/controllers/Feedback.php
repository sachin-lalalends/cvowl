<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Feedback extends CI_Controller {
    
    public function __construct() {
        parent::__construct();
        if(!$this->session->userdata('user_id'))
        {
            redirect("/Home");
        }
        
    }
    
    public function submit(){
        if($this->input->is_ajax_request() && $this->input->method(TRUE) == 'POST'){
        
            $message = $this->input->post('message', TRUE);
            if(!$message)
            {
                die(json_encode(array("resp"=>0,"msg"=>"Invalid message")));
            }
            
            $this->load->model("data_model","data");
            $set = $this->data->set(['table'=>'user_feedback','data'=>['user_id'=>$this->session->userdata('user_id'),'message'=>$message]]);
            !$set && die(json_encode(['resp'=>0,'msg'=>'Unable to submit feedback. Sorry Please try later']));
            
            die(json_encode(['resp'=>1, 'msg'=>'Your feedback is successfully submitted']));
            
        }else{
            redirect('/');
        }
    }
}