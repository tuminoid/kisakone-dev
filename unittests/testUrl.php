<?php

set_include_path(get_include_path() . PATH_SEPARATOR . "../../kisakone");
require_once '../../kisakone/core/url.php';

class UrlTest extends PHPUnit_Framework_TestCase
{

  public function setUp() {

  }


  /**
   * Test valid http urls
   */
  public function test_valid_http_url() {
    $url1 = "http://www.google.com";
    $url2 = "http://www.google.com/";
    $url3 = "http://www.google.com/foo/bar";
    $url4 = "http://www.google.com/?foo=bar";

    $this->assertEquals(
      $url1,
      sanitize_url($url1)
    );

    $this->assertEquals(
      $url2,
      sanitize_url($url2)
    );

    $this->assertEquals(
      $url3,
      sanitize_url($url3)
    );

    $this->assertEquals(
      $url4,
      sanitize_url($url4)
    );
  }


  /**
   * Test valid https urls
   */
  public function test_valid_https_url() {
    $url1 = "https://www.google.com";
    $url2 = "https://www.google.com/";
    $url3 = "https://www.google.com/foo/bar";
    $url4 = "https://www.google.com/?foo=bar";

    $this->assertEquals(
      $url1,
      sanitize_url($url1)
    );

    $this->assertEquals(
      $url2,
      sanitize_url($url2)
    );

    $this->assertEquals(
      $url3,
      sanitize_url($url3)
    );

    $this->assertEquals(
      $url4,
      sanitize_url($url4)
    );
  }


  /**
   * Test urls without schema
   */
  public function test_invalid_url() {
    $url1 = "www.google.com";
    $url2 = "www.google.com/";
    $url3 = "www.google.com/foo/bar";
    $url4 = "www.google.com/?foo=bar";

    $this->assertEquals(
      "http://" . $url1,
      sanitize_url($url1)
    );

    $this->assertEquals(
      "http://" . $url2,
      sanitize_url($url2)
    );

    $this->assertEquals(
      "http://" . $url3,
      sanitize_url($url3)
    );

    $this->assertEquals(
      "http://" . $url4,
      sanitize_url($url4)
    );
  }

  /**
   * Test urls without schema, with https schema
   */
  public function test_invalid_url_https() {
    $url1 = "www.google.com";
    $url2 = "www.google.com/";
    $url3 = "www.google.com/foo/bar";
    $url4 = "www.google.com/?foo=bar";

    $this->assertEquals(
      "https://" . $url1,
      sanitize_url($url1, "https")
    );

    $this->assertEquals(
      "https://" . $url2,
      sanitize_url($url2, "https")
    );

    $this->assertEquals(
      "https://" . $url3,
      sanitize_url($url3, "https")
    );

    $this->assertEquals(
      "https://" . $url4,
      sanitize_url($url4, "https")
    );
  }

  /**
   * Test relative urls
   */
  public function test_absolute_url() {
    $url1 = "/this/is/valid";
    $url2 = "/this/is?valid=too";
    $url3 = "/";

    $this->assertEquals(
      $url1,
      sanitize_url($url1)
    );

    $this->assertEquals(
      $url2,
      sanitize_url($url2)
    );

    $this->assertEquals(
      $url3,
      sanitize_url($url3)
    );

    $this->assertEquals(
      $url1,
      sanitize_url($url1, "https")
    );

    $this->assertEquals(
      $url2,
      sanitize_url($url2, "https")
    );

    $this->assertEquals(
      $url3,
      sanitize_url($url3, "https")
    );
  }

  /**
   * Test relative urls
   */
  public function test_invalid_input() {
    $url1 = "";
    $url2 = null;

    $this->assertEquals(
      "",
      sanitize_url($url1)
    );

    $this->assertEquals(
      "",
      sanitize_url($url2)
    );
  }
}
