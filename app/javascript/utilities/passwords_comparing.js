document.addEventListener('turbolinks:load', function () {
    let password_confirmation = document.querySelector('[name = "user[password_confirmation]"]');

    if (password_confirmation) {
        password_confirmation.addEventListener('input', checkPasswords)
    }
})

function checkPasswords() {
    let password = document.querySelector('[name = "user[password]"]');
    let password_confirmation = document.querySelector('[name = "user[password_confirmation]"]');
    let resultField = document.querySelector('.result-comparison')

    if (password.value === 0 || password_confirmation.value === 0) {
        resultField.classList.remove('hide')
        return
    }

    if (password.value === password_confirmation.value) {
        resultField.classList.add('hide')
    } else {
        resultField.classList.remove('hide');
        resultField.style.color = 'red';
    }
}