<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html>
<head>
<title>rMateMapChartH5 (RiaMore Soft)</title>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="X-UA-Compatible" content="IE=edge"/>

<!-- rMateChartH5 라이센스 -->
<script type="text/javascript" src="./chart/rMateMapChartH5License.js"></script>
<!-- rMateMapChartH5 라이브러리 -->
<script type="text/javascript" src="./chart/rMateMapChartH5.js"></script>
<!-- rMateMapChartH5 CSS -->
<link rel="stylesheet" type="text/css" href="./chart/rMateMapChartH5.css"/>



<script type="text/javascript">
// -----------------------맵차트 설정 시작-----------------------
// rMate 맵차트 생성 준비가 완료된 상태 시 호출할 함수를 지정합니다.
var mapVars = "rMateOnLoadCallFunction=mapReadyHandler";

// 맵차트의 속성인 rMateOnLoadCallFunction 으로 설정된 함수.
// rMate 맵차트 준비가 완료된 경우 이 함수가 호출됩니다.
// 이 함수를 통해 맵차트에 레이아웃과 데이터를 삽입합니다.
// 파라메터 : id - rMateMapChartH5.create() 사용 시 사용자가 지정한 id 입니다.
// 맵차트 콜백함수 7개 존재합니다.
// 1. setLayout - 스트링으로 작성된 레이아웃 XML을 삽입합니다.
// 2. setData - 배열로 작성된 데이터를 삽입합니다.
// 3. setMapDataBase - 스트링으로 작성된 MapData XML을 삽입합니다.
// 4. setLayoutURLEx - 레이아웃 XML 경로를 지시합니다.
// 5. setDataURLEx - 데이터 XML 경로를 지시합니다.
// 6. setMapDataBaseURLEx - MapData XML 경로를 지시합니다.
// 7. setSourceURLEx - Map Source 경로를 지시합니다.
function mapReadyHandler(id) {
	document.getElementById(id).setLayout(layoutStr);
	document.getElementById(id).setData(mapData);
	document.getElementById(id).setMapDataBaseURLEx(mapDataBaseURL);
	document.getElementById(id).setSourceURLEx(sourceURL);
}

// Map Data 경로 정의
// setMapDataBase함수로 mapDataBase를 문자열로 넣어줄 경우 주석처리나 삭제하십시오.
var mapDataBaseURL = "./chart/MapDataBaseXml/Design/Seoul_Design_01.xml";

// MapChart Source 선택
// MapSource 디렉토리의 지도 이미지중 택일가능하며, 이외에 사용자가 작성한 별도의 Svg이미지를 지정할 수 있습니다.(매뉴얼 참조)
var sourceURL = "./chart/MapSource/Design/Seoul_Design_01.svg";

// rMateMapChart 를 생성합니다.
// 파라메터 (순서대로) 
//  1. 맵차트의 id ( 임의로 지정하십시오. ) 
//  2. 맵차트가 위치할 div 의 id (즉, 차트의 부모 div 의 id 입니다.)
//  3. 맵차트 생성 시 필요한 환경 변수들의 묶음인 chartVars
//  4. 맵차트의 가로 사이즈 (생략 가능, 생략 시 100%)
//  5. 맵차트의 세로 사이즈 (생략 가능, 생략 시 100%)
rMateMapChartH5.create("map1", "mapHolder", mapVars, "100%", "100%");



var layoutStr = '\
<?xml version="1.0" encoding="utf-8"?>\
<rMateMapChart>\
	<MapChart id="mainMap1" showDataTips="true" dataTipType="Type2" scaleMode="manual" chartScaleX="1.1" chartScaleY="1.1">\
		<series>\
			<MapSeries id="mapseries" interactive="true" selectionMarking="color" color="#777777" labelPosition="none" displayName="Map" selectionStrokeAlpha="0" rollOverFill="transparent" transparentValue="60">\
				<selectionFill>\
					<SolidColor color="#ffffff" />\
				</selectionFill>\
				<selectionStroke>\
					<Stroke color="#ffffff" weight="0" alpha="1"/>\
				</selectionStroke>\
				<rollOverStroke>\
					<Stroke color="#ffffff" weight="0" alpha="1"/>\
				</rollOverStroke>\
				<showDataEffect>\
					<SeriesInterpolate duration="1000"/>\
				</showDataEffect>\
			</MapSeries>\
		</series>\
	</MapChart>\
</rMateMapChart>\
';


var mapData = [
{"code":905,"label":"관악구","v":0,"h":0,"lapos":"bottom","popu":"52만명", "v":-10},
{"codeB":903,"branchName":"Gangbuk-gu","v":0,"h":0,"lapos":"bottom","address":""},
{"codeB":904,"branchName":"Gangseo-gu","v":0,"h":0,"lapos":"bottom","address":""},
{"codeB":909,"branchName":"Nowon-gu","v":0,"h":0,"lapos":"bottom","address":""},
{"codeB":911,"branchName":"Dongdaemun-gu","v":0,"h":0,"lapos":"bottom","address":""},
{"codeB":914,"branchName":"Seodaemun-gu","v":0,"h":0,"lapos":"bottom","address":""},
{"codeB":915,"branchName":"Seocho-gu","v":0,"h":0,"lapos":"bottom","address":""},
{"codeB":918,"branchName":"Songpa-gu","v":0,"h":0,"lapos":"bottom","address":""}
];

function labelFunction(id, code, label, data) {
	if ( code == 904 )
		return "강서구"
	else if ( code == 905 )
		return "관악구"
	else if ( code == 909 )
		return "노원구"
	else if ( code == 917 )
		return "성북구"
	else
		return "";
}

function changeMap(event, map) {
	var activeClass = document.getElementsByClassName("active")[0];
	var tElement = event.srcElement || event.currentTarget;
	activeClass.className = activeClass.className.replace("active", "");
	tElement.className += " active";
	
	//<MapPanelSeries id="panel" titleField="popu" bodyTextField="popu" horizontalCenterGapField="h" verticalCenterGapField="v" bodyColor="#555555" color="#FFFFFF" horizontalAlign="center" displayName="" itemRenderer="LBAPanelItemRenderer" fill="#0B91FF" ><showDataEffect><SeriesInterpolate duration="1000"/></showDataEffect></MapPanelSeries>
	
	var mapProps = [
		{"dataTip":'Type2', "localFill":'', "addProps":'labelPosition="none" interactive="true"', "rollOverFill":'rollOverFill="transparent" transparentValue="60"', "rollOverStroke":'<rollOverStroke><Stroke color="#ffffff" weight="0" alpha="1"/></rollOverStroke>', "addSeries":''},
		{"dataTip":'Type4', "localFill":'', "addProps":'labelPosition="none" dataTipFill="#f39440" dataTipBorderColor="#e17e2d" dataTipColor="#ffffff" dataTipAlpha="1" interactive="true"', "rollOverFill":'rollOverFill="transparent" transparentValue="60"', "rollOverStroke":'<rollOverStroke><Stroke color="#ffffff" weight="0" alpha="1"/></rollOverStroke>', "addSeries":''},
		{"dataTip":'Type4', "localFill":'<localFill><LinearGradient angle="45"><entries><GradientEntry color="#f9f9f9" ratio="0.0"/><GradientEntry color="#efefef" ratio="1.0"/></entries></LinearGradient></localFill>', "addProps":'dataTipFill="#04bca0" dataTipBorderColor="#04bca0" dataTipColor="#ffffff" dataTipAlpha="1" interactive="true"', "rollOverFill":'rollOverFill="#CCFFFF"', "rollOverStroke":'<rollOverStroke><Stroke color="#576870" weight="5" alpha="1"/></rollOverStroke>', "addSeries":''},
		{"dataTip":'Type2', "localFill":'', "addProps":'labelPosition="none" interactive="false"', "rollOverFill":'rollOverFill="transparent" transparentValue="30"', "rollOverStroke":'<rollOverStroke><Stroke color="#ffffff" weight="0" alpha="0"/></rollOverStroke>', "addSeries":'<MapPlotSeries id="plot2" areaCodeField="codeB" labelField="branchName" horizontalCenterGapField="h" verticalCenterGapField="v" radius="10" adjustedRadius="5" fill="#ffffff" labelPositionField="lapos" color="#ffffff" fontWeight="bold" labelPosition="none" itemRenderer="BoxItemRenderer" displayName="빌라"><showDataEffect><SeriesInterpolate duration="1000"/></showDataEffect><stroke><Stroke color="#fe7701" weight="3" alpha="1"/></stroke></MapPlotSeries>'},
		{"dataTip":'Type1', "localFill":'', "addProps":'fontWeight="bold" color="#ffffff" labelPosition="inside" labelJsFunction="labelFunction" interactive="true" labelField="label"', "rollOverFill":'rollOverFill="transparent" transparentValue="60"', "rollOverStroke":'<rollOverStroke><Stroke color="#ffffff" weight="0" alpha="1"/></rollOverStroke>', "addSeries":'<MapPanelSeries id="panel" titleField="popu" bodyTextField="popu" horizontalCenterGapField="h" verticalCenterGapField="v" bodyColor="#555555" color="#555555" horizontalAlign="center" displayName="" itemRenderer="LBAPanelItemRenderer" fill="#f3f3f3" strokeColor="#f3f3f3" interactive="false"><showDataEffect><SeriesInterpolate duration="1000"/></showDataEffect></MapPanelSeries>'},
		{"dataTip":'Type2', "localFill":'', "addProps":'labelPosition="none" interactive="true"', "rollOverFill":'rollOverFill="transparent" transparentValue="60"', "rollOverStroke":'<rollOverStroke><Stroke color="#ffffff" weight="0" alpha="1"/></rollOverStroke>', "addSeries":''}
	];
	var id = "map1";
	var mapDataBaseURL2 = "./chart/MapDataBaseXml/Design/Seoul_Design_0"+map+".xml";
	var sourceURL2 = "./chart/MapSource/Design/Seoul_Design_0"+map+".svg";
	var layoutStr2 = '<rMateMapChart>'
+'<MapChart id="mainMap1"  scaleMode="manual" chartScaleX="1.1" chartScaleY="1.1" showDataTips="true" dataTipType="'+mapProps[map-1].dataTip+'">'
+'<series>'
+'<MapSeries id="mapseries" selectionMarking="color" selectionStrokeAlpha="0" '+mapProps[map-1].rollOverFill+' '+mapProps[map-1].addProps+'>'
+mapProps[map-1].localFill
+'<selectionFill>'
+'<SolidColor color="#ffffff" />'
+'</selectionFill>'
+'<selectionStroke>'
+'<Stroke color="#ffffff" weight="0" alpha="1"/>'
+'</selectionStroke>'
+mapProps[map-1].rollOverStroke
+'<showDataEffect>'
+'<SeriesInterpolate duration="1000"/>'
+'</showDataEffect>'
+'</MapSeries>'
+mapProps[map-1].addSeries
+'</series>'
+'</MapChart>'
+'</rMateMapChart>';

	document.getElementById(id).setLayout(layoutStr2);
	document.getElementById(id).setMapDataBaseURLEx(mapDataBaseURL2);
	document.getElementById(id).setSourceURLEx(sourceURL2);
};
// -----------------------맵차트 설정 끝 -----------------------

</script>
<!-- 샘플 작동을 위한 css와 js -->
<script type="text/javascript" src="./chart/common.js"></script>
<script type="text/javascript" src="./chart/sample_util.js"></script>
<link rel="stylesheet" type="text/css" href="./chart/sample.css"/>

<!-- SyntaxHighlighter -->
<script type="text/javascript" src="./chart/shCore.js"></script>
<script type="text/javascript" src="./chart/shBrushJScript.js"></script>
<link type="text/css" rel="stylesheet" href="./chart/shCoreDefault.css"/>
</head>
<body>
	<div class="wrapper">
		<div class="header_button">
			<div class="headerTitle_button">DesignMap-Seoul</div>
			<div class="button_top active" onclick="changeMap(event, 1);">Design 1</div>
			<div class="button_top" onclick="changeMap(event, 2);">Design 2</div>
			<div class="button_top" onclick="changeMap(event, 3);">Design 3</div>
			<div class="button_top" onclick="changeMap(event, 4);">Design 4</div>
			<div class="button_top" onclick="changeMap(event, 5);">Design 5</div>
			<div class="button_top" onclick="changeMap(event, 6);">Design 6</div>
		</div>
		<div id="content">
			<!-- 차트가 삽입될 DIV -->
			<div id="mapHolder"></div>
		</div>
		<div class="description">
		디자인이 적용된 맵차트입니다.
		</div>

		<div id="updater">
			<div>Layout과 Data를 수정 후 적용 할 수 있습니다.</div>
			<div id="updaterTab">
				<ul id="updaterTabUl">
					<li id="updaterTabUlSource" class="active_tab">Source</li>
					<li id="updaterTabUlLayout" class="non_active_li">Layout</li>
					<li id="updaterTabUlData" class="non_active_li">Data</li>
					<li id="updaterTabUlBlank">
						<span id="btn_update">수정적용</span>
					</li>
				</ul>
			</div>
			<div id="updaterTarea">
				<pre id="updaterTareaSource" class="brush:js toolbar:false" name="updaterTareaSource"></pre>
				<textarea id="updaterTareaLayout" class="updaterTextarea" spellcheck="false"></textarea>
				<textarea id="updaterTareaData" class="updaterTextarea" spellcheck="false"></textarea>
			</div>
		</div>
	</div>
</body>
</html>
