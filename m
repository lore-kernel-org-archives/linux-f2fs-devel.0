From: Chao Yu <chao@kernel.org>
Subject: [PATCH] f2fs: fix to restore whint_mode in ->remount_fs
Date: Wed, 28 Feb 2018 22:01:20 +0800
Message-ID: <20180228140120.8758-1-chao@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <chao@kernel.org>) id 1er2IZ-009dL1-To
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Feb 2018 14:01:35 +0000
Received: from sfi-lb-mx.v20.lw.sourceforge.com ([172.30.20.201]
 helo=mail.kernel.org) by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 id 1er2IV-008SAr-1F
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 28 Feb 2018 14:01:34 +0000
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

If we fail in ->remount_fs, it needs to restore old whint_mode as other
mount options.

Fixes: e25afe01822f ("f2fs: support passing down write hints given by users to block layer")
Signed-off-by: Chao Yu <yuchao0@huawei.com>
---
 fs/f2fs/super.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 89abe4087e66..8a93f78efca2 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1512,6 +1512,7 @@ static int f2fs_remount(struct super_block *sb, int *flags, char *data)
 		sbi->s_qf_names[i] = s_qf_names[i];
 	}
 #endif
+	sbi->whint_mode = old_whint_mode;
 	sbi->mount_opt = org_mount_opt;
 	sbi->active_logs = active_logs;
 	sb->s_flags = old_sb_flags;
-- 
2.14.1.145.gb3622a4ee


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
