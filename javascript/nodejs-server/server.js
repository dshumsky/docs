'use strict';

const express = require('express');

// Constants
const PORT = 8080;
const HOST = '0.0.0.0';

// App
const app = express();
app.get('/', (req, res) => {
    console.log("/");
    res.send('Hello world\n');
});

app.get('/cache/1', (req, res) => {
    console.log("/cache/1");
    res.header('cache-control' , 'max-age=60, s-max-age=60');
    res.header('Last-Modified' , 'Sat, 26 Oct 1985 08:15:00 GMT');
    res.header('Date', 'Wed, 08 Jan 2020 12:36:56 GMT');
    res.send('Cached v3\n');
});


app.listen(PORT, HOST);
console.log(`Running on http://${HOST}:${PORT}`);
