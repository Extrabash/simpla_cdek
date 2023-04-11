<!DOCTYPE html>
<html lang="ru">
   <head>
	   <base href="{$config->root_url}/"/>
	   <meta charset="windows-1251">
	   <meta name="description" content="{$meta_description|escape}" />
	   <meta name="keywords"    content="{$meta_keywords|escape}" />
      <META NAME="viewport" content="width=device-width, initial-scale=1.0">
      <link rel="shortcut icon" type="image/x-icon" href="design/{$settings->theme|escape}/images/favicon.png" />
      
      {if $module=='MainView'}
      <link href="design/{$settings->theme|escape}/css/page_main.css" type="text/css"  rel="stylesheet">
      {/if}
      
      {if $module == 'ProductsView' || $module == 'WishlistView'}
      <link href="design/{$settings->theme|escape}/css/page_products.css" type="text/css"  rel="stylesheet">
      {/if}
      
      {if $module == 'CompareView'}
      <link href="design/{$settings->theme|escape}/css/page_compare.css" type="text/css"  rel="stylesheet">
      {/if}
      
      {if $module == 'WishlistView'}
       <link href="design/{$settings->theme|escape}/css/page_wishlist.css" type="text/css"  rel="stylesheet">
      {/if}
      
      {if $module == 'PageView'}
       <link href="design/{$settings->theme|escape}/css/page.css" type="text/css"  rel="stylesheet">
      {/if}
      
      {if $module == 'BlogView'}
       <link href="design/{$settings->theme|escape}/css/page_blog.css" type="text/css"  rel="stylesheet">
       <link href="design/{$settings->theme|escape}/css/page_post.css" type="text/css"  rel="stylesheet">
      {/if}
      
      {if $module == 'PostView'}
       <link href="design/{$settings->theme|escape}/css/page_post.css" type="text/css"  rel="stylesheet">
      {/if}
      
       {if $module == 'FeedbackView'}
       <link href="design/{$settings->theme|escape}/css/page_feedback.css" type="text/css"  rel="stylesheet">
      {/if}
      
      {if $module == 'CartView' || $module == 'OrderView' }
       <link href="design/{$settings->theme|escape}/css/page_cart.css" type="text/css"  rel="stylesheet">
      {/if}
      
      {if $module == 'OrderView' }
       <link href="design/{$settings->theme|escape}/css/page_order.css" type="text/css"  rel="stylesheet">
      {/if}
      
      {* Template *}
      <link href="design/{$settings->theme|escape}/css/template.css" type="text/css"  data-template-style="true"  rel="stylesheet">
      
      <title>{$meta_title|escape}</title>
	  
	   {* Канонический адрес страницы *}
	   {if isset($canonical)}<link rel="canonical" href="{$config->root_url}{$canonical}"/>{/if}
      
      {literal}
      <style>
         .tabs__content {
            display: none;
         }
         .tabs__content.active {
            display: block;
         }
      </style>
      {/literal}
   </head>
   <body {if $module=='MainView'}class="index"{/if}>
      <div id="foundation">
         {include file='header.tpl'}
         <div id="main">
            {$content}
         </div>
         {include file='footer.tpl'}
      </div>
      <div id="upButton">
         <a href="#"></a>
      </div>
      
      {* JQuery *}
      <script src="js/jquery/jquery.js"  type="text/javascript"></script>
   
      {* Аяксовая корзина *}
      <script src="design/{$settings->theme}/js/jquery-ui.min.js"></script>
      <script src="design/{$settings->theme}/js/ajax_cart.js"></script>

      {if $module=='MainView'}
      <script src="design/{$settings->theme|escape}/js/tabs.js"></script>
      {/if}
      
      {* Купить в 1 клик *}
      <script type="text/javascript" src="/buyme/js/buyme.js"></script>
     
      {* Всплывающие подсказки для администратора *}
      {if $smarty.session.admin == 'admin'}
      <script src ="js/admintooltip/admintooltip.js" type="text/javascript"></script>
      <link   href="js/admintooltip/css/admintooltip.css" rel="stylesheet" type="text/css" /> 
      {/if}
      
      {* Ctrl-навигация на соседние товары *}
      <script type="text/javascript" src="js/ctrlnavigate.js"></script>           
      
      {* js-проверка форм *}
      {if  $module == 'PostView' || $module == 'FeedbackView' || $module == 'OrderView' || $module == 'CartView' || $module == 'LoginView' || $module == 'UserView' || $module == 'RegisterView'}
      <script src="js/baloon/js/baloon.js" type="text/javascript"></script>
      <link   href="js/baloon/css/baloon.css" rel="stylesheet" type="text/css" />
      {/if}
      
      {* Template *}
      <script type="text/javascript" src="design/{$settings->theme|escape}/js/template.js"></script>
      
      {if $module=='CompareView'}
      <script type="text/javascript" src="design/{$settings->theme|escape}/js/page_compare.js"></script>
      {/if}

      {if $module=='MainView'}
      <script type="text/javascript" src="design/{$settings->theme|escape}/js/page_main.js"></script>
      {/if}
      
      {if $module == 'CartView'}
      <script type="text/javascript" src="design/{$settings->theme|escape}/js/page_cart.js"></script>
      {/if}
      
      <script type="text/javascript"  src="design/{$settings->theme}/js/jquery-migrate-1.2.1.min.js"></script>
      
      {if $module == 'ProductsView' || $module == 'WishlistView'}
      <script type="text/javascript" src="design/{$settings->theme|escape}/js/page_products.js"></script>
      <script src="design/{$settings->theme}/js/jquery-ui-1.9.0.custom.min.js"  type="text/javascript"></script>
      <script src="design/{$settings->theme}/js/filter.min.js"  type="text/javascript"></script>
      {/if}
      
      {* Автозаполнитель поиска *}
      {literal}
      <script src="js/autocomplete/jquery.autocomplete-min.js" type="text/javascript"></script>
      <style>
         .autocomplete-suggestions{
         background-color: #ffffff;
         overflow: hidden;
         border: 1px solid #e0e0e0;
         overflow-y: auto;
         }
         .autocomplete-suggestions .autocomplete-suggestion{cursor: default;}
         .autocomplete-suggestions .selected { background:#F0F0F0; }
         .autocomplete-suggestions div { padding:2px 5px; white-space:nowrap; }
         .autocomplete-suggestions strong { font-weight:normal; color:#3399FF; }
      </style>	
      <script>
      $(function() {
         //  Автозаполнитель поиска
         $(".input_search").autocomplete({
            serviceUrl:'ajax/search_products.php',
            minChars:1,
            noCache: false, 
            onSelect:
               function(suggestion){
                   $(".input_search").closest('form').submit();
               },
            formatResult:
               function(suggestion, currentValue){
                  var reEscape = new RegExp('(\\' + ['/', '.', '*', '+', '?', '|', '(', ')', '[', ']', '{', '}', '\\'].join('|\\') + ')', 'g');
                  var pattern = '(' + currentValue.replace(reEscape, '\\$1') + ')';
                  return (suggestion.data.image?"<img align=absmiddle src='"+suggestion.data.image+"'> ":'') + suggestion.value.replace(new RegExp(pattern, 'gi'), '<strong>$1<\/strong>');
               }	
         });
      });
      </script>
      {/literal}
      {literal}
       <script type="text/javascript">
         $("#captionCarousel").dwCarousel({
         	leftButton: ".captionBtnLeft",
         	rightButton: ".captionBtnRight",
         	countElement: 5,
         	resizeElement: true,
         	resizeAutoParams: {
         		1920: 5,
         		1500: 4,
         		1200: 3,
         		850: 2,
         		480: 1
         	}
         });
      </script>
      <script>
         $("#mainNewsCarousel").dwCarousel({
            leftButton: ".mainNewsBtnLeft",
            rightButton: ".mainNewsBtnRight",
            countElement: 4,
            resizeElement: true,
            resizeAutoParams: {
               1920: 4,
               1200: 3,
               850: 2,
               480: 1
            }
         });
      </script>
      <script>
         $("#mainCollectionCarousel").dwCarousel({
            leftButton: ".mainCollectionBtnLeft",
            rightButton: ".mainCollectionBtnRight",
            countElement: 4,
            resizeElement: true,
            resizeAutoParams: {
               1920: 4,
               1200: 3,
               850: 2,
               480: 1
            }
         });
      </script>
      <script>
         $("#mainServiceCarousel").dwCarousel({
            leftButton: ".mainServiceBtnLeft",
            rightButton: ".mainServiceBtnRight",
            countElement: 4,
            resizeElement: true,
            resizeAutoParams: {
               1920: 4,
               1200: 3,
               850: 2,
               480: 1
            }
         });
      </script>
      <script>
         $("#topProduct").dwCarousel({
            leftButton: ".topBtnLeft",
            rightButton: ".topBtnRight",
            countElement: 6,
            resizeElement: true,
            resizeAutoParams: {
               1920: 5,
               1500: 4,
               1200: 3,
               850: 2,
               480: 1
            }
         });
      </script>
      <script>
         $("#viewedProduct").dwCarousel({
            leftButton: ".viewedBtnLeft",
            rightButton: ".viewedBtnRight",
            countElement: 6,
            resizeElement: true,
            resizeAutoParams: {
               1920: 5,
               1500: 4,
               1200: 3,
               850: 2
            }
         });
      </script>
      {/literal}
      {literal}

      {/literal}

      {* Обработка доставки CDEK при помощи kladr *}
      {if $cart->purchases && $module == 'CartView'}

         <script src="{$config->root_url}/design/{$settings->theme|escape}/js/jquery.kladr.min.js"></script>
         <link rel="stylesheet" href="{$config->root_url}/design/{$settings->theme|escape}/css/jquery.kladr.min.css">
         
         {literal}
      
         <script type="text/javascript">
            $(function () {
               $('#cart_form').submit(function (e) {
                  // Может отличаться получение айди доставки
                  var delivery_id = $('[name=delivery_id]').val();
                  if (delivery_id == 13) {
                        var del_prive = parseInt($('#del_price').val()) || 0;
                        if (!del_prive) {
                           e.preventDefault();
                           alert('Подождите пока рассчитается стоимость доставки!');
                        }
                  }
               })
            })

            $(document).ready(function () {

               function cdek(post_id, kladr_code) {
                  $('#cdek_bl').html('<span style="color:#990000;">Подождите, рассчитываем стоимость доставки</span>');
                  $.ajax({
                        url: "/ajax/ajax_cdek_delivery.php",
                        type: "GET",
                        timeout: 25000,
                        data: {
                           id: post_id,
                           code: kladr_code,
                           reg_name: $('[name="region"]').val()
                        },
                        success: function (result) {
                           var arr = result.split('|');
                           $('#cdek_bl').html(arr[0]);
                           $('#del_price').val($('#cdek_price').val());
                        }
                  });
               }

               $(function () {
                  var $regname;
                  var $tooltip = $('.tooltip');
                  var $zip = $('[name="zip"]'),
                        $region = $('[name="region"]'),
                        //$district = $('[name="district"]'),
                        $city = $('#city_input'),
                        $street = $('[name="streetfix"]'),
                        $building = $('[name="building"]');

                  $.kladr.setDefault({
                        parentInput: '.addr_block',
                        verify: true,
                        select: function (obj) {
                           setLabel($(this), obj.type);
                           $tooltip.hide();
                        },
                        check: function (obj) {
                           var $input = $(this);

                           if (obj) {
                              setLabel($input, obj.type);
                              $tooltip.hide();
                           }
                           else {
                              showError($input, 'Введено неверно');
                           }
                        },
                        checkBefore: function () {
                           var $input = $(this);

                           if (!$.trim($input.val())) {
                              $tooltip.hide();
                              return false;
                           }
                        }
                  });

                  $region.kladr({
                        type: $.kladr.type.region,
                        change: function (obj) {
                           $("#reg_type").val(obj.type);
                           //cdek(obj.name, obj.id);
                        }
                  });

                  $city.kladr({
                        type: $.kladr.type.city,
                        change: function (obj) {
                           //$('#city_input_pup').val(obj.name);
                           cdek(obj.name, obj.id);
                        }
                  });

                  $street.kladr('type', $.kladr.type.street);
                  $building.kladr('type', $.kladr.type.building);

                  // Подключаем плагин для почтового индекса
                  $zip.kladrZip();

                  function setLabel($input, text) {
                        text = text.charAt(0).toUpperCase() + text.substr(1).toLowerCase();
                        $input.parent().find('label').text(text);
                  }

                  function showError($input, message) {
                        $tooltip.find('span').text(message);

                        var inputOffset = $input.offset(),
                           inputWidth = $input.outerWidth(),
                           inputHeight = $input.outerHeight();

                        var tooltipHeight = $tooltip.outerHeight();

                        $tooltip.css({
                           left: (inputOffset.left + inputWidth + 10) + 'px',
                           top: (inputOffset.top + (inputHeight - tooltipHeight) / 2 - 1) + 'px'
                        });

                        $tooltip.show();
                  }
               });

               $('#city_input').focus(function () {
                  if ($('#reg_input').val() == '') {
                        alert('Вначале выберите Оласть');
                        $('#reg_input').focus();
                        return false;
                  }
                  else
                        return true;
               });

               $('.addr_block .deliProps textarea').change(function () {
                  $("#address_full").val('');
                  $('.deliProps textarea').each(function (n) {
                        if ($(this).val() != '' && $(this).attr('disabled') != 'disabled') {
                           if ($("#address_full").val() != '')
                              $("#address_full").val($("#address_full").val() + ', ' + $(this).val());
                           else
                              $("#address_full").val($(this).val());
                        }
                  })
               });

               $('.addr_block [name=delivery_id]').change(function(){
                  var delivery_id = $('[name=delivery_id]').val();
                  $('.addr_block li.deliProps').addClass('hide');
                  $(".addr_block #address_full").val('');
                  $('.addr_block li.deliProps textarea').val('');
                  $('.addr_block li.deliProps input').val('');
                  $('.addr_block li.deliProps[data-delivery-id="'+delivery_id+'"]').removeClass('hide');
               });

            }); 
         </script>
         {/literal}
      {/if}
      
      
   </body>
</html>
