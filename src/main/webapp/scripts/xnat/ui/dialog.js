/*
 * web: dialog.js
 * XNAT http://www.xnat.org
 * Copyright (c) 2005-2017, Washington University School of Medicine and Howard Hughes Medical Institute
 * All Rights Reserved
 *
 * Released under the Simplified BSD.
 */

/*!
 * XNAT dialogs (replaces xmodal functions)
 */

var XNAT = getObject(XNAT || {});

(function(factory){
    if (typeof define === 'function' && define.amd) {
        define(factory);
    }
    else if (typeof exports === 'object') {
        module.exports = factory();
    }
    else {
        return factory();
    }
}(function(){

    var undefined, ui, dialog;
    var counter = 0;
    var squat = function(){};

    window.$body = window.body$ = $('body');
    window.$html = window.html$ = $('html');

    XNAT.ui = ui =
        getObject(XNAT.ui || {});

    XNAT.ui.dialog = dialog =
        getObject(XNAT.ui.dialog || {});

    //if (!window.top.xmodal){ return }

    dialog.count = 0;
    dialog.zIndex = 9000;

    // keep track of dialog objects
    dialog.dialogs = {};

    // keep track of just uids
    dialog.uids = [];

    // which dialog is on top?
    dialog.topUID = null;

    dialog.updateUIDs = function(){
        dialog.uids = forOwn(dialog.dialogs);
    };

    dialog.bodyPosition = window.scrollY;

    // update className on <body> element
    dialog.updateWindow = function(){
        if (!window.$body.find('div.xnat-dialog.open').length) {
            window.$html.removeClass('xnat-dialog-open open');
            window.$body.removeClass('xnat-dialog-open open');
            window.$body.css('top',0);
            window.scrollTo(0, dialog.bodyPosition);
        }
    };

    function frag(){
        return $(document.createDocumentFragment());
    }

    function pxSuffix(val){
        if (typeof val === 'number') {
            val = val + 'px'
        }
        return val;
    }

    function $footerButton(btn, i){

        btn = cloneObject(btn);

        var _this = this;
        var btnId = btn.id || (_this.id || 'dialog-' + _this.count) + '-btn-' + (i + 1);

        // setup object for spawning the button/link
        var opts = {};

        opts.tag = 'button';
        opts.id = btnId;
        opts.tabindex = '0';
        opts.html = btn.label || btn.html || btn.text || '(no label)';
        opts.attr = { tabindex: '0' };
        opts.className = (function(){
            var cls = ['button'];
            if (btn.className) {
                cls.push(btn.className)
            }
            if (btn.link || btn.isLink) {
                cls.push('link');
                opts.tag = 'a';
                opts.href = '#!';
            }
            else {
                cls.push('btn');
            }
            if (btn.isDefault || btn['default']) {
                cls.push('default')
            }
            if (btn.close === true || btn.close === undefined) {
                cls.push('close');
                btn.close = true;
            }
            return cls.join(' ');
        })();

        var btn$ = $.spawn(opts);

        btn$.on('click', function(e){
            e.preventDefault();
            var action = btn.action || btn.onclick || squat;
            action.call(this, _this);
            if (btn.close) {
                _this.close(btn.destroy);
            }
        });

        return btn$;

    }

    function Dialog(opts){

        extend(true, this, opts);

        var _this = this;

        window.$body = window.body$ = $('body');
        window.$html = window.html$ = $('html');

        // unique internal id for keeping track of dialogs
        // this can be pre-defined, but it MUST be unique
        this.uid = this.uid || randomID('dlgx', false);

        this.count = ++dialog.count;

        this.zIndex = {};
        this.zIndex.container = ++dialog.zIndex;
        // this.zIndex.mask = ++dialog.zIndex;
        // this.zIndex.dialog = ++dialog.zIndex;

        this.maxxed = !!this.maxxed;

        this.id = this.id || null;

        // use an outer container for correct positioning
        this.container$ = $.spawn('div.xnat-dialog-container', {
            id: this.uid,
            style: {
                display: 'none',
                zIndex: this.zIndex.container
            },
            data: {
                uid: this.uid,
                count: this.count
            }
        });

        // will this dialog be 'modal' (with a mask behind it)
        this.mask = this.mask !== undefined ? this.mask : true;
        this.isModal = this.mask;

        // mask div
        this.mask$ = this.isModal ? $.spawn('div.xnat-dialog-mask', {
                // style: { zIndex: this.zIndex.mask },
                id: (this.id || this.uid) + '-mask', // append 'mask' to given id
            }) : frag();
        this.$mask = this.__mask = this.mask$;

        // outermost dialog <div>
        this.dialog$ = $.spawn('div.xnat-dialog', {
            id: this.id || (this.uid + '-dialog'), // use given id as-is or use uid-dialog
            attr: { tabindex: '0' },
            style: {
                // zIndex: this.zIndex.dialog,
                width: pxSuffix(this.width || 600),
                height: pxSuffix(this.height || 'auto')
            },
            data: {
                uid: this.uid,
                count: this.count
            }
        });
        this.$modal = this.__modal = this.dialog$;

        // title content
        this.title = this.title || '';

        // title container (inner)
        this.title$ = this.title ?
            $.spawn('div.xnat-dialog-title.inner').append(this.title) :
            frag();

        // header (title) bar
        this.header$ = (this.header !== false) ?
            $.spawn('div.xnat-dialog-header.title').append(this.title$) :
            frag();

        // is there a 'close' button in the header?
        this.closeBtn = (this.closeBtn !== undefined) ? this.closeBtn : true;

        // is there a 'maximize' button in the header?
        // defaults to NO maximize button
        this.maxBtn = this.maxBtn || this.maximize;
        this.maxBtn = (this.maxBtn !== undefined) ? this.maxBtn : false;

        // header buttons (close, maximize)
        this.headerButtons = {};

        this.headerButtons.close$ = (this.closeBtn) ? $.spawn('b.close', {
                title: 'click to close (alt-click to close all modals)'
            }, '&times;').on('click', function(){
                _this.close();
            }) : frag();

        this.headerButtons.max$ = (this.maxBtn) ?
            $.spawn('b.maximize', {
                title: 'maximize/minimize this dialog'
            }, '&ndash;').click(function(){
                _this.toggleMaximize();
            }) :
            frag();

        // add buttons to the header
        this.header$.append([
            this.headerButtons.max$,
            this.headerButtons.close$
        ]);

        // body content (text, html, DOM nodes, or jQuery-wrapped elements
        this.content = this.content || '';

        // if a template is specified, and no content, grab the template
        if (this.template && !this.content) {
            this.template$ = $$(this.template);
            this.templateContent = this.template$.clone(true, true);
            this.content = this.templateContent;
            // this.templateHTML = this.template$.html(); // do we NEED the HTML?
        }

        // body content (inner)
        this.content$ = $.spawn('div.inner.xnat-dialog-content', {
            style: { padding: pxSuffix(this.padding || 20) }
        }).append(this.content);

        // make sure we have a footerHeight to calculate bodyHeight
        this.footerHeight = this.footerHeight || 50;

        this.windowHeight = window.innerHeight;

        // calculate dialog body max-height from window height
        this.bodyHeight = (window.innerHeight * 0.9) - this.footerHeight - 40 - 2;

        // body container
        this.body$ = $.spawn('div.body.content.xnat-dialog-body', {
            style: { maxHeight: pxSuffix(this.bodyHeight) }
        }).append(this.content$);

        // footer (where the footer content and buttons go)
        if (this.footer !== false) {

            this.hasFooter = true;

            // set default footer height
            this.footerHeightPx = pxSuffix(this.footerHeight || 50);

            // footer content (on the left side)
            this.footerContent$ = $.spawn('span.content');

            // footer buttons (on the right side)
            this.footerButtons$ = $.spawn('span.buttons', (this.buttons || []).map(function(btn, i){
                // spawn a <button> element for each item in the 'buttons' array
                return $footerButton.apply(_this, arguments);
            }));

            this.footerInner$ = $.spawn('div.inner').append([
                this.footerContent$,
                this.footerButtons$
            ]);
            this.footer$ = $.spawn('div.footer.xnat-dialog-footer', {
                style: { height: this.footerHeightPx }
            }).append(this.footerInner$);

        }
        else {
            this.footer$ = frag();
        }

        // add the elements to the dialog <div>
        this.dialog$.append([
            this.header$,
            this.body$
        ]);

        if (this.hasFooter) {
            // insert an element to help with sizing with a footer
            this.dialog$.spawn('div.footer-pad', {
                style: { height: this.footerHeightPx }
            }, '&nbsp;').append(this.footer$)
        }

        // add the mask and the dialog box to the container
        this.container$.append([
            this.mask$,
            this.dialog$
        ]);

        // add the container to the DOM (at the end of the <body>)
        window.$body.append(this.container$);

        // save a reference to this instance
        dialog.dialogs[this.uid] = this;

        dialog.updateUIDs();

    }

    Dialog.fn = Dialog.prototype;

    // add all of the content - title, body, footer, buttons, etc.
    // Dialog.fn.render = function(opts){};

    // re-calculate height of modal body if window.innerHeight has changed
    Dialog.fn.setHeight = function(scale){
        console.log('dialog-resize');
        scale = scale || this.maxxed ? 0.98 : 0.9;
        // if (this.windowHeight !== window.innerHeight) {
            this.bodyHeight = (window.innerHeight * scale) - this.footerHeight - 40 - 2;
            this.body$.css('maxHeight', this.bodyHeight);
            this.windowHeight = window.innerHeight;
        // }
        return this;
    };

    Dialog.fn.focus = function(callback){
        this.dialog$.focus();
        if (isFunction(this.onFocus)) {
            this.onFocus.call(this);
        }
        if (isFunction(callback)) {
            callback.call(this);
        }
        return this;
    };

    // bring the dialog to the top
    Dialog.fn.toTop = function(){
        // return early if already top
        if (dialog.topUID === this.uid) {
            return this;
        }
        // otherwise...
        // remove 'top' class from existing dialogs
        forOwn(dialog.dialogs, function(uid, dlg){
            dlg.container$.removeClass('top');
            // dlg.mask$.removeClass('top');
            // dlg.dialog$.removeClass('top');
        });
        // and put it at the top
        this.zIndex.container = ++dialog.zIndex;
        // this.zIndex.mask = ++dialog.zIndex;
        // this.zIndex.dialog = ++dialog.zIndex;
        this.container$.addClass('top').css('z-index', this.zIndex.container);
        this.mask$.addClass('top');
        // this.mask$.css('z-index', this.zIndex.mask);
        this.dialog$.addClass('top');
        // this.dialog$.css('z-index', this.zIndex.dialog);
        dialog.topUID = this.uid;
        return this;
    };

    // accepts the same arguments as jQuery's .show() method
    // http://api.jquery.com/show/
    Dialog.fn.show = function(duration, callback){
        var _this = this;
        duration = +(duration || 0);
        dialog.bodyPosition = window.scrollY;
        this.dialog$.css('top', dialog.bodyPosition);
        if (typeof this.beforeShow === 'function') {
            this.beforeShow.call(this);
        }
        function showCallback(){
            (_this.afterShow || squat).call(_this, arguments);
            (callback || squat).call(_this, arguments);
        }
        this.showMethod = duration === 0 ? 'show' : 'fadeIn';
        this.container$[this.showMethod](duration, function(){
            _this.focus(showCallback);
        });
        this.mask$[this.showMethod](duration / 4).addClass('open');
        this.dialog$[this.showMethod](duration / 2).addClass('open');
        window.$html.addClass('xnat-dialog-open');
        window.$body.addClass('xnat-dialog-open');
        window.$body.css('top', -dialog.bodyPosition);
        window.scrollTo(0,0);
        return this;
    };

    // accepts the same arguments as jQuery's .hide() method
    // http://api.jquery.com/hide/
    Dialog.fn.hide = function(duration, callback){
        this.container$.hide().removeClass('open top');
        this.dialog$.removeClass('open top');
        // this.dialog$.hide.apply(this.dialog$, arguments);
        this.mask$.removeClass('open top').hide();
        dialog.updateWindow();
        return this;
    };

    Dialog.fn.fadeIn = function(duration, callback){
        this.container$.fadeIn(duration || 200, callback);
        return this;
    };

    Dialog.fn.fadeOut = function(duration, callback){
        this.container$.fadeOut(duration || 200, callback);
        this.hide();
        return this;
    };

    // clear out dialog body content
    Dialog.fn.empty = function(){
        this.content$.empty();
        return this;
    };

    // replace body with new content, optionally
    // destructively deleting previous content
    Dialog.fn.replaceContent = Dialog.fn.replace = function(empty, newContent){
        // remove the content from the dialog
        // but keep it in memory...
        // unless empty === true
        if (empty === true) {
            this.empty()
        }
        else {
            this.content$.children().detach();
        }
        this.content$.append(newContent);
        return this;
    };

    // create and setup the dialog
    // Dialog.fn.setup = function(opts){};

    // remove the dialog and all its events from the DOM
    Dialog.fn.destroy = function(){
        if (this.template$) {
            this.template$.empty().append(this.templateContent);
        }
        // this.dialog$.remove();
        // if (this.isModal) {
        //     this.mask$.remove();
        // }
        this.container$.remove();
        delete dialog.dialogs[this.uid];
        dialog.updateUIDs();
        dialog.updateWindow();
        return {};
    };

    // render the elements and show the dialog immediately
    Dialog.fn.open = function(duration, callback){
        this.toTop();
        this.show(duration, callback);
        return this;
    };

    // resize the dialog to the maximum size (92%)
    Dialog.fn.maximize = function(){
        this.dialog$.addClass('maxxed');
        this.maxxed = true;
        this.setHeight(0.98);
    };
    // un-maximize the dialog
    Dialog.fn.restore = function(){
        this.dialog$.removeClass('maxxed');
        this.maxxed = false;
        this.setHeight();
    };
    // toggle max/restore
    Dialog.fn.toggleMaximize = function(){
        this.dialog$.toggleClass('maxxed');
        this.maxxed = !this.maxxed;
        this.setHeight();
    };

    // hide the dialog and remove the elements
    // putting back the template HTML, if used
    Dialog.fn.close = function(duration, callback, destroy){
        this.hide(duration || 1, callback);
        // TODO: to destroy or not to destroy?
        if (destroy || destroy === undefined) {
            this.destroy();
        }
        return this;
    };

    // main function to initialize the dialog
    // WITHOUT showing it
    dialog.init = function(opts){
        var newDialog = new Dialog(opts);
        var resizeTimer = window.setTimeout(null, 60*60*1000);
        $(window).on('resize', function(){
            // console.log('window-resize');
            window.clearTimeout(resizeTimer);
            resizeTimer = window.setTimeout(function(){
                newDialog.setHeight();
            }, 200);
        });
        return newDialog;
    };

    // initialize then open the dialog
    dialog.open = function(opts){
        return dialog.init(opts).open();
    };

    dialog.close = function(dlg){
        if (dlg instanceof Dialog) {
            dlg.close();
            return dlg;
        }
        else {
            if (dialog.dialogs[dlg]) {
                dialog.dialogs[dlg].close();
            }
        }
    };

    dialog.top = function(method, obj){
        if (isPlainObject(method)) {
            obj = cloneObject(method);
            method = 'open';
        }
        return window.top.XNAT.ui.dialog[method](obj);
    };

    // xmodal.iframe 'popup' with sensible defaults
    dialog.iframe = function(url, title, width, height, opts){

        var config = {
            title: '',
            width: 800,
            height: 600,
            //mask: false,
            footer: false
        };

        if (isPlainObject(url)) {
            extendDeep(config, url);
        }
        else if (isPlainObject(title)) {
            config.src = url;
            extendDeep(config, title);
        }
        else {
            extendDeep(config, {
                src: url,
                title: title,
                width: width,
                height: height
            }, getObject(opts))
        }

        return xmodal.iframe(config);

    };

    return XNAT.ui.dialog = dialog;

}));
