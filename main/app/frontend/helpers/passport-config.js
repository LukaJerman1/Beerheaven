const bcrypt = require('bcrypt');
const LocalStrategy = require('passport-local').Strategy;

module.exports = (passport, getUserByEmail, getUserById) => {
    //funkcija za authentikacijo uporabnika
    //done se kliče da se določi rezultat auth.
    const auth = async (email, password, done) => {
        const user = getUserByEmail(email);
        if (user === null) {
            return done(null, false, { message: "Ni takšnega uporabnika"});
        } else {
            try {    
                //preverimo, če je geslo pravo
                if (await bcrypt.compare(password, user.password)) {
                    return done(null, user)
                } else {
                    //geslo se ne ujema
                    return done(null, false, { message: "Napačno geslo"});
                }
            } catch (error) {
                //do tega ne bi smelo priti ..
                console.log(error.message);
                done(error);  
            }
        }
    };

    //izvršimo inicializacijo
    passport.use(new LocalStrategy({usernameFiled: "email", passwordField: "password"}, auth));
    passport.serializeUser((user, done) => { done(null, user.id) });
    passport.deserializeUser((id, done) => { return done(null, getUserById(id))});
};