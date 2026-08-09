Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E80C5AD2C
	for <linux-f2fs-devel@archiver.kernel.org>; Sun,  9 Aug 2026 01:26:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LDLl/faRflxJwCScqCAfUUvch3J+Ps1l8ksH+fHoDDI=; b=fy/dyHd1KueNBqn56u3ADxVWMz
	Kl7uszGyYfNed6jcw9i5Aze0g4zxB/1y184Zd5kuB7nwnb4vKQDYeiYxCrljuWlEiwfn18a27LKTu
	/uD2lv1vkV1l4mvAKo+b1Paw/wsTd3cwBR/1T0uyF4lg0elcIX2P2eVnEllm4OvhEHYs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wssJR-0004RF-1X;
	Sun, 09 Aug 2026 01:26:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wssJP-0004R7-LP
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 01:26:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GdyR95RgyXNdZtaoq952nJ4CVYObk7LTzOIlLzQE7oY=; b=kXoJMOvDAVze7ydNPEJmXU/kq1
 ZI3rO2TypQdjwakYo8smZwrOYUomOus9+Nrbdv1fYx1+44FOGiq83CHOT3LxRTyC5RZ5RAZlnux2j
 6g2q1231m/bhMbNkme2us9wX1N0pzKE7EYR/UuL1oNJHOgZwt8PFe88ayCAH6liyVdSg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GdyR95RgyXNdZtaoq952nJ4CVYObk7LTzOIlLzQE7oY=; b=DnlqfXu18dtOPuPqYLTemAzqXM
 DRj4CTbCFh254Lr06BolFfogaAZKPbhxQLRdDHnbfiPVNCfSd5fxF1a0PZ8y7xnBTdgwe7zSy8lC1
 LulrANqRg8wFWFq0PPP4o61Y2zm6yNZfWe5dPkf8/gIzh9P4p++Zww6eH5YeeZtIjbEc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wssJT-00055j-83 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 09 Aug 2026 01:26:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1B2AC60008
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun,  9 Aug 2026 01:26:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4A531F00A3D;
 Sun,  9 Aug 2026 01:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786238805;
 bh=GdyR95RgyXNdZtaoq952nJ4CVYObk7LTzOIlLzQE7oY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References;
 b=nK4CLs6OdPCvRlXBuEZC3AlYFEbPg6RUWXCAPji55t/VlEimtfSYx0feOIdiVwIIu
 TNyKInxIMSNYixxmzFjU6eo9movg6sH6pVzhzQOpmF8mqL0kgiq9rUIvJ566vUkrrU
 1YaW8pywA1LiVYWX5EzjrK1gPFiFSWqT8iAB82awMAcgP5DZNbZjjb4SwFcgCPVd/1
 Wry/9Nd8vd6uFW63GXLBjjrO2TT3E+3kAtnV/A5VngZXrOo+NIVRKPPcY6A1XCNX2q
 oTjbW3rJ78k1Rq+rlOwURqRRKxOvGWpUAGuSfTcKRTuSuoZZQO/CCO63sSBBmnw9uD
 l9tCoP7Le95kA==
To: jaegeuk@kernel.org
Date: Sun,  9 Aug 2026 09:26:39 +0800
Message-ID: <20260809012639.568485-2-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
In-Reply-To: <20260809012639.568485-1-chao@kernel.org>
References: <20260809012639.568485-1-chao@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1wssJT-00055j-83
Subject: [f2fs-dev] [PATCH v2 2/2] f2fs: reduce memory footprint of ino
 management
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Currently, ino entries for APPEND_INO, UPDATE_INO, TRANS_DIR_INO, and
XATTR_DIR_INO allocate a 'struct ino_entry' slab object and attach it to
both a list and a radix tree solely for existence checks via
f2fs_exist_written_data().

Since these ino types only track binary existence status, we can embed
the information directly into radix tree value entries as a bitmap:

- The Linux radix tree/XArray supports in-place value entries via
  xa_mk_value() / xa_to_value(), which tag the least significant bit
  to store an unallocated integer value of BITS_PER_XA_VALUE bits
  (BITS_PER_LONG - 1) directly in the slot pointer.
- For each inode, (ino / BITS_PER_XA_VALUE) serves as the radix tree
  slot index, and (ino % BITS_PER_XA_VALUE) is used as the bit offset
  within the slot's bitmap.

For example, when tracking ino = 7:
- Before: Allocate a 'struct ino_entry' ({ .ino = 7 }), insert its
  pointer into the radix tree at index = 7, and link it to im->ino_list.
- After: Compute slot_index = 7 / BITS_PER_XA_VALUE (index 0) and
  bit_offset = 7 % BITS_PER_XA_VALUE (bit 7), then set bit 7 in the
  value entry via xa_mk_value(bitmap) at index 0, without allocating
  a slab object or linking to a list.

Additionally:
- In-place slot updates are performed via radix_tree_replace_slot(), and
  slots are deleted with radix_tree_delete() once the bitmap is zeroed.
- Reorder the ino list enum so ORPHAN_INO and FLUSH_INO (which still
  require struct ino_entry and list traversal) remain separated, while
  bitmap-based trees are torn down using xa_destroy().

This eliminates 'struct ino_entry' slab allocations and linked-list
tracking for these ino types, significantly reducing memory consumption.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- fix to call __remove_ino_entry correctly for FLUSH_INO
 fs/f2fs/checkpoint.c | 99 ++++++++++++++++++++++++++++++++++++++++----
 fs/f2fs/f2fs.h       |  6 ++-
 2 files changed, 95 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index eb2f955b1e2a..f81ba8cc861a 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -766,6 +766,64 @@ static void __remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
 	spin_unlock(&im->ino_lock);
 }
 
+static void __set_ino_bitmap(struct f2fs_sb_info *sbi, nid_t ino, int type)
+{
+	struct inode_management *im = &sbi->im[type];
+	unsigned long index = INO_SLOT_INDEX(ino);
+	unsigned int ofs = INO_BIT_OFFSET(ino);
+	void **slot, *entry;
+	unsigned long bitmap = 0;
+	int ret;
+
+	ret = radix_tree_preload(GFP_NOFS | __GFP_NOFAIL);
+	f2fs_bug_on(sbi, ret);
+
+	spin_lock(&im->ino_lock);
+	slot = radix_tree_lookup_slot(&im->ino_root, index);
+	if (slot) {
+		entry = radix_tree_deref_slot(slot);
+		bitmap = xa_to_value(entry);
+		if (!(bitmap & (1UL << ofs))) {
+			bitmap |= (1UL << ofs);
+			entry = xa_mk_value(bitmap);
+			radix_tree_replace_slot(&im->ino_root, slot, entry);
+		}
+	} else {
+		bitmap |= (1UL << ofs);
+		entry = xa_mk_value(bitmap);
+		if (unlikely(radix_tree_insert(&im->ino_root, index, entry)))
+			f2fs_bug_on(sbi, 1);
+	}
+	spin_unlock(&im->ino_lock);
+	radix_tree_preload_end();
+}
+
+static void __clear_ino_bitmap(struct f2fs_sb_info *sbi, nid_t ino, int type)
+{
+	struct inode_management *im = &sbi->im[type];
+	unsigned long index = INO_SLOT_INDEX(ino);
+	unsigned int ofs = INO_BIT_OFFSET(ino);
+	void **slot, *entry;
+	unsigned long bitmap;
+
+	spin_lock(&im->ino_lock);
+	slot = radix_tree_lookup_slot(&im->ino_root, index);
+	if (slot) {
+		entry = radix_tree_deref_slot(slot);
+		bitmap = xa_to_value(entry);
+		if (bitmap & (1UL << ofs))
+			bitmap &= ~(1UL << ofs);
+
+		if (bitmap) {
+			entry = xa_mk_value(bitmap);
+			radix_tree_replace_slot(&im->ino_root, slot, entry);
+		} else {
+			radix_tree_delete(&im->ino_root, index);
+		}
+	}
+	spin_unlock(&im->ino_lock);
+}
+
 static void f2fs_wait_for_inode_record(struct f2fs_sb_info *sbi, int mode)
 {
 	if (mode != APPEND_INO && mode != UPDATE_INO)
@@ -778,8 +836,10 @@ static void f2fs_wait_for_inode_record(struct f2fs_sb_info *sbi, int mode)
 static void __f2fs_add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino,
 					unsigned int devidx, int type)
 {
-	/* add new dirty ino entry into list */
-	__add_ino_entry(sbi, ino, devidx, type);
+	if (type <= FLUSH_INO)
+		__add_ino_entry(sbi, ino, devidx, type);
+	else
+		__set_ino_bitmap(sbi, ino, type);
 }
 
 void f2fs_add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
@@ -789,20 +849,33 @@ void f2fs_add_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
 
 void f2fs_remove_ino_entry(struct f2fs_sb_info *sbi, nid_t ino, int type)
 {
-	/* remove dirty ino entry from list */
-	__remove_ino_entry(sbi, ino, type);
+	if (type <= FLUSH_INO)
+		__remove_ino_entry(sbi, ino, type);
+	else
+		__clear_ino_bitmap(sbi, ino, type);
 }
 
-/* mode should be APPEND_INO, UPDATE_INO or TRANS_DIR_INO */
+/* mode should be APPEND_INO, UPDATE_INO, TRANS_DIR_INO and XATTR_DIR_INO */
 bool f2fs_exist_written_data(struct f2fs_sb_info *sbi, nid_t ino, int mode)
 {
 	struct inode_management *im = &sbi->im[mode];
-	struct ino_entry *e;
+	unsigned long index = INO_SLOT_INDEX(ino);
+	unsigned int ofs = INO_BIT_OFFSET(ino);
+	void *entry;
+	unsigned long bitmap;
+
+	f2fs_bug_on(sbi, mode <= FLUSH_INO);
 
 	spin_lock(&im->ino_lock);
-	e = radix_tree_lookup(&im->ino_root, ino);
+	entry = radix_tree_lookup(&im->ino_root, index);
+	if (!entry) {
+		spin_unlock(&im->ino_lock);
+		return false;
+	}
+	bitmap = xa_to_value(entry);
 	spin_unlock(&im->ino_lock);
-	return e ? true : false;
+
+	return bitmap & (1UL << ofs);
 }
 
 void f2fs_release_ino_entry(struct f2fs_sb_info *sbi, bool all)
@@ -810,7 +883,7 @@ void f2fs_release_ino_entry(struct f2fs_sb_info *sbi, bool all)
 	struct ino_entry *e, *tmp;
 	int i;
 
-	for (i = all ? ORPHAN_INO : APPEND_INO; i < MAX_INO_ENTRY; i++) {
+	for (i = all ? ORPHAN_INO : FLUSH_INO; i <= FLUSH_INO; i++) {
 		struct inode_management *im = &sbi->im[i];
 
 		f2fs_wait_for_inode_record(sbi, i);
@@ -824,6 +897,14 @@ void f2fs_release_ino_entry(struct f2fs_sb_info *sbi, bool all)
 		}
 		spin_unlock(&im->ino_lock);
 	}
+
+	for (i = APPEND_INO; i < MAX_INO_ENTRY; i++) {
+		struct inode_management *im = &sbi->im[i];
+
+		spin_lock(&im->ino_lock);
+		xa_destroy(&im->ino_root);
+		spin_unlock(&im->ino_lock);
+	}
 }
 
 void f2fs_set_dirty_device(struct f2fs_sb_info *sbi, nid_t ino,
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 160e7db0674e..5ae2d347c3ce 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -389,14 +389,18 @@ enum {
 /* for the list of ino */
 enum {
 	ORPHAN_INO,		/* for orphan ino list */
+	FLUSH_INO,		/* for multiple device flushing */
 	APPEND_INO,		/* for append ino list */
 	UPDATE_INO,		/* for update ino list */
 	TRANS_DIR_INO,		/* for transactions dir ino list */
 	XATTR_DIR_INO,		/* for xattr updated dir ino list */
-	FLUSH_INO,		/* for multiple device flushing */
 	MAX_INO_ENTRY,		/* max. list */
 };
 
+#define INO_BITS_PER_SLOT	BITS_PER_XA_VALUE
+#define INO_SLOT_INDEX(ino)	((ino) / INO_BITS_PER_SLOT)
+#define INO_BIT_OFFSET(ino)	((ino) % INO_BITS_PER_SLOT)
+
 struct ino_entry {
 	struct list_head list;		/* list head */
 	nid_t ino;			/* inode number */
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
