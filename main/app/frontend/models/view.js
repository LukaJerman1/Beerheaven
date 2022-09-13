const { MenuModel, newTopMenu } = require('./menu');
const auth = require('../helpers/auth');

//v ta objekt bomo shranjevali vse podatke, ki jih bomo potrebovali, da prikažemo nek view
//preden objekt podamo metodi res.render, kličemo build(): res.render('view_name', model.build())
function parseReq(model, req) {
    model.page.path = req.path.substr(1);
    model.page.url = req.originalUrl;
    model.page.fullurl = req.protocol + '://' + req.get('host') + req.originalUrl;
    model.params.query = req.query;

}

function ViewModel(req) { 

    this.data = {};
    this.menu = {};
    this.page = {};
    this.params = {};
    this.errors = [];
    this.req = req;

    parseReq(this, req);

    this.setTitle = (title) => { this.page.title = title; return this; }

    this.setData = (data) => {
        this.data = data ? data : {};
        return this;
    }

    this.setCustomParams = (params) => {
        this.params.custom = params;
        return this;
    }

    this.addError = (message) => {
        this.errors.push(message);
        return this;
    }

    this.addMenu = (menu) => { 
        if (menu instanceof MenuModel) {
            this.menu[menu.name] = menu.item;
        }
        return this; 
    }

    this.build = () => { 
        let data = {
            page: this.page,
            menu: this.menu,
            params: this.params,
            user: auth.getUser(this.req),
            errors: this.errors,
            data: this.data
        };
        return data;
    }
}

function newDefaultViewModel(title, request, data) {
    let model = new ViewModel(request)
        ?.setTitle(title)
        ?.setData(data)
        ?.addMenu(newTopMenu(request));
    return model;
}

function newDefaultErrorViewModel(request, errors) {
  let model = newDefaultViewModel("Ups, prišlo je do napake", request, null);
  errors.map((err) => {
    model.addError(err);
  });
  return model;
}

module.exports = {
    ViewModel,
    newDefaultViewModel,
    newDefaultErrorViewModel
};