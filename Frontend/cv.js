
//fetch('https://ekq1gza932.execute-api.us-east-1.amazonaws.com/Test/getVisitorCount')
fetch('https://dm01y76po7.execute-api.us-east-1.amazonaws.com/')
.then(res => res.json())
.then(res => {document.getElementById("counter").innerHTML = res.count})
.then(data => console.log(data));