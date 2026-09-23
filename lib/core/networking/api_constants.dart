class ApiConstants {
  static const String baseUrl = "https://abdo8.efadh.net/mafhos/";
  // Public — قوائم ومحتوى عام
  static const String onBoarding = "api/onboarding";
  static const String appData = "api/app-data";
  static const String page = "api/page";
  static const String contactUsInfo = "api/contact-us-info";
  static const String contactUs = "api/contact-us";
  static const String cities = "api/cities";
  static const String neighborhoods = "api/neighborhoods";
  static const String inspectionCenters = "api/inspection-centers";
  static const String carBrands = "api/car-brands";
  static const String carModels = "api/car-models";
  static const String carColors = "api/car-colors";
  static const String timeSlots = "api/time-slots";
  static const String nationalities = "api/nationalities";

  // Public — الرئيسية والخدمات والباقات
  static const String home = "api/home";
  static const String services = "api/services";
  static const String showService = "api/show-service";
  static const String packages = "api/packages";

  /// باقة الأسطول — مسار تعاقدي مستقل عن الحجز العادي.
  static const String fleetPackage = "api/fleet-package";
  static const String fleetSubscribe = "api/fleet-subscribe";
  static const String fleetMyRequests = "api/fleet-my-requests";
  static const String showPackage = "api/show-package";

  // Client — الحساب والمفضلة
  static const String showUser = "api/show-user";
  static const String updateUser = "api/update-user";
  static const String logout = "api/logout";
  static const String destroyUser = "api/destroy-user";
  static const String favourites = "api/favourites";
  static const String toggleFavourite = "api/toggle-favourite";

  // Client — المركبات
  static const String vehicles = "api/vehicles";
  static const String showVehicle = "api/show-vehicle";
  static const String storeVehicle = "api/store-vehicle";
  static const String updateVehicle = "api/update-vehicle";
  static const String deleteVehicle = "api/delete-vehicle";

  // Client — الطلبات
  static const String storeOrder = "api/store-order";
  static const String myOrders = "api/my-orders";
  static const String showOrder = "api/show-order";
  static const String trackOrder = "api/track-order";
  static const String orderTrackPath = "api/order-track-path";
  static const String cancelOrder = "api/cancel-order";
  static const String rescheduleOrder = "api/reschedule-order";
  static const String updateOrderLocation = "api/update-order-location";
  static const String reorder = "api/reorder";
  static const String rateOrder = "api/rate-order";
  static const String checkPromo = "api/check-promo";
  static const String quoteOrder = "api/quote-order";

  // Client — ملاحظات الفحص والتقارير
  static const String orderFindings = "api/order-findings";
  static const String showFinding = "api/show-finding";
  static const String approveFinding = "api/approve-finding";
  static const String rejectFinding = "api/reject-finding";
  static const String myReports = "api/my-reports";
  static const String orderReport = "api/order-report";
  static const String showReport = "api/show-report";

  // Client — المحادثة
  static const String chatRoom = "api/chat-room";
  static const String chatMessages = "api/chat-messages";
  static const String sendMessage = "api/send-message";
  static const String readMessages = "api/read-messages";

  // Client — الدفع والبطاقات
  static const String paymentMethods = "api/payment-methods";
  static const String payOrder = "api/pay-order";
  static const String payFinding = "api/pay-finding";
  static const String paymentStatus = "api/payment-status";
  static const String myCards = "api/my-cards";
  static const String addCard = "api/add-card";
  static const String setDefaultCard = "api/set-default-card";
  static const String deleteCard = "api/delete-card";

  // Client — الإشعارات
  static const String notifications = "api/notifications";
  static const String unreadCount = "api/unread-count";
  static const String seenNotification = "api/seen-notification";
  static const String seenNotifications = "api/seen-notifications";
  static const String deleteNotification = "api/delete-notification";
  // Provider — المندوب
  static const String registerProvider = "api/register-provider";
  static const String providerHome = "api/provider-home";
  static const String providerAvailability = "api/provider-availability";
  static const String providerLocation = "api/provider-location";
  static const String providerWallet = "api/provider-wallet";
  static const String providerNewOrders = "api/provider-new-orders";
  static const String providerOrders = "api/provider-orders";
  static const String providerCurrentOrder = "api/provider-current-order";
  static const String providerShowOrder = "api/provider-show-order";
  static const String providerAcceptOrder = "api/provider-accept-order";
  static const String providerRejectOrder = "api/provider-reject-order";
  static const String providerRejectReasons = "api/provider-reject-reasons";
  static const String providerArrived = "api/provider-arrived";
  static const String providerUpdateStage = "api/provider-update-stage";
  static const String providerUpdateChecklist = "api/provider-update-checklist";
  static const String providerCompleteOrder = "api/provider-complete-order";
  static const String providerFindings = "api/provider-findings";
  static const String providerStoreFinding = "api/provider-store-finding";
  static const String providerMaintenanceTypes =
      "api/provider-maintenance-types";
  static const String providerDocuments = "api/provider-documents";
  static const String providerUploadDocuments = "api/provider-upload-documents";

  // Auth
  static const String register = "api/register";

  /// دخول برقم الجوال وكلمة المرور — بيرجّع `user_type` فبيحدد يفتح
  /// واجهة العميل ولا المندوب.
  static const String login = "api/login";
  static const String loginPhone = "api/login-phone";
  static const String guestLogin = "api/guest-login";
  static const String checkCode = "api/check-code";
  static const String resendCode = "api/resend-code";
  static const String forgetPassword = "api/forget-password";
  static const String resetPassword = "api/reset-password";
  static const String updateDevice = "api/update-device";
}
