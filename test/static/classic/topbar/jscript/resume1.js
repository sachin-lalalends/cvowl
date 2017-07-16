
String.prototype.capitalizeFirstLetter = function() {
    return this.charAt(0).toUpperCase() + this.slice(1);
}

function buildresume() {
  console.log('buildresume()');

  var Data = localStorage.getItem("data");
  Data = $.parseJSON(Data);

  var duplicate_data = {};
  $.each(Data, function(k, v) {
    if (k != null && k != "") {
      if (k == "Profile" || k == "Coverletter") {
        duplicate_data[k] = v;
      }
      else {

        Data[k].sort(function(a, b) {
          if (a == null || b == null) return 0;
          return parseFloat(a.order_prefs) - parseFloat(b.order_prefs);
        });
        var i = 0;
        duplicate_data[k] = [];
        $.each(v, function(key, val) {
          if (val != null) {
            duplicate_data[k].push(val);
            i++;
          }

        });
      }
    }
  });

  localStorage.setItem("data", (JSON.stringify(duplicate_data)));

  if(Data.Profile.type != "EXPERIENCED"){
    $('#fresher').attr('checked','checked');
  }else{
    $('#experienced').attr('checked','checked');
  }
  Data = duplicate_data;
  activeSection = localStorage.getItem("activeSection");

  var str = "";

  str += '<div id="myresume">';
  str += '<table border="0" width="100%">' +
    '<tr id="header">' +
    '<td class="intro" style="width:80%" align="left" valign="bottom">' +
    '<span id="name">' + Data.Profile.firstName.toUpperCase() + ' ' + Data.Profile.lastName.toUpperCase() + '</span><br>' +
    '<span id="job_title">' + Data.Profile.jobTitle.toUpperCase() + ' </span>' +
    '</td>' +
    '<td class="introdesc" style="width:30%" align="right" valign="bottom">';

  if (Data.Profile.phone != null || Data.Profile.phone != "") {
    str += '<span id="phone">' + Data.Profile.phone + '</span><br>';
  }
  str += '<span id="email">' + Data.Profile.email + '</span></td>' +
    '</tr>' +
    '</table>';


  str += '<div style=" width:5%;float:left;min-height: 1px;">&nbsp;</div>';
  str += '<div style="width:55%;float:left;min-height: 1px;">';

  var noOf_breakLines = 0;
  if(Data.Experience.length > 0)
    noOf_breakLines++;
  if(Data.Education.length > 0)
    noOf_breakLines++;
  if(Data.Project.length > 0)
    noOf_breakLines++;
  if(Data.Achievement.length > 0)
    noOf_breakLines++;
  if(Data.Certification.length > 0)
    noOf_breakLines++;
  if(Data.Volunteering.length > 0)
    noOf_breakLines++;
  if(Data.customSections.length > 0)
    noOf_breakLines++;
  if(Data.Reference.length > 0)
    noOf_breakLines++;

  if (Data.Profile.summary != "" && Data.Profile.type == "FRESHER") {

    str += '<table border="0" width="100%">';
    str += '<tr>';
    str += '<td class="section-heading">';
    str += 'OBJECTIVE';
    str += '</td>';
    str += '</tr>';
    str += '</table>';

    str += '<div class="section-title3 E3" style="padding-top: 0px;text-align: justify;">';
    str += Data.Profile.summary;
    str += '</div>';


    str += '<table width="100%" class="section-break">';
    str += '<tbody>';
    str += '<tr class="">';
    str += '<td>&nbsp;</td>';
    str += '</tr>';
    str += '</tbody>';
    str += '</table>';

  }
  var has_exp = 0;
  $.each(Data.Experience, function(k, v) {
    if (v != null && v.section_type == "EXPERIENCE" && v.is_active == 1) {
      has_exp = 1;
      return false;
    }
  });
  if (Data.Experience.length > 0 && has_exp) {

    str += '<table border="0" width="100%">';
    str += '<tr>';
    str += '<td class="section-heading">';
    str += 'EXPERIENCE';
    str += '</td>';
    str += '</tr>';
    str += '</table>';

    $.each(Data.Experience, function(k, v) {
      if (v != null && v.section_type == "EXPERIENCE" && v.is_active == 1) {

        str += '<table border="0" width="100%">';
        str += '<tr>';
        str += '<td class="EXP-' + k + ' section-title1 E1">';
        str += v.section_title1.toUpperCase();
        str += '</td>';
        str += '</tr>';
        str += '<tr>';
        str += '<td class="EXP-' + k + ' section-title2 E2">';
        var subtitle = $.trim(v.section_title2);
        if ($.trim(v.section_title3) != "" && subtitle != "") {
          subtitle += ' &nbsp;|&nbsp; ';
        }
        subtitle += $.trim(v.section_title3);
        if (subtitle != "" && ($.trim(v.start_date) != "")) {
          subtitle += ' &nbsp;|&nbsp; '+$.trim(v.start_date);
        }
        if($.trim(v.end_date) != ""){
          subtitle += " - "+$.trim(v.end_date);
        }
        str += subtitle;  
        str += '</td>';
        str += '</tr>';
        str += '</table>';
        str += '<div class="EXP-' + k + ' section-title3 E3">';
        str += v.more_info1;
        str += '</div>';
      }
    });

    str += '<table width="100%" class="section-break">';
    str += '<tbody>';

    noOf_breakLines--;
    if(noOf_breakLines>0)
    {
      str += '<tr class="">';
      str += '<td>&nbsp;</td>';
      str += '</tr>';
    }
    str += '</tbody>';
    str += '</table>';
  }

  var has_edu = 0;
  $.each(Data.Education, function(k, v) {
    if (v != null && v.section_type == "EDUCATION" && v.is_active == 1) {
      has_edu = 1;
      return false;
    }
  });
  if (Data.Education.length > 0 && has_edu) {

    str += '<table border="0" width="100%">';
    str += '<tr>';
    str += '<td class="section-heading">';
    str += 'EDUCATION';
    str += '</td>';
    str += '</tr>';
    str += '</table>';

    $.each(Data.Education, function(k, v) {
      if (v != null && v.section_type == "EDUCATION" && v.is_active == 1) {

        str += '<table border="0" width="100%">';
        str += '<tr>';
        str += '<td class="EDU-' + k + ' section-title1 E1">';
        str += v.section_title1.toUpperCase();
        str += '</td>';
        str += '</tr>';
        str += '<tr>';
        str += '<td class="EDU-' + k + ' section-title2 E2">';
        var subtitle = $.trim(v.section_title2);
        if ($.trim(v.section_title3) != "" && subtitle != "") {
          subtitle += ' &nbsp;|&nbsp; ';
        }
        subtitle += $.trim(v.section_title3);
        if (subtitle != "" && ($.trim(v.start_date) != "")) {
          subtitle += ' &nbsp;|&nbsp; '+$.trim(v.start_date);
        }
        if($.trim(v.end_date) != ""){
          subtitle += " - "+$.trim(v.end_date);
        }
        str += subtitle;
        str += '</td>';
        str += '</tr>';
        str += '</table>';
        str += '<div class="EDU-' + k + ' section-title3 E3">';
        str += v.more_info1;
        str += '</div>';

      }
    });

    str += '<table width="100%" class="section-break">';
    str += '<tbody>';
    noOf_breakLines--;
    if(noOf_breakLines>0)
    {
      str += '<tr class="">';
      str += '<td>&nbsp;</td>';
      str += '</tr>';
    }
    str += '</tbody>';
    str += '</table>';
  }

  var has_proj = 0;
  $.each(Data.Project, function(k, v) {
    if (v != null && v.section_type == "PROJECT" && v.is_active == 1) {
      has_proj = 1;
      return false;
    }
  });
  if (Data.Project.length > 0 && has_proj) {

    str += '<table border="0" width="100%">';
    str += '<tr>';
    str += '<td class="section-heading">';
    str += 'PROJECTS';
    str += '</td>';
    str += '</tr>';
    str += '</table>';

    $.each(Data.Project, function(k, v) {
      if (v != null && v.section_type == "PROJECT" && v.is_active == 1) {

        str += '<table border="0" width="100%">';
        str += '<tr>';
        str += '<td class="PRO-' + k + ' section-title1 E1">';
        str += v.section_title2.toUpperCase();
        str += '</td>';
        str += '</tr>';
        str += '<tr>';
        str += '<td class="PRO-' + k + ' section-title2 E2">';
        var subtitle = $.trim(v.section_title1);
        if ($.trim(v.section_title3) != "" && subtitle != "") {
          subtitle += ' &nbsp;|&nbsp; ';
        }
        subtitle += $.trim(v.section_title3);
        if (subtitle != "" && ($.trim(v.start_date) != "")) {
          subtitle += ' &nbsp;|&nbsp; '+$.trim(v.start_date);
        }
        if($.trim(v.end_date) != ""){
          subtitle += " - "+$.trim(v.end_date);
        }
        str += subtitle;  
        str += '</td>';
        str += '</tr>';
        str += '</table>';
        str += '<div class="PRO-' + k + ' section-title3 E3">';
        str += v.more_info1;
        str += '</div>';

      }
    });

    str += '<table width="100%" class="section-break">';
    str += '<tbody>';
    noOf_breakLines--;
    if(noOf_breakLines>0)
    {
      str += '<tr class="">';
      str += '<td>&nbsp;</td>';
      str += '</tr>';
    }
    str += '</tbody>';
    str += '</table>';
  }

  if (Data.Achievement.length > 0 && Data.Achievement[0].more_info1 !="" && Data.Achievement[0].more_info1.length != 0) {

    str += '<table border="0" width="100%">';
    str += '<tr>';
    str += '<td class="section-heading" style="padding-bottom: 0px;">';
    str += 'ACHIEVEMENTS';
    str += '</td>';
    str += '</tr>';
    str += '</table>';
    
    $.each(Data.Achievement, function(k, v) {
      if (v != null && v.section_type == "ACHIEVEMENT" && v.is_active == 1) {

        // str += '<table border="0" width="100%">';
        // str += '<tr>';
        // str += '<td class="ACHV-' + k + ' section-title1 E1">';
        // str += v.section_title2.toUpperCase();
        // str += '</td>';
        // str += '</tr>';
        // str += '<tr>';
        // str += '<td class="ACHV-' + k + ' section-title2 E2">';
        // str += v.section_title1;
        // if (v.section_title3 != "") {
        //   str += ' &nbsp;|&nbsp; ';
        // }
        // str += v.section_title3;
        // if (v.start_date.length > 3 && (v.start_date.includes("null")==false)) {
        //   str += ' &nbsp;|&nbsp; ' + v.start_date;;
        // }
        // str += '</td>';
        // str += '</tr>';
        // str += '</table>';
        str += '<div class="ACHV-' + k + ' section-title3 E3">';
        str += v.more_info1;
        str += '</div>';
      }
    });

    str += '<table width="100%" class="section-break">';
    str += '<tbody>';
    noOf_breakLines--;
    if(noOf_breakLines>0)
    {
      str += '<tr class="">';
      str += '<td>&nbsp;</td>';
      str += '</tr>';
    }
    str += '</tbody>';
    str += '</table>';
  }

  var has_cert = 0;
  $.each(Data.Certification, function(k, v) {
    if (v != null && v.section_type == "CERTIFICATION" && v.is_active == 1) {
      has_cert = 1;
      return false;
    }
  });
  if (Data.Certification.length > 0 && has_cert) {

    str += '<table border="0" width="100%">';
    str += '<tr>';
    str += '<td class="section-heading">';
    str += 'CERTIFICATIONS';
    str += '</td>';
    str += '</tr>';
    str += '</table>';

    $.each(Data.Certification, function(k, v) {
      if (v != null && v.section_type == "CERTIFICATION" && v.is_active == 1) {

        str += '<table border="0" width="100%">';
        str += '<tr>';
        str += '<td class="CERT-' + k + ' section-title1 E1">';
        str += v.section_title2.toUpperCase();
        str += '</td>';
        str += '</tr>';
        str += '<tr>';
        str += '<td class="CERT-' + k + ' section-title2 E2">';
        var subtitle = $.trim(v.section_title1);
        if ($.trim(v.section_title3) != "" && subtitle != "") {
          subtitle += ' &nbsp;|&nbsp; ';
        }
        subtitle += $.trim(v.section_title3);
        if (subtitle != "" && ($.trim(v.start_date) != "")) {
          subtitle += ' &nbsp;|&nbsp; '+$.trim(v.start_date);
        }
        str += subtitle;
        str += '</td>';
        str += '</tr>';
        str += '</table>';
        str += '<div class="CERT-' + k + ' section-title3 E3">';
        str += v.more_info1;
        str += '</div>';

      }
    });

    str += '<table width="100%" class="section-break">';
    str += '<tbody>';
    noOf_breakLines--;
    if(noOf_breakLines>0)
    {
      str += '<tr class="">';
      str += '<td>&nbsp;</td>';
      str += '</tr>';
    }
    str += '</tbody>';
    str += '</table>';
  }

  var has_voln = 0;
  $.each(Data.Volunteering, function(k, v) {
    if (v != null && v.section_type == "VOLUNTEERING" && v.is_active == 1) {
      has_voln = 1;
      return false;
    }
  });
  if (Data.Volunteering.length > 0 && has_voln) {

    str += '<table border="0" width="100%">';
    str += '<tr>';
    str += '<td class="section-heading">';
    str += 'VOLUNTEERING EXPERIENCE';
    str += '</td>';
    str += '</tr>';
    str += '</table>';

    $.each(Data.Volunteering, function(k, v) {
      if (v != null && v.section_type == "VOLUNTEERING" && v.is_active == 1) {

        str += '<table border="0" width="100%">';
        str += '<tr>';
        str += '<td class="VOL-' + k + ' section-title1 E1">';
        str += v.section_title2.toUpperCase();
        str += '</td>';
        str += '</tr>';
        str += '<tr>';
        str += '<td class="VOL-' + k + ' section-title2 E2">';
        var subtitle = $.trim(v.section_title1);
        if ($.trim(v.section_title3) != "" && subtitle != "") {
          subtitle += ' &nbsp;|&nbsp; ';
        }
        subtitle += $.trim(v.section_title3);
        if (subtitle != "" && ($.trim(v.start_date) != "")) {
          subtitle += ' &nbsp;|&nbsp; '+$.trim(v.start_date);
        }
        str += subtitle;
        str += '</td>';
        str += '</tr>';
        str += '</table>';
        str += '<div class="VOL-' + k + ' section-title3 E3">';
        str += v.more_info1;
        str += '</div>';

      }
    });

    str += '<table width="100%" class="section-break">';
    str += '<tbody>';
    noOf_breakLines--;
    if(noOf_breakLines>0)
    {
      str += '<tr class="">';
      str += '<td>&nbsp;</td>';
      str += '</tr>';
    }
    str += '</tbody>';
    str += '</table>';
  }


  if (Data.customSections.length > 0) {
    $.each(Data.customSections, function(k, v) {
      if (!v) {
        return true;
      }
      if (Data[v.section_name].length > 0) {

        Data[v.section_name].sort(function(a, b) {
          if (a == null || b == null) return 0;
          return parseFloat(a.order_prefs) - parseFloat(b.order_prefs);
        });

        str += '<table border="0" width="100%">';
        str += '<tr>';
        str += '<td class="section-heading">';
        str += v.section_name.toUpperCase();
        str += '</td>';
        str += '</tr>';
        str += '</table>';

        $.each(Data[v.section_name], function(key, val) {
          if (val != null && val.section_type == v.section_name.toUpperCase() && val.is_active == 1) {

            str += '<table border="0" width="100%">';
            str += '<tr>';
            str += '<td class="section-title1">';
            str += val.section_title2.toUpperCase();
            str += '</td>';
            str += '</tr>';
            str += '<tr>';
            str += '<td class="section-title2">';
            var subtitle = $.trim(v.section_title1);
            if ($.trim(v.section_title3) != "" && subtitle != "") {
              subtitle += ' &nbsp;|&nbsp; ';
            }
            subtitle += $.trim(v.section_title3);
            if (subtitle != "" && ($.trim(v.start_date) != "" || $.trim(v.end_date) != "")) {
              subtitle += ' &nbsp;|&nbsp; ';
            }
            str += subtitle + $.trim(v.start_date)+" - "+$.trim(v.end_date);
            str += '</td>';
            str += '</tr>';
            str += '</table>';
            str += '<div class="section-title3 E3">';
            str += val.more_info1;
            str += '</div>';

          }
        });

        str += '<table width="100%" class="section-break">';
        str += '<tbody>';
        noOf_breakLines--;
        if(noOf_breakLines>0)
        {
          str += '<tr class="">';
          str += '<td>&nbsp;</td>';
          str += '</tr>';
        }
        str += '</tbody>';
        str += '</table>';


      }
    });
  }

  if (Data.Reference.length > 0) {

    str += '<table border="0" width="100%">';
    str += '<tr>';
    str += '<td class="section-heading">';
    str += 'RECOMMENDATIONS';
    str += '</td>';
    str += '</tr>';
    str += '</table>';

    $.each(Data.Reference, function(k, v) {
      if (v != null && v.section_type == "REFERENCE" && v.is_active == 1) {

        str += '<table border="0" width="100%">';
        str += '<tr>';
        str += '<td class="REC-' + k + ' section-title1 E1">';
        str += v.section_title2.toUpperCase();
        str += '</td>';
        str += '</tr>';
        str += '<tr>';
        str += '<td class="REC-' + k + ' section-title2 E2">';
        var subtitle = $.trim(v.section_title1);
        if ($.trim(v.section_title3) != "" && subtitle != "") {
          subtitle += ' &nbsp;|&nbsp; ';
        }
        subtitle += $.trim(v.section_title3);
        if (subtitle != "" && ($.trim(v.start_date) != "")) {
          subtitle += ' &nbsp;|&nbsp; '+$.trim(v.start_date);
        }
        str += subtitle;
        str += '</td>';
        str += '</tr>';
        str += '</table>';
        str += '<div class="REC-' + k + ' section-title3 E3">';
        str += v.more_info1;
        str += '</div>';

      }
    });

    str += '<table width="100%" class="section-break">';
    str += '<tbody>';
    noOf_breakLines--;
    if(noOf_breakLines>0)
    {
      str += '<tr class="">';
      str += '<td>&nbsp;</td>';
      str += '</tr>';
    }
    str += '</tbody>';
    str += '</table>';
  }

  str += '</div>'
  str += '<div style=" width:5%;float:left;min-height: 1px;">&nbsp;</div>';
  str += '<div style="width:30%;float:left;">';

  if (Data.Profile.summary != "" && Data.Profile.type == "EXPERIENCED") {

    str += '<table border="0" width="95%">';
    str += '<tr>';
    str += '<td class="section-heading-right">';
    str += 'SUMMARY';
    str += '</td>';
    str += '</tr>';
    str += '</table>';

    str += '<table border="0" width="95%">';
    str += '<tr>';
    str += '<td class="section-title2-right" id="summary_text">';
    str += Data.Profile.summary;
    str += '</td>';
    str += '</tr>';
    str += '</table>';

    str += '<br>';

  }


  if (Data.Skill.length > 0) {


    str += '<table border="0" width="95%">';
    str += '<tr>';
    str += '<td class="section-heading-right">';
    str += 'SKILLS';
    str += '</td>';
    str += '</tr>';
    str += '</table>';
    

    $.each(Data.Skill, function(k, v) {
      if (v != null && v.section_type == "SKILL" && v.is_active == 1) {

        str += '<table class="progress_table" border="0" cellpadding="0" cellspacing="0" width="100%" data-for="SKL-' + k + '">';
        str += '<tbody>';
        str += '<tr>';
        str += '<td  colspan="2" class="section-title1-right E1">' + v.section_title1 + '</td>';
        str += '</tr>';
        str += '<tr>';
        switch (v.section_title2) {
          case "Beginner":
            str += '<td style="width:25%; border-bottom:3px solid #909090;"></td>';
            str += '<td style="width:75%; border-bottom:3px solid #dfdede"></td>';
            break;
          case "Intermediate":
            str += '<td style="width:50%; border-bottom:3px solid #909090;"></td>';
            str += '<td style="width:50%; border-bottom:3px solid #dfdede"></td>';
            break;
          case "Advanced":
            str += '<td style="width:75%; border-bottom:3px solid #909090;"></td>';
            str += '<td style="width:25%; border-bottom:3px solid #dfdede"></td>';
            break;
          case "Expert":
            str += '<td style="width:95%; border-bottom:3px solid #909090;"></td>';
            str += '<td style="width:5%; border-bottom:3px solid #dfdede"></td>';
            break;
          default:
            str += '<td style="width:25%; border-bottom:3px solid #909090;"></td>';
            str += '<td style="width:75%; border-bottom:3px solid #dfdede"></td>';

        }


        str += '</tr>';
        str += '</tbody>';
        str += '</table>';

        str += '<br>';
      }
    });

  }

  if (Data.Language.length > 0) {


    str += '<table border="0" width="95%">';
    str += '<tr>';
    str += '<td class="section-heading-right">';
    str += 'LANGUAGES';
    str += '</td>';
    str += '</tr>';
    str += '</table>';
    str += '<table width="95%">';
    str += '<tbody>';
    str += '<tr class="">';
    str += '<td>';

    $.each(Data.Language, function(k, v) {
      if (v != null && v.section_type == "LANGUAGE" && v.is_active == 1) {

        str += '<table class="progress_table" border="0" cellpadding="0" cellspacing="0" width="100%" data-for="LANG-' + k + '">';
        str += '<tbody>';
        str += '<tr>';
        str += '<td  colspan="2" class="section-title1-right E1">' + v.section_title1 + " (" + v.section_title2 + ") " + '</td>';
        str += '</tr>';

        str += '</tbody>';
        str += '</table>';
      }
    });

    str += '</td>';
    str += '</tr>';
    str += '</tbody>';
    str += '</table>';

    str += '<br>';
    str += '<br>';
  }

  if (Data.Worklinks[0].websiteURL != "" || Data.Worklinks[1].portfolioURL != "" || Data.Worklinks[2].blogURL != "" || Data.Worklinks[3].slideshareURL != "") {

    str += '<table border="0" width="95%">';
    str += '<tr>';
    str += '<td class="section-heading-right">';
    str += 'WEB LINKS';
    str += '</td>';
    str += '</tr>';
    str += '</table>';
    str += '<table width="95%">';
    str += '<tr>';
    str += '<td>';
    if (Data.Worklinks[0].websiteURL != "" && Data.Worklinks[0].websiteURL != null) {
      str += '<span class="misc_title">Website<br></span><span class=" LINK section-title3 E1">' + Data.Worklinks[0].websiteURL + '</span>';
      str += '<br>';
      str += '<br>';
    }

    if (Data.Worklinks[1].portfolioURL != "" && Data.Worklinks[1].portfolioURL != null) {
      str += '<span class="misc_title">Portfolio<br></span><span class="LINK section-title3 E2">' + Data.Worklinks[1].portfolioURL + '</span>';
      str += '<br>';
      str += '<br>';
    }

    if (Data.Worklinks[2].blogURL != "" && Data.Worklinks[2].blogURL != null) {
      str += '<span class="misc_title">Blog<br></span><span class="LINK section-title3 E3">' + Data.Worklinks[2].blogURL + '</span>';
      str += '<br>';
      str += '<br>';
    }

    if (Data.Worklinks[3].slideshareURL != "" && Data.Worklinks[3].slideshareURL != null) {
      str += '<span class="misc_title">Slideshare<br></span><span class="section-title3 E4">' + Data.Worklinks[3].slideshareURL + '</span>';
      str += '<br>';
      str += '<br>';
    }
    str += '</td>';
    str += '</tr>';
    str += '</table>';

  }

  if (Data.Hobbies.length > 0) {

    str += '<table border="0" width="95%">';
    str += '<tr>';
    str += '<td class="section-heading-right">';
    str += 'HOBBIES';
    str += '</td>';
    str += '</tr>';
    str += '</table>';
    str += '<table width="95%" class="">';
    str += '<tbody>';
    str += '<tr>';
    $.each(Data.Hobbies, function(k, v) {
      if (v != null && v.section_type == "HOBBIES" && v.is_active == 1) {

        str += '<td align="center" valign="top" broder="1" style="padding:3px;" width="70px"><img src="/static/classic/topbar/assets/hobbies/' + v.section_title1.toLowerCase().split(' ').join('_') + '.svg" alt="'+v.section_title1+'" onerror="$(this).parent().remove();" ></td>';
      }
    });
    str += '</tr>';
    str += '</tbody>';
    str += '</table>';
    str += '<br><br>';

  }

  str += '<table border="0" width="95%" style="autosize:1;page-break-inside:avoid;" data-for="INFO">';
  str += '<tr>';
  str += '<td class="section-heading-right">';
  str += 'PERSONAL INFO';
  str += '</td>';
  str += '</tr>';
  str += '<tr>';

  str += '<td class="section-title3">';
  if (Data.Profile.birthDay != "" && Data.Profile.birthDay != null) {

    str += '<span class="misc_title">Date Of Birth<br></span><span class="section-title3">' + Data.Profile.birthDay + '</span>';
    str += '<br>';
    str += '<br>';
  }

  if (Data.Profile.gender != "" && Data.Profile.gender != null) {
    str += '<span class="misc_title">Gender<br></span><span class="section-title3">' + Data.Profile.gender + '</span>';
    str += '<br>';
    str += '<br>';
  }

  if (Data.Profile.maritalStatus != "" && Data.Profile.maritalStatus != null) {
    str += '<span class="misc_title">Marital Status<br></span><span class="section-title3">' + Data.Profile.maritalStatus + '</span>';
    str += '<br>';
    str += '<br>';
  }

  if (Data.Profile.facebookHandle != "" && Data.Profile.facebookHandle != null) {
    str += '<span class="misc_title">Facebook URL<br></span><span class="section-title3">' + 'facebook.com/' + Data.Profile.facebookHandle + '</span>';
    str += '<br>';
    str += '<br>';
  }

  if (Data.Profile.linkedinHandle != "" && Data.Profile.linkedinHandle != null) {
    str += '<span class="misc_title">LinkedIn URL<br></span><span class="section-title3">' + 'linkedin.com/' + Data.Profile.linkedinHandle + '</span>';
    str += '<br>';
    str += '<br>';
  }

  if (Data.Profile.nationality != "" && Data.Profile.nationality != null) {
    str += '<span class="misc_title">Nationality<br></span><span class="section-title3 E4">' + Data.Profile.nationality.capitalizeFirstLetter() + '</span>';
    str += '<br>';
    str += '<br>';
  }

  //if (Data.Profile.location.address != "" || Data.Profile.location.postalCode != "" || Data.Profile.location.city != "" || Data.Profile.location.country != "" || Data.Profile.location.state != "") {
  if (Data.Profile.location.address != "") {
    str += '<span class="misc_title">Address<br></span><span class="section-title3">';
    if (Data.Profile.location.address != "") {
      str += Data.Profile.location.address + '';
    }
    // if (Data.Profile.location.city != "") {
    //   str += Data.Profile.location.city + ', ';
    // }
    // if (Data.Profile.location.state != "") {
    //   str += Data.Profile.location.state + ' - ';
    // }
    // if (Data.Profile.location.postalCode != "") {
    //   str += Data.Profile.location.postalCode + '';
    // }

    str += '<br>';
    str += '<br>';
  }
  str += '</td>';
  str += '</tr>';
  str += '</table>';


  str += '</div>';
  str += '<div style=" width:5%;float:left;min-height: 1px;">&nbsp;</div>';

  $(".resume_html").html(str);

}
