/**
 * https://itechowl.wordpress.com/2020/01/27/javascript-not-allowed-to-navigate-top-frame-to-data-url-chrome/
 * https://stackoverflow.com/questions/27980612/converting-base64-to-blob-in-javascript/27980815
**/ 

$(document).ready(function() {
  $("img.base64").each(function() {
    var item = $(this);
    fetch(item.attr("src")).
      then(res => res.blob()).
      then(blob => {
        let url = URL.createObjectURL(blob);
        item.attr("src", url);
      });
  });
  $("a.base64").each(function() {
    var item = $(this);
    fetch(item.attr("href")).
      then(res => res.blob()).
      then(blob => {
        let url = URL.createObjectURL(blob);
        item.attr("href", url);
      });
  });
});



function shareFB(url) {
  FB.ui({
    method: 'share',
    href: url
  }, function(response){});
}
