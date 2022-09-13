const getDateNow = () => {
  let dat = new Date();
  dat.setTime(dat.getTime() - dat.getTimezoneOffset()*60*1000);
  return dat;
};

module.exports = {
  getDateNow
};