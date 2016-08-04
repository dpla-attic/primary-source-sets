/*
 * Tracks custom events with Google Analytics.
 * This application uses the google-analytics-rails gem to track general usage
 * data. This file defines additional user interations to be tracked with Google
 * Analtyics.
 * See https://developers.google.com/analytics/devguides/collection/analyticsjs/events
 */

$(function(){

  // Track source view when sources#show page loads.
  if ($('.sources-controller.show-action').length > 0) {
    trackSourceViewEvent();
  };

  /*
   * Bind event to a.ViewObject links to track click-throughs to external
   * provider pages.  Assumes that all relevlant links have 'ViewObject' class.
   */
  $('body').on('click', '.ViewObject', function(){
    event.preventDefault();
    trackClickThroughEvent(this);
    window.open(this.href, '_blank');
  });
});

/* Track pageview of an internal source page.
 * Relies on data-* attributes embedded in the HTML of the page.
 */
var trackSourceViewEvent = function(){
  /* 
   * 'ga' must be defined for a signal to be sent to Google Analtyics.
   * It is set by the google analtyics rails gem if a valid tracker is present.
   */
  if (typeof ga !== 'undefined') {

    var item = $("[data-item-id]");
    var category = "View Primary Source : " + item.attr("data-provider");
    var action = item.attr("data-data-provider");
    var label = item.attr("data-item-id") + " : " + item.attr("data-title");

    ga('send', 'event', category, action, label);
  }
}

/* 
 * Track click-throughs to external provider pages.
 * @param HTML object to which the event is bound.
 * Relies on data-* attributes belonging to a parent of the given object.
 */
var trackClickThroughEvent = function(obj){
  /* 
   * 'ga' must be defined for a signal to be sent to Google Analtyics.
   * It is set by the google analtyics rails gem if a valid tracker is present.
   */
  if (typeof ga !== 'undefined') {

    var item = $(obj).parents("[data-item-id]");
    var category = "Click Through : " + item.attr("data-provider");
    var action = item.attr("data-data-provider");
    var label = item.attr("data-item-id") + " : " + item.attr("data-title");

    ga('send', 'event', category, action, label);
  }
}
