<?php
// ** MySQL settings - You can get this info from your web host ** //
/** https://wordpress.org/support/article/editing-wp-config-php/ */
/** The name of the database for WordPress */
define( 'DB_NAME', 'wordpress' );
/** MySQL database username */
define( 'DB_USER', 'wordpress' );
/** MySQL database password */
define( 'DB_PASSWORD', '123456' );
/** MySQL hostname */
define( 'DB_HOST', 'localhost' );
/** DB_CHARSET was made available to allow designation of the database 
 * character set to be used when defining the MySQL database tables.
 * The default value of utf8 (Unicode UTF-8) is almost always the best option. 
 * UTF-8 supports any language, so you typically want to leave DB_CHARSET at utf8 
 * and use the DB_COLLATE value for your language instead.
 * utf8 is considered the WordPress default value: */
define( 'DB_CHARSET', 'utf8' );
/** DB_COLLATE was made available to allow designation of the database collation 
 * (i.e. the sort order of the character set).
 * In most cases, this value should be left blank (null) so the database collation will
 * be automatically assigned by MySQL based on the database character set specified by DB_CHARSET. */
define( 'DB_COLLATE', '' );
/** 
 * Authentication Unique Keys and Salts
 * https://api.wordpress.org/secret-key/1.1/salt/
 * If you change this, will invalidate all existing cookies. 
 * This will force all users to log in again.
 * */
define('AUTH_KEY',         'e+5;<7(=>-I6TcD{eSP)|rR+OS|OLL:1JWa-oo(T}XQM)|$3.&8J4b:Jjd!$|7Ar');
define('SECURE_AUTH_KEY',  'zX;t3S1)D~}dPV+U?+n!L]Wa }P{@nqPz[(anvlgt/Pl8$rvg@WuuVLYy++p|E,,');
define('LOGGED_IN_KEY',    'R}U:J-7]B2 P4Tu6yY{xjDg1kw/Q{!{j9?GkFp/YRs~lNJw-NFKe6|-Uf7!e[d1_');
define('NONCE_KEY',        'K4a^<]~;4+$K}]7HAyR)V-<kuA~$&+XkQ_*+}c1U(](E>d!gQ2ewfc04Hu C=+JT');
define('AUTH_SALT',        '|&66>5gHIngW!&D+dL!<e|IPl{SWE@T0h]-m<15a#6 pz+y,FetY:a)C>S{P_.m3');
define('SECURE_AUTH_SALT', '&bY0O@zbo/GU`I|+-[E-^b@N|>[=j?aBn;G%W~a-SCUblb,G mTlYg@u~To`?)`I');
define('LOGGED_IN_SALT',   ')3-#}cf@%4tk=i&7<-K!,fK%cfMOm3~I/N {!{ZMoflP{,T<[**5ns-&~i$|6b*Z');
define('NONCE_SALT',       ':G8uoqqhT*Ofh(+ZRL2k?U+XT`ByK41P^?a`&GMlOs^+3:smzL&Y`Xrsm!G@+H}m');

/** The $table_prefix is the value placed in the front of your database tables. */
$table_prefix  = 'wp_';

/** The WP_DEBUG option controls the reporting of some errors and warnings and enables use 
 * of the WP_DEBUG_DISPLAY and WP_DEBUG_LOG settings. The default boolean value is false. */
define( 'WP_DEBUG', false );

/** Absolute path to wordpress dir */
if ( ! defined( 'ABSPATH' ) )
		define( 'ABSPATH', __DIR__ . '/' );

/** Set up wordpress vars and included files */
require_once ABSPATH . 'wp-settings.php';