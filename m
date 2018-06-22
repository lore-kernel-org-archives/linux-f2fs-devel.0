From: "Xu, Wen" <wen.xu@gatech.edu>
Subject: Bug report: NULL pointer dereference in
 update_sit_entry() when un-mounting a corrupted f2fs image
Date: Fri, 22 Jun 2018 14:21:12 +0000
Message-ID: <CD416D62-1A9F-4A57-8C3A-E0DAC38CF29C@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wen.xu@gatech.edu>) id 1fWNA2-0003Qs-0K
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jun 2018 14:35:38 +0000
Received: from mail-eopbgr680124.outbound.protection.outlook.com
 ([40.107.68.124] helo=NAM04-BN3-obe.outbound.protection.outlook.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1fWN9z-005nwP-S1
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jun 2018 14:35:37 +0000
Content-Language: en-US
Content-ID: <68CC644F53CA094886D1D5CB957EF96A@namprd07.prod.outlook.com>
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

A bug found by fuzzing at https://bugzilla.kernel.org/show_bug.cgi?id=200185

Thanks,
Wen

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
