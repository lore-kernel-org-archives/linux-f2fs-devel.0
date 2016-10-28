From: Damien Le Moal <damien.lemoal@wdc.com>
Subject: [PATCH v2 2/9] f2fs: Use generic zoned block device
	terminology
Date: Fri, 28 Oct 2016 17:45:00 +0900
Message-ID: <1477644307-30115-3-git-send-email-damien.lemoal@wdc.com>
References: <1477644307-30115-1-git-send-email-damien.lemoal@wdc.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <Damien.LeMoal@wdc.com>) id 1c02o5-0004RB-OM
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:46:33 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1c02o4-0003fO-P4
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 28 Oct 2016 08:46:33 +0000
In-Reply-To: <1477644307-30115-1-git-send-email-damien.lemoal@wdc.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: jaegeuk@kernel.org, yuchao0@huawei.com
Cc: Le Moal <damien.lemoal@wdc.com>, Damien, linux-f2fs-devel@lists.sourceforge.net, Shaun Tancheff <shaun@tancheff.com>, Hannes Reinecke <hare@suse.de>, linux-fsdevel@vger.kernel.org

SMR stands for "Shingled Magnetic Recording" which makes sense
only for hard disk drives (spinning rust). The ZBC/ZAC standards
enable management of SMR disks, but solid state drives may also
support those standards. So rename the HMSMR feature to BLKZONED
to avoid a HDD centric terminology. For the same reason, rename
f2fs_sb_mounted_hmsmr to f2fs_sb_mounted_blkzoned.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/f2fs/data.c  | 2 +-
 fs/f2fs/f2fs.h  | 6 +++---
 fs/f2fs/super.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 9ae194f..803f30f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -110,7 +110,7 @@ static inline void __submit_bio(struct f2fs_sb_info *sbi,
 {
 	if (!is_read_io(bio_op(bio))) {
 		atomic_inc(&sbi->nr_wb_bios);
-		if (f2fs_sb_mounted_hmsmr(sbi->sb) &&
+		if (f2fs_sb_mounted_blkzoned(sbi->sb) &&
 			current->plug && (type == DATA || type == NODE))
 			blk_finish_plug(current->plug);
 	}
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9e8de18..2fc771a 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -103,7 +103,7 @@ struct f2fs_mount_info {
 };
 
 #define F2FS_FEATURE_ENCRYPT	0x0001
-#define F2FS_FEATURE_HMSMR	0x0002
+#define F2FS_FEATURE_BLKZONED	0x0002
 
 #define F2FS_HAS_FEATURE(sb, mask)					\
 	((F2FS_SB(sb)->raw_super->feature & cpu_to_le32(mask)) != 0)
@@ -2412,9 +2412,9 @@ static inline int f2fs_sb_has_crypto(struct super_block *sb)
 	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_ENCRYPT);
 }
 
-static inline int f2fs_sb_mounted_hmsmr(struct super_block *sb)
+static inline int f2fs_sb_mounted_blkzoned(struct super_block *sb)
 {
-	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_HMSMR);
+	return F2FS_HAS_FEATURE(sb, F2FS_FEATURE_BLKZONED);
 }
 
 static inline void set_opt_mode(struct f2fs_sb_info *sbi, unsigned int mt)
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index f6379f5..a83df29 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -975,7 +975,7 @@ static void default_options(struct f2fs_sb_info *sbi)
 	set_opt(sbi, EXTENT_CACHE);
 	sbi->sb->s_flags |= MS_LAZYTIME;
 	set_opt(sbi, FLUSH_MERGE);
-	if (f2fs_sb_mounted_hmsmr(sbi->sb)) {
+	if (f2fs_sb_mounted_blkzoned(sbi->sb)) {
 		set_opt_mode(sbi, F2FS_MOUNT_LFS);
 		set_opt(sbi, DISCARD);
 	} else {
-- 
2.7.4

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.


------------------------------------------------------------------------------
The Command Line: Reinvented for Modern Developers
Did the resurgence of CLI tooling catch you by surprise?
Reconnect with the command line and become more productive. 
Learn the new .NET and ASP.NET CLI. Get your free copy!
http://sdm.link/telerik
