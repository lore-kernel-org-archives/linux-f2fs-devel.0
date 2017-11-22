From: Sheng Yong <shengyong1@huawei.com>
Subject: [RFC PATCH 1/3] f2fs: introduce sysfs readdir_ra to
 readahead inode block in readdir
Date: Wed, 22 Nov 2017 18:23:38 +0800
Message-ID: <20171122102340.133491-1-shengyong1@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-2.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <shengyong1@huawei.com>) id 1eHSCD-000759-3W
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Nov 2017 10:23:57 +0000
Received: from szxga04-in.huawei.com ([45.249.212.190])
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
 (Exim 4.89) id 1eHSCA-0008RJ-Ui
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 22 Nov 2017 10:23:57 +0000
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com, chao@kernel.org
Cc: shengyong1@huawei.com, linux-f2fs-devel@lists.sourceforge.net

This patch introduces a sysfs interface readdir_ra to enable/disable
readaheading inode block in f2fs_readdir. When readdir_ra is enabled,
it improves the performance of "readdir + stat".

For 300,000 files:
	time find /data/test > /dev/null
disable readdir_ra: 1m25.69s real  0m01.94s user  0m50.80s system
enable  readdir_ra: 0m18.55s real  0m00.44s user  0m15.39s system

Signed-off-by: Sheng Yong <shengyong1@huawei.com>
---
 Documentation/ABI/testing/sysfs-fs-f2fs | 6 ++++++
 fs/f2fs/dir.c                           | 4 ++++
 fs/f2fs/f2fs.h                          | 1 +
 fs/f2fs/sysfs.c                         | 2 ++
 4 files changed, 13 insertions(+)

diff --git a/Documentation/ABI/testing/sysfs-fs-f2fs b/Documentation/ABI/testing/sysfs-fs-f2fs
index a7799c2fca28..d870b5514d15 100644
--- a/Documentation/ABI/testing/sysfs-fs-f2fs
+++ b/Documentation/ABI/testing/sysfs-fs-f2fs
@@ -186,3 +186,9 @@ Date:		August 2017
 Contact:	"Jaegeuk Kim" <jaegeuk@kernel.org>
 Description:
 		 Controls sleep time of GC urgent mode
+
+What:		/sys/fs/f2fs/<disk>/readdir_ra
+Date:		November 2017
+Contact:	"Sheng Yong" <shengyong1@huawei.com>
+Description:
+		 Controls readahead inode block in readdir.
diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 2d98d877c09d..724304dc6143 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -798,6 +798,7 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 	unsigned int bit_pos;
 	struct f2fs_dir_entry *de = NULL;
 	struct fscrypt_str de_name = FSTR_INIT(NULL, 0);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(d->inode);
 
 	bit_pos = ((unsigned long)ctx->pos % d->max);
 
@@ -836,6 +837,9 @@ int f2fs_fill_dentries(struct dir_context *ctx, struct f2fs_dentry_ptr *d,
 					le32_to_cpu(de->ino), d_type))
 			return 1;
 
+		if (sbi->readdir_ra == 1)
+			ra_node_page(sbi, le32_to_cpu(de->ino));
+
 		bit_pos += GET_DENTRY_SLOTS(le16_to_cpu(de->name_len));
 		ctx->pos = start_pos + bit_pos;
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ca6b0c9bc621..a269d795ba7c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1095,6 +1095,7 @@ struct f2fs_sb_info {
 	int dir_level;				/* directory level */
 	int inline_xattr_size;			/* inline xattr size */
 	unsigned int trigger_ssr_threshold;	/* threshold to trigger ssr */
+	int readdir_ra;				/* readahead inode in readdir */
 
 	block_t user_block_count;		/* # of user blocks */
 	block_t total_valid_block_count;	/* # of valid blocks */
diff --git a/fs/f2fs/sysfs.c b/fs/f2fs/sysfs.c
index 9835348b6e5d..93c3364250dd 100644
--- a/fs/f2fs/sysfs.c
+++ b/fs/f2fs/sysfs.c
@@ -299,6 +299,7 @@ F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, dir_level, dir_level);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, cp_interval, interval_time[CP_TIME]);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, idle_interval, interval_time[REQ_TIME]);
 F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, iostat_enable, iostat_enable);
+F2FS_RW_ATTR(F2FS_SBI, f2fs_sb_info, readdir_ra, readdir_ra);
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 F2FS_RW_ATTR(FAULT_INFO_RATE, f2fs_fault_info, inject_rate, inject_rate);
 F2FS_RW_ATTR(FAULT_INFO_TYPE, f2fs_fault_info, inject_type, inject_type);
@@ -346,6 +347,7 @@ static struct attribute *f2fs_attrs[] = {
 	ATTR_LIST(cp_interval),
 	ATTR_LIST(idle_interval),
 	ATTR_LIST(iostat_enable),
+	ATTR_LIST(readdir_ra),
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 	ATTR_LIST(inject_rate),
 	ATTR_LIST(inject_type),
-- 
2.11.0


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
