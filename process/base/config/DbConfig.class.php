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
    const page_rows = 2;

	public static $db_query_conditions = array('order'=>NULL, 'limit'=>NULL, 'group'=>NULL, 'where'=>NULL);

}