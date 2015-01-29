From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH 2/3 v2] dump.f2fs: show checkpoint flag
Date: Thu, 29 Jan 2015 13:43:27 -0800
Message-ID: <20150129214327.GA17672@jaegeuk-mac02>
References: <1421974132-18330-1-git-send-email-jaegeuk@kernel.org>
	<1421974132-18330-2-git-send-email-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <jaegeuk@kernel.org>) id 1YGwsF-0003VM-83
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Jan 2015 21:43:39 +0000
Received: from mail.kernel.org ([198.145.29.136])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YGwsE-0006y2-9P for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 29 Jan 2015 21:43:39 +0000
Received: from mail.kernel.org (localhost [127.0.0.1])
	by mail.kernel.org (Postfix) with ESMTP id 6B74F2022D
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 29 Jan 2015 21:43:33 +0000 (UTC)
Received: from localhost (unknown [166.170.43.114])
	(using TLSv1.2 with cipher AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPSA id B952A20225
	for <linux-f2fs-devel@lists.sourceforge.net>;
	Thu, 29 Jan 2015 21:43:31 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1421974132-18330-2-git-send-email-jaegeuk@kernel.org>
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

Change log from v1:
 o add FASTBOOT_FLAG

>From b57708aecf07a7caa8fcce02f65735a11e987154 Mon Sep 17 00:00:00 2001
From: Jaegeuk Kim <jaegeuk@kernel.org>
Date: Wed, 14 Jan 2015 16:18:15 -0800
Subject: [PATCH] dump.f2fs: show checkpoint flag

This patch is to show the checkpoint flag.
With this flag, we can guess the last status of the partition.
And, this can be used by xfstests.

Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fsck/main.c       | 20 ++++++++++++++++++++
 include/f2fs_fs.h |  1 +
 2 files changed, 21 insertions(+)

diff --git a/fsck/main.c b/fsck/main.c
index e05e528..3606f62 100644
--- a/fsck/main.c
+++ b/fsck/main.c
@@ -157,6 +157,8 @@ static void do_fsck(struct f2fs_sb_info *sbi)
 static void do_dump(struct f2fs_sb_info *sbi)
 {
 	struct dump_option *opt = (struct dump_option *)config.private;
+	struct f2fs_checkpoint *ckpt = F2FS_CKPT(sbi);
+	u32 flag = le32_to_cpu(ckpt->ckpt_flags);
 
 	fsck_init(sbi);
 
@@ -172,6 +174,24 @@ static void do_dump(struct f2fs_sb_info *sbi)
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
+	if (flag & CP_FASTBOOT_FLAG)
+		MSG(0, "%s", " fastboot");
+	if (flag & CP_UMOUNT_FLAG)
+		MSG(0, "%s", " unmount");
+	else
+		MSG(0, "%s", " sudden-power-off");
+	MSG(0, "\n");
+
 	dump_node(sbi, opt->nid);
 cleanup:
 	fsck_free(sbi);
diff --git a/include/f2fs_fs.h b/include/f2fs_fs.h
index 4dc2426..d062b7f 100644
--- a/include/f2fs_fs.h
+++ b/include/f2fs_fs.h
@@ -358,6 +358,7 @@ struct f2fs_super_block {
 /*
  * For checkpoint
  */
+#define CP_FASTBOOT_FLAG	0x00000020
 #define CP_FSCK_FLAG		0x00000010
 #define CP_ERROR_FLAG		0x00000008
 #define CP_COMPACT_SUM_FLAG	0x00000004
-- 
2.1.1


------------------------------------------------------------------------------
Dive into the World of Parallel Programming. The Go Parallel Website,
sponsored by Intel and developed in partnership with Slashdot Media, is your
hub for all things parallel software development, from weekly thought
leadership blogs to news, videos, case studies, tutorials and more. Take a
look and join the conversation now. http://goparallel.sourceforge.net/
