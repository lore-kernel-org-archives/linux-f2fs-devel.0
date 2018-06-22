From: "Xu, Wen" <wen.xu@gatech.edu>
Subject: Bug report: buffer overrun in build_sit_info() when
 mounting a crafted f2fs image
Date: Fri, 22 Jun 2018 14:16:04 +0000
Message-ID: <8D7847B2-6B38-48A3-A66F-99598CC78ABE@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wen.xu@gatech.edu>) id 1fWPFj-0004as-NL
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jun 2018 16:49:39 +0000
Received: from mail-eopbgr700123.outbound.protection.outlook.com
 ([40.107.70.123] helo=NAM04-SN1-obe.outbound.protection.outlook.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1fWPFf-006Isv-8F
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jun 2018 16:49:39 +0000
Content-Language: en-US
Content-ID: <56E6788B301C6D4198D9095DB8AC23E9@namprd07.prod.outlook.com>
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

A bug found by fuzzing, and the details is at: https://bugzilla.kernel.org/show_bug.cgi?id=200167

Thanks,
Wen
------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
