function loadAmountActivities(token) {
    $.ajax({
        url: '/api/user/nrecords',
        type: 'GET',
        contentType: 'application/json',
        headers: {
            'Authorization': 'Bearer ' + token
        },
        success: function (result) {
            let span = document.getElementById('amount_activities');
            span.innerText = result.records.toString();
        },
        error: function (error) {
            console.log(error);
        }
    });
}

function loadActivities(token) {
    $.ajax({
        url: '/api/user/get_records',
        type: 'GET',
        contentType: 'application/json',
        headers: {
            'Authorization': 'Bearer ' + token
        },
        success: function (result) {
            console.log(result);
            drawActivities(result)
        },
        error: function (error) {
            console.log(error);
        }
    });
}

function drawActivities(activities) {
    let arr = new Map();
    for (let i = 0; i < activities.length; ++i) {
        let key = activities[i].category;
        if (!arr.has(key)) {
            arr.set(key, 0);
        }
        arr.set(key, arr.get(key) + 1);
    }
    arr = Array.from(arr.entries());

    console.log(arr);

    if (arr.length) {

        let data = [{
            values: arr.map(d => d[1]),
            labels: arr.map(d => d[0]),
            type: 'pie'
        }];

        let layout = {
            height: 400,
            width: 500,
            title: "All activities"
        };

        Plotly.newPlot('example', data, layout);
        plot = document.getElementById('example');
        plot.on('plotly_click', function (data) {
            let pts = '';
            for (let i = 0; i < data.points.length; i++) {
                pts = data.points[i];
            }
            drawDetails(activities, pts.label);
        });
    }
}

function drawDetails(activities, type) {
    let arr = [];
    for (let i = 0; i < activities.length; ++i) {
        if (activities[i].category === type) {
            arr.push({"distance": activities[i].distance, "difficulty": activities[i].difficulty, "name": activities[i].name});
        }
    }
    console.log(arr);
    let data = [{
        values: arr.map(d => d.distance),
        labels: arr.map(d => (d.name + ": " + d.difficulty)),
        type: 'pie',
    }];

    let layout = {
        height: 400,
        width: 500,
        title: "Category: " + type
    };
    Plotly.newPlot('details', data, layout);
}