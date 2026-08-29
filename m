Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CCC9BC61DB9
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 29 Aug 2026 03:17:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lAy+PhJjA8Ptwf+QYQvaxk+FFGPZ6aX9c5uUEHPsHtE=; b=IVG2vAhj843RUwKxfDi53mhlvE
	j4YH6G1quc/xvswVWNSGUP5Y4CtrjnJQjX/EGXLSnaSfyZPfcOeT0/aOCbQpfxD/uEN75neZMfHnK
	6PQxO+rXF8ifMGVgLpj5gsU8qJnQcurttEf2fmT9O0pjpF/oKLccyX6DgxIikCFoQjNU=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x09ZV-00028d-LP;
	Sat, 29 Aug 2026 03:17:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1x09ZT-00028W-Tp
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 03:17:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=b+pAIvIz0j1h3+ZHONm2U01i3bhktkPsbx0YPPt36+Q=; b=etlpEBOohAGxlstZpYjRsOcp8o
 7oOErP/b9Vf9CASEnS35JbMJvteIJ1xK3gHQtpumnQYa0Fp1QlBRt0S5D0JP90BSIfjFxg0HWPBfS
 5GwXeg91JuXdOdgDZQl2wXh9sQn9CZMPTxuP5q5m4QrFh4EXfVbyQy8mTTciGrHloTtk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=b+pAIvIz0j1h3+ZHONm2U01i3bhktkPsbx0YPPt36+Q=; b=Z
 AHma6/iMosPoXcEYq1hbRgsd3bRwhHBs5KSERyfmeTyATG/6wsNPPwgC1XCU9S1K3+XT1tItJbJRf
 Wk6KO509K5nfPAucNuZ/EfxHb/CFdddz/zRhx5oNQwg4j8TSrJta6HRsrfWGqsBJAk1FB3/K4dIS3
 QTwgqGWGGGM5AiP8=;
Received: from mail-pl1-f177.google.com ([209.85.214.177])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x09ZT-0005Bn-QE for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 29 Aug 2026 03:17:32 +0000
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2d6e954afbdso11630295ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 28 Aug 2026 20:17:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787973446; x=1788578246; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=b+pAIvIz0j1h3+ZHONm2U01i3bhktkPsbx0YPPt36+Q=;
 b=gIS6EToI3Gi/+aK05/C8kXxTRzdYbefAbwNjLeixJF94KlKKoIyQnOKL5zDf2x+jxq
 iSeOyCWTaL7w9/g2ImvSqlBMSiv3wUw8tQak+jZea5b8NldwFCJlT87DHWKFNFA/SSEI
 fFR47H9O5+OpcTnYHHBgw7GvUz14KwHVfdbipbcJNM65wusiWqiueZRWv4HwAeWIy2bk
 5UhsEJZZNvowP09n3vEIL5i13vwoaiOwaAtOZ3NcKDtVjX6NvcSHUsu7u/1WlJVjRC4J
 FcQpf868y4k/ICs6sp7H6FnH4u6LSMwR6YfIkwvOolhadcvfeB7Yx37eCpP5XZOpvVg8
 wXeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787973446; x=1788578246;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=b+pAIvIz0j1h3+ZHONm2U01i3bhktkPsbx0YPPt36+Q=;
 b=SPTg77GzScQXbYfRoHnoy3DBJEGM4LwzqbhyjQ8DsefIekcPCgttUzHNQ7lUQ+e/nE
 rpQFlesfQiGF18Qz/25iMc6HUO0ofMZnios9vL5sXPDUKB4vScY1n6cb4znUcONJnrfA
 uaReiVXR1c9lY2Bwm2b4yz19YHTSDSZTNbHrckq/y9iNSi8RAwueQ7vPM1MSowMvIFuI
 S70knoSdvCWkz9qhWODy2Udh4WAknHCSSAFSvYfYGIjZ9CWRv5aZRqcBFQV/eDKTiRj2
 gvnLgtRYqkfCAcqrwmGndRGgGPVYli4XSBC711olYy5Ne+OGdmI3Qsz2P3UJtafxS5L8
 dwrA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz6279YBusX32hn2u7wvGVO17Ttcwxy+Jt6Pt+Ee7oZ/h3eS5dKsD9iEWnuuP80mVQfdPt7Xh4eyJ/FoXNmTzMs@lists.sourceforge.net
X-Gm-Message-State: AFuF++k43YJUvYnU6mggci+8lklE8oMgV+Wb17cInpbAAZwqIk2QRvtd
 qxhJqS12jAQVMO38Fe9LN9i8lRIi9j4GB7m90sXdAJXp+SUc8kvSHPBI
X-Gm-Gg: AYBFou01CTrok8HvBGgzx8rZouolUsDIxWoGZ4nCrkrWIYRMLYg9Rd40wINbSvhd8XT
 K0O54AXgHhpsIjM9r958+Ct6u42kaHALnBSvBe7bmrBE5F4gmuFQclZn4Ru7OtxYDjxnAsxpoRy
 cALDPHlG+hG/PcC3DmWIsmifDPFSKrCpHIKqGdn3wceQsKyGvc8xvclBLGlLqBgAUYXd4m1fnIE
 UlVviLKWduAQl0AvK0+dxF18G8TdAazlptZ4exQITA81VpbiSOWtlF1NbzWGeSWSju2sZDe9ciV
 NySV7gwP1/F1FmqRynIBTG7JtmQ9FiU2xcEJHLfmplNPYIiGnop5zviqwVZkI4df2TuD94XWDno
 2PNDyb39XbCB02zePc67s8gBZKm6S0SMbmI6580Yq/TGhjUf5jHcD+dSjoo5u7c+cPssX1RGMvn
 fFmDrL76M75O10FRTEZyH5FOlQHt3+IhZIWSs1mglrviZXCr/zAj66lbWuhw1k9bHDJzx4qxO0+
 Frf5c8ti4tsXXM83odcA0gdNSfgDQlwJww=
X-Received: by 2002:a17:903:3b88:b0:2d8:df44:a5c2 with SMTP id
 d9443c01a7336-2d8df44b118mr42713655ad.20.1787973445964; 
 Fri, 28 Aug 2026 20:17:25 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d75952e015sm11360005ad.23.2026.08.28.20.17.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 20:17:25 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Sat, 29 Aug 2026 11:17:17 +0800
Message-ID: <20260829031717.2581247-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
X-Headers-End: 1x09ZT-0005Bn-QE
Subject: [f2fs-dev] [PATCH v3] f2fs: sync pending discards before reserving
 device alias
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
Cc: daehojeong@google.com, qwjhust@gmail.com, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 qiwenjie@xiaomi.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Releasing a device alias can leave pending discard commands covering
its range. Reserving the alias makes the same blocks valid again. If a
pending command is submitted afterward, __check_sit_bitmap() observes
valid blocks and triggers a BUG.

The reserve ioctl is the ownership transition from F2FS allocation to
external use. While the range is released, normal F2FS allocation
already synchronizes a pending discard before reusing each block. A
release-time drain would also not cover commands generated before a
later reserve, so synchronize the range at the reserve boundary.

Synchronize discard commands for the alias range under sentry_lock
before marking the range valid. Walk overlapping commands instead of
every block, cancel prepared command intervals in bulk, and wait each
submitted command once. Use a 64-bit cursor and exclusive end so a range
ending at 2^32 blocks does not wrap.

Fixes: eae3faf210bd ("f2fs: support dynamic reserve/release for device aliasing")
Cc: stable@vger.kernel.org
Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>
---
Changes since v2:
- Walk overlapping discard commands instead of every filesystem block.
- Use a 64-bit range cursor and exclusive end.
- Make the commit message describe the standalone final change.
- Clarify reserve as the ownership transition to external use.

  kernel BUG at fs/f2fs/segment.c:1228!
  Oops: invalid opcode: 0000 [#1] SMP DEBUG_PAGEALLOC KASAN PTI
  CPU: 1 UID: 0 PID: 79 Comm: f2fs_discard-25
  RIP: 0010:__check_sit_bitmap+0x2e1/0x4e0
  Call Trace:
   __submit_discard_cmd+0x921/0x1140
   __issue_discard_cmd+0x524/0x12f0
   issue_discard_thread+0x686/0xe20

 fs/f2fs/segment.c | 159 +++++++++++++++++++++++++++-------------------
 1 file changed, 94 insertions(+), 65 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 1e7e745be71d..c4fb1e5f9a34 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -1069,26 +1069,6 @@ static bool f2fs_check_discard_tree(struct f2fs_sb_info *sbi)
 	return true;
 }
 
-static struct discard_cmd *__lookup_discard_cmd(struct f2fs_sb_info *sbi,
-						block_t blkaddr)
-{
-	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-	struct rb_node *node = dcc->root.rb_root.rb_node;
-	struct discard_cmd *dc;
-
-	while (node) {
-		dc = rb_entry(node, struct discard_cmd, rb_node);
-
-		if (blkaddr < dc->di.lstart)
-			node = node->rb_left;
-		else if (blkaddr >= dc->di.lstart + dc->di.len)
-			node = node->rb_right;
-		else
-			return dc;
-	}
-	return NULL;
-}
-
 static struct discard_cmd *__lookup_discard_cmd_ret(struct rb_root_cached *root,
 				block_t blkaddr,
 				struct discard_cmd **prev_entry,
@@ -1114,7 +1094,7 @@ static struct discard_cmd *__lookup_discard_cmd_ret(struct rb_root_cached *root,
 
 		if (blkaddr < dc->di.lstart)
 			pnode = &(*pnode)->rb_left;
-		else if (blkaddr >= dc->di.lstart + dc->di.len)
+		else if ((u64)blkaddr >= (u64)dc->di.lstart + dc->di.len)
 			pnode = &(*pnode)->rb_right;
 		else
 			goto lookup_neighbors;
@@ -1472,42 +1452,56 @@ static void __relocate_discard_cmd(struct discard_cmd_control *dcc,
 	list_move_tail(&dc->list, &dcc->pend_list[plist_idx(dc->di.len)]);
 }
 
-static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
-				struct discard_cmd *dc, block_t blkaddr)
+static void __punch_discard_cmd_range(struct f2fs_sb_info *sbi,
+				      struct discard_cmd *dc, block_t lstart,
+				      unsigned int len)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
 	struct discard_info di = dc->di;
+	u64 end = (u64)lstart + len;
+	u64 di_end = (u64)di.lstart + di.len;
 	bool modified = false;
 
-	if (dc->state == D_DONE || dc->di.len == 1) {
+	f2fs_bug_on(sbi, dc->state != D_PREP || !len ||
+		    lstart < di.lstart || end > di_end);
+
+	if (lstart == di.lstart && end == di_end) {
 		__remove_discard_cmd(sbi, dc);
 		return;
 	}
 
 	dcc->undiscard_blks -= di.len;
-
-	if (blkaddr > di.lstart) {
-		dc->di.len = blkaddr - dc->di.lstart;
+	if (lstart > di.lstart) {
+		dc->di.len = lstart - di.lstart;
 		dcc->undiscard_blks += dc->di.len;
 		__relocate_discard_cmd(dcc, dc);
 		modified = true;
 	}
 
-	if (blkaddr < di.lstart + di.len - 1) {
+	if (end < di_end) {
+		block_t right_lstart = (block_t)end;
+		unsigned int right_len = (unsigned int)(di_end - end);
+		block_t right_start = di.start + right_lstart - di.lstart;
+
 		if (modified) {
-			__insert_discard_cmd(sbi, dc->bdev, blkaddr + 1,
-					di.start + blkaddr + 1 - di.lstart,
-					di.lstart + di.len - 1 - blkaddr);
+			__insert_discard_cmd(sbi, dc->bdev, right_lstart,
+					     right_start, right_len);
 		} else {
-			dc->di.lstart++;
-			dc->di.len--;
-			dc->di.start++;
-			dcc->undiscard_blks += dc->di.len;
+			dc->di.lstart = right_lstart;
+			dc->di.start = right_start;
+			dc->di.len = right_len;
+			dcc->undiscard_blks += right_len;
 			__relocate_discard_cmd(dcc, dc);
 		}
 	}
 }
 
+static void __punch_discard_cmd(struct f2fs_sb_info *sbi,
+				struct discard_cmd *dc, block_t blkaddr)
+{
+	__punch_discard_cmd_range(sbi, dc, blkaddr, 1);
+}
+
 static void __update_discard_tree_range(struct f2fs_sb_info *sbi,
 				struct block_device *bdev, block_t lstart,
 				block_t start, block_t len)
@@ -1872,48 +1866,82 @@ static unsigned int __wait_all_discard_cmd(struct f2fs_sb_info *sbi,
 }
 
 /* This should be covered by global mutex, &sit_i->sentry_lock */
-static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi, block_t blkaddr)
+static void f2fs_wait_discard_bios(struct f2fs_sb_info *sbi,
+				   block_t blkaddr, unsigned int len)
 {
 	struct discard_cmd_control *dcc = SM_I(sbi)->dcc_info;
-	struct discard_cmd *dc;
-	bool need_wait = false;
+	u64 cursor = blkaddr;
+	u64 end = cursor + len;
 
-	mutex_lock(&dcc->cmd_lock);
-	dc = __lookup_discard_cmd(sbi, blkaddr);
-#ifdef CONFIG_BLK_DEV_ZONED
-	if (dc && f2fs_sb_has_blkzoned(sbi) && bdev_is_zoned(dc->bdev)) {
-		int devi = f2fs_bdev_index(sbi, dc->bdev);
+	f2fs_bug_on(sbi, end > (u64)U32_MAX + 1);
+
+	while (cursor < end) {
+		struct discard_cmd *prev_dc = NULL, *next_dc = NULL;
+		struct discard_cmd *dc;
+		struct rb_node **insert_p = NULL, *insert_parent = NULL;
+		u64 dc_end, overlap_end;
+		unsigned int overlap_len;
+		bool need_wait = false;
 
-		if (devi < 0) {
+		mutex_lock(&dcc->cmd_lock);
+		dc = __lookup_discard_cmd_ret(&dcc->root, (block_t)cursor,
+					      &prev_dc, &next_dc, &insert_p, &insert_parent);
+		if (!dc)
+			dc = next_dc;
+		if (!dc || (u64)dc->di.lstart >= end) {
 			mutex_unlock(&dcc->cmd_lock);
-			return;
+			break;
 		}
 
-		if (f2fs_blkz_is_seq(sbi, devi, dc->di.start)) {
-			/* force submit zone reset */
-			if (dc->state == D_PREP)
-				__submit_zone_reset_cmd(sbi, dc, REQ_SYNC,
-							&dcc->wait_list, NULL);
-			dc->ref++;
-			mutex_unlock(&dcc->cmd_lock);
-			/* wait zone reset */
-			__wait_one_discard_bio(sbi, dc);
-			return;
+		if (cursor < dc->di.lstart)
+			cursor = dc->di.lstart;
+		dc_end = (u64)dc->di.lstart + dc->di.len;
+		overlap_end = min(end, dc_end);
+		overlap_len = (unsigned int)(overlap_end - cursor);
+
+#ifdef CONFIG_BLK_DEV_ZONED
+		if (f2fs_sb_has_blkzoned(sbi) && bdev_is_zoned(dc->bdev)) {
+			int devi = f2fs_bdev_index(sbi, dc->bdev);
+
+			if (devi < 0) {
+				mutex_unlock(&dcc->cmd_lock);
+				return;
+			}
+
+			if (f2fs_blkz_is_seq(sbi, devi, dc->di.start)) {
+				if (dc->state == D_PREP)
+					__submit_zone_reset_cmd(sbi, dc, REQ_SYNC,
+								&dcc->wait_list, NULL);
+				dc->ref++;
+				need_wait = true;
+			}
 		}
-	}
 #endif
-	if (dc) {
-		if (dc->state == D_PREP) {
-			__punch_discard_cmd(sbi, dc, blkaddr);
-		} else {
-			dc->ref++;
-			need_wait = true;
+		if (!need_wait) {
+			if (dc->state == D_PREP) {
+				if (len == 1)
+					__punch_discard_cmd(sbi, dc,
+							    (block_t)cursor);
+				else
+					__punch_discard_cmd_range(sbi, dc,
+								  (block_t)cursor,
+								  overlap_len);
+			} else {
+				dc->ref++;
+				need_wait = true;
+			}
 		}
+		mutex_unlock(&dcc->cmd_lock);
+		if (need_wait)
+			__wait_one_discard_bio(sbi, dc);
+		cursor = overlap_end;
 	}
-	mutex_unlock(&dcc->cmd_lock);
+}
 
-	if (need_wait)
-		__wait_one_discard_bio(sbi, dc);
+static void f2fs_wait_discard_bio(struct f2fs_sb_info *sbi,
+				  block_t blkaddr)
+{
+	f2fs_wait_discard_bios(sbi, blkaddr, 1);
 }
 
 void f2fs_stop_discard_thread(struct f2fs_sb_info *sbi)
@@ -2684,6 +2712,7 @@ void f2fs_reserve_device_alias(struct f2fs_sb_info *sbi, block_t addr,
 	seg_num = GET_SEGNO(sbi, addr_end) - segno + 1;
 
 	down_write(&sit_i->sentry_lock);
+	f2fs_wait_discard_bios(sbi, addr, len);
 
 	if (seg_num == 1)
 		cnt = len;
-- 
2.43.0


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
