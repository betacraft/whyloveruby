
var LikeButton = {}

$(document).ready(function(){
  LikeButton.init();
})


LikeButton = {
  init: function(){
          $('.likeButton').click(function(event){
            event.preventDefault();
            $(this).addClass('disabled')
            LikeButton.handleClick(this)
          })
        },

  handleClick: function(button){
                var url = $(button).data('url')
                $.get(url, '', function(data){
                  if(data.success){
                    $('.voteCount .' + data.id).text(data.likes)
                  }else{
                    // not sure what else..
                  }
                }, 'json') 
               }

}
