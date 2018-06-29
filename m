From: "Xu, Wen" <wen.xu@gatech.edu>
Subject: Unfixed bug in f2fs-dev branch
Date: Fri, 29 Jun 2018 17:31:20 +0000
Message-ID: <4C84D904-982F-42E1-910F-202DB0BAABC3@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wen.xu@gatech.edu>) id 1fYxF4-0002a6-To
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Jun 2018 17:31:30 +0000
Received: from mail-bl2nam02on0097.outbound.protection.outlook.com
 ([104.47.38.97] helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1fYxF1-009VMQ-Nj
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 29 Jun 2018 17:31:30 +0000
Content-Language: en-US
Content-ID: <0775F86367E72E448E6D497C2367E7F0@namprd07.prod.outlook.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "yuchao0@huawei.com" <yuchao0@huawei.com>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi Chao,

Thank you for your quick response for my bugs!

After testing your patches, I found all my bugs are fixed except for https://bugzilla.kernel.org/show_bug.cgi?id=200179
The kernel still panics with KASAN report that I have already pasted in the link. Please check it.

-Wen
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
