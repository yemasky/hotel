<?php

/**
 * Created by PhpStorm.
 * User: CooC
 * Date: 2015/12/9
 * Time: 18:04
 */
abstract class BaseDao{
    protected $table = '';
    protected $dsn_read = '';
    protected $dsn_write = '';
    protected $table_key = '';
    protected $fields = '';
    public static $objBaseDao = null;


    public function __call($name, $args){
        $objCallName = new $name($args);
        $objCallName->setCallObj($this, $args);
        return $objCallName;
    }

    public static function instance($objClass = ''){
        if(empty($objClass)) throw new Exception('objClass is null');
        if(isset(self::$objBaseDao[$objClass]) && is_object(self::$objBaseDao[$objClass])) {
            return self::$objBaseService[$objClass];
        }
        self::$objBaseDao[$objClass] = new $objClass();
        return self::$objBaseDao[$objClass];
    }

    public function getList($conditions, $fields = NULL) {
        if(empty($fields)) {
            $fields = '*';
        }
        return DBQuery::instance($this->dsn_read)->setTable($this->table)->setKey($this->table_key)->order($conditions['order'])->limit($conditions['limit'])->getList($conditions['where'], $fields);

    }

    public function getCount($conditions, $fields = NULL) {
        if(empty($fields)) {
            $fields = 'COUNT('. $this->table_key .')';
        }
        return DBQuery::instance($this->dsn_read)->setTable($this->table)->getOne($conditions, $fields);
    }

    public function insertData($arrayData, $insert_type = 'INSERT') {
        return DBQuery::instance($this->dsn_write)->setTable($this->table)->insert($arrayData, $insert_type)->getInsertId();
    }

    public function updateData($where, $row) {
        return DBQuery::instance($this->dsn_write)->setTable($this->table)->update($where, $row);
    }

    public function deleteData($conditions) {
        return DBQuery::instance($this->dsn_write)->setTable($this->table)->delete($conditions);
    }
}