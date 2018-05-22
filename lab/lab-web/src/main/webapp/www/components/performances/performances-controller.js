'use strict';

angular.module('aceConcerts.components.performances.controller', [
  'aceConcerts.core.concert.service'
])
  .controller('PerformancesCtrl', function (
    $log,
    $uibModal,
    concertService,
    $interval,
    usSpinnerService
  ) {
    var vm = this;

    vm.bookings = [];

    var perf;

    function getBookingVal() {
      if (0 in perf.$$state.value) {
        $log.log("Booking was accepted.")
        vm.openBookingSuccessModal();
      }
      else {
        $log.log("Booking was not accepted.")
        vm.openBookingFailureModal();
      }
    };

    activate();

    $interval(activate, 3000);

    function activate() {
      return concertService.getBookings()
        .then(function(bookings) {
          vm.bookings = bookings;
        });
    };

    vm.openAddBookingModal = function() {
      var modalInstance = $uibModal.open(
        {
          animation: true,
          templateUrl: 'www/components/performances/add-modal/add.html',
          controller: 'AddPerformanceCtrl as add',
          size: 'lg'
        }
      );

      modalInstance.result
        .then(addBooking, function () {
          $log.info('Modal dismissed at: ' + new Date());
        });

    };

    function addBooking(newPerformance) {
      usSpinnerService.spin('spinner-book');

      perf = concertService.addBooking(newPerformance);

      return perf
        .then(activate)
        .then(function() {
          return usSpinnerService.stop('spinner-book');
        })
        .then(getBookingVal);
    };


    vm.openBookingSuccessModal = function () {
      var modalInstanceSuccess = $uibModal.open(
        {
          animation: true,
          templateUrl: 'www/components/performances/success-modal/success.html',
          controller: 'SuccessPerformanceCtrl as success',
          size: 'lg'
        }
      )
    };

      vm.openBookingFailureModal = function () {
        var modalInstanceFailure = $uibModal.open(
          {
            animation: true,
            templateUrl: 'www/components/performances/failure-modal/failure.html',
            controller: 'FailurePerformanceCtrl as failure',
            size: 'lg'
          }
        )
      };



    console.log('Performances Controller Created');

});
