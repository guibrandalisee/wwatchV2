'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';
const RESOURCES = {
  "assets/api.env": "7719dba2ab9d7fe678fbeeebf2a389f7",
"assets/AssetManifest.json": "4407d24b18339d8137c49736f8507634",
"assets/assets/icon.png": "152736314d23079fef3395fdfc8aa72d",
"assets/assets/images/GitHubLogo.png": "d01034109cacd1509b8e83afe164c1ef",
"assets/assets/images/GooglePlayLogo.png": "ad50705c787f604f6d8b8235d11b521d",
"assets/assets/images/LinkedInLogo.png": "a19074d6edca7fead6cc86886bc0961f",
"assets/assets/images/LoginDecoration.png": "1e51331d5e3fd5ecb085b3557bc9023b",
"assets/assets/images/logo.png": "6b7291a218002db2d791fd45830c2fd4",
"assets/assets/images/me.png": "13e55d36a7fed95bd48473e2e5880c27",
"assets/assets/images/MovieDB.png": "ee1b1db4dfb3415185b4a2145e0dbfec",
"assets/assets/images/PatreonLogo.png": "7578eac294d7292000b5e3d6d009139b",
"assets/assets/images/PayPalLogo.png": "a1d11b47251bc039aa8651dbd089bbc4",
"assets/assets/images/WWatch2-png.png": "424e4072dc500e8bd1a9edf167470852",
"assets/assets/images/WWatch2.png": "152736314d23079fef3395fdfc8aa72d",
"assets/assets/noConnection/noConnection1.svg": "c5d1737a045cddc64a8c58516078635d",
"assets/assets/noConnection/noConnection2.svg": "64fa2a54a7224dc429df7203fce07cc0",
"assets/assets/noConnection/noConnection3.svg": "3da84c6ad692d8f1b4f927726763b9b2",
"assets/assets/noConnection/noConnection4.svg": "4eb8a2985f6c8fd08245b71d74e0b29e",
"assets/assets/noConnection/noConnection5.svg": "bdc30f753741d92b74c9513ba7474673",
"assets/assets/noConnection/noConnection6.svg": "0b19d7eb14ec1eceeb160649c49d2fbf",
"assets/assets/noConnection/noConnection7.svg": "254290df848ca233149e9c8ce472d5ee",
"assets/assets/noConnection/noConnection8.svg": "7cc24fb19346032469673e760ddf3bec",
"assets/assets/nothingFound/nothingFound1.svg": "fdd137b8a39b970ccbc0807aeea45551",
"assets/assets/nothingFound/nothingFound2.svg": "b1af97d528386879f142a169b4304ea5",
"assets/assets/nothingFound/nothingFound3.svg": "7c6627b748bd80d317aeacbb25cec8b9",
"assets/assets/nothingFound/nothingFound4.svg": "9f7001c8ca9e6eccc04af79c9a91d1b5",
"assets/assets/nothingFound/nothingFound5.svg": "0d48c914f21e84bbff0a65f02cbe0b38",
"assets/assets/nothingFound/nothingFound6.svg": "3cb5a8513880537b653a0b9f9d5a0fce",
"assets/assets/nothingFound/nothingFound7.svg": "c537ae25d6b7451c70aa8fc6f9521297",
"assets/assets/nothingFound/nothingFound8.svg": "0541552c456be83e2397646be3aca4cc",
"assets/FontManifest.json": "e024588c84b5d20cb7869d6f908130e8",
"assets/fonts/MaterialIcons-Regular.otf": "7e7a6cccddf6d7b20012a548461d5d81",
"assets/NOTICES": "62ef60810cf118b98ecd2409941e75bc",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "6d342eb68f170c97609e9da345464e5e",
"assets/packages/line_icons/lib/assets/fonts/LineIcons.ttf": "23621397bc1906a79180a918e98f35b2",
"canvaskit/canvaskit.js": "c2b4e5f3d7a3d82aed024e7249a78487",
"canvaskit/canvaskit.wasm": "4b83d89d9fecbea8ca46f2f760c5a9ba",
"canvaskit/profiling/canvaskit.js": "ae2949af4efc61d28a4a80fffa1db900",
"canvaskit/profiling/canvaskit.wasm": "95e736ab31147d1b2c7b25f11d4c32cd",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"index.html": "8617a9c9352b724905432bbedcf781f0",
"/": "8617a9c9352b724905432bbedcf781f0",
"main.dart.js": "80d9f3dbcc92db337204e5e2fcb93ade",
"manifest.json": "56e1c12a9227754398b1b9321b17449b",
"splash/img/dark-1x.png": "04d142c6df7f7434fbb7c739ace9e545",
"splash/img/dark-2x.png": "54a86f38ad0ce3ae3b1d59c72c357dac",
"splash/img/dark-3x.png": "502a4d1a464d120141051870b31b4ea0",
"splash/img/dark-4x.png": "3ed980af9d8c3ed3c028fe23c1ff57a2",
"splash/img/light-1x.png": "04d142c6df7f7434fbb7c739ace9e545",
"splash/img/light-2x.png": "54a86f38ad0ce3ae3b1d59c72c357dac",
"splash/img/light-3x.png": "502a4d1a464d120141051870b31b4ea0",
"splash/img/light-4x.png": "3ed980af9d8c3ed3c028fe23c1ff57a2",
"splash/style.css": "6427c4e7547958c5ac1b8e4e4d66cbc6",
"version.json": "0dde7fd4559ab664c91dca6bce74ff1b"
};

// The application shell files that are downloaded before a service worker can
// start.
const CORE = [
  "/",
"main.dart.js",
"index.html",
"assets/NOTICES",
"assets/AssetManifest.json",
"assets/FontManifest.json"];
// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});

// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});

// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache.
        return response || fetch(event.request).then((response) => {
          cache.put(event.request, response.clone());
          return response;
        });
      })
    })
  );
});

self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});

// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}

// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}
