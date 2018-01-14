Vue.filter('fixed2', function(value) {
	return value.toFixed(2);
});

iTek.on("Ready", function() {
	new Vue({
		el: '#app',
		data: {
			question: null,
			no: 1,
			commentCount: 0,
			stat: {}
		},
		computed: {
			isRight: function() {
				return this.question.status == 1;
			},
			isError: function() {
				return this.question.status == 2;
			},
			isNotDo: function() {
				return this.question.status == 0;
			}
		},
		methods: {
			select: function(answer) {
				if (this.isNotDo) {
					this.question.select = answer;
				}

			},
			check: function(value) {
				if (this.isNotDo || this.isRight) {
					return this.question.select == value;
				} else {
					return this.question.answer == value;
				}
			},

			checkError: function(value) {
				if (this.isError) {
					return this.question.select == value;
				}
			},

			submit: function() {
				if (!this.question.select) {
					alert("请选择答案");
					return;
				}

				var that = this;
				var result = (this.question.select === this.question.answer) ? "1" : "2";
				iTek.qb.saveDoQuestion({
					questionGuid: this.question.guid,
					chapterGuid: this.chapterGuid,
					answer: this.question.select,
					result: result
				}, function() {
					that.question.status = parseInt(result);
					if (!that.stat.likes) {
						iTek.qb.getDoQuestionInfo({
							questionGuid: that.question.guid
						}, function(result) {
							that.stat = result;
						});
					}
				});

			},

			showComments: function() {
				iTek.qp.showComments({
					questionGuid: this.question.guid
				});
			},

			incComments: function() {
				this.commentCount = '' + (parseInt(this.commentCount) + 1);
			}
		},
		created: function() {
			var guid = iTek.local["questionGuid"];
			this.no = parseInt(iTek.local["index"]) + 1;
			this.chapterGuid = iTek.local["chapterGuid"];

			var that = this;
			iTek.qb.getDoQuestion({
				questionGuid: guid
			}, function(result) {
				result.select = result.select || "";
				that.question = result;

				if (!that.isNotDo) {
					iTek.qb.getDoQuestionInfo({
						questionGuid: guid
					}, function(result) {
						that.stat = result;
					});
				}
			});

			iTek.qb.getCommentCount({
				questionGuid: guid
			}, function(result) {
				that.commentCount = result.count;
			});
		}
	});
});