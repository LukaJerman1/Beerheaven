const auth = require('../helpers/auth');

function MenuModel(name) {
    
    this.name = name;
    this.item = { };
    
    this.addMenuItem = (name, item) => {
        this.item[name] = item;
        return this;
    };
};

function newTopMenu(req) {
    let menu = new MenuModel("top")
        ?.addMenuItem("home", { title: "Domov", link: "/", active: true, selected: false})
        ?.addMenuItem("breweries", { title: "Pivovarne", link: "/breweries", active: true, selected: false})
        ?.addMenuItem("forum", { title: "Forum", link: "/forum", active: true, selected: false});
    if (auth.isAuthenticated(req)) {
        menu.addMenuItem("brewery", { title: "Moja pivovarna", link: "/brewery", active: true, selected: false});
        menu.addMenuItem("logout", { title: "Odjava", link: "/logout", active: true, selected: false});
    } else {
        menu.addMenuItem("login", { title: "Prijava", link: "/login", active: true, selected: false});
    }
    return menu;
}

module.exports = 
{
    MenuModel,
    newTopMenu
};