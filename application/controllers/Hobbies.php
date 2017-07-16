<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Hobbies extends CI_Controller {
    
    public function __construct() {
        parent::__construct();
        if(!$this->session->userdata('user_id'))
        {
            redirect("/Home");
        }
        
    }
    
    public function all()
    {
        if($this->input->is_ajax_request() && $this->input->method(TRUE) == 'POST'){
            
            $this->load->model("data_model","data");
            $result = $this->data->get(array("table"=>"hobbies","where"=>array("is_active"=>"1"),"select"=>array("hobbie_name as hobbie")));
            if($result){
                if($result){
                    die(json_encode(array("resp"=>1,"msg"=>$this->data->result,"count"=>count($this->data->result))));
                }else{
                    die(json_encode(array("resp"=>0,"msg"=>"No result found")));
                }
            }else{
                die(json_encode(array("resp"=>0,"msg"=>"No result found")));
            }
        }else{
            redirect("/");
        }
    
    }

    public function add()
    {
        if($this->input->is_ajax_request() && $this->input->method(TRUE) == 'POST'){
            $hobbie = $this->input->post('hobbie');
            if(ctype_alpha(str_replace(' ', '', $hobbie)) === false){
            	die(json_encode(array("resp"=>0,"msg"=>"Hobbie should contain only alphabets and not blank ")));
            }
            $this->load->model("data_model","data");
            $result = $this->data->get(array("table"=>"hobbies","where"=>array("hobbie_name"=>$hobbie)));
            if($result)
            {
                die(json_encode(array("resp"=>0,"msg"=>"Hobbie already exist")));
            }else{
            	$set = $this->data->set(array("table"=>"hobbies","data"=>array("hobbie_name"=>$hobbie,'is_active'=>0)));
                if($set){
                	die(json_encode(array("resp"=>1,"msg"=>"Hobbie has been submitted for review.")));
                }else{
                	die(json_encode(array("resp"=>0,"msg"=>"Unable to store new hobbie.")));
                }
            }
        }else{
            redirect("/");
        }    
    }
}