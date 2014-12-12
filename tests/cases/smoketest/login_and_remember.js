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
      .click('#loginRememberMe')
      .click('#loginSubmit')
      .pause(1000)
      .waitForElementVisible('td#content', 200)
      .assert.containsText('.loginbox', 'Olet kirjautuneena tunnuksella')
      .assert.containsText('td#content', 'Olet nyt kirjautunut sisään')
  },

/*
  'Check cookie validity' : function (client) {
    client
      .getCookie(function checkCookieName(result) {
        this.assert.equals(result.name, 'kisakone_login')
      })
      .end()
  },
*/
}
