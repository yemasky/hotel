<?php
/**
 * Created by PhpStorm.
 * User: CooC
 * Date: 2016/12/1
 * Time: 12:39
 */

namespace hotel;


class BookActionServiceImpl extends \BaseService  {
    private static $objService = null;

    public static function instance() {
        // TODO: Implement instance() method.
        if(is_object(self::$objService)) {
            return self::$objService;
        }
        self::$objService = new BookActionServiceImpl();
        return self::$objService;
    }

    public function doEditBookAction($objRequest, $objResponse) {
        $order_number = decode($objRequest -> order_number);
        if(empty($order_number) || !is_numeric($order_number)) {
            $objResponse -> message_http404 = '页面没找到！';
            $objResponse -> setTplName("hotel/modules_http404");
            return;
        }
        $hotel_id = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$hotel_id, 'book_order_number'=>$order_number);
        $conditions['order'] = 'book_order_number_main DESC';
        $arrayBookInfo = BookService::instance()->getBook($conditions);
        if(!empty($arrayBookInfo)) {
            $this -> showBookInfo($objRequest, $objResponse, $arrayBookInfo, $order_number);
        } else {
            $objResponse -> message_http404 = '没找到相关订单记录！';
            $objResponse->setTplName("hotel/modules_http404");
            return;
        }
    }

    protected function showBookInfo($objRequest, $objResponse, $arrayBookInfo, $order_number) {
        $arrayRoomId = '';$arraySellLayoutId = '';$arrayLayoutId = '';$arraySystemID = '';
        foreach($arrayBookInfo as $k => $arrayBook) {
            $arrayRoomId[]       = $arrayBook['room_id'];
            $arraySellLayoutId[] = $arrayBook['room_sell_layout_id'];
            $arrayLayoutId[]     = $arrayBook['room_layout_id'];
            $arraySystemID[]     = $arrayBook['room_layout_price_system_id'];
        }
        $hotel_id = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
        $conditions = DbConfig::$db_query_conditions;
        //房间
        $conditions['where'] = array('hotel_id'=>$hotel_id,'IN'=>array('room_id'=>$arrayRoomId));
        $arrayRoomInfo = RoomService::instance()->getRoom($conditions, '*', 'room_id');
        //房型
        $conditions['where'] = array('hotel_id'=>$hotel_id,'IN'=>array('room_sell_layout_id'=>$arraySellLayoutId));
        $arraySellLayout = RoomService::instance()->getRoomSellLayout($conditions, '*', 'room_sell_layout_id');
        //价格体系
        $conditions['where'] = array('IN'=>array('room_layout_price_system_id'=>$arraySystemID));
        $arrayPriceSystem = RoomService::instance()->getRoomLayoutPriceSystem($conditions, '*', 'room_layout_price_system_id');
        //入住信息
        $conditions['where'] = array('hotel_id'=>$hotel_id,'book_order_number'=>$order_number);
        $arrayBookUser = BookService::instance()->getBookUser($conditions);
        //附加服务信息
        $conditions['where'] = array('hotel_id'=>$hotel_id,'book_order_number'=>$order_number);
        $arrayBookHotelService = BookService::instance()->getBookHotelService($conditions);
        $arrayHotelService = array();
        if(!empty($arrayBookHotelService)) {
            $arrayServiceId = array();
            foreach($arrayBookHotelService as $i => $arrayService) {
                $arrayServiceId[] = $arrayService['hotel_service_id'];
            }
            $conditions['where'] = array('hotel_id'=>$hotel_id,'IN'=>array('hotel_service_id'=>$arrayServiceId));
            $arrayHotelService = HotelService::instance()->getHotelService($conditions, '*', 'hotel_service_id');
        }
        //附加服务
        $arrayPaymentType = BookService::instance()->getPaymentType(null, '*', '');
        //来源
        $conditions['where'] = array('IN'=>array('hotel_id'=>array($hotel_id,0)));
        $arrayBookType = BookService::instance()->getBookType($conditions, '*', 'book_type_id');
        //赋值
        $objResponse -> idCardType = ModulesConfig::$idCardType;
        $objResponse -> orderStatus = ModulesConfig::$orderStatus;
        $objResponse -> arrayDataInfo    = $arrayBookInfo;
        $objResponse -> arrayRoomInfo    = $arrayRoomInfo;
        $objResponse -> arraySellLayout  = $arraySellLayout;
        $objResponse -> arrayPriceSystem = $arrayPriceSystem;
        $objResponse -> arrayBookUser = $arrayBookUser;
        $objResponse -> arrayBookHotelService = $arrayBookHotelService;
        $objResponse -> arrayHotelService = $arrayHotelService;
        $objResponse -> arrayPaymentType = $arrayPaymentType;
        $objResponse -> arrayBookType = $arrayBookType;
    }
}