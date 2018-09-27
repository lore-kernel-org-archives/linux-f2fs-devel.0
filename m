From: Chengguang Xu <cgxu519@gmx.com>
Subject: [PATCH 2/2] f2fs: remove unnecessary mount optino flag
 'QUOTA'
Date: Thu, 27 Sep 2018 23:23:14 +0800
Message-ID: <20180927152314.23190-2-cgxu519@gmx.com>
References: <20180927152314.23190-1-cgxu519@gmx.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <cgxu519@gmx.com>) id 1g5Y9H-00076r-H8
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Sep 2018 15:24:15 +0000
Received: from mout.gmx.net ([212.227.17.21])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1g5Y9F-00CZYF-JZ
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 27 Sep 2018 15:24:15 +0000
In-Reply-To: <20180927152314.23190-1-cgxu519@gmx.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: Chengguang Xu <cgxu519@gmx.com>, linux-f2fs-devel@lists.sourceforge.net

Code cleanup by removing unnecessary mount option
flag 'QUOTA'.

Signed-off-by: Chengguang Xu <cgxu519@gmx.com>
---
 fs/f2fs/f2fs.h  | 1 -
 fs/f2fs/super.c | 3 ---
 2 files changed, 4 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index abf925664d9c..58d3e40ee46c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -97,7 +97,6 @@ extern char *f2fs_fault_name[FAULT_MAX];
 #define F2FS_MOUNT_USRQUOTA		0x00080000
 #define F2FS_MOUNT_GRPQUOTA		0x00100000
 #define F2FS_MOUNT_PRJQUOTA		0x00200000
-#define F2FS_MOUNT_QUOTA		0x00400000
 #define F2FS_MOUNT_INLINE_XATTR_SIZE	0x00800000
 #define F2FS_MOUNT_RESERVE_ROOT		0x01000000
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index e2abd45c2cdd..74eb63e8a2fd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -680,7 +680,6 @@ static int parse_options(struct super_block *sb, char *options)
 			F2FS_OPTION(sbi).s_jquota_fmt = QFMT_VFS_V1;
 			break;
 		case Opt_noquota:
-			clear_opt(sbi, QUOTA);
 			clear_opt(sbi, USRQUOTA);
 			clear_opt(sbi, GRPQUOTA);
 			clear_opt(sbi, PRJQUOTA);
@@ -1345,8 +1344,6 @@ static int f2fs_show_options(struct seq_file *seq, struct dentry *root)
 	}
 #endif
 #ifdef CONFIG_QUOTA
-	if (test_opt(sbi, QUOTA))
-		seq_puts(seq, ",quota");
 	if (test_opt(sbi, USRQUOTA))
 		seq_puts(seq, ",usrquota");
 	if (test_opt(sbi, GRPQUOTA))
-- 
2.17.1
