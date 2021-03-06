module.exports = {
  'Log in with default password' : function (client) {
    client
      .url(client.launch_url)
      .waitForElementVisible('body', 200)
      .assert.title('Ajankohtaiset kilpailut - Kisakone')
      .click('#login_link')
      .waitForElementVisible('#login_form', 200)
      .setValue('#loginUsernameInput', 'testuser')
      .setValue('#loginPassword', 'testpass')
      .click('#loginSubmit')
      .pause(200)
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Olet nyt kirjautunut sisään')
      .assert.containsText('.loginbox', 'Olet kirjautuneena tunnuksella')
  },

  'Change to simple password' : function (client) {
    client
      .assert.containsText('#loginMyInfo', 'Omat tiedot')
      .click('#loginMyInfo')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Käyttäjän testuser tiedot')
      .click('td#submenucontainer ul.submenu.submenu1 li:nth-child(2) a')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Voit vaihtaa salasanasi syöttämällä nykyisen')
      .setValue('#current', 'testpass')
      .setValue('#password1', 'passpass')
      .setValue('input[name=password2]', 'passpass')
      .submitForm('form#regform')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Tietojen muokkaus on tehty onnistuneesti.')
  },

  'Log out with simple password' : function (client) {
    client
      .waitForElementVisible('#header .loginbox', 200)
      .assert.containsText('.loginbox', 'Kirjaudu ulos')
      .click('#logout')
      .waitForElementVisible('body', 200)
      .assert.containsText('#login_link', 'Kirjaudu sisään')
      .end()
  },

  'Log in with simple password' : function (client) {
    client
      .url(client.launch_url)
      .waitForElementVisible('body', 200)
      .click('#login_link')
      .waitForElementVisible('#login_form', 200)
      .setValue('#loginUsernameInput', 'testuser')
      .setValue('#loginPassword', 'passpass')
      .click('#loginSubmit')
      .pause(200)
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Olet nyt kirjautunut sisään')
      .assert.containsText('.loginbox', 'Olet kirjautuneena tunnuksella')
  },

  'Change password to medium length' : function (client) {
    client
      .assert.containsText('#loginMyInfo', 'Omat tiedot')
      .click('#loginMyInfo')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Käyttäjän testuser tiedot')
      .click('td#submenucontainer ul.submenu.submenu1 li:nth-child(2) a')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Voit vaihtaa salasanasi syöttämällä nykyisen')
      .setValue('#current', 'passpass')
      .setValue('#password1', 'pass1234/,#€fl!!')
      .setValue('input[name=password2]', 'pass1234/,#€fl!!')
      .submitForm('form#regform')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Tietojen muokkaus on tehty onnistuneesti.')
  },

  'Log out with medium password' : function (client) {
    client
      .waitForElementVisible('#header .loginbox', 200)
      .assert.containsText('.loginbox', 'Kirjaudu ulos')
      .click('#logout')
      .waitForElementVisible('body', 200)
      .assert.containsText('#login_link', 'Kirjaudu sisään')
      .end()
  },

  'Log in with medium password' : function (client) {
    client
      .url(client.launch_url)
      .waitForElementVisible('body', 200)
      .click('#login_link')
      .waitForElementVisible('#login_form', 200)
      .setValue('#loginUsernameInput', 'testuser')
      .setValue('#loginPassword', 'pass1234/,#€fl!!')
      .click('#loginSubmit')
      .pause(200)
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Olet nyt kirjautunut sisään')
      .assert.containsText('.loginbox', 'Olet kirjautuneena tunnuksella')
  },

  'Change password to really long' : function (client) {
    client
      .assert.containsText('#loginMyInfo', 'Omat tiedot')
      .click('#loginMyInfo')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Käyttäjän testuser tiedot')
      .click('td#submenucontainer ul.submenu.submenu1 li:nth-child(2) a')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Voit vaihtaa salasanasi syöttämällä nykyisen')
      .setValue('#current', 'pass1234/,#€fl!!')
      .setValue('#password1', '#!$%3"&gg()mnQQ33€%&/(()"#"#€')
      .setValue('input[name=password2]', '#!$%3"&gg()mnQQ33€%&/(()"#"#€')
      .submitForm('form#regform')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Tietojen muokkaus on tehty onnistuneesti.')
  },

  'Log out with really long password' : function (client) {
    client
      .waitForElementVisible('#header .loginbox', 200)
      .assert.containsText('.loginbox', 'Kirjaudu ulos')
      .click('#logout')
      .waitForElementVisible('body', 200)
      .assert.containsText('#login_link', 'Kirjaudu sisään')
      .end()
  },

  'Log in with really long password' : function (client) {
    client
      .url(client.launch_url)
      .waitForElementVisible('body', 200)
      .click('#login_link')
      .waitForElementVisible('#login_form', 200)
      .setValue('#loginUsernameInput', 'testuser')
      .setValue('#loginPassword', '#!$%3"&gg()mnQQ33€%&/(()"#"#€')
      .click('#loginSubmit')
      .pause(200)
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Olet nyt kirjautunut sisään')
      .assert.containsText('.loginbox', 'Olet kirjautuneena tunnuksella')
  },

  'Change password back to default' : function (client) {
    client
      .assert.containsText('#loginMyInfo', 'Omat tiedot')
      .click('#loginMyInfo')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Käyttäjän testuser tiedot')
      .click('td#submenucontainer ul.submenu.submenu1 li:nth-child(2) a')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Voit vaihtaa salasanasi syöttämällä nykyisen')
      .setValue('#current', '#!$%3"&gg()mnQQ33€%&/(()"#"#€')
      .setValue('#password1', 'testpass')
      .setValue('input[name=password2]', 'testpass')
      .submitForm('form#regform')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Tietojen muokkaus on tehty onnistuneesti.')
  },

  'Log out with default password' : function (client) {
    client
      .waitForElementVisible('#header .loginbox', 200)
      .assert.containsText('.loginbox', 'Kirjaudu ulos')
      .click('#logout')
      .waitForElementVisible('body', 200)
      .assert.containsText('#login_link', 'Kirjaudu sisään')
      .end()
  },

  'Log in with default password again' : function (client) {
    client
      .url(client.launch_url)
      .waitForElementVisible('body', 200)
      .click('#login_link')
      .waitForElementVisible('#login_form', 200)
      .setValue('#loginUsernameInput', 'testuser')
      .setValue('#loginPassword', 'testpass')
      .click('#loginSubmit')
      .pause(200)
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Olet nyt kirjautunut sisään')
      .assert.containsText('.loginbox', 'Olet kirjautuneena tunnuksella')
      .end()
  }
}
