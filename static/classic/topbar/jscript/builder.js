(function(window, document, $) {
  'use strict';

  $.site.sidebar = {
    init: function() {
      if (typeof $.slidePanel === 'undefined') return;
      
      

      $(document).on('click', '[data-toggle="slidePanel"]', function() {
        var $this = $(this);

        var direction = 'left';
        if ($('body').hasClass('site-menubar-flipped')) {
          direction = 'left';
        }

        var defaults = $.components.getDefaults("slidePanel");
        var options = $.extend({}, defaults, {
          direction: direction,
          skin: 'site-sidebar',
          dragTolerance: 80,
          template: function(options) {
            return '<div class="' + options.classes.base + ' ' + options.classes.base + '-' + options.direction + '">' +
              '<div class="' + options.classes.content + ' site-sidebar-content"></div>' +
              '<div class="slidePanel-handle"></div>' +  // spelling mistake
              '</div>';
          },
          afterLoad: function() {
            var self = this;
            this.$panel.find('.tab-pane').asScrollable({
              namespace: 'scrollable',
              contentSelector: "> div",
              containerSelector: "> div"
            });


            this.$panel.on('shown.bs.tab', function() {
              self.$panel.find(".tab-pane.active").asScrollable('update');
            });
          },
          beforeShow: function() {
            if (!$this.hasClass('active')) {
              $this.addClass('active');
            }
            
            $('.cvsectionli').addClass('open');
            $('.site-skintools').animate({
              left: '-2px'
             }, 400);
             $(".resume-holder,.cover-holder").animate({
                  marginLeft: $('.site-sidebar').width()
              }, 500);
              var padding = "0px";
              if(window.outerWidth < 768){
                padding = "0px";
              }else{
                padding = $('.site-sidebar').width();
              }
             $(".emailverify-text").animate({
                  paddingLeft: padding
              }, 500);
            
          },
          afterHide: function() {
            if ($this.hasClass('active')) {
              $this.removeClass('active');
            }
            $('.site-skintools').show();
            $('.cvsectionli').removeClass('open');
            $('.site-skintools').animate({
              left: '29px'
             }, 400); 
            $(".resume-holder,.cover-holder").animate({
                  marginLeft: '0px'
              }, 500);
            $(".emailverify-text").animate({
                  paddingLeft: '0px'
              }, 500);
          }
        });

        if ($this.hasClass('active')) {
          //$.slidePanel.hide();
        } else {
          var url = $this.data('url');
          if (!url) {
            url = $this.attr('href');
            url = url && url.replace(/.*(?=#[^\s]*$)/, '');
          }
          
          if($(this).hasClass("site-skintools")){
            // the arrow which opens slidepanel is clicked
            // if(localStorage.getItem("activeSection")){
            //   url = "/static/classic/topbar/tpl/"+localStorage.getItem("activeSection")+".tpl";
              
            // }else{
            //   console.log("No active section before");
            // }
          }
          var sectionUrl = url;
          var sectionTpl = sectionUrl.split("/").pop();
          var activeSection = sectionTpl.slice(0, sectionTpl.indexOf("."));
          localStorage.setItem('activeSection', activeSection);
          $.slidePanel.show({
            url: url
          }, options);
        }
      });
      
      
      $(document).on('click', '[data-toggle="menuPanel"]', function() {
        var $this = $(this);

        var direction = 'right';
        if ($('body').hasClass('site-menubar-flipped')) {
          direction = 'right';
        }

        var defaults = $.components.getDefaults("slidePanel");
        var options = $.extend({}, defaults, {
          direction: direction,
          skin: 'site-sidebar',
          dragTolerance: 80,
          template: function(options) {
            return '<div class="' + options.classes.base + ' ' + options.classes.base + '-' + options.direction + '" style="width:225px !important;">' +
              '<div class="' + options.classes.content + ' site-sidebar-content"></div>' +
              '<div class="slidePanel-handle"></div>' +  // spelling mistake
              '</div>';
          },
          afterLoad: function() {
            var self = this;
            this.$panel.find('.tab-pane').asScrollable({
              namespace: 'scrollable',
              contentSelector: "> div",
              containerSelector: "> div"
            });


            this.$panel.on('shown.bs.tab', function() {
              self.$panel.find(".tab-pane.active").asScrollable('update');
            });
          },
          beforeShow: function() {
            if (!$this.hasClass('active')) {
              $this.addClass('active');
            }
          },
          afterHide: function() {
            if ($this.hasClass('active')) {
              $this.removeClass('active');
            }
          }
        });

        if ($this.hasClass('active')) {
          $.slidePanel.hide();
        } else {
          var url = $this.data('url');
          if (!url) {
            url = $this.attr('href');
            url = url && url.replace(/.*(?=#[^\s]*$)/, '');
          }

          $.slidePanel.show({
            url: url
          }, options);
        }
      });

    }
  };
  $(document).click(function (e) {
    console.log(e.target);
  });

})(window, document, jQuery);
