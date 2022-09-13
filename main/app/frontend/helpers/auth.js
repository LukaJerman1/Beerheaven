const session = require('express-session');
//funkcije morajo biti registrirane kot middleware in povezane na req (kar naredi passport knjižnica)

const isAuthenticated = (req) => {
    //preverimo samo, če imamo v seji uporabnika in ima ta uporabnik id;
    return req.session.user && req.session.user.id;
};

const getUser = (req) => { 
    return isAuthenticated(req) ? req.session.user : null; 
}

module.exports = {
        
    //uporablja se kot funkcija: requireRegisteredUser(opcijski_parametri)
    //params: za parametrizacijo
    requireRegisteredUser: ((params) => { 
        //TODO: optional parameters .. lahko naredimo kak redirect drugam ali kaj podobnega glede na parametre
        let p = params ? params : {};
        return (req, res, next) => {
            if (isAuthenticated(req)) {
                return next();
            }
            if (params.login) {
              res.redirect('/login' + (params.redirect ? "?redirect=" + params.redirect : ""));
            } else if (params.redirect) {
              // '/' must be public
              res.redirect(req.path !== params.redirect ? params.redirect : '/');
            } else {
                res.status('404').send("Potrebna je prijava.");
            }
        }
    }),
        
    isAuthenticated,
    getUser
};