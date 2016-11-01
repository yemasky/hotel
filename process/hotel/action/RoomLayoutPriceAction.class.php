<?php
/**
 * Created by PhpStorm.
 * User: YEMASKY
 * Date: 2016/7/23
 * Time: 19:17
 */

namespace hotel;


class RoomLayoutPriceAction extends \BaseAction {
    protected function check($objRequest, $objResponse) {
        $objResponse -> back_lis_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomLayoutPrice']['view'])));
    }

    protected function service($objRequest, $objResponse) {
        switch($objRequest->getAction()) {
            case 'edit':
                $this->doEdit($objRequest, $objResponse);
                break;
            case 'add':
                $this->doAdd($objRequest, $objResponse);
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
        //赋值
        $objResponse -> add_roomLayoutPriceSystem_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomLayoutPrice']['add'])));
        //
        //设置类别
    }

    protected function doAdd($objRequest, $objResponse) {
        $conditions = DbConfig::$db_query_conditions;
        if($objRequest -> search == 'hotel_service') {
            $this->setDisplay();
            $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id']);
            $conditions['order'] = 'hotel_service_father_id ASC';
            $field = 'hotel_service_id, hotel_service_father_id, hotel_service_name, hotel_service_price';
            $arrayHotelService = HotelService::instance()->getHotelService($conditions, $field);
            return $this->successResponse("", $arrayHotelService);
        }

        $this->doEdit($objRequest, $objResponse);
        //
        $objResponse -> add_roomLayoutPriceSystem_url =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomLayoutPrice']['add'])));
        $objResponse->view = 'add';
        //更改tpl
    }

    protected function doEdit($objRequest, $objResponse) {

        $conditions = DbConfig::$db_query_conditions;
        //售卖房型

        $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],
                                     'room_layout_valid'=>'1');
        $arrayRoomLayout = RoomService::instance()->getRoomLayout($conditions);

        //价格体系
        $conditions['where'] = array('IN'=>array('hotel_id'=>array('0',$objResponse->arrayLoginEmployeeInfo['hotel_id'])),
            '>'=>array('room_layout_price_system_id'=>0),
            'room_layout_price_system_valid'=>'1');
        $arrayRoomLayoutPriceSystem = RoomService::instance()->getRoomLayoutPriceSystem($conditions);
        //

        //赋值
        $objResponse -> thisDay = getDay();
        $objResponse -> thisToday = getToDay();
        $objResponse -> toDay = getDay(24*6);
        $objResponse -> thisYear = getYear();
        $objResponse -> thisMonth = getMonth();
        $objResponse -> view = '0';
            //售卖房型
        $objResponse -> arrayRoomLayout = $arrayRoomLayout;
            //价格体系
        $objResponse -> arrayRoomLayoutPriceSystem = $arrayRoomLayoutPriceSystem;
        //
        $objResponse -> addoomLayoutPriceSystemUrl =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['roomLayoutPrice']['add'])));
        //
        $objResponse -> setTplName("hotel/modules_roomLayoutPrice_edit");
    }

    protected function doDelete($objRequest, $objResponse) {
        $this->setDisplay();
    }
}