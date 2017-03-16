/*!
 *  XNAT.ui.view usage examples
 */

(function(XNAT){

    if (!XNAT) { return }

    XNAT.ui =
        getObject(XNAT.ui || {});

    XNAT.ui.view =
        getObject(XNAT.ui.view || {});

    XNAT.ui.view.examples = {

        // .ajax opts object
        viewRequestOpts: {
            method: 'getJSON',    // XNAT.xhr method
            url: '/path/to/data', // url can go here or in 'ajax' object
            ajax: {
                dataType: 'json'
            },
            container: '#content-container',
            root: 'ResultSet.Result',
            transform: function(data){
                // data.foo expands to ResultSet.Result.foo
                // since 'ResultSet.Result' is the 'root'
                var output = data.foo;
                return '<p>' + output + '</p>'
            },
            items: {
                foo: '<h1>__VALUE__</h1>',
                bar: function(val){
                    return 'Some (' + (val || 'bogus') + ') more text.'
                }
            }
        },

        displayObject: {
            "xsi_type": "dpuk:dpukAssessmentData",
            "needs_ok_to_sync": true,
            "resources": {
                "sync_type": "include",
                "items": [
                    "DPUK1RESOURCE"
                ]
            }
        },

        objectDisplay: function(o){

            var dataObject = {
                "xsi_type": "dpuk:dpukAssessmentData",
                "needs_ok_to_sync": true,
                "resources": {
                    "sync_type": "include",
                    "items": [
                        "DPUK1RESOURCE"
                    ]
                }
            };

            var opts = {
                data: dataObject,
                transform: function(obj){
                    var self = this;
                    return spawn('div.xsi-type', {
                        style: {
                            border: '1px solid #ccc',
                            padding: '20px'
                        }
                    }, [
                        ['p', obj.xsi_type],
                        ['input|type=checkbox', {
                            name: 'needs_ok_to_sync',
                            data: { value: obj.needs_ok_to_sync },
                            checked: !!obj.needs_ok_to_sync,
                            done: function(){
                                console.log(!!obj.needs_ok_to_sync);
                                console.log(this.checked);
                            }
                        }],
                        ' Needs "ok" to sync?',
                        ['div.resources', [
                            ['label', [
                                'Sync Type:',
                                ['select', {
                                    name: 'resources.sync_type',
                                    value: obj.resources.sync_type,
                                    done: function(){
                                        $(this).changeVal(obj.resources.sync_type)
                                    }
                                }, [
                                    ['option', {value: 'all'}, 'all'],
                                    ['option', {value: 'none'}, 'none'],
                                    ['option', {value: 'include'}, 'include'],
                                    ['option', {value: 'exclude'}, 'exclude']
                                ]]
                            ]],
                            ['p', 'Items'],
                            ['textarea|name=resources.items', obj.resources.items.join(', ')]
                        ]]
                    ]);
                }
            };

            return XNAT.spawner.spawn({
                objectDisplay: extend(true, {}, opts, {
                    kind: 'view.objectDisplay',
                    data: 'XNAT.ui.view.examples.displayObject' // test the string eval
                }, o)
            });

            // return XNAT.ui.view.init(opts).objectDisplay();

        },



        // XNAT.ui.view.objectList()
        // renders elements from an object or array of objects
        // using transform functions for each property
        objectList: function(o){

            // set up example vars...

            // 'data' needs to be an array of objects
            var data = [
                {
                    "xsi_type": "dpuk:dpukAssessmentData",
                    "needs_ok_to_sync": true,
                    "resources": {
                        "sync_type": "include",
                        "items": [
                            "DPUK1RESOURCE"
                        ]
                    }
                },
                {
                    "xsi_type": "hcp:subjectMetaData",
                    "needs_ok_to_sync": false,
                    "resources": {
                        "sync_type": "none",
                        "items": []
                    }
                }
            ];

            var itemCount = -1;

            // transform function that will be called on each object
            function subjectAssessors() {

                var obj = this;

                itemCount++;

                var NAME = 'subject_assessors.xsi_types[' + itemCount + ']';

                var xsi_type = spawn('p.xsi_type', { title: NAME }, [
                    ['b', obj.xsi_type],
                    ['input|type=hidden', { value: obj.xsi_type }]
                ]);

                var needs_ok = spawn('label', [
                        ['input', {
                            type: 'checkbox',
                            name: NAME + '.needs_ok_to_sync',
                            checked: obj.needs_ok_to_sync
                        }],
                        ' Needs "ok" to sync?'
                ]);

                var sync_type = XNAT.ui.select.menu({
                    name: NAME + '.resources.sync_type',
                    value: obj.resources.sync_type,
                    options: ['none', 'all', 'include', 'exclude']
                }).element;

                var $items = $.spawn('textarea').val(obj.resources.items.join(', '));

                return spawn('div.subject_assessors', [
                    xsi_type, '<br>', needs_ok, '<br>', sync_type, $items
                ])

            }

            var opts = {
                data: data,
                element: {
                    title: 'Just Foo',
                    className: 'foo',
                    on: [
                        ['click', function(){ alert(this.className) }],
                        ['click', function(){ console.log('another onclick handler')}]
                    ]
                },
                // 'apply' at this level has access to entire data object as 'this'
                transform: subjectAssessors,
                // using properties from 'data' array above...
                items: {
                    xsi_type: {
                        // simple transforms can use string replacement of '__VALUE__'
                        content: '<input type="text" value="__VALUE__">'
                    },
                    needs_ok_to_sync: {
                        // each item can also have its own 'apply' transform function
                        transform: function(value, output){
                            console.log(output);
                            return spawn('input|type=checkbox', { checked: !!realValue(value) })
                        }
                    }
                }
            };


            return XNAT.spawner.spawn({
                objectList: extend(true, {}, opts, {
                    kind: 'view.objectList',
                    data: data
                }, o)
            });

            // return {
            //     render: function(container){
            //         XNAT.ui.view
            //             .objectList(opts)
            //             .render(container);
            //     }
            // }

        }


    };

})(XNAT);

