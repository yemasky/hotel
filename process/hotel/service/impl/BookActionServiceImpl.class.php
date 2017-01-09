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
        $conditions['where'] = array('hotel_id'=>$hotel_id,'room_sell_layout_valid'=>1);
        $arraySellLayout = RoomService::instance()->getRoomSellLayout($conditions, '*', 'room_sell_layout_id');
        //价格体系
        $conditions['where'] = array('IN'=>array('hotel_id'=>array(0,$hotel_id)),'room_layout_price_system_valid'=>1);
        $arrayPriceSystem = RoomService::instance()->getRoomLayoutPriceSystem($conditions, '*', 'room_layout_price_system_id');
        //入住信息
        $conditions['where'] = array('hotel_id'=>$hotel_id,'book_order_number'=>$order_number);
        $arrayBookUser = BookService::instance()->getBookUser($conditions);
        //入住房价信息
        $conditions['where'] = array('hotel_id'=>$hotel_id,'book_order_number'=>$order_number);
        $arrayBookRoomPrice = BookService::instance()->getBookRoomPrice($conditions, '*', 'room_sell_layout_id');
        //入住加床价格信息
        $conditions['where'] = array('hotel_id'=>$hotel_id,'book_order_number'=>$order_number);
        $arrayBookRoomExtraBedPrice = BookService::instance()->getBookRoomExtraBedPrice($conditions, '*', 'room_sell_layout_id');
        //附加服务信息
        $conditions['where'] = array('hotel_id'=>$hotel_id,'book_order_number'=>$order_number);
        $arrayBookHotelService = BookService::instance()->getBookHotelService($conditions);
        $conditions['where'] = array('hotel_id'=>$hotel_id);
        $conditions['order'] = 'hotel_service_father_id ASC';
        $arrayHotelService = HotelService::instance()->getHotelService($conditions, '*', 'hotel_service_id');
        $conditions['order'] = '';
        //支付方式
        $arrayPaymentType = HotelService::instance()->getHotelPaymentType(null, '*', 'payment_type_id');
        //来源
        $conditions['where'] = array('IN'=>array('hotel_id'=>array($hotel_id,0)));
        $arrayBookType = BookService::instance()->getBookType($conditions, '*', 'book_type_id');
        //变更历史
        $conditions['where'] = array('hotel_id'=>$hotel_id,'book_order_number'=>$order_number);
        $arrayBookChange = BookService::instance()->getBookChange($conditions, '*', 'book_type_id');

        //hotel info
        $conditions['where'] = array('hotel_id'=>$hotel_id);
        $arrayHotel = HotelService::instance()->getHotel($conditions);
        $hotel_checkout = empty($arrayHotel[0]['hotel_checkout']) ? '12:00' : $arrayHotel[0]['hotel_checkout'];
        $hotel_checkin = empty($arrayHotel[0]['hotel_checkin']) ? '06:00' : $arrayHotel[0]['hotel_checkin'];
        $hotel_overtime = empty($arrayHotel[0]['hotel_overtime']) ? '18:00' : $arrayHotel[0]['hotel_overtime'];
        //赋值
        $objResponse -> idCardType = ModulesConfig::$idCardType;
        $objResponse -> orderStatus = ModulesConfig::$orderStatus;
        $objResponse -> arrayDataInfo    = $arrayBookInfo;
        $objResponse -> arrayBookRoomPrice    = $arrayBookRoomPrice;
        $objResponse -> arrayBookRoomExtraBedPrice    = $arrayBookRoomExtraBedPrice;
        $objResponse -> arrayRoomInfo    = $arrayRoomInfo;
        $objResponse -> arraySellLayout  = $arraySellLayout;
        $objResponse -> arrayPriceSystem = $arrayPriceSystem;
        $objResponse -> arrayBookUser = $arrayBookUser;
        $objResponse -> arrayBookHotelService = $arrayBookHotelService;
        $objResponse -> arrayHotelService = $arrayHotelService;
        $objResponse -> arrayPaymentType = $arrayPaymentType;
        $objResponse -> arrayBookType = $arrayBookType;
        $objResponse -> arrayBookChange = $arrayBookChange;
        $objResponse -> thisDay = getDay();
        $objResponse -> thisDayTime = getDateTime();

        $objResponse -> hotel_checkout = $hotel_checkout;
        $objResponse -> hotel_checkin  = $hotel_checkin;
        $objResponse -> hotel_overtime  = $hotel_overtime;
        $objResponse -> searchBookInfoUrl =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['book']['add'])));
        $objResponse -> saveBookInfoUrl =
            \BaseUrlUtil::Url(array('module'=>encode(ModulesConfig::$modulesConfig['book']['edit']),'order_number'=>encode($order_number)));
    }

    public function doSaveEditbookAction($objRequest, $objResponse) {
        BookOperateService::instance()->saveEditReBookInfo($objRequest, $objResponse);
    }

    public function doSaveEditBookPayment($objRequest, $objResponse) {
        $order_number = decode($objRequest -> order_number);
        $book_is_pay = $objRequest -> book_is_pay;
        $book_is_pay = $book_is_pay == 2 ? '0' : '1';
        $book_payment = $objRequest -> book_payment;
        $book_payment = $book_payment < 2 ? '0' : '1';
        $book_payment_type = $objRequest -> book_payment_type;
        $conditions = DbConfig::$db_query_conditions;
        $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],'book_order_number'=>$order_number);
        $arrayUpdate['book_is_pay'] = $book_is_pay;
        $arrayUpdate['book_is_payment'] = $book_payment;
        $arrayUpdate['payment_type_id'] = $book_payment_type;
        if($book_is_pay > 0) $arrayUpdate['book_pay_date'] = getDateTime();
        BookService::instance()->updateBook($conditions['where'], $arrayUpdate);
    }

    public function doEditCheckInRoom($objRequest, $objResponse) {
        $order_number = decode($objRequest -> order_number);
        $book_id = $objRequest -> book_id;
        $room_id = $objRequest -> room_id;
        $conditions = DbConfig::$db_query_conditions;
        if($book_id == 'ALL' && $room_id = 'ALL') {
            $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],'book_order_number'=>$order_number);
            $arrayUpdate['book_order_number_main_status'] = '1';
        } else {
            $conditions['where'] = array('hotel_id'=>$objResponse->arrayLoginEmployeeInfo['hotel_id'],'book_order_number'=>$order_number,
                'book_id'=>$book_id, 'room_id'=>$room_id);
        }
        $arrayUpdate['book_order_number_status'] = '1';
        BookService::instance()->updateBook($conditions['where'], $arrayUpdate);

    }

    public function doAddBookUser($objRequest, $objResponse) {
        $arraySaveData['book_id'] = $objRequest -> book_id;//
        $arraySaveData['hotel_id'] = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
        $arraySaveData['book_order_number'] = decode($objRequest -> order_number);
        $arraySaveData['room_id'] = $objRequest -> room_num;//
        $arraySaveData['room_sell_layout_id'] = $objRequest -> sell_layout_id;//
        $arraySaveData['room_layout_id'] = $objRequest -> layout_id;//
        //
        $arraySaveData['book_user_name'] = $objRequest->room_user_name;
        $arraySaveData['book_user_sex'] = $objRequest->room_user_sex;
        $arraySaveData['book_user_lodger_type'] = $objRequest->user_lodger_type;
        $arraySaveData['book_user_id_card_type'] = $objRequest->user_id_card_type;
        $arraySaveData['book_user_id_card'] = $objRequest->user_id_card;
        $arraySaveData['book_user_comments'] = $objRequest->user_comments;

        $arraySaveData['book_add_date'] = getDay();
        $arraySaveData['book_add_time'] = getTime();
        BookService::instance()->saveBookUser($arraySaveData);
    }

    public function setUserRoomCard($objRequest, $objResponse) {
        $arraySaveData['hotel_id'] = $objResponse->arrayLoginEmployeeInfo['hotel_id'];
        $arraySaveData['book_order_number'] = decode($objRequest -> order_number);
        $arraySaveData['room_id'] = $objRequest -> room_num;//

    }
}