var vue;
iTek.on("Ready", function(){
    vue = new Vue({
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
                iTek.qb.startDoQuestion({
                                        index: index,
                                        subjectName: this.subjectName,
                                        chapterGuid: this.chapterGuid,
                                        chapterName: this.chapterName,
                                        questionGuid: guid,
                                        type: this.type
                });
            },
            reloadQuestions: function() {
                var that = this;
                iTek.qb.getChapterQuestion({chapterGuid: this.chapterGuid, type: this.type}, function(result){
                    that.questions = result;
                });
            }
        },
        created: function() {
            this.chapterGuid = iTek.local['chapterGuid'];
            this.chapterName = iTek.local['chapterName'];
            this.subjectName = iTek.local['subjectName'];
            this.type = iTek.local['type'];
            this.reloadQuestions();
        }
    });
});

