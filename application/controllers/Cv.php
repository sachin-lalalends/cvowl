<?php
if (!defined('BASEPATH'))
    exit('No direct script access allowed');
    
class Cv extends CI_Controller {
    
    public function __construct() {
        parent::__construct();
        if(!$this->session->userdata('user_id')){
            redirect("/Home");
        }
    }
    
    public function builder(){
        

        $this->load->model('data_model','data');
        $template = $this->data->get(array('table'=>'cv_templates','where'=>array('id'=>3)));
        
        $error = false;
        $result = $this->data->get(array('table'=>'jobseeker_profiles', 'where'=>array('user_id'=>$this->session->userdata('user_id')), 'select'=>array('active_resume_id')));
        if($result)
        {
            $this->session->set_userdata(array(
                                     'resume_id'  => $result->active_resume_id));
            $result = $this->data->get(array('table'=>'jobseeker_resumes', 'where'=>array('user_id'=>$this->session->userdata('user_id'),"id"=>$result->active_resume_id)));
            if($result){
            }else{
                $error  = "No resume for this user found #1";
            }
        }
        else
        {
            $error  = "No resume for this user found #2";
        }
        $this->load->view('loginheader_view',$data = ['tab' => 'makeyourcv','framework'=>$template->template_framework,'resume_data'=>json_encode($result->user_resume),'error'=>$error,'modified_dt'=>time()]);
        $this->load->view('builder_view');
        $this->load->view('loginfooter_view',['slidepanel_url'=>'/static/classic/topbar/tpl/sections.tpl']);
    }

    public function coverletter(){
        
        $this->load->model('data_model','data');
        $template = $this->data->get(array('table'=>'cv_templates','where'=>array('id'=>5)));
        
        $error = false;
        $result = $this->data->get(array('table'=>'jobseeker_profiles', 'where'=>array('user_id'=>$this->session->userdata('user_id')), 'select'=>array('active_resume_id')));
        if($result)
        {
            $this->session->set_userdata(array(
                                     'resume_id'  => $result->active_resume_id));
            $result = $this->data->get(array('table'=>'jobseeker_resumes', 'where'=>array('user_id'=>$this->session->userdata('user_id'),"id"=>$result->active_resume_id)));
            if($result){
            }else{
                $error  = "No resume for this user found #1";
            }
        }
        else
        {
            $error  = "No resume for this user found #2";
        }
        $this->load->view('loginheader_view',$data = ['tab' => 'makeyourcv','framework'=>$template->template_framework,'resume_data'=>json_encode($result->user_resume),'error'=>$error,'modified_dt'=>time()]);
        $this->load->view('coverletter_view');
        $this->load->view('loginfooter_view',['slidepanel_url'=>'/static/classic/topbar/tpl/COVER_LETTER.tpl']);
    }
    
    public function buildPDf(){
        
            $texttt= rawurldecode($this->input->post('html'));
            $pdfFilePath = $this->session->userdata('user_id').".pdf";
            //load mPDF library
            $this->load->library('m_pdf');
            if($this->input->post('size') == 'Letter'){
                $pdf = $this->m_pdf->load('Letter');
            }else{
                $pdf = $this->m_pdf->load('');
            }
            
            $pdf->WriteHTML($texttt);

            //offer it to user via browser download! (The PDF won't be saved on your server HDD)
            $pdf->Output($pdfFilePath, "D");
    }  
    
    public function sync() {
        $data = $this->input->post("data");
        $this->load->model('data_model','data');
        $upd = $this->data->upd(array('table'=>'jobseeker_resumes','data'=>array("user_resume"=>$data),'where'=>array('user_id'=>$this->session->userdata('user_id'))));
        if($upd){
            die(json_encode(['resp'=>1,'msg'=>'All changes saved']));
        }else{
            die(json_encode(['resp'=>1,'msg'=>'All changes saved']));
        }
    }
    
    public function logout(){
    	$this->session->sess_destroy();
    	redirect('/Home');
    }
    
}