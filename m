From: "Xu, Wen" <wen.xu@gatech.edu>
Subject: Bug report: Buffer overrun when reading inline data in
 f2fs
Date: Sat, 23 Jun 2018 04:50:10 +0000
Message-ID: <6562EC54-1E49-4CF5-A227-E77E1109EC06@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wen.xu@gatech.edu>) id 1fWajY-0002om-2P
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Jun 2018 05:05:12 +0000
Received: from mail-bl2nam02on0105.outbound.protection.outlook.com
 ([104.47.38.105] helo=NAM02-BL2-obe.outbound.protection.outlook.com)
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1fWajV-003wYI-No
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Jun 2018 05:05:11 +0000
Content-Language: en-US
Content-ID: <1FED072833BD80468E2A3C3D6FEA5555@namprd07.prod.outlook.com>
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

A bug related with inline data read is found by fuzzing at https://bugzilla.kernel.org/show_bug.cgi?id=200219

Thanks,
Wen
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
