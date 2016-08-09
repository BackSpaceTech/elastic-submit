# coffeelint: disable=max_line_length
exports.name = 'backlinksindexer.com'
exports.url = 'http://backlinksindexer.com/wp-login.php'
exports.steps = [
  {
    command: 'wait-for'
    selector: '#user_login'
  }
  {
    command: 'login-indexer'
    form: '#loginform'
    username: '#user_login'
    password: '#user_pass'
    submit: true
  }
  {
    command: 'click'
    selector: '#wp-submit'
  }
  {
    command: 'wait'
    value: 5000
  }
  {
    command: 'wait-for'
    selector: '#url-textarea'
  }
  {
    command: 'backlinks'
    selector: '#url-textarea'
  }
  {
    command: 'click'
    selector: '#submit_add'
  }
  {
    command: 'wait'
    value: 5000
  }
  {
    command: 'wait-for'
    selector: '.alert-success'
  }
]
