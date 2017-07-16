<?php
defined('BASEPATH') OR exit('No direct script access allowed');

require_once 'vendor/google/apiclient/src/Google/Client.php';
require_once 'vendor/facebook/graph-sdk/src/Facebook/Facebook.php';


class Home extends CI_Controller {
  

	public function __construct() {
        parent::__construct();
        if($this->session->userdata('user_id'))
        {
            redirect("/cv/builder");
        }
        
    }

  private $default_entry = '{"Profile":{"firstName":"MARY","lastName":"JONES","birthDay":"6-Apr-1980","gender":"Female","maritalStatus":"Married","nationality":"American","picture":"/photos/original/missing.png","email":"mary.james@cvowl.com","phone":"555-322-7337","jobTitle":"ENTER YOUR DESIGNATION","summary":"You should use this section of your resume to summarize what makes you a good fit for an open position. It needs to be compelling and concise, approximately four to six lines. Summarize your skills  and experience in order for a prospective employer to quickly get a sense of the value you could offer.","facebookHandle":"","linkedinHandle":"","currentLocation":"Newyork","location":{"address":"1 square street, New York, USA","postalCode":"78967","city":"New York","countryCode":"+91","region":"India","country":"USA","state":"Northeastern United States "},"city":"City","type":"EXPERIENCED","coverletterDate":"6 Jan 2017"},"Experience":[{"end_date":"Present","is_active":1,"more_info1":"<p>This section of resume is where employers will look to see what jobs and job titles you\'ve held in the past, and will give employers a sense of your career arc</p><ul><li>Keep your experience tightly focused for the job you applying for.&nbsp;</li><li>Use measurable results wherever possible\r</li><li>Make it clear what results you achieved for your organization\'s goals and objectives.</li></ul>","order_prefs":999,"section_title1":"JOB TITLE HERE...","section_title2":"Company Name","section_title3":"Location","section_type":"EXPERIENCE","start_date":"Jan 2015"}],"Education":[{"end_date":"Oct 2014","is_active":1,"more_info1":"List your education in reverse order if you have a master’s and a bachelor’s degree, make sure\rto first list the master’s degree. You can also highlight any alternative education such as online learning or self directed training","order_prefs":999,"section_title1":"COURSE NAME","section_title2":"Institute Name","section_title3":"8.0 CGPA","section_type":"EDUCATION","start_date":"Oct 2012"}],"Skill":[{"is_active":1,"order_prefs":999,"section_title1":"Skill 1","section_title2":"Intermediate","section_type":"SKILL"},{"is_active":1,"order_prefs":999,"section_title1":"Skill 2","section_title2":"Expert","section_type":"SKILL"},{"is_active":1,"order_prefs":999,"section_title1":"Skills 3","section_title2":"Advanced","section_type":"SKILL"}],"Project":[{"end_date":"Jul ","is_active":1,"more_info1":"<div>Focus on a specific projects in which you successfully used your skills and abilities to create a beneficial outcome for a former employee and present projects as accomplishments.</div><ul><li>Briefly mention the background for the projects</li><li>Quantify the results of your projects</li><li>Highlight how your involvement led to the project exceeding its goals</li></ul>","order_prefs":999,"section_title1":"Institute/Company Name","section_title2":"PROJECT TITLE","section_title3":"Location","section_type":"PROJECT","start_date":"Oct "}],"Language":[],"Hobbies":[{"is_active":1,"order_prefs":999,"section_title1":"Archery","section_type":"HOBBIES"},{"is_active":1,"order_prefs":999,"section_title1":"Football","section_type":"HOBBIES"}],"Achievement":[],"Certification":[],"Volunteering":[],"Reference":[],"Worklinks":[{"websiteURL":"","is_active":0},{"portfolioURL":"","is_active":0},{"blogURL":"","is_active":0},{"slideshareURL":"","is_active":1}],"Coverletter":{"recruiterSal":"Ms. ","recruiterName":"ABC","companyName":"XYZ Inc.","address":"1 square street, New York, USA","description":"I read with interest you posting for [name of position] on the [name of the job board]. I believe I possess the necessary skills and experience you are seeking and would make a valuable addition to your company.<br>As my resume indicates, I possess more than [number of years] years of progressive experience in the [job field] field. My professional history includes position such as [job title] at [company name] as well as [job title] at [company name].<br>Most recently, my responsibilities as [job title] at [company name] match the qualifications you are seeking. As the [job title], my responsibilities included [two or three responsibilities which are similar to ones stated in job posting]. I assisted in the successful completion of [project which is similar to one that job posting stated you will work on]. My supervisor also relied on my ability to [skills such as proofreading and excellent communication skills].<br>I have attached my resume for your review and I look forward to speaking with you further regarding your available position.<br>"},"customSections":[]}';


	public function index(){
		$this->load->view('homepage_view');
	}

	public function signup(){


        $param = array();
        $param['emid'] = $this->input->post('email');
        $param['password'] = $this->input->post('pass');
        $param['fime'] = $this->input->post('firstName');
        $param['lame'] = $this->input->post('lastName');
        $output = array("new_login"=>0,"profile_created"=>0,"login_update"=>0,"already_exist"=>0,"resp"=>0, "technical_error"=>0,"msg"=>"");
        if(filter_var($param["emid"], FILTER_VALIDATE_EMAIL) || $param["fime"] != "" || strlen($param["password"]) > 6)
        {
            $this->load->model("data_model","data");
            $get = $this->data->get(array("table"=>"user_logins","where"=>array("login_email"=>$param["emid"])));
            if($get)
            {
                $output["msg"] = "User Already Exists";
                $output["already_exist"] = 1;
            }
            else
            {   
                $user_login = $this->data->set(array("table"=>"user_logins","data"=>array("login_email"=>$param["emid"], "login_pass"=>md5($param["password"]), "role_id"=>"1", "signup_dt"=>date('Y-m-d H:i:s'), "email_verified"=>"0", "is_active"=>"1")));
                if($user_login)
                {
                    $this->load->helper('general_helper');
                    
                    $this->load->library('Aws','','aws');
                    $guid = getGUID();
                    $set = $this->data->set(array("table"=>"auth_token","data"=>array("token"=>$guid, "action"=>'VERIFYEMAIL','email_id'=>$param["emid"], "is_active"=>"1")));
                    // insert this guid in db;
                    if($set){
                      $mail = $this->aws->signupmail([$param["emid"]],$guid,$param['fime']);
                    }

                    $output["new_login"] = 1;
                    $output["msg"] = "Account Created";
                    if(!isset($param["phne"]))
                    {
                      $param["phne"] = "";
                    }
                    if(!isset($param["lame"]))
                    {
                      $param["lame"] = "";
                    }
                    $user_profile = $this->data->set(array("table"=>"jobseeker_profiles","data"=>array("user_id"=>$user_login,"first_name"=>$param["fime"], "last_name"=>$param["lame"],"resume_data"=>$this->getResumedata($param["fime"],$param["lame"],$param["emid"]), "email_id"=>$param["emid"],"phone_number"=>$param["phne"],"created_dt"=>date('Y-m-d H:i:s'))));
                    $user_resume = $this->data->set(array("table"=>"jobseeker_resumes","data"=>array("user_id"=>$user_login,"user_resume"=>$this->getResumedata($param["fime"],$param["lame"],$param["emid"]))));
                    if($user_resume){
                      $this->data->upd(array('table'=>'jobseeker_profiles','data'=>array("active_resume_id"=>$user_resume),'where'=>array('user_id'=>$user_login)));
                    }


                    if($user_profile)
                    {
                        $output["msg"] = "Profile Created";
                        $output["profile_created"] = 1;
                        $login_update = $this->data->set(array("table"=>"login_history","data"=>array("user_id"=>$user_login, "login_dt"=>date('Y-m-d H:i:s'), "agent_string"=>"user agent","ip_address"=>$_SERVER['REMOTE_ADDR'])));
                        if($login_update)
                        {
                            $this->session->set_userdata(array(
                                       'user_id'  => $user_login,
                                       'email'     => $param["emid"],
                                       'verified'=>0,
                                       'logged_in' => TRUE
                                   ));
                            $output["msg"] = "login_successful";
                            $output["login_update"] = 1;
                            $output["resp"] = 1;
                        }
                    }
                    else
                    {
                        $output["msg"] = "Unable to create Profile";
                        $output["profile_created"] = 0;
                    }
                }
                else
                {
                    $output["msg"] = "Unable to create Account";
                    $output["technical_error"] = 1;
                }
            }
            
            
        }
        else
        {
            $output["msg"] = "Invalid Details";
        }
        
        die(json_encode($output)); 
  }

  public function login(){
      $email = $this->input->post('email');
      $pass = $this->input->post('pass');
      $param = array();
      $param['emid'] = $email;
      $param['pard'] = $pass;
      
      $output = array("login"=>0,"login_update"=>0,"resp"=>0, "technical_error"=>0,"msg"=>"");
      if(filter_var($param["emid"], FILTER_VALIDATE_EMAIL) || strlen($param["pard"]) > 6 )
      {
          $this->load->model("data_model","data");
          $get = $this->data->get(array("table"=>"user_logins","where"=>array("login_email"=>$param["emid"])));
          if($get != false && $get->login_pass == md5($param["pard"]))
          {
              $output["login"] = 1;
              $login_update = $this->data->set(array("table"=>"login_history","data"=>array("user_id"=>$get->id, "login_dt"=>date('Y-m-d H:i:s'), "agent_string"=>"user agent","ip_address"=>$_SERVER['REMOTE_ADDR'])));
              if($login_update)
              {
                  $this->session->set_userdata(array(
                                     'user_id'  => $get->id,
                                     'email'     => $param["emid"],
                                     'verified'=>$get->email_verified,
                                     'logged_in' => TRUE
                                 ));
                  $this->session->mark_as_temp('verified', 60);
                  $output["login_update"] = 1;
                  $output["resp"] = 1;
                  $output["msg"] = "Login Successful";
                  
              }
              else
              {
                  $output["technical_error"] = 1;
                  $output["msg"] = "Login Update Unsuccessful";
              }
          }
          else
          {
              $output["msg"] = "Invalid Email Password Combination";
          }
      }
      else
      {
              $output["msg"] = "Invalid Details";
          
      }
      
      die(json_encode($output));
  } 
  
  public function forgotpassword(){
    $email = $this->input->post('email');
    $this->load->model("Data_model","data");
    $rec = $this->data->get(array("table"=>"user_logins","where"=>array("login_email"=>$email),"select"=>array("id","login_email","is_active")));
    if(!$rec)
    {
    	die(json_encode(array("resp"=>0,"msg"=>"User does not exist")));
    }
    
    if($rec->is_active != 1){
    	die(json_encode(array("resp"=>0,"msg"=>"User is blocked. contact help.cvowl@gmail.com")));
    }
    
    $this->load->helper('general_helper');
                    
    $this->load->library('Aws','','aws');
    
    $guid = getGUID();
    $set = $this->data->set(array("table"=>"auth_token","data"=>array("token"=>$guid, "action"=>'FORGOTPASS','email_id'=>$email, "is_active"=>"1")));
    
    if($set){
      
      $mail = $this->aws->sendmail([$email],$guid);
    }
    
    if($mail){
      die(json_encode(array("resp"=>1,"msg"=>"Change password link has been sent to your email")));
    }else{
      die(json_encode(array("resp"=>0,"msg"=>"Contact help.cvowl@gmail.com. Technical error")));
    }
  }
  
  public function changepassword(){

    $newpass = $this->input->post('newpass', true);
    $confpass = $this->input->post('confpass', true);

    if($newpass != $confpass){
      die(json_encode(['resp'=>0,'msg'=>'password do not match']));
    }

    if(!$this->session->userdata('forgot_email')){
      var_dump($this->session->userdata('forgot_email'));
      die(json_encode(['resp'=>0,'msg'=>'Something Wrong']));
    }

    $this->load->model("data_model","data");
    
    
    
    if(strlen($newpass) > 5){
      $upd = $this->data->upd(array("table"=>"user_logins", "data"=>array("login_pass"=>md5($newpass),"email_verified"=>1), "where"=>array("login_email"=>$this->session->userdata('forgot_email'), "is_active"=>1)));
      $this->session->set_userdata(array('forgot_email'=>""));
      if($upd){
        die(json_encode(array("resp"=>1,"msg"=>"Password successfully changed")));
      }
      die(json_encode(array("resp"=>1,"msg"=>"Please try again")));
    }else{
      die(json_encode(array("resp"=>0,"msg"=>"Invalid password. Minimum lenght 5 character")));
    }
  }
  
  private function sendforgotmail($rec){
    $this->load->model('data_model','data');
    $date = date("Y-m-d H:i:s");
    $time = strtotime($date);
    $time = $time - (15 * 60);
    $date = date("Y-m-d H:i:s", $time);
    $otpsent = $this->data->get(array('table'=>'2fa_auth','where'=>array('user_id'=>$rec->id,"is_active"=>1,"created_dt > "=> $date)));
    if($otpsent){
      $this->load->library('Aws','','aws');
      $mail = $this->aws->sendmail([$rec->login_email],$otpsent->{"2fa_otp"});
      if($mail)return true;
      else return false;
    }
    else{
      $otp = mt_rand(1000, 9999);
      $upd = $this->data->upd(array("table"=>"2fa_auth", "where"=>array("user_id"=>$rec->id),"data"=>array("is_active"=>0)));
      $set = $this->data->set(array("table"=>"2fa_auth", "data"=>array("user_id"=>$rec->id,"is_active"=>1,"2fa_otp"=>$otp,"created_dt"=>date('Y-m-d H:i:s'))));
      if($set){
        $this->load->library('Aws','','aws');
        $mail = $this->aws->sendmail([$rec->login_email],$otp);
        if($mail)return true;
        else return false;
      }
    }
  }
  
  public function login_facebook(){
      
      $fb = new \Facebook\Facebook([
        'app_id' => '1177739742319479',
        'app_secret' => '6a0124b2efa7f5665b833c514899c664',
        'default_graph_version' => 'v2.5'
      ]);
      
      $helper = $fb->getRedirectLoginHelper();
      $permissions = ['email']; // optional
      $loginUrl = $helper->getLoginUrl('https://www.cvowl.com/home/login_callback_facebook', $permissions);
      
      redirect($loginUrl);   
  }

  public function login_callback_facebook(){
      
      $fb = new \Facebook\Facebook([
                'app_id' => '1177739742319479',
                'app_secret' => '6a0124b2efa7f5665b833c514899c664',
                'default_graph_version' => 'v2.5'
              ]);
              
      
      $helper = $fb->getRedirectLoginHelper();

      try {
        $accessToken = $helper->getAccessToken();
      } catch(Facebook\Exceptions\FacebookResponseException $e) {
        // When Graph returns an error
        echo 'Graph returned an error: ' . $e->getMessage();
        exit;
      } catch(Facebook\Exceptions\FacebookSDKException $e) {
        // When validation fails or other local issues
        echo 'Facebook SDK returned an error: ' . $e->getMessage();
        exit;
      }
      
      if (! isset($accessToken)) {
        if ($helper->getError()) {
          header('HTTP/1.0 401 Unauthorized');
          echo "Error: " . $helper->getError() . "\n";
          echo "Error Code: " . $helper->getErrorCode() . "\n";
          echo "Error Reason: " . $helper->getErrorReason() . "\n";
          echo "Error Description: " . $helper->getErrorDescription() . "\n";
        } else {
          header('HTTP/1.0 400 Bad Request');
          echo 'Bad request';
        }
        exit;
      }
      // The OAuth 2.0 client handler helps us manage access tokens
      $oAuth2Client = $fb->getOAuth2Client();
      
      // Get the access token metadata from /debug_token
      $tokenMetadata = $oAuth2Client->debugToken($accessToken);
      
      // Validation (these will throw FacebookSDKException's when they fail)
      $tokenMetadata->validateAppId('1177739742319479'); // Replace {app-id} with your app id
      // If you know the user ID this access token belongs to, you can validate it here
      //$tokenMetadata->validateUserId('123');
      $tokenMetadata->validateExpiration();
      
      if (! $accessToken->isLongLived()) {
        // Exchanges a short-lived access token for a long-lived one
        try {
          $accessToken = $oAuth2Client->getLongLivedAccessToken($accessToken);
        } catch (Facebook\Exceptions\FacebookSDKException $e) {
          echo "<p>Error getting long-lived access token: " . $helper->getMessage() . "</p>\n\n";
          exit;
        }
      
      }
      
      try {
        // Returns a `Facebook\FacebookResponse` object
        $response = $fb->get('/me?fields=id,name,email', (string) $accessToken);
      } catch(Facebook\Exceptions\FacebookResponseException $e) {
        echo 'Graph returned an error: ' . $e->getMessage();
        exit;
      } catch(Facebook\Exceptions\FacebookSDKException $e) {
        echo 'Facebook SDK returned an error: ' . $e->getMessage();
        exit;
      }
      
      $user = $response->getGraphUser();
      $param = array();
      $param['email'] = $user['email'];
      $param['name'] = $user['Name'];
      $this->signup_facebook($param);
  }

  public function login_google(){
      $client = new Google_Client();
      $client->setAuthConfigFile('client_secrets.json');
      $client->setRedirectUri('http://www.cvowl.com/home/login_callback_google');
      $client->addScope(Google_Service_Oauth2::USERINFO_EMAIL);
      
      if (isset($_SESSION['access_token']) && $_SESSION['access_token']) {
        $client->setAccessToken($_SESSION['access_token']);
        $oauth = new Google_Service_Oauth2($client);
        $user = $oauth->userinfo->get();
        $this->signup_google($user);
      } else {
        $auth_url = $client->createAuthUrl();
        header('Location: ' . filter_var($auth_url, FILTER_SANITIZE_URL));
      }
  }

  public function login_callback_google(){
      $client = new Google_Client();
      $client->setAuthConfigFile('client_secrets.json');
      $client->setRedirectUri('http://www.cvowl.com/home/login_callback_google');
      $client->addScope(Google_Service_Oauth2::USERINFO_EMAIL);
      
      if (! isset($_GET['code'])) {
        
        redirect('/home');
      } else {
        $client->authenticate($_GET['code']);
        $_SESSION['access_token'] = $client->getAccessToken();
        $oauth = new Google_Service_Oauth2($client);
        $user = $oauth->userinfo->get();
        $this->signup_google($user);
        
      }
  }
  
  public function login_linkedin(){
      $url = 'https://www.linkedin.com/uas/oauth2/authorization';
  
  		$params = array();
  		$params["client_id"] = "81daw31ionbseg";
  		$params["state"] = sha1(time());
  		$params["redirect_uri"] = "http://www.cvowl.com/home/linkedin_callback";
  		$params["response_type"] = "code";
  
  		//print_r($params);
  		
		 redirect($url.'?'.http_build_query($params, '', '&'));
  }

  public function linkedin_callback(){
    	if (array_key_exists('code', $_GET) && !empty($_GET['code'])){
    		$code = $_GET['code'];
    		$url = 'https://www.linkedin.com/uas/oauth2/accessToken';
    
    		$params = array(
    			'grant_type' => 'authorization_code',
    			'code' => $code,
    			'client_id' => "81daw31ionbseg",
    			'client_secret' => "Wa5dVVggmGVRvTax",
    			'redirect_uri' => "http://www.cvowl.com/home/linkedin_callback",
    		);
    		
    		$query = http_build_query($params, '', '&');
    		
    		$ch = curl_init();  
 
        curl_setopt($ch,CURLOPT_URL,$url);
        curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);
        curl_setopt($ch,CURLOPT_HEADER, false); 
        curl_setopt($ch, CURLOPT_POSTFIELDS, $query);    
     
        $response = curl_exec($ch);
     
        curl_close($ch);
        
    		$results = json_decode($response);
    
    		if (!empty($results) && !empty($results->access_token)){
    			$profile = $this->getProfile($results->access_token);
    		  
    			$this->signup_linkedin($profile);
    		}
    		else{
    			$error = array(
    				'code' => 'access_token_error',
    				'message' => 'Failed when attempting to obtain access token',
    				'raw' => array(
    					'response' => $response,
    				)
    			);
          redirect('/');
          //var_dump($error);
    			die("Please try again");
    		}
    		
    	}
    	else{
    		$error = array(
    			'code' => 'oauth2callback_error',
    			'raw' => $_GET
    		);
    
    		$this->errorCallback($error);
    	}
    }

  private function errorCallback($error){
    redirect('/');
  }
    
  private function signup_linkedin($p){
    
    $param = array("fime"=>"","lame"=>"","emid"=>"","jobtitle"=>"","profile_link"=>"","picture"=>"","phne"=>"","industry"=>"","headline");
    if($p["email-address"] != "" )
    {
      $param["emid"] = $p["email-address"];
    }
    if($p["last-name"] != "" )
    {
      $param["lame"]  = $p["last-name"];
    }
    if($p["first-name"] != "" )
    {
      $param["fime"]  = $p["first-name"];
    }
    if($p["headline"] != "" )
    {
      $param["jobtitle"]  = $p["headline"];
    }
    if($p["public-profile-url"] != "" )
    {
      $param["profile_link"]  = $p["public-profile-url"];
    }
    if($p["picture-url"] != "" )
    {
      $param["picture"]  = $p["picture-url"];
    }
    if($p["industry"] != "" )
    {
      $param["industry"]  = $p["industry"];
    }
    
    
    $output = array("new_login"=>0,"profile_created"=>0,"login_update"=>0,"already_exist"=>0,"resp"=>0, "technical_error"=>0,"msg"=>"");
    
    if(filter_var($param["emid"], FILTER_VALIDATE_EMAIL) || $param["fime"] != "")
      {
          $this->load->model("data_model","data");
          $output = array("new_login"=>0,"profile_created"=>0,"login_update"=>0,"already_exist"=>0,"resp"=>0, "technical_error"=>0,"msg"=>"");
          $get = $this->data->get(array("table"=>"user_logins","where"=>array("login_email"=>$param["emid"])));
          if($get)
          {
              $output["msg"] = "User Already Exists";
              $output["already_exist"] = 1;
              $login_update = $this->data->set(array("table"=>"login_history","data"=>array("user_id"=>$get->id, "login_dt"=>date('Y-m-d H:i:s'), "agent_string"=>"user agent","ip_address"=>$_SERVER['REMOTE_ADDR'])));
              $user_update = $this->data->upd(array("table"=>"user_logins","data"=>array("email_verified"=>1),'where'=>array('id'=>$get->id)));
              $this->session->set_userdata(array(
                                     'user_id'  => $get->id,
                                     'email'     => $get->login_email,
                                     'verified'=>1,
                                     'logged_in' => TRUE
                                 ));
              redirect('/home');
          }
          else
          {
              $user_login = $this->data->set(array("table"=>"user_logins","data"=>array("login_email"=>$param["emid"], "login_pass"=>md5("cvdexter123"), "role_id"=>"1", "signup_dt"=>date('Y-m-d H:i:s'), "email_verified"=>"1", "is_active"=>"1")));
              if($user_login)
              {
                  $output["new_login"] = 1;
                  $output["msg"] = "Account Created";
                  
                  //industry id need to be entered
                  $user_profile = $this->data->set(array("table"=>"jobseeker_profiles","data"=>array("user_id"=>$user_login,"first_name"=>$param["fime"], "last_name"=>$param["lame"], "email_id"=>$param["emid"],"phone_number"=>$param["phne"],"created_dt"=>date('Y-m-d H:i:s'))));
                  $user_resume = $this->data->set(array("table"=>"jobseeker_resumes","data"=>array("user_id"=>$user_login,"user_resume"=>$this->getResumedata($param["fime"],$param["lame"],$param["emid"]))));
                  if($user_resume){
                    $this->data->upd(array('table'=>'jobseeker_profiles','data'=>array("active_resume_id"=>$user_resume),'where'=>array('user_id'=>$user_login)));
                  }
                  if($user_profile)
                  {
                      $output["msg"] = "Profile Created";
                      $output["profile_created"] = 1;
                      $login_update = $this->data->set(array("table"=>"login_history","data"=>array("user_id"=>$user_login, "login_dt"=>date('Y-m-d H:i:s'), "agent_string"=>"user agent","ip_address"=>$_SERVER['REMOTE_ADDR'])));
                      if($login_update)
                      {
                          $this->session->set_userdata(array(
                                     'user_id'  => $user_login,
                                     'email'     => $param["emid"],
                                     'verified'=>1,
                                     'logged_in' => TRUE
                                 ));
                          $output["msg"] = "login_successful";
                          $output["login_update"] = 1;
                          $output["resp"] = 1;
                          
                          redirect("/cv/builder");
                      }
                  }
                  else
                  {
                      $output["msg"] = "Unable to create Profile";
                      $output["profile_created"] = 0;
                  }
              }
              else
              {
                  $output["msg"] = "Unable to create Account";
                  $output["technical_error"] = 1;
              }
          }
          
          
      }
      else
      {
          $output["msg"] = "Invalid Details";
      }
      
      die(json_encode($output)); 
  }
  
  private function signup_facebook($p){
    
    $param = array("fime"=>"","lame"=>"","emid"=>"");
    if($p["email"] != "" )
    {
      $param["emid"] = $p["email"];
    }
    
    $name = explode(" ",$p['name']);
    if($name[0] != "")
    {
      $param["fime"]  = $name[0];
      if($name[1] != ""){
        $param["lame"]  = $name[1];
      }else{
        $param["lame"] = null;
      }
    }
    
    
    
    $output = array("new_login"=>0,"profile_created"=>0,"login_update"=>0,"already_exist"=>0,"resp"=>0, "technical_error"=>0,"msg"=>"");
    
    if(filter_var($param["emid"], FILTER_VALIDATE_EMAIL) || $param["fime"] != "")
      {
          $this->load->model("data_model","data");
          $output = array("new_login"=>0,"profile_created"=>0,"login_update"=>0,"already_exist"=>0,"resp"=>0, "technical_error"=>0,"msg"=>"");
          $get = $this->data->get(array("table"=>"user_logins","where"=>array("login_email"=>$param["emid"])));
          if($get)
          {
              $output["msg"] = "User Already Exists";
              $output["already_exist"] = 1;
              $user_update = $this->data->upd(array("table"=>"user_logins","data"=>array("email_verified"=>1),'where'=>array('id'=>$get->id)));
              $login_update = $this->data->set(array("table"=>"login_history","data"=>array("user_id"=>$get->id, "login_dt"=>date('Y-m-d H:i:s'), "agent_string"=>"user agent","ip_address"=>$_SERVER['REMOTE_ADDR'])));
              $this->session->set_userdata(array(
                                     'user_id'  => $get->id,
                                     'email'     => $get->login_email,
                                     'verified'=>1,
                                     'logged_in' => TRUE
                                 ));
              redirect('/home');
          }
          else
          {
              $user_login = $this->data->set(array("table"=>"user_logins","data"=>array("login_email"=>$param["emid"], "login_pass"=>md5("cvdexter123"), "role_id"=>"1", "signup_dt"=>date('Y-m-d H:i:s'), "email_verified"=>"1", "is_active"=>"1")));
              if($user_login)
              {
                  $output["new_login"] = 1;
                  $output["msg"] = "Account Created";
                  
                  //industry id need to be entered
                  $user_profile = $this->data->set(array("table"=>"jobseeker_profiles","data"=>array("user_id"=>$user_login,"first_name"=>$param["fime"], "last_name"=>$param["lame"], "email_id"=>$param["emid"],"phone_number"=>$param["phne"],"created_dt"=>date('Y-m-d H:i:s'))));
                    $user_resume = $this->data->set(array("table"=>"jobseeker_resumes","data"=>array("user_id"=>$user_login,"user_resume"=>$this->getResumedata($param["fime"],$param["lame"],$param["emid"]))));
                    if($user_resume){
                      $this->data->upd(array('table'=>'jobseeker_profiles','data'=>array("active_resume_id"=>$user_resume),'where'=>array('user_id'=>$user_login)));
                    }
                  if($user_profile)
                  {
                      $output["msg"] = "Profile Created";
                      $output["profile_created"] = 1;
                      $login_update = $this->data->set(array("table"=>"login_history","data"=>array("user_id"=>$user_login, "login_dt"=>date('Y-m-d H:i:s'), "agent_string"=>"user agent","ip_address"=>$_SERVER['REMOTE_ADDR'])));
                      if($login_update)
                      {
                          $this->session->set_userdata(array(
                                     'user_id'  => $user_login,
                                     'email'     => $param["emid"],
                                     'verified'=>1,
                                     'logged_in' => TRUE
                                 ));
                          $output["msg"] = "login_successful";
                          $output["login_update"] = 1;
                          $output["resp"] = 1;
                          
                          redirect("/home");
                      }
                  }
                  else
                  {
                      $output["msg"] = "Unable to create Profile";
                      $output["profile_created"] = 0;
                  }
              }
              else
              {
                  $output["msg"] = "Unable to create Account";
                  $output["technical_error"] = 1;
              }
          }
          
          
      }
      else
      {
          $output["msg"] = "Invalid Details";
      }
      
      die(json_encode($output)); 
  }
  
  private function signup_google($p){
    
    $param = array("fime"=>"","lame"=>"","emid"=>"","gender"=>"","profile_link"=>"","picture"=>"","phne"=>"");
    if($p["email"] != "" )
    {
      $param["emid"] = $p["email"];
    }
    if($p["familyName"] != "" )
    {
      $param["lame"]  = $p["familyName"];
    }
    if($p["givenName"] != "" )
    {
      $param["fime"]  = $p["givenName"];
    }
    if($p["gender"] != "" )
    {
      $param["gender"]  = $p["gender"];
    }
    if($p["link"] != "" )
    {
      $param["profile_link"]  = $p["link"];
    }
    if($p["picture"] != "" )
    {
      $param["picture"]  = $p["picture"];
    }
    
    $output = array("new_login"=>0,"profile_created"=>0,"login_update"=>0,"already_exist"=>0,"resp"=>0, "technical_error"=>0,"msg"=>"");
    
    if(filter_var($param["emid"], FILTER_VALIDATE_EMAIL) || $param["fime"] != "")
      {
          $this->load->model("data_model","data");
          $output = array("new_login"=>0,"profile_created"=>0,"login_update"=>0,"already_exist"=>0,"resp"=>0, "technical_error"=>0,"msg"=>"");
          $get = $this->data->get(array("table"=>"user_logins","where"=>array("login_email"=>$param["emid"])));
          if($get)
          {
              $output["msg"] = "User Already Exists";
              $output["already_exist"] = 1;
              $login_update = $this->data->set(array("table"=>"login_history","data"=>array("user_id"=>$get->id, "login_dt"=>date('Y-m-d H:i:s'), "agent_string"=>"user agent","ip_address"=>$_SERVER['REMOTE_ADDR'])));
              $user_update = $this->data->upd(array("table"=>"user_logins","data"=>array("email_verified"=>1),'where'=>array('id'=>$get->id)));
              $this->session->set_userdata(array(
                                     'user_id'  => $get->id,
                                     'email'     => $get->login_email,
                                     'verified'=>1,
                                     'logged_in' => TRUE
                                 ));
              redirect('/home');
          }
          else
          {
              $user_login = $this->data->set(array("table"=>"user_logins","data"=>array("login_email"=>$param["emid"], "login_pass"=>md5("cvdexter123"), "role_id"=>"1", "signup_dt"=>date('Y-m-d H:i:s'), "email_verified"=>"1", "is_active"=>"1")));
              if($user_login)
              {
                  $output["new_login"] = 1;
                  $output["msg"] = "Account Created";
                  
                  $user_profile = $this->data->set(array("table"=>"jobseeker_profiles","data"=>array("user_id"=>$user_login,"first_name"=>$param["fime"], "last_name"=>$param["lame"], "email_id"=>$param["emid"],"phone_number"=>$param["phne"],"created_dt"=>date('Y-m-d H:i:s'))));
                    $user_resume = $this->data->set(array("table"=>"jobseeker_resumes","data"=>array("user_id"=>$user_login,"user_resume"=>$this->getResumedata($param["fime"],$param["lame"],$param["emid"]))));
                    if($user_resume){
                      $this->data->upd(array('table'=>'jobseeker_profiles','data'=>array("active_resume_id"=>$user_resume),'where'=>array('user_id'=>$user_login)));
                    }
                  if($user_profile)
                  {
                      $output["msg"] = "Profile Created";
                      $output["profile_created"] = 1;
                      $login_update = $this->data->set(array("table"=>"login_history","data"=>array("user_id"=>$user_login, "login_dt"=>date('Y-m-d H:i:s'), "agent_string"=>"user agent","ip_address"=>$_SERVER['REMOTE_ADDR'])));
                      if($login_update)
                      {
                          $this->session->set_userdata(array(
                                     'user_id'  => $user_login,
                                     'email'     => $param["emid"],
                                     'verified'=>1,
                                     'logged_in' => TRUE
                                 ));
                          $output["msg"] = "login_successful";
                          $output["login_update"] = 1;
                          $output["resp"] = 1;
                          
                          redirect("/cv/builder");
                      }
                  }
                  else
                  {
                      $output["msg"] = "Unable to create Profile";
                      $output["profile_created"] = 0;
                  }
              }
              else
              {
                  $output["msg"] = "Unable to create Account";
                  $output["technical_error"] = 1;
              }
          }
          
          
      }
      else
      {
          $output["msg"] = "Invalid Details";
      }
      
      die(json_encode($output));
  }
  
	private function getProfile($access_token){
  		if (empty($this->strategy['profile_fields'])) {
  			$this->strategy['profile_fields'] = array('id', 'first-name', 'last-name', 'maiden-name', 'formatted-name', 'headline', 'industry', 'summary', 'email-address', 'picture-url', 'location:(name)', 'public-profile-url', 'site-standard-profile-request');
  		}
  
  		if (is_array($this->strategy['profile_fields'])) {
  			$fields = '(' . implode(',', $this->strategy['profile_fields']) . ')';
  		} else {
  			$fields = '(' . $this->strategy['profile_fields'] . ')';
  		}
  		
  		$ch = curl_init();  
 
      curl_setopt($ch,CURLOPT_URL,'https://api.linkedin.com/v1/people/~:' . $fields."?oauth2_access_token=".$access_token);
      curl_setopt($ch,CURLOPT_RETURNTRANSFER,true);
      //  curl_setopt($ch,CURLOPT_HEADER, false); 
   
      $userinfo =curl_exec($ch);
   
      curl_close($ch);
  
  		//$userinfo = $this->serverGet('https://api.linkedin.com/v1/people/~:' . $fields, array('oauth2_access_token' => $access_token), null, $headers);
  
  		if (!empty($userinfo)){
  			return $this->recursiveGetObjectVars(simplexml_load_string($userinfo));
  		}
  		else{
  			$error = array(
  				'code' => 'userinfo_error',
  				'message' => 'Failed when attempting to query for user information',
  				'raw' => array(
  					'response' => $userinfo,
  					'headers' => $headers
  				)
  			);
  
  			$this->errorCallback($error);
  		}
  }
	
	// helper function for linkedin to parse the given info
	public static function recursiveGetObjectVars($obj){
  		$arr = array();
  		$_arr = is_object($obj) ? get_object_vars($obj) : $obj;
  		
  		foreach ($_arr as $key => $val) {
  			$val = (is_array($val) || is_object($val)) ? self::recursiveGetObjectVars($val) : $val;
  			
  			// Transform boolean into 1 or 0 to make it safe across all Opauth HTTP transports
  			if (is_bool($val)) $val = ($val) ? 1 : 0;
  			
  			$arr[$key] = $val;
  		}
  		
  		return $arr;
  }
  	
  private function getResumedata($firstName, $lastName, $email){
    $data = json_decode($this->default_entry);
	  $data->Profile->firstName = (($firstName == "")?"YOUR":$firstName) ;
	  $data->Profile->lastName = (($lastName == "")?"NAME":$lastName);
	  $data->Profile->email = (($email == "")?"email@cvowl.com":$email);
	  return json_encode($data);
	  
  }
  
  
}
