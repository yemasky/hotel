<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 17:00
 */
class DbConfig{
	const hotel_dsn_read = 'mysqli://root:root@127.0.0.1:3306/hotel';
    const hotel_dsn_write = 'mysqli://root:root@127.0.0.1:3306/hotel';
    const tourism_dsn_read = 'mysqli://root:@127.0.0.1:3306/heniba';
	const tourism_dsn_write = 'mysqli://root:@127.0.0.1:3306/heniba';

	public static $db_query_conditions = array('order'=>NULL, 'limit'=>NULL, 'group'=>NULL, 'where'=>NULL);

}