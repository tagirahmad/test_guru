document.addEventListener('turbolinks:load', function () {
    let progress = document.querySelector('.progress-bar');

    if (progress) {
        let questionPosition = progress.dataset.questionPosition;
        let questionsCount = progress.dataset.questionsCount;
        progress.style.width = questionPosition === '1' ? '0 %' : (Math.floor(questionPosition / questionsCount * 100) + '%')
    }
})
