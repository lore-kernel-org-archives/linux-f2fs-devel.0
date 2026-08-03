Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42EB9C55822
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 18:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hUeHMzi7aw4jGHYr6/8W9DWTQZ8PflP5PfHJZu8UR5A=; b=Fsp8Z4Ak0TW4bWYAQ9L9sDImyS
	OrKALMG7jzIlugnklhw8wawcApHhet902xDteXMFH6+FZV4NmU5tTI2Ysuo5/5zs60W70JusHDOnT
	FvAABL0bjK191Jcd09tWkeKJOAtXa245aptuQp0el9Ks3bZoBD9irHaiafqwf54+KsSI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqxI4-0002Of-9p;
	Mon, 03 Aug 2026 18:21:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wqxI2-0002OR-UN
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 18:21:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EDn4UWKobmcKu1/v3Fdz9cNRdvVkcvj9H0wMMoSALPc=; b=YX32frWAYe8CzdwAv7LuOblxCb
 9QwqJDeQWjoMUzGuoM8BDZynhFSRBwI9NZ9xsn8qMD5+Yo8dKUnmT/tYGK65XlCWZT8lzWhwaE/yF
 DDytqB1tezkEi8vCfRKJAc/aDQtEvT07//FoVlL9vZvbbaLMzwcgfLYNvhfHHNQw/kec=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=EDn4UWKobmcKu1/v3Fdz9cNRdvVkcvj9H0wMMoSALPc=; b=R
 FYWdFKrgJkTdDu+81w5F3zmTKQJOVVHeSLDRoJhdKplcUV5cyzZH3DS1Sf9RI8v8uXc6+1iwLzPIZ
 5nDPGVMWZPy6Q13LqMe/DzBbfZpMwNxx/MVeZGHlgTIfyvCAOKsMpTWpoUB9pWF+u5m7lGNAuPIzL
 Yb87rlnTKURqJoko=;
Received: from mail-pj1-f47.google.com ([209.85.216.47])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wqxI3-0005QQ-7s for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 18:21:31 +0000
Received: by mail-pj1-f47.google.com with SMTP id
 98e67ed59e1d1-38e42560ebcso2812254a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 03 Aug 2026 11:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785781285; x=1786386085; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EDn4UWKobmcKu1/v3Fdz9cNRdvVkcvj9H0wMMoSALPc=;
 b=n//7BY6l3HGw8O/IL005xtDD7aiApinfv0WBkpC0TyDW5hpP96t2z053Qljb6VNzso
 x90taLFKBfcNQk4hgkRVqF+ZJM402Dal9PLet3YBU3jhTm8xWavYe199DDc0q966JTm+
 rUE88yyHqy9u+acPiWxb1Ayj4Xpb8Vz0eLo8qSMG9ulCA9gXDvw0l4AEXrvNseXtWDbJ
 H6XN28KrB326jPCHP2EX/pZFG574wwxn33JbY4oegdvUsHX0BPKPIEher9Mbz6+UOKFQ
 tEHeufyLEVBL8fPhvIGSfjsByvmVeg+zIn+s4TQ/Wp+naj5RAdXkTpSVK63apC6qwQMu
 zNFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785781285; x=1786386085;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EDn4UWKobmcKu1/v3Fdz9cNRdvVkcvj9H0wMMoSALPc=;
 b=BafW/TfXPEytVyOiqY/iT8dhtjXlkBCwb7MtkItc5zKB8loL5pOophIh2snxnTEd1X
 mXczvVhpJLmSnyA6Y10mMcZLTLXyzXF4sBZ6y+YG+vbqiTmC0K56H2f6Y5ihgwta112m
 z/HIsEf/lCKoBWNQ6IbYvor8QL0X0NbU4CLHC4ztQPnk2DTXQWqBgK3e0F9YwbJh/5Cs
 mnrOX1k9FQlcPfIqWmGS1Z5TUgPUb0L0/ZsZmFwpSt61dsBkn0pNGMH3dKFKqzp0O5dg
 OkFoMu8C81WKq2quO+eAA2z4zWu7ZZT3ZUGdoMFmYMlT+n3xxjPdPPyHdJCkV8N3NscF
 qy1g==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJuHFtPirpO++4GE1LXfDnyaJzhMnva52zBewf1mCxqPqrBxUZbbnC0csJMX49Sy3H8p69YXpAM0DWZXcyJ6V4@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxNLIov7TphETsZT5T4zK9XSqdsOug6UzFS7/cLI0MUFocggHFX
 T05ad7NkDr8MPeN2F+TYgNkyfqxhm7cDacYcJEGonMRuoYY0f+aSAxOw
X-Gm-Gg: AR+sD123VFi5R/Jaun8f2sbW/mjCMp4T4i8DYBh1P3vgmKBbq+tkVse2Lyd0ZggakyU
 M23HhIUyrBqa2wHiAww8Bb0YLPnvgsdEMsFTFk5cL7uMPfP1fVXz9YWtR6rJY+WR9PdZsEixvxQ
 DjCuxaB8Wl8xyFEfpEQeRwlOiu3DHtT+dSnqmFdEn5eW/THkNu2hpaLFzCdfQfV0wlV5NS/tdpn
 QYg3YJ8I5SzA25+Yi2gEdKbo0ZHzpg8HKXcd+ndAwDi9p3KCh1Q+qAA9yHuG9ce/C63JKRbuaoh
 d+eiEsNKw/kXbQ/DPcZVtzqwjsaQNaBqxJrMMbFcyosYYGqZgAb8bp2SDAn/ePrsuu5CFfGbzFG
 DffRtlz4lhiskA1QzkII2rJMbYHLLDcp3GnzLUUeW1v7W7F2e/mVkHXyv/c/0ABv3zAG+jlwv4s
 De3pqoiiZeieKbeJVZ4LpQ91paUs53bDb0fkMGqSntNnLAVvs/jinVIY1/e2G56GFOD7F1AbNu7
 rzttZdeoYx+wi0rNAIwV24ghESqFq59slqpKbTztS/yaK2H9KzapmekOw+q2CTrPClfQj5oGMEJ
 I9JLHtK2ArVO
X-Received: by 2002:a17:90b:4f48:b0:38d:c834:2106 with SMTP id
 98e67ed59e1d1-38fbc4fcf95mr10120552a91.28.1785781285428; 
 Mon, 03 Aug 2026 11:21:25 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:d709:21da:d427:ef7d])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13fab14475asm32112432c88.5.2026.08.03.11.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2026 11:21:24 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  3 Aug 2026 11:21:20 -0700
Message-ID: <20260803182120.2291138-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
MIME-Version: 1.0
X-Headers-End: 1wqxI3-0005QQ-7s
Subject: [f2fs-dev] [PATCH v2] fsck.f2fs: sanitize invalid segment type
 during block update
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Daeho Jeong <daehojeong@google.com>

If an invalid segment type (type < 0 || type >= NO_CHECK_TYPE) is read
from SIT during block update, update_block() now validates the type,
reports corruption via ASSERT_MSG(), fixes se->type directly, and falls
back to a valid active curseg type based on its SSA summary block type
when fix_on is enabled. find_next_free_block() also validates want_type to
prevent out-of-bounds accesses.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
v2: used ASSERT_MSG() instead of ERR_MSG().
    used the correct type info for fixed_type.
    fixed se->type on top of fixing the local type only.
---
 fsck/mount.c   |  5 +++++
 fsck/segment.c | 20 ++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 85ed404..916dfbf 100644
--- a/fsck/mount.c
+++ b/fsck/mount.c
@@ -3059,6 +3059,11 @@ int find_next_free_block(struct f2fs_sb_info *sbi, u64 *to, int left,
 	u64 end_blkaddr = (get_sb(segment_count_main) <<
 			get_sb(log_blocks_per_seg)) + get_sb(main_blkaddr);
 
+	if (want_type < 0 || want_type >= NO_CHECK_TYPE) {
+		ASSERT_MSG("Invalid segment type %d for block allocation", want_type);
+		return -EINVAL;
+	}
+
 	if (c.zoned_model == F2FS_ZONED_HM && !new_sec) {
 		struct curseg_info *curseg = CURSEG_I(sbi, want_type);
 		unsigned int segs_per_zone = sbi->segs_per_sec * sbi->secs_per_zone;
diff --git a/fsck/segment.c b/fsck/segment.c
index 46dc747..43f85ec 100644
--- a/fsck/segment.c
+++ b/fsck/segment.c
@@ -770,15 +770,32 @@ int update_block(struct f2fs_sb_info *sbi, void *buf, u32 *blkaddr,
 	struct seg_entry *se;
 	struct f2fs_summary sum;
 	u64 new_blkaddr, old_blkaddr = *blkaddr, offset;
-	int ret, type;
+	int ret, type, sum_type;
 
 	if (c.zoned_model != F2FS_ZONED_HM)
 		return dev_write_block(buf, old_blkaddr, WRITE_LIFE_NONE);
 
+	sum_type = get_sum_entry(sbi, old_blkaddr, &sum);
+
 	/* update sit bitmap & valid_blocks && se->type for old block*/
 	se = get_seg_entry(sbi, GET_SEGNO(sbi, old_blkaddr));
 	offset = OFFSET_IN_SEG(sbi, old_blkaddr);
 	type = se->type;
+	if (type < 0 || type >= NO_CHECK_TYPE) {
+		int fixed_type = (sum_type == SEG_TYPE_NODE ||
+				sum_type == SEG_TYPE_CUR_NODE) ?
+				CURSEG_HOT_NODE : CURSEG_HOT_DATA;
+
+		ASSERT_MSG("Invalid SIT segment type %d at blkaddr 0x%"PRIx64,
+				type, old_blkaddr);
+
+		if (!c.fix_on)
+			return -EINVAL;
+
+		FIX_MSG("Correct invalid segment type %d -> %d for blkaddr 0x%"PRIx64"\n",
+				type, fixed_type, old_blkaddr);
+		se->type = se->orig_type = type = fixed_type;
+	}
 	se->valid_blocks--;
 	f2fs_clear_bit(offset, (char *)se->cur_valid_map);
 	if (need_fsync_data_record(sbi))
@@ -811,7 +828,6 @@ int update_block(struct f2fs_sb_info *sbi, void *buf, u32 *blkaddr,
 	f2fs_set_sit_bitmap(sbi, new_blkaddr);
 
 	/* update SSA */
-	get_sum_entry(sbi, old_blkaddr, &sum);
 	update_sum_entry(sbi, new_blkaddr, &sum);
 
 	if (IS_DATASEG(type)) {
-- 
2.55.0.571.g244d577d93-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
