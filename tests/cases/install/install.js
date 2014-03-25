module.exports = {
  'Verify Kisakone not installed' : function (client) {
    client
      .url("http://127.0.0.1/doc/install/install.php")
      .waitForElementVisible('body', 1000)
      .assert.elementPresent('#installform')
  },

  'Install Kisakone' : function(client) {
    client
      .setValue('#db_host', 'localhost')
      .setValue('#db_user', 'root')
      .setValue('#db_pass', 'pass')
      .setValue('#db_db', 'test_kisakone')
      .setValue('#db_prefix', 'test_')
      .setValue('#ad_user', 'admin')
      .setValue('#ad_pass', 'apass')
      .setValue('#ad_firstname', 'Admin')
      .setValue('#ad_lastname', 'God')
      .setValue('#ad_email', 'admin@localhost')
      .click('#formsubmit')
      .waitForElementVisible('body', 1000)
      .assert.containsText('body', 'Done.')
  },

  'Verify installation' : function (client) {
    client
      .url("http://127.0.0.1/")
      .waitForElementVisible('body', 1000)
      .assert.title('Ajankohtaiset kilpailut - Kisakone')
      .end();
  }
}