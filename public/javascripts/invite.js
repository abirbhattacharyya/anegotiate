
function clearLoading(callback) {
  $("#loading-initial").remove();
  $("#select-followers-title").show();
  $("#network-tabs").show();
  callback();
}


// network tabs
function selectFacebook(e) {
  if ($('#facebook-selector').is(':hidden')) {
    //FB.XFBML.Host.get_areElementsReady().waitUntilReady(function() {
      $('#twitter-selector').animate({ height: 'hide', opacity: 'hide' });
      $('#facebook-selector').animate({ height: 'show', opacity: 'show' });
      $('a#facebook-tab').parent().addClass('active');
      $('a#twitter-tab').parent().removeClass('active');

      // for some god-forsaken reason, the iframe spawns at 1400+ px;
      // after it's loaded, set a height on it
      $("iframe.fbmlIframe").height(500); // HACK. addressing it by class fails too.
    //});
  }
  return false;
}

function selectTwitter(e) {
  if ($('#twitter-selector').is(':hidden')) {
    $('#facebook-selector').animate({ height: 'hide', opacity: 'hide' });
    $('#twitter-selector').animate({ height: 'show', opacity: 'show' });
    $('a#twitter-tab').parent().addClass('active');
    $('a#facebook-tab').parent().removeClass('active');

  }
  return false;
}


function handleValidation(json) {
  var sn = json.screen_name;
  if (json.success) {
    if (json.local) {
      errors.find("span.reason").html("@" + sn + " is already a spymaster.");
      errors.show();
    } else  {
      // fire invite post
      $.post("/invite/send_invite",
           {id: sn, authenticity_token: AUTH_TOKEN },
           function(resp) {
             form.find('#indicator').hide();
             $("#adhoc-invite").hide();
             $("#friend-selector").hide();
             $("#post-success").show();
           },
           "json");
    }
  } else if (json.reason === "Not found") {
    errors.find("span.reason").html("@" + sn + " doesn't appear to be a valid user.");
    errors.show();
  } else {
    errors.find("span.reason").html(json.reason).show();
    errors.show();
  }
  form.find("#indicator").hide();
}

// confirm valid user
function validate(ev) {
  sn = input.val();
  if (sn.length > 0 && sn.indexOf("Enter a") != -1) {
    return false;
  }
  form.find('#indicator').show();
  $.post("/invite/validate_twitter",
         {id: sn, check_invite:true, authenticity_token: AUTH_TOKEN},
         handleValidation,
         'json');
  return false;
}



