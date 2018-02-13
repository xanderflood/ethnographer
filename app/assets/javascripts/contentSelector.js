/*
 * A simple JavaScript module for swapping out content based on
 * a set of links. There are 3 main classes that control this:
 *
 * content-selector-toggle indicates the links that cause a content swap
 * content-selector-viewport indicates where the content should go
 * content-selector-block indicates one of the blocks of content
 *
 * These are tied together into a unit as follows:
 * + The viewport and links should all bear a `data-selector-id`
 *   attribute with the same value.
 * + The possible blocks should all be descendants of the viewport.
 *   It may help to put them underneath a child div with `display: none;`
 * + The blocks and links should all bear a `data-content-id` attribute
 *   which groups them into corresponding pairs.
 */

// TODO: the current implementation uses way more jQuery selectors than
// necessary. Maybe instead of storing them in an object attached to the
// viewport, the blocks should get attached as hidden children of the
// nav-links for easy access?

// TODO: One source claims that arbitrary JS objects can't go in data
// attributes, so viewport/data-content-selector-blocks may not work
// in all browsers. Most sources I've found don't confirm that.
// Figure out the truth.
window.divContentSelector = window.divContentSelector || (function () {

  // `this` is a content-selector-viewport dom element to be setup
  _setup = function () {
    viewport = this;
    selectorId = $(viewport).data("selector-id");

    currentContentId = $(".content-selector[data-selector-id='" + selectorId +
      "'] .active .content-selector-toggle").data("content-id");

    // Gather up the content-selector-blocks inside this viewport,
    // and attach them to the parent in a data attribute
    // Whichever one is currently selected, re-attach it to the viewport
    obj = {};
    $(viewport).find(".content-selector-block").each(function() {
      $(this).detach();

      if ($(this).data("content-id") === currentContentId)
        $(viewport).append($(this));

      obj[$(this).data("content-id")] = this;
    });

    $(viewport).data("content-selector-blocks", obj);
  };

  // `this` is the link bearing the content-selector-toggle class
  _swap = function (event) {
    link = $(this);
    contentId  = link.data("content-id");
    selector = link.closest(".content-selector");
    currentContentId = selector.data("content-id");

    if (contentId === currentContentId) return;

    selectorId = selector.data("selector-id");
    viewport   = $(".content-selector-viewport[data-selector-id='" + selectorId + "']");
    blocks  = viewport.data("content-selector-blocks");

    viewport.find(".content-selector-block").detach();
    viewport.append(blocks[contentId]);

    // TODO: using `nav-item` here explicitly makes this much
    // less reusable. figure out an alternative solution
    selector.find(".nav-item.active").removeClass("active");
    link.closest(".nav-item").addClass("active");
  };

  return {
    setup: _setup,
    swap: _swap
  };
})();

$(document).on('turbolinks:load', function () {
  // first, find all the content-selector-viewports
  $(".content-selector-viewport").each(window.divContentSelector.setup);

  // attach swap to the tab actions
  $(".content-selector-toggle").click(window.divContentSelector.swap);
});
