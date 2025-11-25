

// import 'dart:convert';



// class ApiManager {

  

//   // pa3d ma ktpt el methd klha fe 4 e7tmlat lazem a3mel handle

//   /**
//      * 1- loading lazem hndlha fe el ui
//      * 2- mafesh net aslan 
//      * 3- rad el server   response success response error 
//      * // kol dool pyt3mlo pe FutureBuilder
//      */

//    Future<News> getNewsbySourceId(String sourceId , {String? query}) async {
//     Uri url = Uri.https(ApiConstant.baseUrl, EndPoints.everyThingApi, {
//       "apiKey": ApiConstant.apiKey,
//       "sources": sourceId,
//         if (query != null && query.isNotEmpty) "q": query,
//     });

//     try {
//       var respone = await http.get(url);

//       var responseBody = respone.body;

//       var json = jsonDecode(responseBody);

//       print("json is");
//       print(json);

//       return News.fromJson(
//         json,
//       ); // ma3aya object gahzez feh el dinya kolha
//     } catch (e) {
//       throw e;
//     }
//   }
// }
