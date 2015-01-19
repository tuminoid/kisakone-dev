module.exports = {
  'Log in as admin' : function (client) {
    client
      .url(client.launch_url)
      .waitForElementVisible('body', 200)
      .assert.title('Ajankohtaiset kilpailut - Kisakone')
      .click('#login_link')
      .waitForElementVisible('#login_form', 200)
      .setValue('#loginUsernameInput', 'admin')
      .setValue('#loginPassword', 'adminpass')
      .click('#loginSubmit')
      .pause(200)
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Olet nyt kirjautunut sisään')
      .assert.containsText('.loginbox', 'Olet kirjautuneena tunnuksella')
  },

/* TODO
  'Check cookie validity' : function (client) {
    client
      .getCookie(function callback(result) {
        this.assert.equals(result.name, 'kisakone_login');
    })
  },
*/

  'Log out admin' : function (client) {
    client
      .waitForElementVisible('#header .loginbox', 200)
      .assert.containsText('.loginbox', 'Kirjaudu ulos')
      .click('#logout')
      .waitForElementVisible('body', 200)
      .assert.containsText('#login_link', 'Kirjaudu sisään')
  },

  'Remember login as admin' : function (client) {
    client
      .url(client.launch_url)
      .waitForElementVisible('body', 200)
      .assert.title('Ajankohtaiset kilpailut - Kisakone')
      .click('#login_link')
      .waitForElementVisible('#login_form', 200)
      .setValue('#loginUsernameInput', 'admin')
      .setValue('#loginPassword', 'adminpass')
      .click('#loginRememberMe')
      .click('#loginSubmit')
      .pause(200)
      .waitForElementVisible('td#content', 200)
      .assert.containsText('.loginbox', 'Olet kirjautuneena tunnuksella')
      .assert.containsText('td#content', 'Olet nyt kirjautunut sisään')
  },

/* TODO
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
  },
}
