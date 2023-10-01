
//fetch('https://ekq1gza932.execute-api.us-east-1.amazonaws.com/Test/getVisitorCount')
fetch('https://efpic5j5fl.execute-api.us-east-1.amazonaws.com/')
.then(res => res.json())
.then(res => {document.getElementById("counter").innerHTML = res.count})
.then(data => console.log(data));