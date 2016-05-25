(function(){
  var app = angular.module('store', [ ]);

  app.controller('StoreController', function(){
    this.product = gem;
  });

  var gem = {
    name: 'Dodecahedron',
    price: 2.0,
    description: 'Some gems have hidden qualities beyond their luster, beyond their...',
    canPurchase: true,
    soldOut: false,
  };
})();
