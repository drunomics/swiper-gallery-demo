@gallery-base
@javascript
Feature: Gallery open, closes & slides.

  Scenario: The gallery opens via the main launcher.
    Given I am on "/gallery-media-preview"
    And I launch the gallery
    Then I should see the 1 slide

  Scenario: The gallery opens via a thumbnail launcher.
    Given I am on "/gallery-thumbs-preview"
    And I launch the gallery via thumbnail
    Then I should see the 1 slide

  Scenario: The gallery opens & closes.
    Given I am on "/gallery-media-preview"
    And I launch the gallery
    Then the gallery should be open
    When I close the gallery
    Then the gallery should be closed

  Scenario: Clicking on a thumbnail slides to that Image.
    Given I am on "/gallery-media-preview"
    And I launch the gallery
    When I click the 2 thumbnail
    Then I should see the 2 slide
