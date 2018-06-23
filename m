From: "Xu, Wen" <wen.xu@gatech.edu>
Subject: Bug report: Buffer overrun when reading inline data in
 f2fs
Date: Sat, 23 Jun 2018 04:56:30 +0000
Message-ID: <D81D3CDA-8D2F-445F-934E-5A0FD7743CED@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wen.xu@gatech.edu>) id 1fWapp-0002hb-0A
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Jun 2018 05:11:41 +0000
Received: from mail-co1nam03on0119.outbound.protection.outlook.com
 ([104.47.40.119] helo=NAM03-CO1-obe.outbound.protection.outlook.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1fWapm-006Ms5-FL
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 23 Jun 2018 05:11:40 +0000
Content-Language: en-US
Content-ID: <37BCBEC9437B674DB32B94DF92649B2A@namprd07.prod.outlook.com>
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
