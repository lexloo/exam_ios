iTek.on("Ready", function(){
    new Vue({
        el: '#app',
        data: {
            questions: null
        },
        computed: {
            title: function() {
                return this.chapterName;
            }
        },
        methods: {
            doQuestion: function(index, guid) {
//                __Native__.startDoQuestion(parseInt(index), this.subjectName, this.chapterGuid, this.chapterName, this.type);
            }
        },
        created: function() {
            this.chapterGuid = iTek.local['chapterGuid'];
            this.chapterName = iTek.local['chapterName'];
            this.subjectName = iTek.local['subjectName'];
            this.type = iTek.local['type'];
        
            var that = this;
            iTek.qb.getChapterQuestion({chapterGuid: this.chapterGuid, type: this.type}, function(result){
                that.questions = result;
            });
        }
    });
});

