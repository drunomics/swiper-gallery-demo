module.exports = function (chromy, scenario, vp) {
  console.log('SCENARIO > ' + scenario.label);
  require('./clickAndHoverHelper')(chromy, scenario);
  require('./inputHelper')(chromy, scenario);
  // add more ready handlers here...
  chromy.evaluate(() => {
    window.vueApp.$Lazyload.ListenerQueue.forEach((listener) => {listener.load();});
  })
  require('./waitHelper')(chromy, scenario);
};
