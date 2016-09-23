<?php

/**
 * Created by PhpStorm.
 * User: CooC
 * Date: 2015/12/9
 * Time: 18:04
 */
class BaseDao{
    private $table = '';
    private $dsn_read = '';
    private $dsn_write = '';
    private $table_key = '*';
    private static $objBaseDao = null;


    public function __call($name, $args){
        $objCallName = new $name($args);
        $objCallName->setCallObj($this, $args);
        return $objCallName;
    }

    public static function instance($objClass = ''){
        if(empty($objClass)) $objClass = 'BaseDao';
        if(isset(self::$objBaseDao[$objClass]) && is_object(self::$objBaseDao[$objClass])) {
            return self::$objBaseService[$objClass];
        }
        self::$objBaseDao[$objClass] = new $objClass();
        return self::$objBaseDao[$objClass];
    }

    public function setTable($table) {
        $this->table = $table;
        return $this;
    }

    public function setKey($table_key) {
        $this->table_key = $table_key;
        return $this;
    }

    public function setDsnRead($dsn_read) {
        $this->dsn_read = $dsn_read;
        return $this;
    }

    public function setDsnWrite($dsn_write) {
        $this->dsn_write = $dsn_write;
        return $this;
    }

    public function getList($conditions, $fields = NULL) {
        if(empty($fields)) {
            $fields = '*';
        }
        return DBQuery::instance($this->dsn_read)->setTable($this->table)->setKey($this->table_key)->group($conditions['group'])->order($conditions['order'])->limit($conditions['limit'])->getList($conditions['where'], $fields);

    }

    public function getCount($conditions, $fields = NULL) {
        if(empty($fields)) {
            $fields = 'COUNT('. $this->table_key .')';
        }
        return DBQuery::instance($this->dsn_read)->setTable($this->table)->getOne($conditions, $fields);
    }

    public function insert($arrayData, $insert_type = 'INSERT') {
        return DBQuery::instance($this->dsn_write)->setTable($this->table)->insert($arrayData, $insert_type)->getInsertId();
    }

    public function update($where, $row) {
        return DBQuery::instance($this->dsn_write)->setTable($this->table)->update($where, $row);
    }

    public function delete($conditions) {
        return DBQuery::instance($this->dsn_write)->setTable($this->table)->delete($conditions);
    }
}