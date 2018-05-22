'use strict';

angular.module('aceConcerts.components.performances.success.controller', [
  'aceConcerts.core.concert.service'
])
  .controller('SuccessPerformanceCtrl',
  function (
    $scope,
    $uibModalInstance,
    concertService
  ) {

    var vm = this;

    vm.cancel = function () {
      $uibModalInstance.dismiss('cancel');
    };

});
