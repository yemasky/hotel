<div id="content-header">
    <div id="breadcrumb">
        <a href="index.php" title="Go to Home" class="tip-bottom"><i class="icon-home"></i> Home</a>
        <%section name=nav loop=$arrayNavigation%>
        	<a href="<%$arrayNavigation[nav].url%>" class="<%if $smarty.section.nav.last%>current<%else%>tip-bottom<%/if%>"><%$arrayNavigation[nav].hotel_modules_name%></a>
        <%/section%>
    </div>
    <h1>Common Form Elements</h1>
</div>