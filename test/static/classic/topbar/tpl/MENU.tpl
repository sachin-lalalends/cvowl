<style>
  .end{
    border-bottom:1px solid #D0D0D0;
  }
</style>
<div class="site-sidebar-tab-content tab-content">
  <div class="tab-pane fade active in" id="sidebar-userlist">
    <div>
      <div>
        <h5 class="clearfix">
          <div class="pull-right">
            <!-- <a class="text-action slidePanel-close" href="javascript:void(0)" role="button">
              <i class="icon wb-close" aria-hidden="true"></i>
            </a> -->
          </div>
        </h5>
        
        <section class="end">
          <h5 class="">GENERAL</h5>
          <div class="list-group calendar-list">
            <a class="list-group-item" id="cvbuilder-rightsidebar" href="http://www.cvowl.com/cv/builder">
              <i class="wb-medium-point teal-600 margin-right-10" aria-hidden="true"></i>
              CV Builder
            </a>
            <a class="list-group-item" id="cvbuilder-rightsidebar" href="http://www.cvowl.com/cv/coverletter">
              <i class="wb-medium-point teal-600 margin-right-10" aria-hidden="true"></i>
              Cover Letter
            </a>
            <a class="list-group-item" id="mdownloadA4" href="javascript:void(0);">
              <i class="fa fa-file-pdf-o teal-600 margin-right-10 " aria-hidden="true"></i>
              Download - A4
            </a>
            <a class="list-group-item " id="mdownloadLetter" href="javascript:void(0);">
              <i class="fa fa-file-pdf-o teal-600 margin-right-10 mdownloadLetter" aria-hidden="true"></i>
              Download - Letter
            </a>


            <!-- <a class="list-group-item ">
              <i class="wb-medium-point teal-600 margin-right-10" aria-hidden="true"></i>
              Make Your CV
            </a>
            <a class="list-group-item ">
              <i class="wb-medium-point green-600 margin-right-10" aria-hidden="true"></i>
              Services
            </a>
            <a class="list-group-item ">
              <i class="wb-medium-point orange-600 margin-right-10" aria-hidden="true"></i>
              Find A Job
            </a>
            <a class="list-group-item ">
              <i class="wb-medium-point cyan-600 margin-right-10" aria-hidden="true"></i>
              Aquire Skills
            </a> -->
          </div>
        </section>
        <br>
        <!-- <section class="end">
          <h5 class="">NOTIFICATION</h5>
          <div class="list-group calendar-list">
            <a class="list-group-item ">
              <i class="wb-medium-point red-600 margin-right-10" aria-hidden="true"></i>
              4 Notifications
            </a>
          </div>
        </section> -->
        <!-- <br> -->
        <section class="">
          <h5 class="">PROFILE</h5>
          <div class="list-group calendar-list">
            <!-- <a class="list-group-item " href="http://www.cvowl.com/settings">
              <i class="wb-medium-point teal-600 margin-right-10" aria-hidden="true"></i>
              Settings
            </a> -->
            <a class="list-group-item " href="http://www.cvowl.com/logout">
              <i class="wb-medium-point red-600 margin-right-10" aria-hidden="true"></i>
              Logout
            </a>
          </div>
        </section>
        
      </div>
    </div>
  </div>
</div>
<script type="text/javascript">
  $('#mdownloadA4').on('click', function() {
    var download = $('.cover-download').html();
    if(!download){
      download = $('.resume-download').html();
    } 
    $.redirectPost('/cv/buildPDF', {
      'html': encodeURIComponent(download),
      'size':'A4'
    });
  });

  $('#mdownloadLetter').on('click', function() {
    var download = $('.cover-download').html();
    if(!download){
      download = $('.resume-download').html();
    } 
    $.redirectPost('/cv/buildPDF', {
      'html': encodeURIComponent(download),
      'size':'Letter'
    });
  });
</script>