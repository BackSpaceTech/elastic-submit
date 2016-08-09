# coffeelint: disable=max_line_length

exports.name = 'wordpress'
exports.url = 'https://wordpress.com/wp-login.php'
exports.steps = [
  {
    command: 'create-article'
    micro: false
    noHTML: false
  }
  {
    command: 'wait-for'
    selector: '#user_login'
  }
  {
    command: 'login'
    form: '#loginform'
    username: '#user_login'
    password: '#user_pass'
    submit: true
  }
  {
    command: 'wait'
    value: 2000
  }
  {
    command: 'wait-for'
    selector: 'svg.gridicon.gridicons-create'
  }
  {
    command: 'click'
    selector: 'svg.gridicon.gridicons-create'
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'wait-for'
    selector: '#tinymce-1'
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'title'
    selector: 'textarea.textarea-autosize.editor-title__input'
  }
  {
    command: 'click'
    selector: 'a[title="Edit the raw HTML code"]'
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'body'
    selector: '#tinymce-1'
  }
  {
    command: 'click'
    selector: 'button.editor-ground-control__publish-button.button.is-primary'
  }
  {
    command: 'wait-for'
    selector: '.is-success'
  }
  {
    command: 'save-href'
    selector: 'a.notice__action'
  }
  {
    command: 'wait'
    value: 5000
  }
]
