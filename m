From: "Xu, Wen" <wen.xu@gatech.edu>
Subject: Bug report: use-after-free in update_sit_entry() when
 operating on a corrupted f2fs image
Date: Fri, 22 Jun 2018 14:19:11 +0000
Message-ID: <57E73AEE-7219-46EA-8961-B39882B98E2B@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wen.xu@gatech.edu>) id 1fWNQz-00025h-7y
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jun 2018 14:53:09 +0000
Received: from mail-eopbgr690122.outbound.protection.outlook.com
 ([40.107.69.122] helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1fWNQw-003T1b-Q7
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jun 2018 14:53:08 +0000
Content-Language: en-US
Content-ID: <E419485564EBC144A3D1B2507C85CBF7@namprd07.prod.outlook.com>
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

Hi,

A bug found by fuzzing at https://bugzilla.kernel.org/show_bug.cgi?id=200179

Thanks,
Wen

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
