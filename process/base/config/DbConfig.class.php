<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 17:00
 */
class DbConfig{
	const supplier_dsn = 'mysqli://root:@127.0.0.1:3306/supplier';
	const merchant_dsn = 'mysqli://root:@127.0.0.1:3306/merchant';
	const tourism_dsn_read = 'mysqli://root:@127.0.0.1:3306/heniba';
	const tourism_dsn_write = 'mysqli://root:@127.0.0.1:3306/heniba';

	public static $db_query_conditions = array('order'=>null, 'limit'=>null, 'condition'=>null, 'gropy'=>null, 'where'=>null);

}