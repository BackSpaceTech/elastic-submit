# coffeelint: disable=max_line_length

exports.name = 'blog.com'
exports.url = 'http://blog.com/'
exports.steps = [
  {
    command: 'create-article'
    micro: false
    noHTML: false
  }
  {
    command: 'wait-for'
    selector: '#loginform'
  }
  {
    command: 'login'
    form: '#loginform'
    username: '#user_login'
    password: '#user_pass'
    submit: true
  }
  {
    command: 'wait-for'
    selector: '#site-title'
  }
  {
    command: 'open-site'
    begin: 'http://'
    end: '.blog.com/wp-admin/post-new.php'
  }
  {
    command: 'wait-for'
    selector: '#post-body'
  }
  {
    command: 'click'
    selector: '#edButtonHTML'
  }
  {
    command: 'title'
    selector: 'input#title'
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'body'
    selector: 'textarea#content'
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'click'
    selector: 'input#publish'
  }
  {
    command: 'wait-for-text'
    text: 'Post published. '
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'save-href'
    selector: '#message  p  a'
  }
  {
    command: 'click'
    selector: 'a[title="Sign Out"]'
  }
  {
    command: 'wait-for'
    selector: '#loginform'
  }
]
