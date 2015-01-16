<?php

require_once '../../kisakone/core/login.php';

class LoginTest extends PHPUnit_Framework_TestCase
{
  private $testhash;

  public function setUp() {
     $this->testhash = md5("foobar12");
  }


  /**
   * Test valid IsValidPassword cases
   */
  public function test_valid_IsValidPassword() {
    $this->assertEquals(
      true,
      IsValidPassword("12345678")
    );

    $this->assertEquals(
      true,
      IsValidPassword("12345678abcdefgh")
    );

    $this->assertEquals(
      true,
      IsValidPassword("1234567890123456789012345678901234567890")
    );
  }


  /**
   * Test valid IsValidPassword cases
   */
  public function test_invalid_IsValidPassword() {
    $this->assertEquals(
      false,
      IsValidPassword("")
    );

    $this->assertEquals(
      false,
      IsValidPassword(null)
    );

    $this->assertEquals(
      false,
      IsValidPassword(false)
    );

    $this->assertEquals(
      false,
      IsValidPassword("1234567")
    );

    $this->assertEquals(
      false,
      IsValidPassword("12345678901234567890123456789012345678901")
    );
  }


  /**
   * Test valid IsValidSalt cases
   */
  public function test_valid_IsValidSalt() {
    $this->assertEquals(
      true,
      IsValidSalt("123456789012345678901234567890==")
    );
  }


  /**
   * Test invalid IsValidSalt cases
   */
  public function test_invalid_IsValidSalt() {
    $this->assertEquals(
      false,
      IsValidSalt("1234567890123456789012345678901")
    );

    $this->assertEquals(
      false,
      IsValidSalt("123456789012345678901234567890123")
    );

    $this->assertEquals(
      false,
      IsValidSalt(null)
    );

    $this->assertEquals(
      false,
      IsValidSalt(false)
    );

    $this->assertEquals(
      false,
      IsValidSalt(true)
    );

    $this->assertEquals(
      false,
      IsValidSalt(-1)
    );
  }


  /**
   * Test valid GenerateHash with "md5"
   */
  public function test_MD5() {
    $hash = GenerateHash("foobar12");

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
      GenerateHash("foobar12", "md5")
    );

    $this->assertEquals(
      $this->testhash,
      GenerateHash("foobar12", "md5", "12345678")
    );
  }


  /**
   * Test invalid GenerateHash with "md5"
   */
  public function test_invalid_MD5() {
    $this->assertNotEquals(
      $this->testhash,
      GenerateHash("barbaz12")
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


  /**
   * Test valid GenerateSalt
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
   * Test valid GenerateHash with "crypt"
   */
  public function test_simple_Crypt() {
    $salt = GenerateSalt();
    $crypt = GenerateHash("foobar12", "crypt", $salt);

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
    $expected = '$2y$10$t4DyD8LupAXVJ9TEYknt4ergTKZNren6Rkn.DfYM7L9eaW5E/PDJi';
    $this->assertEquals(
      $expected,
      GenerateHash("foobar12", "crypt", $salt)
    );

  }


  /**
   * Test invalid GenerateHash with "crypt"
   */
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
      GenerateHash("foobar12", "crypt")
    );

    $this->assertEquals(
      null,
      GenerateHash("foobar12", "crypt", "")
    );

    $this->assertEquals(
      null,
      GenerateHash("foobar12", "crypt", null)
    );

    $this->assertEquals(
      null,
      GenerateHash("foobar12", "crypt", 1)
    );

    $this->assertEquals(
      null,
      GenerateHash("foobar12", "crypt", -1)
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
   * Test GenerateHash with invalid "crypt" calls
   */
  public function test_invalid_calls() {
    $this->assertEquals(
      null,
      GenerateHash("foobar12", "rc4")
    );

    $this->assertEquals(
      null,
      GenerateHash("foobar12", -1)
    );
  }
}
