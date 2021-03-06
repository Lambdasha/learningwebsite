<%--
  Created by IntelliJ IDEA.
  User: My
  Date: 2022/4/25
  Time: 13:27
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>在线学习平台设计</title>
    <meta name="keywords" content="keyword1,keyword2,keyword3">
    <meta name="description" content="this is my page">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <script type="text/javascript" src="js/jquery-1.11.0.js"></script>
    <link rel="stylesheet" href="css/jquery-ui.css" />
    <link rel="stylesheet" href="css/jquery-ui.structure.css" />
    <link rel="stylesheet" href="colorpicker-master/jquery.colorpicker.css" />
    <link rel="stylesheet" href="css/jquery-ui.theme.css" />
    <script type="text/javascript" src="js/jquery-ui.js"></script>
    <script type="text/javascript" src="js/anyLine.js"></script>
    <script type="text/javascript" src="colorpicker-master/jquery.colorpicker.js"></script>
    <script type="text/javascript" src="colorpicker-master/parts/jquery.ui.colorpicker-rgbslider.js"></script>
    <script type="text/javascript" src="js/json2.js"></script>
    <script type="text/javascript" src="js/canvas.js"></script>
    <style type="text/css">
        * {
            font-family: '微软雅黑';
            font-size:12px;
        }

        canvas {
            border: 2px dashed gray;
        }

        .container_pencil{
            cursor: url(images/PencilToolCursor.gif), pointer;
        }

        .container_eraser{
            cursor: url(images/test.png), pointer;
        }
t
        .container_font{
            cursor:crosshair;
        }
        .speed {
            top: 15px;
        }

        .ui-selectmenu-text {
            font-size: 12px;
        }

    </style>
</head>
<body>
<div id="dialog" title="HTML画板">
    <div style="font-size:14px;">
        <fieldset style="float:left;width:250px;">
            <legend>工具</legend>
            <div id="toolsOptions">
                <input type="radio" id="tools_pencil" name="toolsOption" checked="checked"><label for="tools_pencil">画笔</label> &nbsp;
                <input type="radio" id="tools_eraser" name="toolsOption" ><label for="tools_eraser">橡皮擦</label> &nbsp;
                <input type="radio" id="tools_trash" name="toolsOption"><label 	for="tools_trash">清空</label>
                <div style="border-top:1px dashed gray;margin-top:8px;padding-top:8px;"><span>
						<button id="tools_save">save</button>&nbsp;&nbsp;&nbsp;
						<button id="tools_undo">undo</button>&nbsp;&nbsp;&nbsp;
						<button id="tools_redo">redo</button>
					</span></div>
            </div>

        </fieldset>
        <fieldset style="float:left;">
            <legend>多边形</legend>
            <div><span>
					<input type="radio" id="tools_line" name="toolsOption"><label for="tools_line">直线</label>
					<input type="radio" id="tools_rectangle" name="toolsOption"><label for="tools_rectangle">矩形</label>
					<input type="radio" id="tools_circle" name="toolsOption"><label for="tools_circle">文字</label>
				</span></div>
        </fieldset>
        <fieldset style="float:left;width:180px;">
            <legend>线条设置</legend>
            <span style="float: left;margin-top: 6px;">线条粗细: </span>
            <select id="penWidth" >
                <option value="1" selected>1px</option>
                <option value="2">2px</option>
                <option value="4">4px</option>
                <option value="6">6px</option>
                <option value="8">8px</option>
                <option value="12">12px</option>
                <option value="14">14px</option>
                <option value="16">16px</option>
                <option value="18">18px</option>
            </select>
            <div style="border-top:1px dashed gray;margin-top:8px;padding-top:8px;">
                <span>边框色:<input id="colorpicker-popup" type="text"  value="000000" style="width: 72px;display:none; "></span>&nbsp;
                <span>填充色:<input id="colorpicker-popup2" type="text"  value="fe9810" style="width: 72px;display:none; "></span>
            </div>
        </fieldset>
        <fieldset style="float:left;width:160px;">
            <legend>字体设置</legend>
            <span><span style="float: left;margin-top: 6px;">字体大小: </span>
	        		<select id="fontSize"  >
		                 <option value="8px" selected>8px</option>
		                 <option value="10px">10px</option>
		                 <option value="12px">12px</option>
		                 <option value="14px">14px</option>
		                 <option value="16px">16px</option>
		                 <option value="18px">18px</option>
		                 <option value="20px">20px</option>
		                 <option value="22px">22px</option>
		                 <option value="24px">24px</option>
		                 <option value="26px">26px</option>
		                 <option value="28px">28px</option>
		                 <option value="30px">30px</option>
		                 <option value="32px">32px</option>
		                 <option value="34px">34px</option>
		                 <option value="36px">36px</option>
	             </select>
	             </span>
            <br/>
            <span><span style="float: left;margin-top: 6px;">字体选择:</span>
	        		<select id="fontType" style="top:20px;" >
		                 <option value="宋体" >宋体</option>
		                 <option value="微软雅黑">微软雅黑</option>
		                 <option value="仿宋">仿宋</option>
		                 <option value="Arial" selected>Arial</option>
		                 <option value="Consolas">Consolas</option>
	             </select>
	        </span>
            <span style="font-weight:bold;"><input type="checkbox" id="boldOption" name="fontOption"><label for="boldOption">B</label></span>
            <span style="font-style: italic;"><input type="checkbox" id="italicOption" name="italicOption"><label for="italicOption">I</label></span>
        </fieldset>

        <div style="clear:both;"></div>
    </div>

    <div style="background:white;position:relative;" id="container">
        <div id="temp" style="border:1px solid gray;width:1px;height:1px;position:absolute;display:none;"></div>

        <canvas id="myCanvas" width="880" height="400" class="container_pencil">

        </canvas>
    </div>
    <span id="show" style="display:none;"></span>

    <div style="text-align:center; margin-top:20px;">
        @Author:&nbsp;<b>luan louis </b> @Email:&nbsp;<b>louemail@qq.com </b><br/>
    </div>

</div>

</body>
</html>
