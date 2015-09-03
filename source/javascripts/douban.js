var douban = (function(){
  function render(target, books){
    var i = 0, fragment = '', t = $(target)[0];

    for(i = 0; i < books.length; ++i) {
      fragment += '<li><a href="' + books[i].html_url + '">' + books[i].name + '</a></li>';
    }
    t.innerHTML += fragment;
  }
  return {
    showBooks: function(options){
	  var statusList = { reading: "What am I reading?", read: "What did I read?", wish: "What do I wish to read?" };
	  for(status in statusList) {
	    var startIndex = 1;
		do {
          $.ajax({
            url: "http://api.douban.com/people/" + options.user + "/collection?cat=book&status=" + status + "&start-index=" + startIndex + "&max-results=50",
            type: 'xml',
            error: function (err) { $(options.target + ' li.loading').addClass('error').text("Error loading feed"); },
            success: function (data) {
              var books = [];
              if (!data ) { return; }
              for (var i = 0; i < data.length; ++i) books.push(data[i]);
              if (options.count) { books.splice(options.count); }
              render(options.target, books);
            }
          });
		} while();
	  }
    }
  };
})();
