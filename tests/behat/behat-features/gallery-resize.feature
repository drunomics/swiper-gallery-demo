@gallery-resize
@javascript
Feature: Resizing the window will render different gallery variants.

  Scenario: Resize to mobile variant shows vertical swiper.
    Given I am on "/gallery-media-preview"
    And I launch the gallery
    And I set browser window size to "400" x "600"
    Then the swiper variant should be vertical

  Scenario: Resize to desktop variant shows horizontal swiper.
    Given I am on "/gallery-media-preview"
    And I launch the gallery
    And I set browser window size to "600" x "600"
    Then the swiper variant should be horizontal

  Scenario: Changing the height below 550 hides the thumbs.
    Given I am on "/gallery-media-preview"
    And I launch the gallery
    And I set browser window size to "600" x "549"
    Then the swiper variant should be horizontal
    And I should see Element ".gallery.is-active .gallery__thumbs" with the Css Style Property "display" matching "none"

  Scenario: Thumbs shown for desktop version with height >= 550.
    Given I am on "/gallery-media-preview"
    And I launch the gallery
    And I set browser window size to "600" x "550"
    Then the swiper variant should be horizontal
    And I should see Element ".gallery.is-active .gallery__thumbs" with the Css Style Property "display" matching "block"
