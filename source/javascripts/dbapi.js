var dbapi = (function() {
    var render = function (infos) {
        var html = '';
        for(var i = 0; i < infos.length; ++i) {
            var detail = infos[i]["db:subject"];
            var title = detail["title"]["$t"];
            var link = detail["link"][1]["@href"];
//          var image = detail["link"][2]["@href"];
            html += '<a href="' + link + '" target="_blank">' + title + '</a>';
        }
        return html;
    };

    var getURL = function (status, begin, count) {
        var url = "https://api.douban.com/people/" + opts.user + "/collection?cat=book&alt=json";
        url += "&status=" + status + "&start-index=" + begin + "&max-results=" + count;
        if (opts.api.length > 0) url += "&apikey=" + opts.api;
        return url;
    };

    var appendInfos = function (item, total) {
        if(total > item.maxCount) total = item.maxCount;
        for(var i = 1; i <= total; i += 50) {
            $.ajax({
                url: getURL(item.status, i, 50),
                type: "jsonp",
                success: function (data) { $("#book_" + item.status).append(render(data.entry)); }
            });
        }
    };

    var defaults = {
        target: "douban",
        user: "metaphilosophy",
        api: "0a071301c64c69681e15390552e53c38",
        count: [{status: "reading", maxCount: 20}, {status: "read", maxCount: 200}, {status: "wish", maxCount: 200}],
        readingTitle: "What am I reading?",
        readTitle: "What did I read?",
        wishTitle: "What do I wish to read?"
    };

    var opts = defaults;

    return {
        showBooks: function() {
            var h = $("#" + opts.target);
            if(h.length === 0) h = $("<ul/>").attr("id", opts.target).prependTo($("body"));
            for(var i = 0; i < opts.count.length; ++i) {
                var item = opts.count[i];
                if($("#book_" + item.status).length === 0) {
                    $("<li/>").text(opts[item.status + "Title"]).appendTo(h);
                    $("<li/>").attr("id", "book_" + item.status).addClass("douban-list").appendTo(h);
                }
                $.ajax({
                    url: getURL(item.status, 1, 0),
                    type: "jsonp",
                    error: function (err) { $("#book_" + this.item.status).addClass('error').text("Error loading feed"); },
                    success: function (data) { appendInfos(this.item, data["opensearch:totalResults"]["$t"]); },
                    item: item
                });
            }
        }
    };
})();
