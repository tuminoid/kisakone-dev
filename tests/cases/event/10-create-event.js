/* this is TODO, fails now */

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

  'Create event' : function (client) {
    client
      .url(client.launch_url)
      .assert.containsText('.loginbox', 'Omat tiedot')
      .assert.containsText('td#content', 'Ajankohtaiset kilpailut')
      .click('ul#mainmenu li:nth-child(4)')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#submenucontainer', 'Uusi kilpailu')
      .click('#submenucontainer li:nth-child(6)')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Luo uusi kilpailu')
      .setValue('#name', 'test event')
      .setValue('#venueField', 'test venue')
      .setValue('#tournament', 'test tournament')
      .setValue('#level', 'test level')
      .setValue('#start', '2020-06-30')
      .setValue('#duration', '2')
      .setValue('#playerlimit', '2')
      .setValue('#signup_start', '2020-06-28 09:00')
      .setValue('#signup_end', '2020-06-29 21:00')
      .setValue('#contact', 'test contact')
      .setValue('#td', 'admin')
      .submitForm('form#eventform')
      .waitForElementVisible('td#content', 200)
      .assert.containsText('td#content', 'Tulossa olevat kilpailut')
      .assert.containsText('td#content', 'test event')
      .assert.containsText('td#content', 'test venue')
      .assert.containsText('td#content', '30.06.2020 - 01.07.2020')
  }
}
