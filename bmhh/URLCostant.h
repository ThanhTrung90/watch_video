//
//  URLCostant.h
//  bmhh
//
//  Created by Nguyễn Thành Trung on 5/27/16.
//  Copyright © 2016 joeteam90. All rights reserved.
//

#ifndef URLCostant_h
#define URLCostant_h

#define METHOD_GET                                          @"GET"
#define METHOD_POST                                         @"POST"
#define REQUEST_TIMEOUT                                     120
/* Start function appending*/
#define APPEND(A,B)                                         [(A) stringByAppendingString:(B)]
/* End function appending*/

/* Start server*/
#define SERVER                                               @"google.com"
#define SERVER_API                                           APPEND(SERVER,@"/api/")
/* End server*/

#define LIST_STAGE                                           APPEND(SERVER_API,@"stages/search")
#define IMPRESSIVE_STAGE                                     APPEND(SERVER_API,@"stages/byfeature")
#define RETRIEVE_STAGE                                       APPEND(SERVER_API,@"Stages/%@")
#endif /* URLCostant_h */
