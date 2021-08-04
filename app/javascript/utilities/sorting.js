document.addEventListener('turbolinks:load', function () {
    let control = document.querySelector('.sort-by-title');

    if (control) {
        control.addEventListener('click', sortRowsByTitle);
    }
})

function sortRowsByTitle() {
    let table = document.querySelector('.tests-list');
    let rows = table.querySelectorAll('.card'); // NodeList
    let sortedRows = [];

    for (let i = 0; i < rows.length; i++) {
        sortedRows.push(rows[i]);
    }

    if (this.querySelector('.octicon-arrow-up').classList.contains('hide')) {
        sortedRows.sort(compareRowsAsc)
        this.querySelector('.octicon-arrow-up').classList.remove( 'hide')
        this.querySelector('.octicon-arrow-down').classList.add( 'hide')
    } else {
        sortedRows.sort(compareRowsDesc)
        this.querySelector('.octicon-arrow-up').classList.add( 'hide')
        this.querySelector('.octicon-arrow-down').classList.remove( 'hide')
    }

    let sortedTable = document.createElement('div')
    sortedTable.classList.add('tests-list')

    for (let i = 0; i < sortedRows.length; i++) {
        sortedTable.appendChild(sortedRows[i])
    }

    table.parentNode.replaceChild(sortedTable, table)
}

function compareRowsAsc(row1, row2) {
    let testTitle1 = row1.querySelector('.card-title').textContent
    let testTitle2 = row2.querySelector('.card-title').textContent

    if (testTitle1 < testTitle2) {
        return -1
    } else if (testTitle1 > testTitle2) {
        return 1
    }
    return 0
}

function compareRowsDesc(row1, row2) {
    let testTitle1 = row1.querySelector('.card-title').textContent
    let testTitle2 = row2.querySelector('.card-title').textContent

    if (testTitle1 < testTitle2) {
        return 1
    } else if (testTitle1 > testTitle2) {
        return -1
    }
    return 0
}