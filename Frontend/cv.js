
fetch('https://i8jzd7yev5.execute-api.us-east-1.amazonaws.com/')
.then(res => res.json())
.then(res => {document.getElementById("counter").innerHTML = res.count})
.then(data => console.log(data));