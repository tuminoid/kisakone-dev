module.exports = {
  'Log in as regular user' : function (client) {
    client
      .url(client.launch_url)
      .waitForElementVisible('body', 200)
      .assert.title('Ajankohtaiset kilpailut - Kisakone')
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

  'Change password' : function (client) {
    client
      .assert.containsText('.loginbox', 'Omat tiedot')
      .click('#loginMyInfo')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Käyttäjän testuser tiedot')
      .click('td#submenucontainer ul.submenu.submenu1 li:nth-child(2) a')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Voit vaihtaa salasanasi syöttämällä nykyisen')
      .setValue('#current', 'test')
      .setValue('#password1', 'pass')
      .setValue('input[name=password2]', 'pass')
      .submitForm('form#regform')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Tietojen muokkaus on tehty onnistuneesti.')
  },

  'Log out' : function (client) {
    client
      .waitForElementVisible('#header .loginbox', 200)
      .assert.containsText('.loginbox', 'Kirjaudu ulos')
      .click('#logout')
      .waitForElementVisible('body', 200)
      .assert.containsText('#login_link', 'Kirjaudu sisään')
      .end()
  },

  'Log in with new password' : function (client) {
    client
      .url(client.launch_url)
      .waitForElementVisible('body', 200)
      .click('#login_link')
      .waitForElementVisible('#login_form', 200)
      .setValue('#loginUsernameInput', 'testuser')
      .setValue('#loginPassword', 'pass')
      .click('#loginSubmit')
      .pause(200)
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Olet nyt kirjautunut sisään')
      .assert.containsText('.loginbox', 'Olet kirjautuneena tunnuksella')
  },

  'Change password again' : function (client) {
    client
      .assert.containsText('.loginbox', 'Omat tiedot')
      .click('#loginMyInfo')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Käyttäjän testuser tiedot')
      .click('td#submenucontainer ul.submenu.submenu1 li:nth-child(2) a')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Voit vaihtaa salasanasi syöttämällä nykyisen')
      .setValue('#current', 'pass')
      .setValue('#password1', 'test')
      .setValue('input[name=password2]', 'test')
      .submitForm('form#regform')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Tietojen muokkaus on tehty onnistuneesti.')
  },

  'Log out again' : function (client) {
    client
      .waitForElementVisible('#header .loginbox', 200)
      .assert.containsText('.loginbox', 'Kirjaudu ulos')
      .click('#logout')
      .waitForElementVisible('body', 200)
      .assert.containsText('#login_link', 'Kirjaudu sisään')
      .end()
  },

  'Log in with old password' : function (client) {
    client
      .url(client.launch_url)
      .waitForElementVisible('body', 200)
      .click('#login_link')
      .waitForElementVisible('#login_form', 200)
      .setValue('#loginUsernameInput', 'testuser')
      .setValue('#loginPassword', 'test')
      .click('#loginSubmit')
      .pause(200)
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Olet nyt kirjautunut sisään')
      .assert.containsText('.loginbox', 'Olet kirjautuneena tunnuksella')
      .end()
  }
}
