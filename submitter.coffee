# coffeelint: disable=max_line_length
scriptDebug = true # When true takes screenshots

system = require('system')
fs = require('fs')
webPage = require('webpage')
async = require('async')
xpath2css = require('./app/xpath2css.js')
consolex = require('./app/console-xtra')
importFiles = require('./app/import-files')
spinner = require('./app/spinner')
jQueryLoc = './js/jquery-2.2.4.min.js'

waitTimeout = 30000 # Seconds

submitMode = system.args[1]

if submitMode = 'seo'
  fileAccounts = './accounts/' + system.args[2] + '.csv'
  fileArticles = './articles/' + system.args[3] + '.txt'
  fileBacklinks = './backlinks/' + system.args[4] + '.txt'
  numPosts = system.args[5]
  consolex.log 'cyan', '\n'
  consolex.log 'cyan', '---------------- Submission Details --------------------'
  consolex.log 'cyan', 'Accounts file: ' + fileAccounts
  consolex.log 'cyan', 'Articles file: ' + fileArticles
  consolex.log 'cyan', 'Backlinks saved to file: ' + fileBacklinks
  consolex.log 'cyan', 'Number of Submissions: ' + numPosts
  currentService = 0
  currentStep = 0
  submitArticle =
    title: ''
    body: ''
    keywords: ''
  randomAccount =
    username: ''
    password: ''
    site: ''
  backlinksList = ''

  # Import settings
  services = importFiles.services('./settings/services.txt')
  indexerDetails = importFiles.indexers('./settings/indexers.txt')

  # Load services
  service = []
  currentService = 0
  i = 0
  while i < services.length
    if services[i].status.toLowerCase() == 'ok'
      service[currentService] = require('./services/' + services[i].name)
    ++currentService
    ++i

  # Load indexers
  numIndexerLoops = 0
  indexers = []
  currentIndexer = 0
  i = 0
  while i < indexerDetails.length
    if indexerDetails[i].status.toLowerCase() == 'ok'
      indexers[currentIndexer] = require('./indexers/' + indexerDetails[i].name)
      indexers[currentIndexer].login = indexerDetails[i]
      numIndexerLoops += indexers[currentIndexer].steps.length
      ++currentIndexer
    ++i

  # Import Files
  consolex.log 'cyan', 'Importing files...'
  accounts = importFiles.accounts(fileAccounts)
  articles = importFiles.articles(fileArticles)


else if submitMode = 'seo-accounts'
  fileAccounts = './accounts/' + system.args[2] + '.csv'
  fileProfiles =  './profiles/' + system.args[3] + '.csv'
  serviceAccount = system.args[4]
  numPosts = system.args[5]


#-------------------------- Submit  ------------------------------------------
currentLoop = 0
currentStep = 0
goodService = true
serviceName = ''

#---------------------- Service Loop ------------------------------------------
doService = (service, doneCallback) ->
  serviceName = service.name
  # Steps Loop
  consolex.log 'yellow', '\n-------------- Submit to ' + serviceName +
    ' ----------------'
  consolex.log 'blue','Opening url '+service.url+'...'
  page = webPage.create()
  page.viewportSize =
    width: 800
    height: 600
  if scriptDebug
    page.onConsoleMessage = (msg) ->
      console.log msg
      return
  page.onError = (msg, trace) ->
    if msg.slice(0,9) != 'TypeError' # Ignore
      console.log msg
    if trace
      trace.forEach (t) ->
        stackmsg = ' at' + (if t.function then ' function ' +
          t.function else '') + ' (' + (t.file or t.sourceURL) +
          ':' + t.line + ')'
        return
    return
  getSelector = (step) ->
    tempSelect = switch
      when step.selector then step.selector
      when step.xpath then xpath2css.x2c(step.xpath)
      when step.text then ':contains("' + step.text + '")'
      else null
    return tempSelect
  stepError = (step) ->
    goodService = false
    consolex.log 'red', 'Step error - ' + step.command +
      '. Skipping ' + serviceName + '...'
    page.render './capture/error.png'
  page.settings.userAgent = 'Mozilla/5.0 (Windows NT 10.0; WOW64) ' +
    'AppleWebKit/537.36 (KHTML, like Gecko) Chrome/51.0.2704.103 Safari/537.36'
  page.open service.url, (status) ->
    if status == 'success'
      consolex.log 'blue','Opened url.'
      page.render './capture/capture' + currentStep + '.png'
      #------------------------ Steps Loop ----------------------------------
      doStep = (step, doneCallback) ->
        saveScreen = () ->
          if scriptDebug
            page.render './capture/capture' + currentStep + '.png'
        #------------------------ Input text ----------------------------------
        typeField = (selector, inputText) ->
          if page.injectJs jQueryLoc
            x = page.evaluate ((s) ->
              if ($(s).length)
                $(s)[0].focus()
                return true
              else
                return false
            ), selector
            if x
              page.sendEvent('keypress', inputText)
            else
              consolex.log 'red', 'Could not find selector'
              stepError step
          else
            consolex.log 'red', 'Could not inject jQuery'
            stepError step
        submitForm = (selector) ->
          if page.injectJs jQueryLoc
            x = page.evaluate ((s) ->
              if $(s).length
                $(s).submit()
                return true
              else
                return false
            ), selector
            if !x
              consolex.log 'red', 'Could not find selector'
              stepError step
          else
            consolex.log 'red', 'Could not inject jQuery'
            stepError step

        ++currentStep
        if goodService
          consolex.log 'blue', 'Step ' + currentStep + ' - ' + step.command
          #---------------------- Create ------------------------------------
          if step.command == 'create-article'
            consolex.log 'cyan', 'Creating article...'
            submitArticle = spinner.getArticle(articles, step.micro,
              step.noHTML)
            randomAccount = spinner.getAccount(accounts, serviceName)
            doneCallback(null)
          #---------------------- Wait-for ----------------------------------
          else if step.command == 'wait-for'
            saveScreen()
            consolex.log 'blue', 'Waiting for ' + step.selector + '...'
            count = 0
            x = 0
            tempDelay = 250
            jQueryLoadTime = 1000
            if page.injectJs jQueryLoc
              async.whilst (->
                count < waitTimeout
              ), ((callback) ->
                count += tempDelay
                if count > jQueryLoadTime
                  x = page.evaluate(((s) ->
                    y = $(s)
                    if y
                      y.length
                    else
                      0
                  ), step.selector)
                  if x > 0
                    count = waitTimeout
                setTimeout (->
                  callback null, count
                  return
                ), tempDelay
                return
              ), (err, n) ->
                if x and (x.length != 0)
                  saveScreen()
                  doneCallback(null)
                else
                  consolex.log 'red', 'Could not find selector'
                  stepError step
                  doneCallback(null)
            else
              consolex.log 'red', 'Could not inject jQuery'
              stepError step
              doneCallback(null)
          #---------------------- Wait ---------------------------------------
          else if step.command == 'wait'
            tempTime = step.value
            consolex.log 'blue', 'Waiting for ' + tempTime + ' ms...'
            count = 0
            tempDelay = 1000
            async.whilst (->
              count < tempTime
            ), ((callback) ->
              count += tempDelay
              setTimeout (->
                callback null, count
                return
              ), tempDelay
              return
            ), (err, n) ->
              saveScreen()
              doneCallback(null)
          # -------------------------- Login --------------------------------
          else if step.command == 'login' or step.command == 'login-indexer'
            saveScreen()
            if step.command == 'login'
              if randomAccount.username == 'no accounts'
                consolex.log 'red', 'No '+ serviceName + ' accounts!'
                stepError step
              else
                consolex.log 'blue', ('Logging in: ' +  randomAccount.username)
                tempUser = randomAccount.username
                tempPassword = randomAccount.password
            else
              consolex.log 'blue', ('Logging in: ' +  service.login.username)
              tempUser = service.login.username
              tempPassword = service.login.password
            typeField(step.username, tempUser)
            typeField(step.password, tempPassword)
            if step.submit
              submitForm(step.form)
            saveScreen()
            doneCallback(null)
          # -------------------------- Login --------------------------------
          else if step.command == 'click'
            saveScreen()
            if page.injectJs jQueryLoc
              x = page.evaluate ((s) ->
                # find element to send click to
                if ($(s).length)
                  element = $(s)[0]
                  # create a mouse click event
                  event = document.createEvent('MouseEvents')
                  event.initMouseEvent 'click', true, true, window, 1, 0, 0
                  # send click to element
                  element.dispatchEvent event
                  return true
                else
                  return false
              ), step.selector
              if !x
                consolex.log 'red', 'Could not find selector'
                stepError step
            else
              consolex.log 'red', 'Could not inject jQuery'
              stepError step
            saveScreen()
            doneCallback(null)
          # -------------------------- Title / Body ---------------------------
          else if step.command == 'title' or step.command == 'body'
            saveScreen()
            if step.command == 'title'
              temp = submitArticle.title
            else
              temp = submitArticle.body
            typeField(step.selector, temp)
            saveScreen()
            doneCallback(null)
          # -------------------------- Save-href --------------------------------
          else if step.command == 'save-href'
            saveScreen()
            if page.injectJs jQueryLoc
              x = page.evaluate ((s) ->
                if ($(s).length)
                  return $(s).attr('href')
                else
                  return false
              ), step.selector
              if x
                backlinksList += x + '\n'
                # Save backlinks.txt
                try
                  fs.write fileBacklinks, x, 'a'
                  fs.write fileBacklinks, '\n', 'a'
                catch e
                  consolex.log 'red', 'File error'
                  consolex.log 'red', e
                  stepError step
                consolex.log 'blue', 'Saved backlink to ' + fileBacklinks
              else
                consolex.log 'red', 'Could not find selector'
                stepError step
            else
              consolex.log 'red', 'Could not inject jQuery'
              stepError step
            saveScreen()
            doneCallback(null)
          # -------------------------- Save-href --------------------------------
          else if step.command == 'backlinks'
            saveScreen()
            typeField(step.selector, backlinksList)
            saveScreen()
            doneCallback(null)
          #---------------------- Step Error ----------------------------------
          else
            consolex.log 'red', 'Unrecognized command: ' + step.command
            stepError step
            doneCallback(null)
        else
          doneCallback(null)

      async.eachSeries service.steps, doStep, (err) ->
        if goodService
          consolex.log 'green', 'Finished steps!'
        else
          consolex.log 'red', '------------- Failed submission -------------'
        goodService = true
        currentStep = 0
        page.close()
        doneCallback null
    else
      consolex.log 'red', 'Error opening page!'
      stepError(step)
      doneCallback(null)

#------------------------ Job Loop -------------------------------------------
async.whilst ( ->
  currentLoop < numPosts
  ), ((next) ->
  # Services Loop
  async.eachSeries service, doService, (err) ->
    currentLoop++
    consolex.log 'green', 'Finished services for loop'
    next()
  ), (err) ->
  consolex.log 'green', 'Finished all submissions'
  # Indexers Loop
  async.eachSeries indexers, doService, (err) ->
    if err
      console.log 'Indexer submission failed'
    else
      consolex.log 'green', 'Finished indexer submissions'
      phantom.exit(0)
