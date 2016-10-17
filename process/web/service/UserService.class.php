<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/24
 * Time: 0:04
 */
namespace web;
class UserService extends \BaseService {
    private static $objService = null;
    public static function instance() {
        if(is_object(self::$objService)) {
            return self::$objService;
        }
        self::$objService = new UserService();
        return self::$objService;
    }

    public function getUser($user_id) {
        $conditions = \DbConfig::$db_query_conditions;
        $conditions['where'] = array('user_id'=>$user_id);
        return UserDao::instance()->getUser($conditions);
    }


}