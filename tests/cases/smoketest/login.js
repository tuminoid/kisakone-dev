module.exports = {
  'Verify site loads' : function (client) {
    client
      .url('http://127.0.1.1/')
      .waitForElementVisible('body', 200)
      .assert.title('Ajankohtaiset kilpailut - Kisakone')
  },

  'Log in as admin' : function (client) {
    client
      .click('#login_link')
      .waitForElementVisible('#login_form', 200)
      .setValue('#loginUsernameInput', 'admin')
      .setValue('#loginPassword', 'apass')
      .click('#loginSubmit')
      .pause(1000)
      .waitForElementVisible('td#content', 200)
      .assert.containsText('#login_panel', 'Olet kirjautuneena tunnuksella')
  },

  'Check cookie validity' : function (client) {
    client
      .getCookies(function callback(result) {
        this.assert.equal(result.value.length, 1);
//        this.assert.equals(result.value[0].name, 'kisakone_login');
    })
  },

  'Log out' : function (client) {
    client
      .waitForElementVisible('#header #login_panel', 200)
      .assert.containsText('#login_panel', 'Kirjaudu ulos')
      .click('#logout')
      .waitForElementVisible('body', 200)
      .assert.containsText('#login_link', 'Kirjaudu sisään')
      .end()
  }
}
