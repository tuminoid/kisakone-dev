<?php
/**
 * Suomen Frisbeegolfliitto Kisakone
 * Copyright 2013-2015 Tuomo Tanskanen <tuomo@tanskanen.org>
 *
 * Site wide configuration options.
 *
 * --
 *
 * This file is part of Kisakone.
 * Kisakone is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Kisakone is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * You should have received a copy of the GNU General Public License
 * along with Kisakone.  If not, see <http://www.gnu.org/licenses/>.
 * */

global $settings;

/*
 * EMAIL
 * Set enabled to true to send emails about certain actions
 */
$settings['EMAIL_ENABLED'] = false;
$settings['EMAIL_SENDER'] = "no-reply@kisakone.localhost";
$settings['EMAIL_MAILER'] = "Kisakone localhost";


/*
 * SFL INTEGRATION
 * By default, all license payment mechanisms are disabled.
 * If you enable payments, they will be handled internally by Kisakone.
 * If you enable SFL Payments, Kisakone will try to access SFL Jäsenrekisteri
 * for data, which fails unless you are the SFL.
 */
define("IGNORE_PAYMENTS", true);

$settings['SFL_ENABLED'] = false;
$settings['SFL_USERNAME'] = "";
$settings['SFL_PASSWORD'] = "";

// defines for licences, mandated by SFL membership database
define("LICENSE_MEMBERSHIP", 1);
define("LICENSE_A", 2);
define("LICENSE_B", 6);


/*
 * PDGA STUFF
 * If you have a PDGA API access, then enable this setting and enter your credentials
 * Otherwise, everything just slows down and your host probably gets a ban to pdga.com
 */
$settings["PDGA_ENABLED"] = false;
$settings["PDGA_USERNAME"] = "";
$settings["PDGA_PASSWORD"] = "";


/*
 * MEMCACHED
 *
 * If you have memcached at your disposal, you can enable it for speed-ups
 */
$settings["MEMCACHED_ENABLED"] = true;
$settings["MEMCACHED_NAME"] = "kisakone";
$settings["MEMCACHED_HOST"] = "127.0.0.1";
$settings["MEMCACHED_PORT"] = "11211";


/*
 * DEVELOPMENT/ERROR HANDLING/TECHNICAL
 */
// php 5.3 spits out deprecation warnings without this
error_reporting(E_ALL);
ini_set('display_errors', 0);

// mysql debugging
$settings['DB_ERROR_LOGGING'] = true;
$settings['DB_ERROR_DIE'] = true;
