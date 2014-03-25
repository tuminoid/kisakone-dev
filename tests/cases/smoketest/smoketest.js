module.exports = {
  'Verify site loads' : function (client) {
    client
      .url('http://127.0.0.1/')
      .waitForElementVisible('body', 1000)
      .assert.title('Ajankohtaiset kilpailut - Kisakone')
  },

  'Log in as admin' : function (client) {
    client
      .click('#login_link')
      .waitForElementVisible('#login_form', 1000)
      .setValue('#loginUsernameInput', 'admin')
      .setValue('#loginPassword', 'apass')
      .click('#loginSubmit')
      .pause(1000)
      .waitForElementVisible('td#content', 1000)
      .assert.containsText('td#content', 'Sisäänkirjautuminen onnistui')
  },

/*
  'Check cookie validity' : function (client) {
    client
      .getCookie(function checkCookieName(result) {
        this.assert.equals(result.name, 'kisakone_login')
      })
  },
*/

  'Log out' : function (client) {
    client
      .waitForElementVisible('#header .loginbox', 1000)
      .click('#logout')
      .waitForElementVisible('body', 1000)
      .assert.containsText('#login_link', 'Kirjaudu sisään')
      .end()
  }
}