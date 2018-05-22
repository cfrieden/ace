'use strict';

angular.module('aceConcerts.components.performances.failure.controller', [
  'aceConcerts.core.concert.service'
])
  .controller('FailurePerformanceCtrl',
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
