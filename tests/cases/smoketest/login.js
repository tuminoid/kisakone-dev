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
      .assert.containsText('td#content', 'Olet nyt kirjautunut sisään')
      .assert.containsText('.loginbox', 'Olet kirjautuneena tunnuksella')
  },

/*
  'Check cookie validity' : function (client) {
    client
      .getCookie(function callback(result) {
        this.assert.equals(result.name, 'kisakone_login');
    })
  },
*/
  'Log out' : function (client) {
    client
      .waitForElementVisible('#header .loginbox', 200)
      .assert.containsText('.loginbox', 'Kirjaudu ulos')
      .click('#logout')
      .waitForElementVisible('body', 200)
      .assert.containsText('#login_link', 'Kirjaudu sisään')
      .end()
  }
}
