<?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Test extends CI_Controller {
	
	public function __construct() {
        parent::__construct();
    }

	
	public function index()
	{
		$this->load->model('Data_model','data');
		$result = $this->data->get(array('table'=>'tags_summary','where'=>array('1'=>'1'),'select'=>array('id','tag_name')));
    	$this->load->view('add_summary_view',array('tags'=>$this->data->result));
    }
}
