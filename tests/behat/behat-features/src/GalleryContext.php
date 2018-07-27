<?php

/**
 * @file
 * The behat context for the gallery.
 */

use Drupal\DrupalExtension\Context\RawDrupalContext;
use Behat\Mink\Exception\ExpectationException;

/**
 * Defines application features from the specific context.
 */
class GalleryContext extends RawDrupalContext {

  /**
   * Gets the swiper object.
   */
  const SWIPER = "jQuery('.gallery.is-inactive')[0].gallery.swiper";
  const SWIPER_THUMB = "jQuery('.gallery.is-inactive')[0].gallery.swiperThumb";

  /**
   * Opens the gallery via main or thumb launcher.
   *
   * Example: Given I launch the gallery
   * Example: And I launch the gallery via thumbnail
   * Example: When I launch the gallery via "main launcher"
   *
   * @When I launch the gallery via :launcher
   * @When I launch the gallery
   */
  public function launchGallery($launcher = NULL) {
    switch ($launcher) {
      case 'thumbnail':
        $this->getSession()
          ->evaluateScript("jQuery('.gallery-preview-thumbnails .gallery-launcher').first().click()");
        break;

      case 'main launcher':
      default:
        $this->getSession()
          ->evaluateScript("jQuery('.gallery-launcher-main').first().click()");
    }

    $this->waitForGalleryOpen();
  }

  /**
   * Closes the gallery by pressing the X-button.
   *
   * Example: And I close the gallery
   *
   * @When I close the gallery
   */
  public function closeGallery() {
    $this->getSession()
      ->evaluateScript("jQuery('.featherlight-close').click()");

    $this->waitForGalleryClose();
  }

  /**
   * Checks in what status the gallery is.
   *
   * Example: Then the gallery should be open
   * Example: Then the gallery should be closed
   *
   * @Then the gallery should be :status
   */
  public function galleryStatus($status) {
    switch ($status) {
      case 'open':
        $this->assertSession()->elementExists('css', '.featherlight .gallery.is-active');
        break;

      case 'closed':
        $this->assertSession()->elementNotExists('css', '.featherlight .gallery.is-active');
        break;

      default:
        throw new Exception('Invalid parameter: ' . $status);
    }
  }

  /**
   * Checks the active slide on the gallery.
   *
   * Example: Then I should see the 1 slide
   *
   * @Then I should see the :index slide
   */
  public function activeSlideByIndex($index) {
    $result = $this->getSession()
      ->evaluateScript("jQuery('.gallery.is-active .gallery__main .swiper-slide-active').attr('data-swiper-slide-index')");
    if (is_null($result) || ++$result != $index) {
      throw new ExpectationException('The index of the active slide is ' . (is_null($result) ? '-not found-' : $result), $this->getSession());
    }
  }

  /**
   * Checks the active slide on the gallery.
   *
   * @Then I should see the slide with id :id
   */
  public function activeSlideById($id) {
    $result = $this->getSession()
      ->evaluateScript("jQuery('.gallery.is-active .gallery__main .swiper-slide-active').attr('slide-id')");
    if (is_null($result) || $result != $id) {
      throw new ExpectationException('The id of the active slide is ' . (is_null($result) ? '-not found-' : $result), $this->getSession());
    }
  }

  /**
   * Click on a thumbnail.
   *
   * Example: Then I click the 2 thumbnail
   *
   * @When I click the :index thumbnail
   */
  public function clickThumbnail($index) {
    --$index;
    $this->getSession()
      ->evaluateScript(static::SWIPER_THUMB . ".slideTo($index)");
    $this->getSession()->getDriver()
      ->wait(500, "jQuery('.gallery.is-active .gallery__main .swiper-slide-active').attr('data-swiper-slide-index') == " . $index);
  }

  /**
   * Set or remove the hash via javascript.
   *
   * @When I set the hash to :hash
   * @When I remove the hash from the url
   */
  public function setHash($hash = NULL) {
    $this->getSession()
      ->evaluateScript("location.hash = '{$hash}'");

    if (empty($hash)) {
      $this->waitForGalleryClose();
    }
    else {
      $this->waitForGalleryOpen();
    }
  }

  /**
   * Check the current hash.
   *
   * @Then the hash should be :hash
   */
  public function hashIs($hash) {
    $hash = '#' . $hash;
    $current0 = $this->getSession()->evaluateScript('window.location.hash');
    // Wait for possible hash update.
    $this->getSession()->getDriver()->wait(300, "window.location.hash != '{$current0}'");
    $current = $this->getSession()->evaluateScript('window.location.hash');

    if ($current != $hash) {
      throw new ExpectationException('Expected hash: ' . $hash . ', actual: ' . $current, $this->getSession());
    }
  }

  /**
   * Wait until the gallery is closed.
   *
   * @When I wait for the gallery to be closed
   */
  public function waitForGalleryClose() {
    $this->getSession()->getDriver()
      ->wait(500, "jQuery('.featherlight .gallery.is-active').length == 0");
  }

  /**
   * Wait until the gallery is shown.
   *
   * @When I wait for the gallery to be open
   */
  public function waitForGalleryOpen() {
    $this->getSession()->getDriver()
      ->wait(500, "jQuery('.featherlight .gallery.is-active').length == 1");
  }

}
