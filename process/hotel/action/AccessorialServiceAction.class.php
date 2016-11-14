<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class AccessorialServiceAction extends \BaseAction {
    protected function check($objRequest, $objResponse) {

    }

    protected function service($objRequest, $objResponse) {
        switch($objRequest->getAction()) {
            case 'add':
                $this->doAdd($objRequest, $objResponse);
                break;
            case 'edit':
                $this->doEdit($objRequest, $objResponse);
                break;
            case 'delete':
                $this->doDelete($objRequest, $objResponse);
                break;
            default:
                $this->doDefault($objRequest, $objResponse);
                break;
        }
    }

    /**
     * 首页显示
     */
    protected function doDefault($objRequest, $objResponse) {
        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'], 'hotel_service_valid'=>1);
        $arrayAccessorialService = HotelService::instance()->getHotelService($conditions, '*', 'hotel_service_id', true, 'hotel_service_father_id');
        sort($arrayAccessorialService);
        //print_r($arrayAccessorialService);
        //赋值
        //sort($arrayRoomAttribute, SORT_NUMERIC);
        //
        $objResponse -> arrayData = $arrayAccessorialService;
        $objResponse -> add_accessorialService_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['accessorialService']['add'])));
        $objResponse -> edit_accessorialService_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['accessorialService']['edit'])));
        $objResponse -> delete_add_accessorialService_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['accessorialService']['delete'])));
        //设置类别
    }
    protected function doAdd($objRequest, $objResponse) {
        $objRequest -> hotel_service_id = 0;
        $this->doEdit($objRequest, $objResponse);
    }

    protected function doEdit($objRequest, $objResponse) {
        $this->setDisplay();
        $arrayPostValue= $objRequest->getPost();

        if(!empty($arrayPostValue) && is_array($arrayPostValue) && $objRequest -> hotel_service_id > 0) {

            return $this->successResponse('保存客房属性成功');
        }
        return $this->errorResponse('没有保存任何客房属性');
    }

    protected function doDelete($objRequest, $objResponse) {
        $this->setDisplay();
        $arrayPostValue= $objRequest->getPost();
        if(!empty($arrayPostValue) && is_array($arrayPostValue)) {

            return $this->successResponse('修改成功！');
        }
        return $this->errorResponse('修改失败，请检查！');
    }

}