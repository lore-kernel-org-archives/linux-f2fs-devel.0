From: "Xu, Wen" <wen.xu@gatech.edu>
Subject: Bug report: BUG() triggered in
 f2fs_truncate_inode_blocks() when un-mounting a mounted f2fs image after
 writing to it
Date: Sat, 23 Jun 2018 04:51:35 +0000
Message-ID: <D78C5A1F-4F0D-4F2D-B901-9CF72C296E9C@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wen.xu@gatech.edu>) id 1fWaWW-0002VL-8V
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Jun 2018 04:51:44 +0000
Received: from mail-cys01nam02on0098.outbound.protection.outlook.com
 ([104.47.37.98] helo=NAM02-CY1-obe.outbound.protection.outlook.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1fWaWT-000mhL-Oq
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Jun 2018 04:51:44 +0000
Content-Language: en-US
Content-ID: <C689454A5EFC1C40841E2F231E6285A5@namprd07.prod.outlook.com>
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

A bug related to inode processing is found by fuzzing at https://bugzilla.kernel.org/show_bug.cgi?id=200223

Thanks,
Wen
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
