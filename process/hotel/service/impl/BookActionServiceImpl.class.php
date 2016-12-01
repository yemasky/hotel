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
            foreach($arrayBookInfo as $k => $v) {

            }
        } else {
            $objResponse -> message_http404 = '没找到相关订单记录！';
            $objResponse->setTplName("hotel/modules_http404");
            return;
        }

        //
        $objResponse -> arrayBookInfo = $arrayBookInfo;
    }
}