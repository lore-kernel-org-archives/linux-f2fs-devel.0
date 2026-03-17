Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 827C6FD8741
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Mar 2026 11:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UJBV1k8Sw7xh5wKJvjhFUfhj2KGVlk02iLUhMjCxkqA=; b=Kew+A8Kah11QL8IOnzauXVCs7h
	u4ZEm/JTBmCk/fD19ddo4rIeJnsaaauJh16C0kN+EGmz6/q2bhoDLt2sVPcLJLk8AVMeFsNtEggmO
	bVD6zv5vcJabZKU1tzqPOSIcK1NWuEa4xgq+Le/kMzBMsB2KZW1/sTwKqzbTHrYneqmQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w2T1M-0003hP-2l;
	Tue, 17 Mar 2026 11:55:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1w2T1K-0003hI-QO
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Mar 2026 11:55:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=J8PIWe9d3gwfMwbgyToh6mdpitWP4fOFw/Ta2BFIElQ=; b=SSAjKNB5M1WBRi/ZYX2IKPwcZg
 VoYr3fJTwbA79hTDmg/VKmFoodjD8dXgPPjCnJQQNR7A6uxecTjWkztifwVfKAJNV1wWTBokbR8VR
 9hePvCtu3yiMkC8oeQg2caQUOFMnBP0S3wbvVcfnRFwEEJBfZ1ii6AZG4KwLBTTqRUQY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=J8PIWe9d3gwfMwbgyToh6mdpitWP4fOFw/Ta2BFIElQ=; b=jsYhyyY9tZo7DiqKWKc8Hiuu3C
 h6aqwOvvJyNYt/VTi5WdO8a14awfM3qTlJt5gZ6c/DsMjBPrXttaggIvESRZItAzEjiFaQhltk+QJ
 tNMwVhr/yO2BpoZNXJUId8djxSddl17NqzFWLJbMCJSxZriMtT/rP4aCoiez3yU7YHy0=;
Received: from r3-25.sinamail.sina.com.cn ([202.108.3.25])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1w2T1J-0004VC-T7 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Mar 2026 11:55:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1773748534; bh=J8PIWe9d3gwfMwbgyToh6mdpitWP4fOFw/Ta2BFIElQ=;
 h=From:Subject:Date:Message-ID;
 b=BRFpgtC0iaX81hFBzLB2EHFJwOGQcTmOi0T4Z8HRwr1KSKoQOiPXtPg8hyNAEEwNZ
 T5ZHUGgn7KDZgJmMuPaZY6vMeanLZQJCpnudq/AlYPtZ2rJD7n6QQnWDPyVNwio5nl
 z4JSw53bRSStkPEmleLDRaMA12gubWhkt6zv64lY=
X-SMAIL-HELO: xiaomi-ThinkCentre-M760t.mioffice.cn
Received: from unknown (HELO
 xiaomi-ThinkCentre-M760t.mioffice.cn)([114.247.175.249])
 by sina.com (10.54.253.31) with ESMTP
 id 69B9411A000012B1; Tue, 17 Mar 2026 19:55:24 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 9475926816029
X-SMAIL-UIID: 033512976C564778B3073F7F1C169ECE-20260317-195524-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Tue, 17 Mar 2026 19:55:01 +0800
Message-ID: <20260317115459.208306-6-monty_pavel@sina.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260317115459.208306-2-monty_pavel@sina.com>
References: <20260317115459.208306-2-monty_pavel@sina.com>
MIME-Version: 1.0
X-Headers-End: 1w2T1J-0004VC-T7
Subject: [f2fs-dev] [PATCH v4 3/4] f2fs: fix fsck inconsistency caused by
 FGGC of node block
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

During FGGC node block migration, fsck may incorrectly treat the
migrated node block as fsync-written data.

The reproduction scenario:
root@vm:/mnt/f2fs# seq 1 2048 | xargs -n 1 ./test_sync // write inline inode and sync
root@vm:/mnt/f2fs# rm -f 1
root@vm:/mnt/f2fs# sync
root@vm:/mnt/f2fs# f2fs_io gc_range // move data block in sync mode and not write CP
  SPO, "fsck --dry-run" find inode has already checkpointed but still
  with DENT_BIT_SHIFT set

The root cause is that GC does not clear the dentry mark and fsync mark
during node block migration, leading fsck to misinterpret them as
user-issued fsync writes.

In BGGC mode, node block migration is handled by f2fs_sync_node_pages(),
which guarantees the dentry and fsync marks are cleared before writing.

This patch move the set/clear of the fsync|dentry marks into
__write_node_folio to make the logic clearer, and ensures the
fsync|dentry mark is cleared in FGGC.

Fixes: da011cc0da8c ("f2fs: move node pages only in victim section during GC")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
v4:
- Move the set/clear of the fsync|dentry marks into __write_node_folio().
v3:
- Clearing fsync|dentry marks in f2fs_write_single_node_folio() for FGGC.
---
 fs/f2fs/node.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3c862d8ed3d9..0151dc4895d6 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1732,9 +1732,10 @@ static struct folio *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 	return last_folio;
 }
 
-static bool __write_node_folio(struct folio *folio, bool atomic, bool *submitted,
-				struct writeback_control *wbc, bool do_balance,
-				enum iostat_type io_type, unsigned int *seq_id)
+static bool __write_node_folio(struct folio *folio, bool atomic, bool do_fsync,
+				bool *submitted, struct writeback_control *wbc,
+				bool do_balance, enum iostat_type io_type,
+				unsigned int *seq_id)
 {
 	struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
 	nid_t nid;
@@ -1807,6 +1808,8 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool *submitted
 	if (atomic && !test_opt(sbi, NOBARRIER))
 		fio.op_flags |= REQ_PREFLUSH | REQ_FUA;
 
+	set_dentry_mark(folio, false);
+	set_fsync_mark(folio, do_fsync);
 	if (IS_INODE(folio) && (atomic || is_fsync_dnode(folio)))
 		set_dentry_mark(folio,
 				f2fs_need_dentry_mark(sbi, ino_of_node(folio)));
@@ -1873,7 +1876,7 @@ int f2fs_write_single_node_folio(struct folio *node_folio, int sync_mode,
 		goto out_folio;
 	}
 
-	if (!__write_node_folio(node_folio, false, NULL,
+	if (!__write_node_folio(node_folio, false, false, NULL,
 				&wbc, false, FS_GC_NODE_IO, NULL))
 		err = -EAGAIN;
 	goto release_folio;
@@ -1920,6 +1923,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 		for (i = 0; i < nr_folios; i++) {
 			struct folio *folio = fbatch.folios[i];
 			bool submitted = false;
+			bool do_fsync = false;
 
 			if (unlikely(f2fs_cp_error(sbi))) {
 				f2fs_folio_put(last_folio, false);
@@ -1950,11 +1954,8 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 
 			f2fs_folio_wait_writeback(folio, NODE, true, true);
 
-			set_fsync_mark(folio, 0);
-			set_dentry_mark(folio, 0);
-
 			if (!atomic || folio == last_folio) {
-				set_fsync_mark(folio, 1);
+				do_fsync = true;
 				percpu_counter_inc(&sbi->rf_node_block_count);
 				if (IS_INODE(folio)) {
 					if (is_inode_flag_set(inode,
@@ -1971,8 +1972,9 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 
 			if (!__write_node_folio(folio, atomic &&
 						folio == last_folio,
-						&submitted, wbc, true,
-						FS_NODE_IO, seq_id)) {
+						do_fsync, &submitted,
+						wbc, true, FS_NODE_IO,
+						seq_id)) {
 				f2fs_folio_put(last_folio, false);
 				folio_batch_release(&fbatch);
 				ret = -EIO;
@@ -2172,10 +2174,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			if (!folio_clear_dirty_for_io(folio))
 				goto continue_unlock;
 
-			set_fsync_mark(folio, 0);
-			set_dentry_mark(folio, 0);
-
-			if (!__write_node_folio(folio, false, &submitted,
+			if (!__write_node_folio(folio, false, false, &submitted,
 					wbc, do_balance, io_type, NULL)) {
 				folio_batch_release(&fbatch);
 				ret = -EIO;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
