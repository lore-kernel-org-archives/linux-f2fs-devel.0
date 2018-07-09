From: "Xu, Wen" <wen.xu@gatech.edu>
Subject: Bug report: null ptr dereference in
 fscrypt_do_page_crypto() when operating a file on a corrupted f2fs image
Date: Mon, 9 Jul 2018 23:51:42 +0000
Message-ID: <15F87A3F-7218-435E-8D5B-2D3BF3434B9E@gatech.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wen.xu@gatech.edu>) id 1fcgBx-0006mE-Ad
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Jul 2018 00:07:41 +0000
Received: from mail-eopbgr690132.outbound.protection.outlook.com
 ([40.107.69.132] helo=NAM04-CO1-obe.outbound.protection.outlook.com)
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-SHA384:256) (Exim 4.90_1)
 id 1fcgBv-004gCN-8l
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 10 Jul 2018 00:07:41 +0000
Content-Language: en-US
Content-ID: <D7C534B32851E246BF067F030CEE65E9@namprd07.prod.outlook.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <chao@kernel.org>
Cc: "linux-f2fs-devel@lists.sourceforge.net" <linux-f2fs-devel@lists.sourceforge.net>

Hi Chao,

Could you please check: https://bugzilla.kernel.org/show_bug.cgi?id=200465

This new issue cannot be solved by your recent commits from my testing.

Thanks,
Wen

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
