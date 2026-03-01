Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59180FD0049
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  1 Mar 2026 01:21:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xKRGed6t8TvVHQ834/e0qCGbmN0EcRReKlfD0KrCUjI=; b=Fv1OnaY0bL1QistG3nUQC0Zw47
	BCF8cd2Cd8a6lMz0+PMcFnZtc6QnaXHD4jdmIw169agOyVlMeo1DoMutgRs/MVREVVO8aRGWB0geY
	GN8GYLPFOXAt1cTPcYNR6Cao6pw/rjR8aHekPSO/ENdCnTdBDY218icexupJ3xkGhza0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vwVVC-0001pb-0O;
	Sun, 01 Mar 2026 01:21:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1vwVVA-0001pT-Jr
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 01 Mar 2026 01:21:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GaoiCh4w9o22QH/sGLTITHwWT2OwJAdhas0MkRhF7ik=; b=lewp1xvTQATCGDlT+jC9Qccdi2
 g/b+vG4vRC3FIdds+Ov9Tv6bP+idEVWgZEx+TqV5D9Uogr7ImBLbNhxwx1VVHdzO/1i/qU8fTVssT
 WleqIrzO8F9aa5CuNESajrIWmTUG5oCEX3JJpNc5FBIpdI0l0EURfsL/XAifR3sgpjlE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=GaoiCh4w9o22QH/sGLTITHwWT2OwJAdhas0MkRhF7ik=; b=T
 h2KYxVy+bzmyau5G3y9cTE4lAVffZF1lbABt+mJW/aooSxBFIb4C7JKrFUuRvfI54u1nJSDX1Y6Ut
 dA/LGBBb+FnSdPAmXsCc8ERinm3GKQBpG36w5wz11VU5af37YEurJRE881Q59YsKlpJO4uihmt/FY
 CfkStlfCa5c3fM54=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vwVV9-0001hs-V2 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 01 Mar 2026 01:21:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 4842960008;
 Sun,  1 Mar 2026 01:21:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F91C19421;
 Sun,  1 Mar 2026 01:21:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772328093;
 bh=/kWwGlvAlFnNgImeHHbjaJdS230hrWl+PHTq8OrMSzE=;
 h=From:To:Cc:Subject:Date:From;
 b=t/GFTHEmlbcSAjDm74h/gwMwA/r29Ed43WEZwbhf7CiuD/ZTLi/NvKXHH2PuGiZNz
 bIPKcjGIelc1DCpqDgtSEJGDfglHQyDzZod9gkoiowhrTGb31j4+OVF507m6OEWIbK
 l1/3I1CDesXGa9zUI5uUewjSbE3rRQssacEkSC6gTVl5a9zh79rneg88SYdaBsexAn
 B/9fIZMFpsvpccnSTkatf05I6RmXH94cbBjMxzG2P7AuECzMPA2GmitDCuTKtANptz
 jvQyxTZdEwWIk9xWJ+Ghnn3h9Ilxj/gu3S+ABpZLotVDqKiIZnm5pIeu7bX8/ZQYBo
 ES5RfgqWe3dQQ==
To: stable@vger.kernel.org,
	chao@kernel.org
Date: Sat, 28 Feb 2026 20:21:30 -0500
Message-ID: <20260301012131.1677456-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
X-Headers-End: 1vwVV9-0001hs-V2
Subject: [f2fs-dev] FAILED: Patch "f2fs: fix to do sanity check on node
 footer in {read, write}_end_io" failed to apply to 6.12-stable tree
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
From: Sasha Levin via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Sasha Levin <sashal@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
 syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com, stable@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 50ac3ecd8e05b6bcc350c71a4307d40c030ec7e4 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Mon, 12 Jan 2026 15:49:16 +0800
Subject: [PATCH] f2fs: fix to do sanity check on node footer in
 {read,write}_end_io

-----------[ cut here ]------------
kernel BUG at fs/f2fs/data.c:358!
Call Trace:
 <IRQ>
 blk_update_request+0x5eb/0xe70 block/blk-mq.c:987
 blk_mq_end_request+0x3e/0x70 block/blk-mq.c:1149
 blk_complete_reqs block/blk-mq.c:1224 [inline]
 blk_done_softirq+0x107/0x160 block/blk-mq.c:1229
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>

In f2fs_write_end_io(), it detects there is inconsistency in between
node page index (nid) and footer.nid of node page.

If footer of node page is corrupted in fuzzed image, then we load corrupted
node page w/ async method, e.g. f2fs_ra_node_pages() or f2fs_ra_node_page(),
in where we won't do sanity check on node footer, once node page becomes
dirty, we will encounter this bug after node page writeback.

Cc: stable@kernel.org
Reported-by: syzbot+803dd716c4310d16ff3a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=803dd716c4310d16ff3a
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/data.c | 12 ++++++++++--
 fs/f2fs/f2fs.h | 11 +++++++++++
 fs/f2fs/node.c | 20 +++++++++++---------
 fs/f2fs/node.h |  8 --------
 4 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f461f1318b4cc..9b70b6d337031 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -172,6 +172,11 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 		while (nr_pages--)
 			dec_page_count(F2FS_F_SB(folio), __read_io_type(folio));
 
+		if (F2FS_F_SB(folio)->node_inode && is_node_folio(folio) &&
+			f2fs_sanity_check_node_footer(F2FS_F_SB(folio),
+				folio, folio->index, NODE_TYPE_REGULAR, true))
+			bio->bi_status = BLK_STS_IOERR;
+
 		if (finished)
 			folio_end_read(folio, bio->bi_status == BLK_STS_OK);
 	}
@@ -374,8 +379,11 @@ static void f2fs_write_end_io(struct bio *bio)
 						STOP_CP_REASON_WRITE_FAIL);
 		}
 
-		f2fs_bug_on(sbi, is_node_folio(folio) &&
-				folio->index != nid_of_node(folio));
+		if (is_node_folio(folio)) {
+			f2fs_sanity_check_node_footer(sbi, folio,
+				folio->index, NODE_TYPE_REGULAR, true);
+			f2fs_bug_on(sbi, folio->index != nid_of_node(folio));
+		}
 
 		dec_page_count(sbi, type);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index ae78b8e1ca0ce..d41210a381cdb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1572,6 +1572,14 @@ enum f2fs_lookup_mode {
 	LOOKUP_AUTO,
 };
 
+/* For node type in __get_node_folio() */
+enum node_type {
+	NODE_TYPE_REGULAR,
+	NODE_TYPE_INODE,
+	NODE_TYPE_XATTR,
+	NODE_TYPE_NON_INODE,
+};
+
 /* a threshold of maximum elapsed time in critical region to print tracepoint */
 #define MAX_LOCK_ELAPSED_TIME		500
 
@@ -3915,6 +3923,9 @@ struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs);
 void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
 struct folio *f2fs_get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 						enum node_type node_type);
+int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
+					struct folio *folio, pgoff_t nid,
+					enum node_type ntype, bool in_irq);
 struct folio *f2fs_get_inode_folio(struct f2fs_sb_info *sbi, pgoff_t ino);
 struct folio *f2fs_get_xnode_folio(struct f2fs_sb_info *sbi, pgoff_t xnid);
 int f2fs_move_node_folio(struct folio *node_folio, int gc_type);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 30e26b878af0b..efd4f176a1f44 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1511,9 +1511,9 @@ void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
 	f2fs_folio_put(afolio, err ? true : false);
 }
 
-static int sanity_check_node_footer(struct f2fs_sb_info *sbi,
+int f2fs_sanity_check_node_footer(struct f2fs_sb_info *sbi,
 					struct folio *folio, pgoff_t nid,
-					enum node_type ntype)
+					enum node_type ntype, bool in_irq)
 {
 	if (unlikely(nid != nid_of_node(folio)))
 		goto out_err;
@@ -1538,12 +1538,13 @@ static int sanity_check_node_footer(struct f2fs_sb_info *sbi,
 		goto out_err;
 	return 0;
 out_err:
-	f2fs_warn(sbi, "inconsistent node block, node_type:%d, nid:%lu, "
-		  "node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
-		  ntype, nid, nid_of_node(folio), ino_of_node(folio),
-		  ofs_of_node(folio), cpver_of_node(folio),
-		  next_blkaddr_of_node(folio));
 	set_sbi_flag(sbi, SBI_NEED_FSCK);
+	f2fs_warn_ratelimited(sbi, "inconsistent node block, node_type:%d, nid:%lu, "
+		"node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
+		ntype, nid, nid_of_node(folio), ino_of_node(folio),
+		ofs_of_node(folio), cpver_of_node(folio),
+		next_blkaddr_of_node(folio));
+
 	f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
 	return -EFSCORRUPTED;
 }
@@ -1589,7 +1590,7 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 		goto out_err;
 	}
 page_hit:
-	err = sanity_check_node_footer(sbi, folio, nid, ntype);
+	err = f2fs_sanity_check_node_footer(sbi, folio, nid, ntype, false);
 	if (!err)
 		return folio;
 out_err:
@@ -1764,7 +1765,8 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool *submitted
 	/* get old block addr of this node page */
 	nid = nid_of_node(folio);
 
-	if (sanity_check_node_footer(sbi, folio, nid, NODE_TYPE_REGULAR)) {
+	if (f2fs_sanity_check_node_footer(sbi, folio, nid,
+					NODE_TYPE_REGULAR, false)) {
 		f2fs_handle_critical_error(sbi, STOP_CP_REASON_CORRUPTED_NID);
 		goto redirty_out;
 	}
diff --git a/fs/f2fs/node.h b/fs/f2fs/node.h
index 9cb8dcf8d4176..824ac9f0e6e42 100644
--- a/fs/f2fs/node.h
+++ b/fs/f2fs/node.h
@@ -52,14 +52,6 @@ enum {
 	IS_PREALLOC,		/* nat entry is preallocated */
 };
 
-/* For node type in __get_node_folio() */
-enum node_type {
-	NODE_TYPE_REGULAR,
-	NODE_TYPE_INODE,
-	NODE_TYPE_XATTR,
-	NODE_TYPE_NON_INODE,
-};
-
 /*
  * For node information
  */
-- 
2.51.0






_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
