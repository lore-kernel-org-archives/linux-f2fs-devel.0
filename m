From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: [PATCH 2/3] dump.f2fs: show checkpoint flag
Date: Thu, 22 Jan 2015 16:48:51 -0800
Message-ID: <1421974132-18330-2-git-send-email-jaegeuk@kernel.org>
References: <1421974132-18330-1-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YESQr-00080h-Iv
	for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Jan 2015 00:49:05 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YESQq-0007Lz-Kk for linux-f2fs-devel@lists.sourceforge.net;
	Fri, 23 Jan 2015 00:49:05 +0000
In-Reply-To: <1421974132-18330-1-git-send-email-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: linux-f2fs-devel@lists.sourceforge.net
Cc: Jaegeuk Kim <jaegeuk@kernel.org>

This patch is to show the checkpoint flag.
With this flag, we can guess the last status of the partition.
And, this can be used by xfstests.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/fsck/main.c b/fsck/main.c
index e05e528..812d196 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -157,6 +157,8 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 static void do_dump(struct f2fs_sb_info *sbi)
 {
 	struct dump_option *opt = (struct dump_option *)config.private;
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	u32 flag = le32_to_cpu(ckpt->ckpt_flags);
 
 	fsck_init(sbi);
 
@@ -172,6 +174,22 @@ static void do_dump(struct f2fs_sb_info *sbi)
 		dump_info_from_blkaddr(sbi, opt->blk_addr);
 		goto cleanup;
 	}
+
+	MSG(0, "Info: checkpoint state = %x : ", flag);
+	if (flag & CP_FSCK_FLAG)
+		MSG(0, "%s", " fsck");
+	if (flag & CP_ERROR_FLAG)
+		MSG(0, "%s", " error");
+	if (flag & CP_COMPACT_SUM_FLAG)
+		MSG(0, "%s", " compacted_summary");
+	if (flag & CP_ORPHAN_PRESENT_FLAG)
+		MSG(0, "%s", " orphan_inodes");
+	if (flag & CP_UMOUNT_FLAG)
+		MSG(0, "%s", " unmount");
+	else
+		MSG(0, "%s", " sudden-power-off");
+	MSG(0, "\n");
+
 	dump_node(sbi, opt->nid);
 cleanup:
 	fsck_free(sbi);
-- 
2.1.1


------------------------------------------------------------------------------
New Year. New Location. New Benefits. New Data Center in Ashburn, VA.
GigeNET is offering a free month of service with a new server in Ashburn.
Choose from 2 high performing configs, both with 100TB of bandwidth.
Higher redundancy.Lower latency.Increased capacity.Completely compliant.
http://p.sf.net/sfu/gigenet
