casper.test.begin('Test signing in with wrong credentials', function(test) {
  casper.start('http://localhost:3000/users/sign_in', function() {
    test.assertUrlMatch(/http:\/\/localhost:3000\/users\/sign_in[\/]{0,}/, 'We arrived at expected URL for signing in');
  });
  casper.then(function() {
    this.fillSelectors('form#new_user', {
      'input[name="user[email]"]': 'nutsgmuic@gmail.com',
      'input[name="user[password]"]': '11111111'
    }, true);
  });
  casper.then(function() {
    test.assertUrlMatch(/http:\/\/localhost:3000\/users\/sign_in[/]{0,}/, 'We are redirected to sign in again');
    test.assertVisible('.alert-danger', "Alert element found.");
  });
  casper.run(function() {
    test.done();
  });
});
