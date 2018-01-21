var vue
iTek.on("Ready", function() {
	vue = new Vue({
		el: '#app',
		data: {
			comments: []
		},
		methods: {
			addComment: function(item) {
				iTek.callback.addComment(item)
			},
            insertComment: function(item) {
                //native call
                this.comments.unshift(item)
            }
		},
		created: function() {
            iTek.__html5_reg('callback','addComment')
			var questionGuid = iTek.local["questionGuid"];

			var that = this;

			iTek.qb.getComments({
				questionGuid: questionGuid
			}, function(result) {
				that.comments = result;
			});
		}
	});
});
