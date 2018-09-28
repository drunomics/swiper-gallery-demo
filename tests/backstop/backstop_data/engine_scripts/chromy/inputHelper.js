module.exports = function (chromy, scenario) {
  var inputSelector = scenario.inputSelector;
  var input = scenario.input;
  var postInteractionWait = scenario.postInteractionWait; // selector [str] | ms [int]

  if (inputSelector && input) {
    chromy
      .wait(inputSelector)
      .type(inputSelector, input)
  }

  if (postInteractionWait) {
    chromy.wait(parseInt(postInteractionWait, 10));
  }
};
