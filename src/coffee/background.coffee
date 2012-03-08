class Application
  constructor: ->
    @blink_url = "http://cogdev.net/blink"
    @page = {}
    @logged_in = false
    @last_notified_id = ''
    @notified_logged_out = false

    chrome.browserAction.onClicked.addListener =>
      chrome.tabs.create url: @blink_url

  fetch_page: ->
    $.ajax
      url: @blink_url
      type: 'GET'
      async: false
      success: (data, textStatus, jqXHR) =>
        @page = $(data)

  check_logged_in: ->
    if $('#blink_logged_out', @page).length > 0
      chrome.browserAction.setBadgeBackgroundColor color: [255, 0, 0, 255]
      chrome.browserAction.setBadgeText text: ":("

      chrome.browserAction.setTitle title: "Blink Watcher - Not Logged In"

      
      this.notify "Not Logged In", "You must be logged in to Blink." unless @notified_logged_out

      @logged_in = false
      @notified_logged_out = true
    else
      chrome.browserAction.setBadgeBackgroundColor color: [0, 255, 0, 255]
      chrome.browserAction.setBadgeText text: ""

      chrome.browserAction.setTitle title: "Blink Watcher"

      @logged_in = true
      @notified_logged_out = false

  check_for_promo: ->
    return unless @logged_in

    promo_check = ($('form#featured_blink', @page).length > 0)

    if promo_check
      id = $('form#featured_blink > :input[name="blinkID"]', @page).val()

      # Only notify once per promo
      return if @last_notified_id == id
      @last_notified_id = id

      ship = $('#promo_description > .last h2.pretty', @page).html()
      d = new Date
      date_string = "#{d.toDateString()} #{d.toTimeString()}"

      this.notify "New Promo: #{ship}!", "As of #{date_string} there is a #{ship} promo active!", "#{@blink_url}/?#blink_#{id}"

  notify: (title, body, click_url = false) ->
    n = webkitNotifications.createNotification '/icon48.png', title, body

    if click_url
      n.onclick = ->
        chrome.tabs.create url: click_url
        n.cancel()

    n.show()

  run: ->
    callback = =>
      this.fetch_page()
      this.check_logged_in()
      this.check_for_promo()

    setInterval callback, 5000
  
$ ->
  app = new Application
  app.run()
