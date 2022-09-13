var axios = require('axios');

module.exports = axios.create({
    /* process.env potrebuje recompile?? da se pozna?? */
    baseURL: "http://localhost:8000/api",
    timeout: 30000,
    headers: {
        "Content-Type": "application/json",
        "Accept": "application/json"
    }
});
