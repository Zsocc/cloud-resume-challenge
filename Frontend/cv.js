
fetch('https://ekq1gza932.execute-api.us-east-1.amazonaws.com/Test/getVisitorCount')
.then(res => res.json())
.then(res => {document.getElementById("counter").innerHTML = res.count})
.then(data => console.log(data));
