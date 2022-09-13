Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8332CECAAA1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Sep 2022 02:25:46 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oXvcB-0003U6-2F;
	Tue, 13 Sep 2022 02:25:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1oXvc9-0003Tz-PB
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Sep 2022 02:25:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WQLVrOhldhokKa0xyQt4L6wzS0XneQ8v+cnci/BxYU0=; b=WpAWwlVgkfuXJfO8ML8j9af1jU
 twv1H6Czxof/4jozCYdMR+AJU5XjBy2KWskq8Qnw/PvjD1k6QzSMB9MkdyEdthvYMM8uRitGezpzX
 Fg6Y+h+lphUyvFbsVsloTHCFVcIwF/qevx6g2j7gGUPDcBC4sr0Q6xsBXmhm3YUQbbt8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WQLVrOhldhokKa0xyQt4L6wzS0XneQ8v+cnci/BxYU0=; b=j
 CWT98jdupJs/rIKC3Wja79r/wdl3/OTXeF2Y521X/+ssz87QJjKQNMThFVCgdYc4Lsi+VFsM042gT
 8ruUhI+M8v4aoKr7nARP1M5Ua4i4EjTIs6vplU3LwlgpHmXqGQD+tjW234RYNQEMldnwJR9V4F2xl
 sVoUkQ60vL9zy6a8=;
Received: from [145.40.68.75] (helo=ams.source.kernel.org)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oXvcL-0002gl-DQ for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Sep 2022 02:25:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 279A2B80920;
 Tue, 13 Sep 2022 02:25:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12935C433D6;
 Tue, 13 Sep 2022 02:25:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1663035923;
 bh=n7s2YM0FbSs9gTxsnZ/8IzTSbkACg4whGgnweAhPvw8=;
 h=From:To:Cc:Subject:Date:From;
 b=DPPo//cr8RapvpQvsM/jlU7VI9ukvcTwr/I5lMieKw7ADjVdv6kvqfIXwvz2oa1ZU
 4zOkYQNvY39IGCNWN3P/RpEOblKPJ7QgxVkzkDX8eDywqSnMHx+GZKKnBFKbCTZOdV
 VIH2uqpxa11AaZ2gEefpisQKvc6IOq6oLH0rA687MY7qljYMSfpL3/EuEun7bqiF3F
 XK8WEqYRI636YoCrCFrV1SUfZSKRsfNmXug5L9+T625/1baU6MXlhuvDpeO1Si25c8
 +kDErdWkIE+F9tiMoRzQlSzuhNMzLg35fZ/PDkdroduJXhbslJv4Y5LQ6Et3gBeAWf
 UCNlS5/9logbw==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue, 13 Sep 2022 10:25:13 +0800
Message-Id: <20220913022513.2162885-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1oXvcL-0002gl-DQ
Subject: [f2fs-dev] [PATCH] f2fs: fix to do sanity check on summary info
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: stable@kernel.org, Wenqing Liu <wenqingliu0120@gmail.com>,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

As Wenqing Liu reported in bugzilla:

https://bugzilla.kernel.org/show_bug.cgi?id=216456

BUG: KASAN: use-after-free in recover_data+0x63ae/0x6ae0 [f2fs]
Read of size 4 at addr ffff8881464dcd80 by task mount/1013

CPU: 3 PID: 1013 Comm: mount Tainted: G        W          6.0.0-rc4 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.15.0-1 04/01/2014
Call Trace:
 dump_stack_lvl+0x45/0x5e
 print_report.cold+0xf3/0x68d
 kasan_report+0xa8/0x130
 recover_data+0x63ae/0x6ae0 [f2fs]
 f2fs_recover_fsync_data+0x120d/0x1fc0 [f2fs]
 f2fs_fill_super+0x4665/0x61e0 [f2fs]
 mount_bdev+0x2cf/0x3b0
 legacy_get_tree+0xed/0x1d0
 vfs_get_tree+0x81/0x2b0
 path_mount+0x47e/0x19d0
 do_mount+0xce/0xf0
 __x64_sys_mount+0x12c/0x1a0
 do_syscall_64+0x38/0x90
 entry_SYSCALL_64_after_hwframe+0x63/0xcd

The root cause is: in fuzzed image, SSA table is corrupted: ofs_in_node
is larger than ADDRS_PER_PAGE(), result in out-of-range access on 4k-size
page.

- recover_data
 - do_recover_data
  - check_index_in_prev_nodes
   - f2fs_data_blkaddr

This patch adds sanity check on summary info in recovery and GC flow
in where the flows rely on them.

After patch:
[   29.310883] F2FS-fs (loop0): Inconsistent ofs_in_node:65286 in summary, ino:0, nid:6, max:1018

Cc: <stable@kernel.org>
Reported-by: Wenqing Liu <wenqingliu0120@gmail.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/gc.c       | 10 +++++++++-
 fs/f2fs/recovery.c | 15 ++++++++++++---
 2 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index fd400d148afb..3a820e5cdaee 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1078,7 +1078,7 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 {
 	struct page *node_page;
 	nid_t nid;
-	unsigned int ofs_in_node;
+	unsigned int ofs_in_node, max_addrs;
 	block_t source_blkaddr;
 
 	nid = le32_to_cpu(sum->nid);
@@ -1104,6 +1104,14 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 		return false;
 	}
 
+	max_addrs = IS_INODE(node_page) ? DEF_ADDRS_PER_INODE :
+						DEF_ADDRS_PER_BLOCK;
+	if (ofs_in_node >= max_addrs) {
+		f2fs_err(sbi, "Inconsistent ofs_in_node:%u in summary, ino:%u, nid:%u, max:%u",
+			ofs_in_node, dni->ino, dni->nid, max_addrs);
+		return false;
+	}
+
 	*nofs = ofs_of_node(node_page);
 	source_blkaddr = data_blkaddr(NULL, node_page, ofs_in_node);
 	f2fs_put_page(node_page, 1);
diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
index 8326003e6918..9b361fff30aa 100644
--- a/fs/f2fs/recovery.c
+++ b/fs/f2fs/recovery.c
@@ -474,7 +474,7 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 	struct dnode_of_data tdn = *dn;
 	nid_t ino, nid;
 	struct inode *inode;
-	unsigned int offset;
+	unsigned int offset, ofs_in_node, max_addrs;
 	block_t bidx;
 	int i;
 
@@ -501,15 +501,24 @@ static int check_index_in_prev_nodes(struct f2fs_sb_info *sbi,
 got_it:
 	/* Use the locked dnode page and inode */
 	nid = le32_to_cpu(sum.nid);
+	ofs_in_node = le16_to_cpu(sum.ofs_in_node);
+
+	max_addrs = ADDRS_PER_PAGE(dn->node_page, dn->inode);
+	if (ofs_in_node >= max_addrs) {
+		f2fs_err(sbi, "Inconsistent ofs_in_node:%u in summary, ino:%u, nid:%u, max:%u",
+			ofs_in_node, ino, nid, max_addrs);
+		return -EFSCORRUPTED;
+	}
+
 	if (dn->inode->i_ino == nid) {
 		tdn.nid = nid;
 		if (!dn->inode_page_locked)
 			lock_page(dn->inode_page);
 		tdn.node_page = dn->inode_page;
-		tdn.ofs_in_node = le16_to_cpu(sum.ofs_in_node);
+		tdn.ofs_in_node = ofs_in_node;
 		goto truncate_out;
 	} else if (dn->nid == nid) {
-		tdn.ofs_in_node = le16_to_cpu(sum.ofs_in_node);
+		tdn.ofs_in_node = ofs_in_node;
 		goto truncate_out;
 	}
 
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
