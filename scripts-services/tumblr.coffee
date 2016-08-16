# coffeelint: disable=max_line_length

exports.name = 'tumblr'
exports.url = 'https://www.tumblr.com/login'
exports.steps = [
  {
    command: 'create-article'
    micro: true
    noHTML: false
    noLinks: true
  }
  {
    command: 'wait-for'
    selector: '#signup_determine_email'
  }
  {
    command: 'service-username'
    selector: '#signup_determine_email'
  }
  {
    command: 'click'
    selector: '#signup_forms_submit'
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'press-tab'
  }
  {
    command: 'service-password'
    selector: '#signup_password'
  }
  {
    command: 'click'
    selector: '#signup_forms_submit'
  }
  {
    command: 'wait'
    value: 5000
  }
  {
    command: 'wait-for'
    selector: '#post_buttons'
  }
  {
    command: 'click'
    selector: '#new_post_label_text'
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'wait-for'
    selector: 'div.editor.editor-plaintext'
  }
  {
    command: 'title'
    selector: 'div.editor.editor-plaintext'
  }
  {
    command: 'click'
    selector: 'button.post-settings'
  }
  {
    command: 'wait-for'
    selector: 'select#editorType'
  }
  {
    command: 'select-option'
    selector: 'select#editorType'
    value: 'html'
  }
  {
    command: 'random-link'
    selector: 'input#sourceUrl_input'
  }
  {
    command: 'wait'
    value: 5000
  }
  {
    command: 'wait-for'
    selector: 'div[class="ace_layer ace_text-layer"]'
  }
  {
    command: 'body'
    selector: 'div[class="ace_layer ace_text-layer"]'
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'click'
    selector: 'button.button-area.create_post_button'
  }
  {
    command: 'wait'
    value: 10000
  }
  {
    command: 'wait-for'
    selector: 'div[title="Share"]'
  }
  {
    command: 'click'
    selector: 'div[title="Share"]'
  }
  {
    command: 'wait'
    value: 1000
  }
  {
    command: 'wait-for'
    selector: 'a[class="messaging-share-post-external-network network--permalink"]'
  }
  {
    command: 'save-href'
    selector: 'a[class="messaging-share-post-external-network network--permalink"]'
  }
  {
    command: 'wait'
    value: 5000
  }
]
