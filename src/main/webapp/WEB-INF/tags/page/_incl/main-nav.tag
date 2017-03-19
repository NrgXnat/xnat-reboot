<%@ tag description="Main Nav Menu" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="pg" tagdir="/WEB-INF/tags/page" %>
<%@ taglib prefix="incl" tagdir="/WEB-INF/tags/page/_incl" %>

<%@ attribute name="page" %>

<c:set var="PAGE" value="${not empty page ? page : PAGE}"/>

<c:if test="${USERNAME != '-' && PAGE != 'setup'}">

    <style type="text/css">
        #quickSearchForm .chosen-results {
            max-height: 500px;
        }

        #quickSearchForm .chosen-results li {
            padding-right: 20px;
            white-space: nowrap;
        }

        #quickSearchForm .chosen-container .chosen-drop {
            width: auto;
            min-width: 180px;
            max-width: 360px;
        }

        #quickSearchForm .chosen-container .chosen-drop .divider {
            padding: 0;
            overflow: hidden;
        }
    </style>


    <%-- TODO: use Spawner to dynamically insert menu items --%>
    <div id="main-nav">
        <div class="inner">

            <ul class="nav">
                <!-- Sequence: 10 -->
                <!-- allowGuest: true -->
                <li>
                    <a id="nav-home" title="Home" href="${SITE_ROOT}/">&nbsp;</a>
                    <script>
                        $('#nav-home').css({
                            width: '30px',
                            backgroundImage: "url('${SITE_ROOT}/images/xnat-nav-logo-white-lg.png')",
                            backgroundRepeat: 'no-repeat',
                            backgroundSize: '32px',
                            backgroundPosition: 'center'
                        });
                    </script>
                </li>
                <!-- Sequence: 11 -->
                <li class="hidden"><a id="browse" title="Browse" href="#Browse">Browse</a>
                    <ul class="" style="display:none; min-width: 120px;">
                        <!-- Browse/Default -->
                        <li class="hidden"><a href="#BrowseProjects">Projects</a>
                            <ul id="browse-projects">
                                <!-- Sequence: 10 -->
                            </ul>
                        </li>
                        <li class="hidden"><a href="#FavoriteProjects">Favorite Projects</a>
                            <ul id="favorite-projects">
                                <!-- Sequence: 20 -->
                            </ul>
                        </li>
                        <li class="hidden"><a href="#BrowseData">Data</a>
                            <ul id="browse-data">
                                <!-- Sequence: 30 -->
                            </ul>
                        </li>
                    </ul>
                </li>
                <!-- Sequence: 20 -->
                <li class="more"><a href="#new">New</a>
                    <ul class="" style="display: none;">
                        <!-- Sequence: 10 -->
                        <c:set var="hidden_li">
                            <li class="hidden">&nbsp;</li>
                        </c:set>
                            <%-- only allow admins to create projects for now --%>
                        <pg:restricted msg="${hidden_li}">
                            <li id="top-new-project">
                                <a href="${SITE_ROOT}/app/template/XDATScreen_add_xnat_projectData.vm">Project</a>
                            </li>
                        </pg:restricted>
                        <li>
                            <a href="${SITE_ROOT}/app/action/XDATActionRouter/xdataction/edit/search_element/xnat:subjectData">Subject</a>
                        </li>
                        <li><a href="${SITE_ROOT}/app/template/XDATScreen_add_experiment.vm">Experiment</a></li>
                    </ul>
                </li>
                <!-- Sequence: 30 -->
                <li class="more"><a href="#upload">Upload</a>
                    <ul>
                        <!-- Sequence: 10 -->
                        <!-- Upload/Default -->
                        <li><a href="${SITE_ROOT}/app/template/UploadOptions.vm">Images</a>
                            <ul>
                                <!-- Sequence: 10 -->
                                <!-- Images -->
                                <li><a href="${SITE_ROOT}/app/template/UploadAssistantPage.vm">Upload Assistant</a></li>
                                <li><a href="${SITE_ROOT}/app/template/CompressedUploaderPage.vm">Compressed Uploader</a></li>
                                <li><a href="${SITE_ROOT}/app/template/DICOMSCPPage.vm">DICOM SCP</a></li>
                            </ul>
                        </li>
                        <li><a href="${SITE_ROOT}/app/template/XMLUpload.vm">XML</a></li>
                        <li><a href="${SITE_ROOT}/app/template/XDATScreen_uploadCSV.vm">Spreadsheet</a></li>
                        <li><a href="${SITE_ROOT}/app/template/XDATScreen_prearchives.vm">Go to prearchive</a></li>
                    </ul>
                </li>

                <pg:restricted msg="<!-- non-admin -->">

                    <!-- Sequence: 40 -->
                    <li class="more"><a href="#adminbox">Administer</a>
                        <ul>
                            <!-- Sequence: 10 -->
                            <li><a href="${SITE_ROOT}/page/#/admin/">Site Administration</a></li>
                            <li><a href="${SITE_ROOT}/app/template/XDATScreen_admin.vm">Users</a></li>
                            <li><a href="${SITE_ROOT}/app/template/XDATScreen_groups.vm">Groups</a></li>
                            <li><a href="${SITE_ROOT}/app/template/XDATScreen_dataTypes.vm">Data Types</a></li>
                            <li><a href="${SITE_ROOT}/app/template/XDATScreen_email.vm">Email</a></li>
                            <li><a href="${SITE_ROOT}/app/template/XDATScreen_manage_pipeline.vm">Pipelines</a></li>
                            <li><a href="${SITE_ROOT}/app/template/Scripts.vm">Automation</a></li>
                            <li><a href="${SITE_ROOT}/app/template/XDATScreen_admin_options.vm">More...</a></li>
                        </ul>
                    </li>

                </pg:restricted>

                <!-- Title: Tools -->
                <!-- Sequence: 50 -->
                <!-- allowGuest: true -->

                <li class="more"><a href="#tools">Tools</a>
                    <ul>
                        <!-- Sequence: 10 -->
                        <!-- allowGuest: true -->
                        <li>
                            <a href="https://wiki.xnat.org/display/XTOOLS/XNAT+Desktop" target="_blank">XNAT Desktop (XND)</a>
                        </li>
                        <li>
                            <a href="http://nrg.wustl.edu/software/dicom-browser/" target="_blank">DICOM Browser</a>
                        </li>
                        <li>
                            <a href="https://wiki.xnat.org/display/XTOOLS" target="_blank">Command Prompt Tools</a>
                        </li>
                    </ul>
                </li>
                <!-- Sequence: 60 -->
                <li class="more"><a href="#help">Help</a>
                    <ul class="" style="display: none;">
                        <!-- Sequence: 10 -->
                        <!-- Home/Default -->
                        <li><a href="${SITE_ROOT}/app/template/ReportIssue.vm">Report a Problem</a></li>
                        <li><a href="http://wiki.xnat.org" target="_blank">Documentation</a></li>
                    </ul>
                </li>
            </ul>

            <!-- search script -->
            <script type="text/javascript">
                function submitQuickSearch(){
                    if ($('#searchValue').val() != "") {
                        $('#quickSearchForm').submit();
                    }
                }
            </script>
            <!-- end search script -->

            <form id="quickSearchForm" method="post" action="${SITE_ROOT}/app/action/QuickSearchAction">
                <select id="stored-searches" data-placeholder="Stored Searches" style="display: none;">
                    <option></option>
                    <optgroup>
                        <option value="${SITE_ROOT}/app/template/XDATScreen_search_wizard1.vm">Advanced Search…</option>
                    </optgroup>
                    <optgroup class="stored-search-list">
                        <option disabled="">(no stored searches)</option>
                        <!-- stored searches will show up here -->
                    </optgroup>
                </select>
                <input id="searchValue" class="clean" name="searchValue" type="text" maxlength="40" size="20" value="">
                <input id="xnat_csrf" name="XNAT_CSRF" type="hidden" value="">
                <button type="button" id="search_btn" class="btn2" onclick="submitQuickSearch();">Go</button>

                <script>
                    var searchField = $('#searchValue');
                    searchField.keyup(function(event){
                        if (event.which == 13) {
                            submitQuickSearch();
                        }
                    });

                    $('#xnat_csrf').val(window.csrfToken);

                    searchField.each(function(){
                        var _this = this;
                        _this.value = _this.value || 'search';
                        $(_this).focus(function(){
                            $(_this).removeClass('clean');
                            if (!_this.value || _this.value === 'search') {
                                _this.value = '';
                            }
                        })
                    });

                    $('#stored-searches').on('change', function(){
                        if (this.value) {
                            window.location.href = this.value;
                        }
                    }).chosen({
                        width: '150px',
                        disable_search_threshold: 9,
                        inherit_select_classes: true,
                        placeholder_text_single: 'Stored Searches',
                        search_contains: true
                    });
                </script>
            </form>

            <!-- main-nav interactions -->
            <script type="text/javascript">

                (function(){

                    // cache it
                    var main_nav$ = jq('#main-nav ul.nav');

                    function fadeInNav(el$){
                        //            el$.stop('clearQueue','gotoEnd');
                        el$.find('> ul').show().addClass('open');
                    }

                    function fadeOutNav(el$){
                        //            el$.stop('clearQueue','gotoEnd');
                        el$.find('> ul').hide().removeClass('open');
                    }

                    // give menus with submenus a class of 'more'
                    main_nav$.find('li ul, li li ul').closest('li').addClass('more');
                    main_nav$.find('li li ul').addClass('subnav');

                    // no fancy fades on hover
                    main_nav$.find('li.more').on('mouseover',
                        function(){
                            var li$ = $(this);
                            fadeInNav(li$);
                            //jq('#main-nav li').removeClass('open');
                            li$.find('ul.subnav').each(function(){
                                var sub$ = $(this);
                                var offsetL = sub$.closest('li').width();
                                sub$.css({'left': offsetL});
                            });
                        }
                    ).on('mouseout',
                        function(){
                            var li$ = $(this);
                            fadeOutNav(li$);
                        }
                    );

                    // clicking the "Logout" link sets the warning bar cookie to 'OPEN' so it's available if needed on next login
                    jq('#logout_user').click(function(){
                        Cookies.set('WARNING_BAR', 'OPEN', {path: '/'});
                        Cookies.set('NOTIFICATION_MESSAGE', 'OPEN', {path: '/'});
                    });

                })();
            </script>
            <!-- end main-nav interactions -->

        </div>
        <!-- /.inner -->

    </div>
    <!-- /#main-nav -->

    <script src="${SITE_ROOT}/scripts/xnat/app/topnav-browse.js"></script>

    <script>

        function submitQuickSearch(){
            if ($('#searchValue').val() != "") {
                $('#quickSearchForm').submit();
            }
        }

        function loadMainNav(){

            // get Velocity-generated menu
            $('#main-nav').load('${SITE_ROOT}/app/template/Page.vm #main-nav > .inner', function(){


                $('#nav-home').css({
                    width: '30px',
                    backgroundImage: "url('${SITE_ROOT}/images/xnat-nav-logo-white-lg.png')",
                    backgroundRepeat: 'no-repeat',
                    backgroundSize: '32px',
                    backgroundPosition: 'center'
                });


                var searchField = $('#searchValue');
                searchField.keyup(function(event){
                    if (event.which == 13) {
                        submitQuickSearch();
                    }
                });

                $('#xnat_csrf').val(window.csrfToken);

                searchField.each(function(){
                    var _this = this;
                    _this.value = _this.value || 'search';
                    $(_this).focus(function(){
                        $(_this).removeClass('clean');
                        if (!_this.value || _this.value === 'search') {
                            _this.value = '';
                        }
                    })
                });

                $('#stored-searches').on('change', function(){
                    if (this.value) {
                        window.location.href = this.value;
                    }
                }).chosen({
                    width: '150px',
                    disable_search_threshold: 9,
                    inherit_select_classes: true,
                    placeholder_text_single: 'Stored Searches',
                    search_contains: true
                });


                // cache it
                var main_nav$ = jq('#main-nav ul.nav');

                function fadeInNav(el$){
                    //            el$.stop('clearQueue','gotoEnd');
                    el$.find('> ul').show().addClass('open');
                }

                function fadeOutNav(el$){
                    //            el$.stop('clearQueue','gotoEnd');
                    el$.find('> ul').hide().removeClass('open');
                }

                // give menus with submenus a class of 'more'
                main_nav$.find('li ul, li li ul').closest('li').addClass('more');
                main_nav$.find('li li ul').addClass('subnav');

                // no fancy fades on hover
                main_nav$.find('li.more').on('mouseover',
                    function(){
                        var li$ = $(this);
                        fadeInNav(li$);
                        //jq('#main-nav li').removeClass('open');
                        li$.find('ul.subnav').each(function(){
                            var sub$ = $(this);
                            var offsetL = sub$.closest('li').width();
                            sub$.css({'left': offsetL});
                        });
                    }
                ).on('mouseout',
                    function(){
                        var li$ = $(this);
                        fadeOutNav(li$);
                    }
                );

                // clicking the "Logout" link sets the warning bar cookie to 'OPEN' so it's available if needed on next login
                jq('#logout_user').click(function(){
                    Cookies.set('WARNING_BAR', 'OPEN', {path: '/'});
                    Cookies.set('NOTIFICATION_MESSAGE', 'OPEN', {path: '/'});
                });

                // load js files from elements with 'data-loadjs' attributes
                $('[data-loadjs]').each(function(){
                    var jsAttr = this.dataset ? this.dataset.loadjs : this.getAttribute('data-loadjs');
                    var jsUrl = XNAT.url.rootUrl('/scripts/' + jsAttr + '.js');
                    loadjs(jsUrl);
                })

            });

        }

        loadMainNav();

    </script>

</c:if>

<jsp:doBody/>
