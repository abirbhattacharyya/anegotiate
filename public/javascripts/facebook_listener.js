/*
 * Ensure Facebook app is initialized and call callback afterward
 *
 */
function ensure_init(callback) {
  if(!window.api_key) {
    window.alert("api_key is not set");
  }

  if(window.is_initialized) {
    callback();
  } else {
    FB_RequireFeatures(["XFBML", "CanvasUtil", "Connect"], function() {
      //FB.CanvasClient.startTimerToSizeToContent();
      
      FB.FBDebug.logLevel = 4;
      FB.FBDebug.isEnabled = false;
      FB.Facebook.init(window.api_key, window.xd_receiver_location);
      FB.Facebook.get_sessionState().waitUntilReady(function() { } );
      
      window.is_initialized = true;

      FB.XFBML.Host.parseDomTree();
    });
  }
}


// on include, listen for login_status.php callback  
ensure_init(function() {
    FB.XFBML.Host.parseDomTree();
    //FB.CanvasClient.startTimerToSizeToContent();
});


function redirect_authed() {
  // used in the login flow. (ie. not present anywhere
  // else we need to authenticate, like link-accounts for instance)

//  $("#global-loader").height($(window).height());
//  $("#global-loader").css('display', 'block');
//  $("#global-loader").animate({opacity:1.0});

  // this needs to run outside of animation callback
  // so that the authenticate call happens
  window.setTimeout(function() {
    window.location = window.facebook_authenticate_location;
  }, 200);
};

  

/*
 * "Session Ready" handler. This is called when the facebook
 * session becomes ready after the user clicks the "Facebook login" button.
 * In a more complex app, this could be used to do some in-page
 * replacements and avoid a full page refresh. For now, just
 * notify the server the user is logged in, and redirect to home.
 *
 * @param link_to_current_user  if the facebook session should be
 *                              linked to a currently logged in user, or used
 *                              to create a new account anyway
 */
function facebook_button_onclick() {

  ensure_init(function() {

    FB.Facebook.get_sessionState().waitUntilReady(function() {
        
      var user = FB.Facebook.apiClient.get_session() ?
        FB.Facebook.apiClient.get_session().uid :
        null;

      // probably should give some indication of failure to the user
      if (!user) {
        alert('There was an error talking to facebook. Try logging out and back in on facebook'); 
        return;
      }
      
      
      function permCheckDone(need_perms) {
        if (need_perms.length == 0) {
          redirect_authed();
        } else {
          FB.Connect.showPermissionDialog(need_perms.join(','), redirect_authed);
        }
      }
      
      FB.Facebook.apiClient.users_hasAppPermission('offline_access', function(result) {
        var need_perms = [];
        if (result === 0) { need_perms.push('offline_access') } 
        FB.Facebook.apiClient.users_hasAppPermission('publish_stream', function(result) {
          if (result === 0) { need_perms.push('publish_stream') }  
          permCheckDone(need_perms);
        });
      });
      
    });

  });
}


