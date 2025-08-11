Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8F6FC87FDB
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 11 Aug 2025 11:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hG4vdfEUJjB+ROylXYnoKOETuzg3mIdYgDWyuG4lChU=; b=D2CyeKjXfRxzlMIN57p5mIFJSH
	3vm+pA/BOgPUaiv5wi5rZjTTREvaEQORvNeaAF7trQZrt31wgvHrsndkJ4qMQo1ehzdw7HvfRroym
	REN7XpsSV64Tuu6UijFKy+yHiFFxUPc02qUKIO49VkVS3lOcG6RuOl20m53J26RW5wF4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ulQuR-0002M6-Nn;
	Mon, 11 Aug 2025 11:41:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ulQuQ-0002Lz-GG
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 Aug 2025 11:41:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OPd+VF73R/CUjKTNBmI2w7JtDho6lq0UPnbxo4cjt54=; b=P1H52CDhBT1eShdExI4fXT/w5U
 jNfFaR3RcnUvNOid97b+zpOGI0pIkgffUuOUsGCByY93lq/W9ewoR56CBdkyKMmTcs8YXjFkqKS/+
 eSO0qM0K8wQ8IZGuL95ERR0f6tHENp5RDKd4SDmU+6XY3aAc0TD3nb7e5Pmw1CdMr2YI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=OPd+VF73R/CUjKTNBmI2w7JtDho6lq0UPnbxo4cjt54=; b=V
 0+P7lOGJBmqfL+QfEBBXc/A7F8aZFeqeOujdmfRQbl9+RPlY6Lj7iw78NwnA5dhU0EG2x8puoKT3S
 QpVd4cjD1dEEmHBDZQIpBLY3Utd3QUNj5ED/y+5HLF9XJnJfb61OxnLkkvCc/SFzRzIb8b05nNrKE
 f+vqxcEfJjzTUSPs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ulQuQ-0007OE-3W for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 11 Aug 2025 11:41:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id C952345C4B
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 11 Aug 2025 11:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6D1EC4CEED;
 Mon, 11 Aug 2025 11:41:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1754912495;
 bh=51wNWVQOpou5wJgNNVWp3dJSjpKJGs0ljeNl9exowZw=;
 h=From:To:Cc:Subject:Date:From;
 b=at4UkOvhu5/i7kf4YTbu5G2eSt2vGZBwHhKkQcF2G3siDcTHHe+4CeujfX1t1SEeD
 K5fhszitucY9WZVpI1WMTlRivcDhEcAN3j+Knns6ejx7ZxKqD922Xpaz9FWLLXK0+c
 QiWEro5wWqDmOdpCh1dQeU5VQULyGzlArOPfjbi+dpX7RNg/bDD5AT7XQUQuGipdXa
 n2Mz/YhTq9CUSrzlnrhFFtlecaEjL4PIJOPZmjY9SPJNHwj1Q8u2NWxFD98fQn6yeL
 /uziq4A8HKR7sbUQCDOMt+sbO//okPwM32lLQ3wVYkoaWY0aXiLvyCxWViDZbIKUvh
 1Q6pJbsDM2jxQ==
To: jaegeuk@kernel.org
Date: Mon, 11 Aug 2025 19:41:23 +0800
Message-ID: <20250811114123.1085143-1-chao@kernel.org>
X-Mailer: git-send-email 2.50.1.703.g449372360f-goog
MIME-Version: 1.0
X-Headers-End: 1ulQuQ-0007OE-3W
Subject: [f2fs-dev] [PATCH] f2fs: clean up w/ get_left_section_blocks()
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

Introduce get_left_section_blocks() for cleanup, no logic changes.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/segment.h | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/segment.h b/fs/f2fs/segment.h
index fdc2c34daa47..36427fdd6b15 100644
--- a/fs/f2fs/segment.h
+++ b/fs/f2fs/segment.h
@@ -600,6 +600,16 @@ static inline int reserved_sections(struct f2fs_sb_info *sbi)
 	return GET_SEC_FROM_SEG(sbi, reserved_segments(sbi));
 }
 
+static inline unsigned int get_left_section_blocks(struct f2fs_sb_info *sbi,
+					enum log_type type, unsigned int segno)
+{
+	if (f2fs_lfs_mode(sbi) && __is_large_section(sbi))
+		return CAP_BLKS_PER_SEC(sbi) - SEGS_TO_BLKS(sbi,
+			(segno - GET_START_SEG_FROM_SEC(sbi, segno))) -
+			CURSEG_I(sbi, type)->next_blkoff;
+	return CAP_BLKS_PER_SEC(sbi) - get_ckpt_valid_blocks(sbi, segno, true);
+}
+
 static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 			unsigned int node_blocks, unsigned int data_blocks,
 			unsigned int dent_blocks)
@@ -614,14 +624,7 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 		if (unlikely(segno == NULL_SEGNO))
 			return false;
 
-		if (f2fs_lfs_mode(sbi) && __is_large_section(sbi)) {
-			left_blocks = CAP_BLKS_PER_SEC(sbi) -
-				SEGS_TO_BLKS(sbi, (segno - GET_START_SEG_FROM_SEC(sbi, segno))) -
-				CURSEG_I(sbi, i)->next_blkoff;
-		} else {
-			left_blocks = CAP_BLKS_PER_SEC(sbi) -
-					get_ckpt_valid_blocks(sbi, segno, true);
-		}
+		left_blocks = get_left_section_blocks(sbi, i, segno);
 
 		blocks = i <= CURSEG_COLD_DATA ? data_blocks : node_blocks;
 		if (blocks > left_blocks)
@@ -634,14 +637,7 @@ static inline bool has_curseg_enough_space(struct f2fs_sb_info *sbi,
 	if (unlikely(segno == NULL_SEGNO))
 		return false;
 
-	if (f2fs_lfs_mode(sbi) && __is_large_section(sbi)) {
-		left_blocks = CAP_BLKS_PER_SEC(sbi) -
-				SEGS_TO_BLKS(sbi, (segno - GET_START_SEG_FROM_SEC(sbi, segno))) -
-				CURSEG_I(sbi, CURSEG_HOT_DATA)->next_blkoff;
-	} else {
-		left_blocks = CAP_BLKS_PER_SEC(sbi) -
-				get_ckpt_valid_blocks(sbi, segno, true);
-	}
+	left_blocks = get_left_section_blocks(sbi, CURSEG_HOT_DATA, segno);
 
 	if (dent_blocks + data_blocks > left_blocks)
 		return false;
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
