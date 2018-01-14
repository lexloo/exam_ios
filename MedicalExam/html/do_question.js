Vue.filter('fixed2', function(value) {
  return value.toFixed(2);
});
alert("MMMMM")
iTek.on("Ready", function(){
var vue = new Vue({
	el: '#app',
	data: {
		question: null,
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

			let result = (this.question.select === this.question.answer) ? 1 : 2;

//            __Native__.saveDoQuestion(this.question.guid, this.chapterGuid, this.question.select, result);
			window.location.reload();
		},

		showComments: function() {
//            __Native__.showComments(this.question.guid);
		},

		incComments: function() {
			this.commentCount = '' + (parseInt(this.commentCount) + 1);
		}
	},
	created: function() {
                  alert(iTek.local["questionGuid"]);
//        this.no = parseInt(getUrlKey('no'));
//        this.chapterGuid = getUrlKey('chapter_guid');
//
//        let data = JSON.parse(__Native__.getDoQuestion(this.no));
//        data.select = data.select || '';
//
//        this.question = data;

//        this.commentCount = __Native__.getCommentCount(this.question.guid);

		if (!this.isNotDo) {
//            this.stat = JSON.parse(__Native__.getDoQuestionInfo(this.question.guid)) || {};
		}
	}
});
});
