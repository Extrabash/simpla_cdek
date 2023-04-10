{* Шаблон корзины *}

<script src="{$config->root_url}/design/{$settings->theme|escape}/js/jquery.kladr.min.js"></script>
<link rel="stylesheet" href="{$config->root_url}/design/{$settings->theme|escape}/css/jquery.kladr.min.css">

{$meta_title = "Корзина" scope=parent}
<div class="limiter">
   <div id="breadcrumbs"><ul><li><a title="Главная страница" href="/">Главная страница</a></li><li><span class="arrow"> • </span></li><li><span class="changeName">Содержимое корзины</span></li></ul></div>						
   <h1>
   {if $cart->purchases}В корзине {$cart->total_products} {$cart->total_products|plural:'товар':'товаров':'товара'}
   {else}Корзина пуста{/if}
   </h1>
	{if $cart->purchases}
	<form method="post" name="cart">
      <div id="personalCart">
         <div id="basketTopLine">
            <div id="basketView">
               <div class="item">
                  <span>Вид корзины: </span>
               </div>
               <div class="item">
                  <a class="squares {if $smarty.cookies.view == 'grid_cart'}selected{/if}" onclick="document.cookie='view=grid_cart;path=/';document.location.reload();" href="javascript:;"></a>
               </div>
               <div class="item">
                  <a class="table {if $smarty.cookies.view == 'table_cart'}selected{/if}" onclick="document.cookie='view=table_cart;path=/';document.location.reload();" href="javascript:;"></a>
               </div>
            </div>
         </div>
         <div id="basketProductList">
          {if $smarty.cookies.view == 'table_cart'}
            {include file='table_cart.tpl'} 
            {else} 
            {include file='grid_cart.tpl'}
          {/if}
         </div>
         {if $coupon_error}
            <div class="message_error">
               {if $coupon_error == 'invalid'}Купон недействителен{/if}
            </div>
         {/if}
         <div class="orderLine">
            <div id="sum">
               <span class="label hd">Всего товаров:</span>
               <span id="countItems" class="price hd">{$cart->total_products}</span> 
               <span class="label">Сумма заказа:</span> 
               <span class="price">
                  <span id="allSum">{$cart->total_price|convert}&nbsp;{$currency->sign}</span>
               </span>								
            </div>
            {*if $coupon_request}
            <span id="coupon">{if $cart->coupon->min_order_price>0}(купон {$cart->coupon->code|escape} действует для заказов от {$cart->coupon->min_order_price|convert} {$currency->sign}){/if}
               <input class="couponField" name="coupon_code" value="{$cart->coupon->code|escape}" placeholder="Введите номер купона"><input type="button" name="apply_coupon" onclick="document.cart.submit();" class="couponActivate" value="Активировать">
            </span>
            {/if*}
         </div>
         {if $coupon_request}
         {literal}
         <script>
         $("input[name='coupon_code']").keypress(function(event){
            if(event.keyCode == 13){
               $("input[name='name']").attr('data-format', '');
               $("input[name='email']").attr('data-format', '');
               document.cart.submit();
            }
         });
         </script>
         {/literal}
         {/if}
         {if $error}
         <div class="message_error">
            {if $error == 'empty_name'}Введите имя{/if}
            {if $error == 'empty_email'}Введите email{/if}
            {if $error == 'captcha'}Капча введена неверно{/if}
         </div>
         {/if}
         <div class="orderContainer" id="order">
            <span class="title">Заполните пожалуйста Ваши данные для заказа</span> 
            <table class="orderProps active">
               <tbody>
                  <tr>
                     <td>
                        <span>Личные данные</span>
                     </td>
                     <td>
                        <ul class="userProp">
                           <li>
                              <span class="label">ФИО или ИНН*</span>
                              <label>Например: 7700021212</label>
                              <input name="name" type="text" value="{$name|escape}" data-format=".+" data-notice="Введите имя"/>
                           </li>
                           <li>
                              <span class="label">E-Mail*</span>
                              <label>Например: info@site.ru</label>
                              <input name="email" type="text" value="{$email|escape}" data-format="email" data-notice="Введите email" />
                           </li>
                           <li>
                              <span class="label">Телефон*</span>
                              <label>Например: +7 (495) 123-45-67</label>
                              <input name="phone" type="text" value="{$phone|escape}" />
                           </li>
                        </ul>
                     </td>
                  </tr>
               </tbody>
            </table>
            <table class="orderProps active">
               <tbody>
                  <tr>
                     <td>
                        <span>Доставка</span>
                     </td>
                     <td>
                        <span class="label">Доставка</span>
                        <select name="delivery_id" class="deliSelect">
                           {foreach $deliveries as $delivery}
                              <option value="{$delivery->id}"{if $delivery_id == $delivery->id} selected{/if}>
                                 {$delivery->name}
                                 {if $cart->total_price < $delivery->free_from && $delivery->price>0}
                                    ({$delivery->price|convert}&nbsp;{$currency->sign})
                                 {elseif $cart->total_price >= $delivery->free_from}
                                    (бесплатно)
                                 {/if}
                              </option>
                           {/foreach}
                        </select>
                        <ul class="userProp">
                           <li class="deliProps">
                              {*<span class="label">Адрес доставки</span>
                              <label></label>
                              <input name="address" type="text" value="{$address|escape}"/>*}
                              <span class="label">Область*</span>
                              <label></label>
                              <input name="region" required  id="reg_input" type="text" value="{$reg_name|escape}"/>

                              <span class="label">Город*</span>
                              <label></label>
                              <input name="city" required id="city_input" type="text" value="{$city_name|escape}"/>

                              <span class="label">Улица</span>
                              <label></label>
                              <input name="street" type="text" value="{$street|escape}"/>

                              <span class="label">Дом</span>
                              <label></label>
                              <input name="building" type="text" value="{$building|escape}"/>

                              <span class="label">Квартира</span>
                              <label></label>
                              <input name="app1" type="text" value="{$app1|escape}"/>

                              <input type=hidden name="address" id="address_full" value="{$address|escape}"/> 
                           </li>
                        </ul>
                     </td>
                  </tr>
                  <tr>
                     <td></td>
                     <td>
                        <span class="label">Комментарий к заказу</span>
                        <textarea name="comment" id="order_comment">{$comment|escape}</textarea>
                     </td>
                  </tr>
                  <tr>             
                     <td>
                        <span>Капча</span>
                     </td>
                     <td>
                        <ul class="userProp">
                           <li> 
                              <div class="captcha"><img src="captcha/image.php?{math equation='rand(10,10000)'}" alt='captcha'/></div> 
                           </li>
                           <li class="deliProps" data-id="deli_1">
                              <span class="label">Цифры с картинки</span>
                              <label></label>
                              <input class="input_captcha" id="comment_captcha" type="text" name="captcha_code" value="" data-format="\d\d\d\d" data-notice="Введите капчу"/>
                           </li>
                        </ul>
                     </td>
                  </tr>
               </tbody>
            </table>
            <div class="orderLine bottom">
               <div id="sum">
                  <button id="orderMake" name="checkout" class="order" type="submit"><img src="design/{$settings->theme|escape}/images/order.png"> Оформить заказ</button>
                  <span class="label hd">Всего товаров:</span> <span id="countOrderItems" class="price hd">{$cart->total_products}</span>
                  {if $user->discount}
                  <span class="label">Скидка:</span>
                  <span class="price"><span id="allDevilerySum">{$user->discount}&nbsp;%</span></span> 
                  {/if}
                  {if $cart->coupon_discount>0}
                  <span class="label">Скидка:</span>
                  <span class="price"><span id="allDevilerySum">&minus;{$cart->coupon_discount|convert}&nbsp;{$currency->sign}</span></span> 
                  {/if}
                  <span class="label">Сумма заказа:</span> 
                  <span class="price"><span id="allOrderSum">{$cart->total_price|convert}&nbsp;{$currency->sign}</span></span>
               </div>
            </div>
         </div>
         <div class="clear"></div>
      </div>
   </form>
  {else}
   <p>В корзине нет товаров</p>
  {/if}
</div>
