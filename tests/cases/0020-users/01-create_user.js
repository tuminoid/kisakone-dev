module.exports = {
  'Create an user' : function (client) {
    client
      .url(client.launch_url)
      .waitForElementVisible('body', 200)
      .click('#register_link')
      .waitForElementVisible('#regform', 200)
      .setValue('#firstname', 'Test')
      .setValue('#lastname', 'User')
      .setValue('#email', 'test@user.invalid')
      .setValue('#username', 'testuser')
      .setValue('#password1', 'test')
      .setValue('#password2', 'test')
      .click('#gender')
      .click('#termsandconditions')
      .click('#registerButton')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Tervetuloa kisakoneen käyttäjäksi, testuser!')
      .assert.containsText('.loginbox', 'Olet kirjautuneena tunnuksella')
  },

  'Log user out' : function (client) {
    client
      .waitForElementVisible('#header .loginbox', 200)
      .assert.containsText('.loginbox', 'Kirjaudu ulos')
      .click('#logout')
      .waitForElementVisible('body', 200)
      .assert.containsText('#login_link', 'Kirjaudu sisään')
      .end()
  }
}
