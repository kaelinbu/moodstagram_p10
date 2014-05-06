$(document).ready(function() {
  $('button').on('click', getImages);

});

function getImages(event) {
  event.preventDefault();

  var request = $.ajax({
    url: '/images',
    data: {tag: this.id},
    type: 'GET'
  });

  request.done(showImage);
  $('.images div').remove();
}

function showImage(a) {
  $('.images').append(a);
}