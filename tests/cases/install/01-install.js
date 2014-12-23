module.exports = {
  'Install Kisakone' : function (client) {
    var data = client.globals;
    client
      .url(data.url + "/doc/install/install.php")
      .waitForElementVisible('body', 200)
      .assert.elementPresent('#installform')
      .setValue('#db_host', '127.0.0.1')
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
      .waitForElementVisible('body', 200)
      .assert.containsText('body', 'Done.')
      .url(client.launch_url)
      .waitForElementVisible('body', 200)
      .assert.title('Ajankohtaiset kilpailut - Kisakone')
      .end();
  }
}
