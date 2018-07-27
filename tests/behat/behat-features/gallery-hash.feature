@gallery-hash
@javascript
Feature: Test url hash functionality.

  Scenario: The hash of the first slide is set when opening the gallery.
    Given I am on "/gallery-media-preview"
    And I launch the gallery
    Then I should see the 1 slide
    And the hash should be "slide-f6e79-24"

  Scenario: The hash changes when changing slides.
    Given I am on "/gallery-media-preview"
    And I launch the gallery
    When I click the 2 thumbnail
    Then the hash should be "slide-f6e79-25"
    When I click the 3 thumbnail
    Then the hash should be "slide-f6e79-26"

  Scenario: When the hash is removed from the url, the gallery closes.
    Given I am on "/gallery-media-preview"
    And I launch the gallery
    Then the gallery should be open
    When I remove the hash from the url
    Then the gallery should be closed

  Scenario: When the gallery closes, the hash is removed from the url.
    Given I am on "/gallery-media-preview"
    And I launch the gallery
    Then the hash should be "slide-f6e79-24"
    When I close the gallery
    Then I should be on "/gallery-media-preview"

  Scenario: Browser back button closes the gallery & stays on the same page.
    Given I am on "/"
    When I go to "/gallery-media-preview"
    And I launch the gallery
    And I click the 2 thumbnail
    When move backward one page
    And I wait for the gallery to be closed
    Then the gallery should be closed
    And I should be on "/gallery-media-preview"
