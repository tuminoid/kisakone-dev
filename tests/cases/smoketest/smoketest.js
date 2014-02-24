module.exports = {
  'Smoketest Kisakone' : function (client) {
    client
      .url("http://127.0.0.1/")
      .waitForElementVisible('body', 1000)
      .assert.title('Ajankohtaiset kilpailut - Kisakone')
      .end();
  }
}