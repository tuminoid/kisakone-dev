module.exports = {
  'Log in as regular user' : function (client) {
    client
      .url('http://127.0.1.1/')
      .waitForElementVisible('body', 200)
      .click('#login_link')
      .waitForElementVisible('#login_form', 200)
      .setValue('#loginUsernameInput', 'testuser')
      .setValue('#loginPassword', 'test')
      .click('#loginSubmit')
      .pause(1000)
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Olet nyt kirjautunut sisään')
      .assert.containsText('.loginbox', 'Olet kirjautuneena tunnuksella')
  },
}
