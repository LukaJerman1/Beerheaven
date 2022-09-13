module.exports.register = (engine) => {
  engine.registerHelper("isDividable", (num1, num2) => {
    return num2 !== 0 && num1 % num2 === 0;
  });

  engine.registerHelper("sum", (num1, num2) => {
    return num1 + num2;
  });

  engine.registerHelper("formatDate", (date, format) => {
    let d = new Date(Date.parse(date));
    if (!d) return "";
    
    const [hour, minutes, seconds] = [d.getHours(), d.getMinutes(), d.getSeconds()];
    let datstr = [
        d.getDate().toString().padStart(2, '0'), 
        d.getMonth().toString().padStart(2, '0'), 
        d.getFullYear()
    ].join('.');
    let timestr = [
      d.getHours().toString().padStart(2, '0'), 
      d.getMinutes().toString().padStart(2, '0'), 
      d.getSeconds().toString().padStart(2, '0')
    ].join(':');
    if (timestr.replace(/0|:/g, '')) {
      datstr += " " + timestr;
    }
    return datstr;
  });
};
