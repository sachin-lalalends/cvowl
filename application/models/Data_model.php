<?php if ( ! defined('BASEPATH')) exit('No direct script access allowed');

class Data_model extends CI_model
{
	public $result = false;
	public function set($p)
	{
        $db = $this->load->database('default',true);
        $qry = $db->insert($p['table'],$p['data']);
		if($db->affected_rows() > 0)
		{
			return $db->insert_id();
		}
		else
		{
			return false;
		}
	}
	
	public function set_batch($p)
	{
		$db = $this->load->database('default',true);
		$qry = $db->insert_batch($p['table'],$p['data']);		
		if($db->affected_rows() > 0)
		{
			return true;
		}
		else
		{
			return false;
		}		
	}
	
	public function upd($p)                 
	{
        $db = $this->load->database('default',true);
		$qry = $db->update($p['table'],$p['data'],$p['where']);
		;
		if($db->affected_rows() > 0)
		{ 
			return true;
		}
		else
		{
			return false;
		}
	}
	
	public function del($p)                 
	{
        $db = $this->load->database('default',true);
		$qry = $db->delete($p['table'],$p['where']);
		if($db->affected_rows() > 0)
		{
			return true;
		}
		else
		{
			return false;
		}
	}
	
	public function get($p)
	{
        $db = $this->load->database('default',true);
        if(array_key_exists('limit',$p))
        {
        	$db->limit($p['limit']);
        }
        if(array_key_exists('select',$p))
        {
        	$db->select($p['select']);
        }
        if(array_key_exists('distinct',$p))
        {
        	$db->distinct();
        }
        if(array_key_exists('orderby',$p))
        {
        	$db->order_by($p['orderby']['col'],$p['orderby']['order']);
        }
        if(array_key_exists('groupby',$p))
        {
        	$db->group_by($p['groupby']);
        }
        if(array_key_exists('where_in',$p))
        {
        	$db->where_in($p['where_in']['key'],$p['where_in']['value']);
        }
        if(array_key_exists('or_where_in',$p))
        {
        	$db->or_where_in($p['or_where_in']['key'],$p['or_where_in']['value']);
        }
        if(array_key_exists('or_like',$p))
        {
        	$db->or_like($p['or_like']['key'],$p['or_like']['value']);
        }
		$qry = $db->get_where($p['table'],$p['where']);
		if($qry->num_rows() > 0)
		{
			$this->result = $qry->result();
			return $qry->row();
		}
		else
		{
			return false;
		}
	}

	public function query($p)
	{
		$db = $this->load->database('default',true);
		$qry = $db->query($p['query'],$p['data']);
		if($qry->num_rows() > 0)
		{	
			$this->result = $qry->result();
			return $qry->row();
		}
		else
		{
			return false;
		}
	}
	
	public function fetchSummary($p)
	{
        $db = $this->load->database('default',true);
        if(array_key_exists('limit',$p))
        {
        	$db->limit($p['limit']);
        }
        if(array_key_exists('select',$p))
        {
        	$db->select($p['select']);
        }
        if(array_key_exists('distinct',$p))
        {
        	$db->distinct();
        }
        if(array_key_exists('orderby',$p))
        {
        	$db->order_by($p['orderby']['col'],$p['orderby']['order']);
        }
        if(array_key_exists('groupby',$p))
        {
        	$db->group_by($p['groupby']);
        }
        if(array_key_exists('where_in',$p))
        {
        	$db->where_in($p['where_in']['key'],$p['where_in']['value']);
        }
        
        if(array_key_exists('or_where_in',$p))
        {
        	foreach($p['or_where_in'] as $key=>$val){
        		$db->or_where_in($key,$val);
        	}
        	
        }
        if(array_key_exists('or_like',$p))
        {
        	$db->or_like($p['or_like']['key'],$p['or_like']['value']);
        }
		$qry = $db->get_where($p['table'],$p['where']);
		if($qry->num_rows() > 0)
		{
			$this->result = $qry->result();
			return $qry->row();
		}
		else
		{
			return false;
		}
	}
}