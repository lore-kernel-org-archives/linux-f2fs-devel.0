From: Chao Yu <chao@kernel.org>
Subject: [PATCH 2/2] f2fs: reuse original mount option in
 ->remount_fs
Date: Thu, 29 Jun 2017 23:20:46 +0800
Message-ID: <20170629152046.2610-2-chao@kernel.org>
References: <20170629152046.2610-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <chao@kernel.org>) id 1dQbHZ-00058s-7k
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Jun 2017 15:23:01 +0000
Received: from mail.kernel.org ([198.145.29.99])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dQbHY-0008WE-Gb
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Jun 2017 15:23:01 +0000
In-Reply-To: <20170629152046.2610-1-chao@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

From: Chao Yu <yuchao0@huawei.com>

Don't clear old mount option before parse new option during ->remount_fs
like other generic filesystems.

Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f27c141cd8aa..af472f7968d0 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -846,7 +846,6 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 			clear_sbi_flag(sbi, SBI_NEED_SB_WRITE);
 	}
 
-	sbi->mount_opt.opt = 0;
 	default_options(sbi);
 
 	/* parse mount options */
-- 
2.13.0.90.g1eb437020


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
