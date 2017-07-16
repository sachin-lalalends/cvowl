    <?php
defined('BASEPATH') OR exit('No direct script access allowed');

class Resume extends CI_Controller {
    
    public function index()
    {
        $this->load->view("Resumes/rubenbaker");
    }
    
    public function test($x = 1){
        if($x){
            $this->load->view("Resumes/resume_final");
        }else{
            $texttt= $this->load->view("Resumes/resume_final",'',TRUE);
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
    }
    
    public function james()
    {
        $this->load->view("Resumes/resume_final");
    }

    public function buildPDf(){
        
        
    } 
}