From: "Xu, Wen" <wen.xu@gatech.edu>
Subject: Bug report: NULL pointer dereference in f2fs_test_bit()
 when mounting a crafted f2fs image
Date: Fri, 22 Jun 2018 14:19:46 +0000
Message-ID: <87BE4FDD-6930-44DC-B7EF-1612B71FAB32@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wen.xu@gatech.edu>) id 1fWPK0-0004ga-ND
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jun 2018 16:54:04 +0000
Received: from mail-sn1nam01on0102.outbound.protection.outlook.com
 ([104.47.32.102] helo=NAM01-SN1-obe.outbound.protection.outlook.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 id 1fWPJy-000OM8-0J
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jun 2018 16:54:04 +0000
Content-Language: en-US
Content-ID: <A7531BB156BBB1489C9C60CDDEBDE3BC@namprd07.prod.outlook.com>
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

A bug found by fuzzing at: https://bugzilla.kernel.org/show_bug.cgi?id=200181

Thanks,
Wen

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
