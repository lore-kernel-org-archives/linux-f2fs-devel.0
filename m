Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0822C79FAD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  9 Sep 2026 05:06:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xpqFijLYWtJh5x47DbAT2J3Tv3jP4dYPicfaPFbLgpk=; b=GWbYVTcP1yo6Tt/B68dyYO8NHz
	an5+uIuabiYPnTQFAqJpttrpl4ZJ/qNqSGozlM43MTPk+dS56QKaGai/RUYOk1cRSdpmDJX4ojzFO
	lWdzp7kJv/RewA3aqfrRbLW6hYCatKUWbVv8Tww4d//WBOToWK8o8pWN4zNdOefaxuWs=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4AVp-0002XX-7o;
	Wed, 09 Sep 2026 05:06:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x4AVm-0002XF-3E
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 05:06:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=RsDvgoKPbc7IZI/Q1CUq25bFvbIrJS4QZ3Ki/H0ZJXM=; b=Rylas19JZ8pYmK+mfg2ztJYqgg
 JZKIkOKPzZ/WzL/ZF7Ya65gYUljtUgj0MQlKy7qjj2au7zuAhaq5U1SNga7oTFB1ZQ5E4evLZ/zQc
 9Q+tlBXyp1v5BrZ9ibPzNSadKgDHbWiJRLgnbeVHTfj9MxTc03UCI1x2RK4dSdaG+OK4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=RsDvgoKPbc7IZI/Q1CUq25bFvbIrJS4QZ3Ki/H0ZJXM=; b=C
 rZLNSkbF0nC7QO3UF3liqyEMEhFskAHRel5aIXDdZiosvIq/dBsBynxW0F9k+DBAXdkbcawv21Gz5
 mjLi5FwCa0xlRt234Dso9iAEbI/Ovpoi4Z3kEUtffZmQNX/8ga2ld+189kAkgApo4Mtb+it8UiztG
 8zEw4q84tI0xg0tI=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4AVl-0003Ub-En for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 09 Sep 2026 05:06:18 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id A3F1F601FB
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed,  9 Sep 2026 05:06:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6B881F00A3A;
 Wed,  9 Sep 2026 05:06:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788930371;
 bh=RsDvgoKPbc7IZI/Q1CUq25bFvbIrJS4QZ3Ki/H0ZJXM=;
 h=From:To:Cc:Subject:Date;
 b=HwNngrbnAXt5/yrEeOcyXipgjTWA1ev2eLhIX/TIZRLJrV3MPA+WVnl6FvC7IVOPe
 zaIJqn3oFQGGNyjviIt5NFJ3kFN4CU8hwH8eRft4CsKay697pPlbpWJmT43+7EIFtf
 g8kb39ccPdCL6QK9JIMRbwLNqLTDsQlanWrAqXM7tfEr42oJcN7/AUzFXZ69RyuqCC
 eLAF7OARHIYrJUNvnV7Ir/3Nf994FPHN0Ni3Fu1o6fL8Gxe/FWlTTdvQ0BXzYhDgfD
 LKOY8HmVgUJf0n9sp7f9vcVSVHIJAPCq9kW3cO2pFt8umqZGrAh3ba01gdUCFvmTVT
 5S0GTuezSeMOg==
To: jaegeuk@kernel.org
Date: Wed,  9 Sep 2026 13:06:04 +0800
Message-ID: <20260909050604.3513016-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.979.g7e5102b832-goog
MIME-Version: 1.0
X-Headers-End: 1x4AVl-0003Ub-En
Subject: [f2fs-dev] [PATCH] fsck.f2fs: fix to maintain ckpt_valid_blocks
 correctly
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

When need_fsync_data_record() is true (e.g. after sudden power-off or
shutdown), get_seg_vblocks() returns se->ckpt_valid_blocks.

In reserve_new_block(), se->ckpt_valid_blocks is correctly incremented
along with setting the bit in se->ckpt_valid_map. However, in
update_block() and release_block(), while se->ckpt_valid_map is updated,
se->ckpt_valid_blocks is never incremented or decremented.

As a result, if blocks in an empty segment are newly allocated or migrated
by fsck (e.g. during quota rebuild), se->ckpt_valid_blocks remains 0.
Subsequent calls to get_seg_vblocks() will treat the segment as completely
empty, leading to false free segment detection or incorrect section reuse.

Fix this by maintaining se->ckpt_valid_blocks alongside se->ckpt_valid_map
in update_block() and release_block().

Fixes: 10dad5ed7ce1 ("f2fs-tools: support zoned ufs devices")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fsck/fsck.c    | 4 +++-
 fsck/segment.c | 8 ++++++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/fsck/fsck.c b/fsck/fsck.c
index e47f7be..a56c16b 100644
--- a/fsck/fsck.c
+++ b/fsck/fsck.c
@@ -3262,8 +3262,10 @@ static inline void release_block(struct f2fs_sb_info *sbi, u64 blkaddr,
 		offset = OFFSET_IN_SEG(sbi, blkaddr);
 		se->valid_blocks--;
 		f2fs_clear_bit(offset, (char *)se->cur_valid_map);
-		if (need_fsync_data_record(sbi))
+		if (need_fsync_data_record(sbi)) {
 			f2fs_clear_bit(offset, (char *)se->ckpt_valid_map);
+			se->ckpt_valid_blocks--;
+		}
 		se->dirty = 1;
 		f2fs_clear_sit_bitmap(sbi, blkaddr);
 	}
diff --git a/fsck/segment.c b/fsck/segment.c
index 9f3fa0c..ee66a8e 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -798,8 +798,10 @@ int update_block(struct f2fs_sb_info *sbi, void *buf, u32 *blkaddr,
 	}
 	se->valid_blocks--;
 	f2fs_clear_bit(offset, (char *)se->cur_valid_map);
-	if (need_fsync_data_record(sbi))
+	if (need_fsync_data_record(sbi)) {
 		f2fs_clear_bit(offset, (char *)se->ckpt_valid_map);
+		se->ckpt_valid_blocks--;
+	}
 	se->dirty = 1;
 	f2fs_clear_main_bitmap(sbi, old_blkaddr);
 	f2fs_clear_sit_bitmap(sbi, old_blkaddr);
@@ -821,8 +823,10 @@ int update_block(struct f2fs_sb_info *sbi, void *buf, u32 *blkaddr,
 	se->type = se->orig_type = type;
 	se->valid_blocks++;
 	f2fs_set_bit(offset, (char *)se->cur_valid_map);
-	if (need_fsync_data_record(sbi))
+	if (need_fsync_data_record(sbi)) {
 		f2fs_set_bit(offset, (char *)se->ckpt_valid_map);
+		se->ckpt_valid_blocks++;
+	}
 	se->dirty = 1;
 	f2fs_set_main_bitmap(sbi, new_blkaddr, type);
 	f2fs_set_sit_bitmap(sbi, new_blkaddr);
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
