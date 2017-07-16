<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Summary extends CI_Controller {
    
    public function __construct() {
        parent::__construct();
        if(!$this->session->userdata('user_id'))
        {
            redirect("/Home");
        }
    }

    public function index(){
        $this->load->model('Data_model','data');
        $result = $this->data->get(array('table'=>'tags_summary','where'=>array('1'=>'1'),'select'=>array('id','tag_name')));
        $tag_summary = $this->data->result;
        $this->data->result = false;
        $result = $this->data->get(array('table'=>'tags_skills','where'=>array('1'=>'1'),'select'=>array('id','tag_name')));
        $skills = $this->data->result;
        $this->load->view('add_summary_view',array('tags'=>$tag_summary,'skill_tags'=>$skills));
    }
    
    public function suggestion(){
        $tags = $this->input->post('t');
        $exp = $this->input->post('e');
        $limit = $this->input->post('l');
        if(!ctype_digit($exp))
        $exp = 1;
        if(!ctype_digit($limit)){
            $limit = 2;
        }
        else{
            $limit = $limit*2;
        }
        
        $this->load->model("data_model","data");
        $result = $this->data->query(['query'=>"SELECT xref.summary_id  FROM tags_summary
                                    LEFT JOIN summary_tag_XREF as xref
                                    ON xref.tag_id = tags_summary.id
                                    WHERE `tag_name` LIKE ?",'data'=>array('%'.$tags.'%')]);
        if(!$result){
            die(json_encode(array("resp"=>0,"msg"=>"No result found")));
        }
        $summary_id = [];
        foreach ($this->data->result as $key => $value) {
            # code...
            if($value->summary_id){
                array_push($summary_id, $value->summary_id);
            }
            
        }
        
        if(count($summary_id)){

            $result = $this->data->query(['query'=>"SELECT sl.summary_name as summary  
                                    FROM summary_list as sl
                                    WHERE FIND_IN_SET(?,`sl`.`summary_for`) AND `sl`.`id` IN (".implode(',', $summary_id).") LIMIT $limit",'data'=>[$exp]]);
            if($result){
                die(json_encode(array("resp"=>1,"msg"=>$this->data->result,"count"=>count($this->data->result))));
            }else{
                die(json_encode(array("resp"=>0,"msg"=>"No result found")));
            }

            
        }else{
            die(json_encode(array("resp"=>0,"msg"=>"No result found")));
        }
    }

    public function addsummary(){
        $summary = $this->input->post('summary_text', TRUE);
        $for = $this->input->post('summary_for', TRUE);
        $tags = $this->input->post('summary_tag', TRUE);
        if(!isset($tags) || !is_array($tags)){
            die(json_encode(['resp'=>0,'msg'=>'Empty Summary tags']));
        }
        if(!isset($for) || !is_array($for)){
            die(json_encode(['resp'=>0,'msg'=>'Empty Summary for']));

        }
        $this->load->model('Data_model','data');
        $set = $this->data->set(array('table'=>'summary_list','data'=>array('summary_name'=>$summary,'summary_for'=>implode(',', $for))));     
        if($set){
            foreach ($tags as $key => $value) {
                # code...
                $this->data->set(['table'=>'summary_tag_XREF','data'=>['summary_id'=>$set,'tag_id'=>$value]]);
            }
        }else{
            die(json_encode(['resp'=>0,'msg'=>'Unable to add summary']));
        }
        die(json_encode(['resp'=>1,'msg'=>'Summary Added successfully']));
    }

    public function addjobskill(){
        $title = $this->input->post('job_title', TRUE);
        $tags = $this->input->post('skill_tag', TRUE);
        if(!isset($tags) || !is_array($tags)){
            die(json_encode(['resp'=>0,'msg'=>'Empty Skill tags']));
        }

        if($title == ''){
            die(json_encode(['resp'=>0,'msg'=>'Empty title']));
        }

        $this->load->model('Data_model','data');
        $rec = $this->data->get(array('table'=>'job_has_skills','where'=>array('job_title'=>$title)));
        if($rec){
            $str = implode(',', $tags);
            $str = $rec->skill_set.",".$str;
            $upd = $this->data->upd(array('table'=>'job_has_skills','data'=>array('skill_set'=>$str),'where'=>array('job_title'=>$title))); 
            if($upd){
                die(json_encode(['resp'=>1,'msg'=>'Skill updated for '.$title]));
            }else{
                die(json_encode(['resp'=>1,'msg'=>'Skill not updated for '.$title]));
            }
        }else{
            $set = $this->data->set(array('table'=>'job_has_skills','data'=>array('job_title'=>$title,'skill_set'=>implode(',', $tags))));     
            if($set){            
                die(json_encode(['resp'=>1,'msg'=>'Skill Added for '.$title]));
            }else{
                die(json_encode(['resp'=>0,'msg'=>'Unable to add']));
            }
        }
        
    }

    public function addnewtag(){
        $this->load->model('Data_model','data');
        $tag = $this->input->post('tag_name', TRUE);
        if(!isset($tag)){
            die(json_encode(['resp'=>0,'msg'=>'Invalid tag name']));
        }
        $set = $this->data->set(array('table'=>'tags_summary','data'=>array('tag_name'=>$tag)));   
        if($set){
            die(json_encode(['resp'=>1,'msg'=>'Summary Added successfully']));
        }else{
            die(json_encode(['resp'=>0,'msg'=>'Summary Unable to add']));
        }
    }

    public function addnewskill(){
        $this->load->model('Data_model','data');
        $tag = $this->input->post('tag_name', TRUE);
        if(!$tag){
            die(json_encode(['resp'=>0,'msg'=>'Invalid tag name']));
        }
        $get = $this->data->get(array('table'=>'tags_skills','where'=>array('tag_name'=>$tag))); 
        if($get){
            die(json_encode(['resp'=>0,'msg'=>'Skill Already exist']));
        }
        $set = $this->data->set(array('table'=>'tags_skills','data'=>array('tag_name'=>$tag)));   
        if($set){
            die(json_encode(['resp'=>1,'msg'=>'Skill Added successfully']));
        }else{
            die(json_encode(['resp'=>0,'msg'=>'Skill Unable to add']));
        }
    }
}