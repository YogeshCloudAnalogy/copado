({
	 init: function (cmp, event, helper) {
        cmp.set('v.mapMarkers', [
            {
                location: {
                    Street: '415 Mission St',
                    City: 'San Francisco',
                    State: 'CA'
                },

                title: 'Salesforce Tower',
                description: 'San Francisco\'s tallest building'
            }
        ]);
    },
})