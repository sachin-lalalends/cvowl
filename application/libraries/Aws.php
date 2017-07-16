<?php if (!defined('BASEPATH')) exit('No direct script access allowed');

require APPPATH.'/third_party/asdk/autoload.php';

use Aws\Ses\SesClient;
use Aws\Common\Credentials\Credentials;



class Aws {
    
    //public $credentials = new Credentials('AKIAJ336WGEDFLNQ4GWQ', 'hI1Uf+W2B5i2coRlTbQg4wLr1Ao5K83PGCLCL4OA');
    
    // send mail is forgot password mail
    public function sendmail($email,$link){
        
        $client = SesClient::factory(array(
            'credentials' => array(
                'key'    => 'AKIAIJY7JXL74TM5N5MA',
                'secret' => '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',
            ),
            'version'=> 'latest',     
            'region' => 'us-east-1'
        ));
        
        $request = array();
        $request['Source'] = "support@cvowl.com";
        $request['Destination']['ToAddresses'] = $email;
        $request['Message']['Subject']['Data'] = "Reset you password";
        $request['Message']['Body']['Html']['Data'] = '<center><table align="center" border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" bgcolor="#eaeced"><tbody><tr><td align="center" valign="top"><table width="600"><tbody><tr><td align="center" valign="top"><table width="580" bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0" valign="top" style="overflow:hidden!important;border-radius:3px"><tbody><tr><td><a ><img src="https://ci5.googleusercontent.com/proxy/ysg9CBKK99Pery0vBdIOIgd4g3_DMEW7K9sToX6sak6bmswvtFcrUI0YIAr7ZgAz-kLGxIpYP7RY8rFQwIRXK_s5qeqGDjmZApshQxhnxvMPcGU51LN6ttCfnzYli71-7fmYMLKqggg0QrkhV3udnQE_XgnYKpB8i9zZNInQ-qVxods6sE0xIGtp9m6RaXFTQodrwfgB-pPpKVR1uwpfY7UwXWWCG4zViYauIuU=s0-d-e1-ft#http://get.invisionapp.com/hs-fs/hubfs/Aa_Weekly_Digest/Week_28_2016/What-has-the-biggest-impact-on-designers-happiness-.png?t=1468280001755&amp;width=580" width="580" style="border:0;max-width:100%!important" class="CToWUd"></a></td></tr><tr height="46"><td>&nbsp;</td></tr><tr><td align="center"><table width="85%"><tbody><tr><td align="center"><h2 style="margin:0!important;font-family:Open Sans,Helvetica,Arial,sans-serif!important;font-size:28px!important;line-height:38px!important;font-weight:200!important;color:#252b33!important">Forgot Password ?</h2></td></tr></tbody></table></td></tr><tr height="25"><td>&nbsp;</td></tr><tr><td align="center"><table border="0" cellpadding="0" cellspacing="0" width="78%"><tbody><tr><td align="center" style="font-family:Open Sans,Helvetica,Arial,sans-serif!important;font-size:16px!important;line-height:30px!important;font-weight:400!important;color:#7e8890!important">You told us you forgot your password. If you really did, we are sharing a reset password link.</td></tr></tbody></table></td></tr><tr height="36"><td>&nbsp;</td></tr><tr><td align="center" valign="top"><table border="0" cellspacing="0" cellpadding="0"><tbody><tr><td align="center" valign="top"><a href="http://www.cvowl.com/verify?guid='.$link.'" style="background-color:#4285f4;padding:14px 28px 14px 28px;border-radius:3px;line-height:18px!important;letter-spacing:0.125em;text-transform:uppercase;font-size:13px;font-family:Open Sans,Arial,sans-serif;font-weight:400;color:#ffffff;text-decoration:none;display:inline-block;line-height:18px!important" target="_blank">CHANGE PASSWORD</a></td></tr></tbody></table></td></tr><tr height="72"><td>&nbsp;</td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table></center>';
        
        try {
             $result = $client->sendEmail($request);
             $messageId = $result->get('MessageId');
             return $messageId;
        
        } catch (Exception $e) {
             return false;
        }
    }
    
    public function signupmail($email,$link,$name){ 
        
        $client = SesClient::factory(array(
            'credentials' => array(
                'key'    => 'AKIAIJY7JXL74TM5N5MA',
                'secret' => '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',
            ),
            'version'=> 'latest',     
            'region' => 'us-east-1'
        ));
        
        $request = array();
        $request['Source'] = "support@cvowl.com";
        $request['Destination']['ToAddresses'] = $email;
        $request['Message']['Subject']['Data'] = "Verification Mail";
        $request['Message']['Body']['Html']['Data'] = '<center><table align="center" border="0" cellpadding="0" cellspacing="0" height="100%" width="100%" bgcolor="#eaeced"><tbody><tr><td align="center" valign="top"><table width="600"><tbody><tr><td align="center" valign="top"><table width="580" bgcolor="#ffffff" border="0" cellpadding="0" cellspacing="0" valign="top" style="overflow:hidden!important;border-radius:3px"><tbody><tr><td><a ><img src="https://ci5.googleusercontent.com/proxy/ysg9CBKK99Pery0vBdIOIgd4g3_DMEW7K9sToX6sak6bmswvtFcrUI0YIAr7ZgAz-kLGxIpYP7RY8rFQwIRXK_s5qeqGDjmZApshQxhnxvMPcGU51LN6ttCfnzYli71-7fmYMLKqggg0QrkhV3udnQE_XgnYKpB8i9zZNInQ-qVxods6sE0xIGtp9m6RaXFTQodrwfgB-pPpKVR1uwpfY7UwXWWCG4zViYauIuU=s0-d-e1-ft#http://get.invisionapp.com/hs-fs/hubfs/Aa_Weekly_Digest/Week_28_2016/What-has-the-biggest-impact-on-designers-happiness-.png?t=1468280001755&amp;width=580" width="580" style="border:0;max-width:100%!important" class="CToWUd"></a></td></tr><tr height="46"><td>&nbsp;</td></tr><tr><td align="center"><table width="85%"><tbody><tr><td align="center"><h2 style="margin:0!important;font-family:Open Sans,Helvetica,Arial,sans-serif!important;font-size:28px!important;line-height:38px!important;font-weight:200!important;color:#252b33!important">Hello '.$name.'</h2></td></tr></tbody></table></td></tr><tr height="25"><td>&nbsp;</td></tr><tr><td align="center"><table border="0" cellpadding="0" cellspacing="0" width="78%"><tbody><tr><td align="center" style="font-family:Open Sans,Helvetica,Arial,sans-serif!important;font-size:16px!important;line-height:30px!important;font-weight:400!important;color:#7e8890!important">We are there to help you make your resume. But please confirm us that it\'s you. \n\n Or just drop us a mail, we will contact you and deliver your resume.</td></tr></tbody></table></td></tr><tr height="36"><td>&nbsp;</td></tr><tr><td align="center" valign="top"><table border="0" cellspacing="0" cellpadding="0"><tbody><tr><td align="center" valign="top"><a  href="http://www.cvowl.com/verify?guid='.$link.'" style="background-color:#4285f4;padding:14px 28px 14px 28px;border-radius:3px;line-height:18px!important;letter-spacing:0.125em;text-transform:uppercase;font-size:13px;font-family:Open Sans,Arial,sans-serif;font-weight:400;color:#ffffff;text-decoration:none;display:inline-block;line-height:18px!important" target="_blank">Click here to verify </a></td></tr></tbody></table></td></tr><tr height="72"><td>&nbsp;</td></tr></tbody></table></td></tr></tbody></table></td></tr></tbody></table></center>';
        
        try {
             $result = $client->sendEmail($request);
             $messageId = $result->get('MessageId');
             return $messageId;
        
        } catch (Exception $e) {
             return false;
        }
    }
    
    
}