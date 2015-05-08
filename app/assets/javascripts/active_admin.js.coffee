//= require active_admin/base
//= require jquery
//= require chosen-jquery
//= require 'includes/scroll_buttons_init.js'
//= require 'includes/server_time_init.js'
//= require 'includes/panel_toggle_init.js'
//= require 'includes/table_highlight_init.js'
//= require 'includes/boolean_editable.js'
//= require 'includes/resources.js'


$ ->
  # enable chosen js
  $('.chosen').chosen
    allow_single_deselect: true
    no_results_text: 'No results matched'
    width: '233px'
