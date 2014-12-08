<?php

require_once '../../kisakone/core/crypto.php';

class CryptoTest extends PHPUnit_Framework_TestCase
{
  private $testhash;

  public function setUp() {
     $this->testhash = md5("foobar");
  }

  /*
   * Test GenerateHash with "md5"
   */
  public function test_MD5() {
    $hash = GenerateHash("foobar");

    $this->assertNotEquals(
      null,
      $hash
    );

    $this->assertEquals(
      $this->testhash,
      $hash
    );

    $this->assertEquals(
      32,
      strlen($hash)
    );

    $this->assertEquals(
      $this->testhash,
      GenerateHash("foobar", "md5")
    );

    $this->assertEquals(
      $this->testhash,
      GenerateHash("foobar", "md5", "12345678")
    );
  }

  public function test_invalid_MD5() {
    $this->assertNotEquals(
      $this->testhash,
      GenerateHash("barbaz")
    );

    $this->assertEquals(
      null,
      GenerateHash(null)
    );

    $this->assertEquals(
      null,
      GenerateHash("")
    );

    $this->assertEquals(
      null,
      GenerateHash(null, "md5")
    );
  }


  /*
   * Test GenerateSalt
   */
  public function test_Salt_creation() {
    $salt = GenerateSalt();

    $this->assertNotEquals(
      null,
      $salt
    );

    $this->assertEquals(
      32,
      strlen($salt)
    );

    $this->assertEquals(
      "==",
      substr($salt, 30, 2)
    );
  }


  /*
   * Test GenerateHash with "crypt"
   */
  public function test_simple_Crypt() {
    $salt = GenerateSalt();
    $crypt = GenerateHash("foobar", "crypt", $salt);

    $this->assertNotEquals(
      null,
      $crypt
    );

    $this->assertEquals(
      60,
      strlen($crypt)
    );

    $this->assertEquals(
      "$2y$10$",
      substr($crypt, 0, 7)
    );

    $salt = 't4DyD8LupAXVJ9TEYknt4jQnzIHyDw==';
    $expected = '$2y$10$t4DyD8LupAXVJ9TEYknt4eCkepEqkDCjTbdx.wAcv7AAjBW4Wkg6a';
    $this->assertEquals(
      $expected,
      GenerateHash("foobar", "crypt", $salt)
    );

  }

  public function test_invalid_Crypt() {
    $salt = GenerateSalt();

    $this->assertEquals(
      null,
      GenerateHash("", "crypt", $salt)
    );

    $this->assertEquals(
      null,
      GenerateHash(null, "crypt", $salt)
    );

    $this->assertEquals(
      null,
      GenerateHash("foobar", "crypt")
    );

    $this->assertEquals(
      null,
      GenerateHash("foobar", "crypt", "")
    );

    $this->assertEquals(
      null,
      GenerateHash("foobar", "crypt", null)
    );

    $this->assertEquals(
      null,
      GenerateHash("foobar", "crypt", 1)
    );

    $this->assertEquals(
      null,
      GenerateHash("foobar", "crypt", -1)
    );

    $this->assertEquals(
      null,
      GenerateHash("", "crypt")
    );

    $this->assertEquals(
      null,
      GenerateHash(null, "crypt", "")
    );

    $this->assertEquals(
      null,
      GenerateHash("", "crypt", null)
    );

    $this->assertEquals(
      null,
      GenerateHash(null, "crypt", 1)
    );

    $this->assertEquals(
      null,
      GenerateHash("", "crypt", -1)
    );
  }


  /*
   * Test GenerateHash with invalid "crypt"
   */
  public function test_invalid_calls() {
    $this->assertEquals(
      null,
      GenerateHash("foobar", null)
    );

    $this->assertEquals(
      null,
      GenerateHash("foobar", "")
    );

    $this->assertEquals(
      null,
      GenerateHash("foobar", "rc4")
    );

    $this->assertEquals(
      null,
      GenerateHash("foobar", -1)
    );
  }
}
