module.exports = function (chromy, scenario) {
  var wait = scenario.wait;
  if (wait) {
    chromy.wait(wait)
  }
};
