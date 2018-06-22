From: "Xu, Wen" <wen.xu@gatech.edu>
Subject: Bug report: Divide zero in reset_curseg() when mounting
 a crafted f2fs image
Date: Fri, 22 Jun 2018 14:20:22 +0000
Message-ID: <15AA751D-8F5A-4258-A389-1D7EBBAED613@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wen.xu@gatech.edu>) id 1fWNQS-0004nX-E6
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jun 2018 14:52:36 +0000
Received: from mail-eopbgr720096.outbound.protection.outlook.com
 ([40.107.72.96] helo=NAM05-CO1-obe.outbound.protection.outlook.com)
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1fWNQQ-000Jf8-15
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 22 Jun 2018 14:52:36 +0000
Content-Language: en-US
Content-ID: <ACC0B0AA1C0EE740BAD7297D73A3ADD2@namprd07.prod.outlook.com>
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

A bug found by fuzzing at https://bugzilla.kernel.org/show_bug.cgi?id=200183

Thanks,
Wen

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
