importScripts("https://www.gstatic.com/firebasejs/7.5.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/7.5.0/firebase-messaging.js");
firebase.initializeApp({
    apiKey: "AIzaSyCweMMCzHsNkbbGwi_pB1_BIshB6V_vNa8",
    authDomain: "yolo-ebd7f.firebaseapp.com",
    databaseURL: "https://yolo-ebd7f.firebaseio.com",
    projectId: "yolo-ebd7f",
    storageBucket: "yolo-ebd7f.appspot.com",
    messagingSenderId: "388523766928",
    appId: "1:388523766928:web:f7f6189383dc32bc58d415",
    measurementId: "G-3CT6N8999Q"
});
console.log(firebase);
const messaging = firebase.messaging();
messaging.setBackgroundMessageHandler(function (payload) {
    const promiseChain = clients
        .matchAll({
            type: "window",
            includeUncontrolled: true
        })
        .then(windowClients => {
            for (let i = 0; i < windowClients.length; i++) {
                const windowClient = windowClients[i];
                windowClient.postMessage(payload);
            }
        })
        .then(() => {
            return registration.showNotification("New Message");
        });
    return promiseChain;
});
self.addEventListener('notificationclick', function (event) {
    console.log('notification received: ', event)
});
//const messaging = firebase.messaging();
//messaging.setBackgroundMessageHandler(function(payload) {
//  console.log('[firebase-messaging-sw.js] Received background message ', payload);
//  // Customize notification here
//  const notificationTitle = 'Background Message Title';
//  const notificationOptions = {
//    body: 'Background Message body.',
//    icon: '/firebase-logo.png'
//  };
//
//  return self.registration.showNotification(notificationTitle,
//    notificationOptions);
//});