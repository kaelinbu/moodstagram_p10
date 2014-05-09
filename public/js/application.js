$(document).ready(function() {
  $('.button_nav').on('click','button', getImages);
  $('.button_nav').on('click', 'button', updateButtons);
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

function updateButtons(event) {

  var request = $.ajax({
    url: '/update',
    type: 'GET'
  });

  request.done(showNewButtons);
}

function showNewButtons(a) {
  $('.choices').replaceWith(a);
}