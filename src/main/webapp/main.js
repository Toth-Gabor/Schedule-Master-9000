function populateTable(table, time, rows, cells, content) {
            if (!table) table = document.createElement('table');
                    var head = document.createElement('thead');
                    table.appendChild(head);

                    for (var x = 1; x <= time; x++) {
                        var title = document.createElement('th');
                        title.appendChild(document.createTextNode(x));
                        head.appendChild(title);
                    }
                var body = document.createElement('tbody');
                    for (var i = 0; i < rows; ++i) {
                        var row = document.createElement('tr');
                            for (var j = 0; j < cells; ++j) {
                            row.appendChild(document.createElement('td'));
                            row.cells[j].appendChild(document.createTextNode(content + (j + 1)));
                            }
                        table.appendChild(row);
                    }
                return table;
                }
$(document).ready(function () {
      document.getElementById('schedule-table-content')
      .appendChild(populateTable(null,7,24, 7, "content"));
        });
