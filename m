From: "Xu, Wen" <wen.xu@gatech.edu>
Subject: Bug report: BUG() triggered in clear_inode() when
 mounting and un-mounting a corrupted f2fs image
Date: Sat, 23 Jun 2018 04:50:54 +0000
Message-ID: <620F669E-4D73-4AC8-9C12-95817F27C4D1@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wen.xu@gatech.edu>) id 1fWaVs-0002as-Cb
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Jun 2018 04:51:04 +0000
Received: from mail-cys01nam02on0134.outbound.protection.outlook.com
 ([104.47.37.134] helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1fWaVp-000mgV-88
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Jun 2018 04:51:04 +0000
Content-Language: en-US
Content-ID: <956EE6B6EC24094488162B71AA1E1855@namprd07.prod.outlook.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi all,

There is bug related to node cleaning found by fuzzing at https://bugzilla.kernel.org/show_bug.cgi?id=200221

Thanks,
Wen
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
