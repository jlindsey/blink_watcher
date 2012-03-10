init_local_storage = ->
  localStorage['play_sounds'] = false unless localStorage['play_sounds']?

save_options = ->
  localStorage['play_sounds'] = $('#play_sounds').is ':checked'

load_options = -> 
  if localStorage['play_sounds'] == 'true'
    $('#play_sounds').attr 'checked', 'checked'
  else
    $('#play_sounds').removeAttr 'checked'

$ ->
  init_local_storage()
  load_options()

  $(':input[name="play_sounds"]').change (e) ->
    save_options()

