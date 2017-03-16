/*!
 * Render UI elements from returned data
 */

var XNAT = getObject(XNAT);

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

    // TODO: reconcile 'output' and 'content'

    var undefined, view;

    XNAT.ui =
        getObject(XNAT.ui || {});

    XNAT.ui.view = view =
        getObject(XNAT.ui.view || {});

    function resolveContainer(selector){
        selector = selector || this.container || 'div.view-container';
        if (!this.$container) {
            if (this.container) {
                this.$container = $$(this.container);
            }
            else if ($$(selector).length) {
                this.$container = $(selector).last();
            }
            else if (typeof selector === 'string') {
                this.$container = $.spawn(selector);
            }
            else if (isArray(selector)) {
                // 'selector' can be a spawn() array
                // selector = ['div', { title: 'Foo' }, 'The text is foo.']
                this.$container = $.spawn(selector)
            }
        }
        this.container = this.$container[0];
        return this.$container;
    }

    // replace items in 'str' with 'replacements' object map
    function replaceAll(str, replacements){
        var self = this;
        forOwn(replacements, function(to_replace, replacement){
            str = str.split(to_replace).join(self['data'][replacement])
        });
        return str;
    }

    function View(opts){
        extend(true, this, opts);
        this.output = '';
        this.$output = [];
    }

    View.fn = View.prototype;

    View.fn.get = function(){
        return this.$output[0];
    };

    View.fn.$get = View.fn.get$ = function(){
        return this.$output;
    };

    View.fn.getContainer = function(container){
        return resolveContainer.call(this, container);
    };

    View.fn.setupOutput = function(){};

    View.fn.getOutput = function(){
        return this.output;
    };

    View.fn.render = function(container){
        // this.html = this.$output.outerHTML;
        resolveContainer.call(this, container);
        this.$container.append(this.output);
        return this;
    };

    // explicitly set data object
    View.fn.setData = function(data){
        data = data || this.data;
        this.data = typeof data === 'string' ? JSON.parse(data) : data || null;
        return this;
    };

    // return data object, possibly after transformation
    View.fn.getData = function(){
        return this.data || null;
    };

    function evalInContext(js, context) {
        //# Return the results of the in-line anonymous function we .call with the passed context
        return function() { return eval(js) }.call(context);
    }

    // local function for transforming the data
    // make sure to use .call() or .apply()
    // to set 'this' context
    function transformData(data, func){
        this.data = data || this.data || null;
        this.transform = func || this.transform || this.content;
        if (typeof this.transform === 'string') {
            this.transform = eval(this.transform);
        }
        if (typeof this.transform === 'function') {
            this.content = this.transform.call(this, this.data);
        }
        else {
            this.content = this.transform;
        }
        return this.content;
    }

    // transform data with 'func' and output to 'content'
    View.fn.transformData = function(func){
        this.output = transformData.call(this, null, func);
        return this;
    };

    // transform only specified 'items'
    View.fn.transformItems = function(items){

    };

    // replace content with string(s)
    View.fn.replaceContent = function(replacements){
        this.replacements = replacements || this.replacements || this.toReplace;
        this.output = replaceAll.call(this, this.content, this.replacements)
    };

    // transform data from a SINGLE object to HTML elements
    View.fn.objectDisplay = function(opts){

        var self = this,
            output = '';

        extend(true, this, opts);

        this.$output =
            this.$output && this.$output.length ?
                $$(this.$output) :
                $.spawn('div.object-display');

        this.setData();

        if (this.data) {

            if (this.transform) {
                this.transformData();
            }


            // TODO: figure out content transformation with an object map


            // if (this.content && (this.toReplace || this.replacements)) {
            //     this.replaceContent();
            // }

            // call .render() to append the content
            // this.$output.append(this.content);

            if (isPlainObject(this.items)) {
                forOwn(this.items, function(name, obj){
                    var value = obj.value || self.data[name];
                    if (obj.content) {
                        output = obj.content.replace(/__VALUE__/g, value);
                    }
                    if (obj.transform) {
                        output = obj.transform.call(data, value, output);
                    }
                    self.$output.append(output);
                });
            }

        }

        // add 'element' and 'spawned' for XNAT.spawner compatibility
        // this.element = this.spawned = this.$output[0];

        return this;

    };

    // transform data from an ARRAY of objects to HTML
    View.fn.objectList = function(opts){

        var self = this;

        extend(true, this, opts);

        this.$output =
            this.$output && this.$output.length ?
                $$(this.$output) :
                $.spawn('div.object-list');

        this.setData();
        this.transformData();

        // process each data item
        [].concat(this.data).forEach(function(item){
            if (self.transform) {
                // 'apply' could be a string if defined in YAML
                // and will need to be eval'd
                if (typeof self.transform === 'string') {
                    self.transform = eval(self.transform);
                }
                if (typeof self.transform === 'function') {
                    self.$output.append(self.transform.call(item))
                }
            }
            if (isPlainObject(self.items || null)) {
                forOwn(self.items, function(name, obj){
                    var value = obj.value || item[name],
                        output = '';
                    if (obj.content) {
                        output = obj.content.replace(/__VALUE__/g, value);
                    }
                    if (obj.transform) {
                        output = obj.transform.call(item, value, output);
                    }
                    self.$output.append(output);
                });
            }
        });

        // add 'spawned' for XNAT.spawner compatibility
        this.element = this.spawned = this.$output[0];

        return this;

        // // call transform function for EACH object in the array
        // if (/function/.test(typeof opts.transform)) {
        //     [].concat(data).forEach(function(obj){
        //         // 'this' is the current object
        //         var $item = transform.call(obj, self);
        //         self.$output.append($item)
        //     });
        //     return this.$output;
        // }
        //
        // // if there's an 'apply' function, call that for each item
        // if (typeof opts.transform === 'function') {
        //     [].concat(data).forEach(function(obj){
        //         // 'this' is the current object
        //         var $item = opts.transform.call(obj, self);
        //         self.$output.append($item)
        //     });
        //     return this.$output;
        // }

    };

    view.init = function(opts){
        return new View(opts);
    };

    // render a single object
    // XNAT.ui.view.objectDisplay(opts).render(container);
    view.objectDisplay = function(opts){
        return view.init(opts).objectDisplay();
    };

    // render an array of objects
    view.objectList = function(opts){
        return view.init(opts).objectList();
    };

    // render from data returned via XHR
    view.ajax = view.request = function(opts){
        var opts_sample = {
            // which AJAX function are we using?
            method: XNAT.xhr.get,
            // properties for AJAX request
            ajax: {
                url: '/path/to/data',
                dataType: 'json'
            },
            container: '#container-selector',
            transform: function(data){
                return '<p>' + data.ResultSet.Result.foo + '</p>'
            },
            items: {
                foo: '<h1>__VALUE__</h1>',
                bar: function(val){
                    return 'Some (' + (val || 'bogus') + ') more text.'
                }
            }



        }
    };

    // this script has loaded
    view.loaded = true;

    return XNAT.ui.view = XNAT.view = view;

}));
