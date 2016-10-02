<?php

/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2015/12/6
 * Time: 16:56
 */
namespace hotel;
class ModulesDao extends \BaseDao {

    public function getDsnRead() {
        // TODO: Implement getDsnRead() method.
        return DbConfig::dsnRead();
    }

    public function getDsnWrite() {
        // TODO: Implement getDsnWrite() method.
        return DbConfig::dsnWrite();
    }
    
    public function getModules($conditions){
        $cacheId = md5('getModules');
        $fileid = 'modules_id, modules_father_id, modules_name, modules_order, modules_module, modules_action, modules_action_field, modules_action_permissions, modules_ico, modules_show';
        return $this->setDsnRead($this->getDsnRead())->setTable('modules')->getList($conditions, $fileid, 'modules_id');//DBCache($cacheId)->
    }
}