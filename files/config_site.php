<?php
/**
 * Suomen Frisbeegolfliitto Kisakone
 * Copyright 2013-2014 Tuomo Tanskanen <tumi@tumi.fi>
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

/*
 * EMAIL
 * Set enabled to true to send emails about certain actions
 */
global $settings;
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
define("USE_SFL_PAYMENTS", false);

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
 * DEVELOPMENT/ERROR HANDLING/TECHNICAL
 */
// php 5.3 spits out deprecation warnings without this
error_reporting(E_ALL);

// mysql debugging
$settings['DB_ERROR_LOGGING'] = true;
