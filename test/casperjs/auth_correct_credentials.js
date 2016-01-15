casper.test.begin('Test signing in with correct credentials', function(test) {
  casper.start('http://localhost:3000/users/sign_in', function() {
    test.assertUrlMatch(/http:\/\/localhost:3000\/users\/sign_in/, 'We arrived at expected URL for signing in');
  });
  casper.then(function() {
    this.fillSelectors('form#new_user', {
      'input[name="user[email]"]': 'nutsgmuic@gmail.com',
      'input[name="user[password]"]': '00000000'
    }, true);
  });
  casper.then(function() {
    test.assertUrlMatch(/http:\/\/localhost:3000[/]{0,}$/, 'Successfully signed in.');
    test.assertVisible('.alert-info', "Notice element found.");
    test.assertSelectorHasText('a.dropdown-toggle', 'nutsgmuic@gmail.com', "User menu with email labeled is shown");
  });
  casper.run(function() {
    casper.clear();
    test.done();
  });
});
