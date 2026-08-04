Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12879C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 17:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=vIhWglhsqg4wv2i9K/djhdDPrV5yIQe3mNrIkbqdG3I=; b=IDvPxL0P5bbd41tlw6IXqzMTVs
	4s9OW1n7bglKIDqiue8AWaYt6A58ue3h7m55DEguYHfh92aywc1qE6RiZVUKNcnWUB2Xc7tqZkwfb
	e5P1YG0JQE+wHVW1wMGRv8VNRE+dNBoFcgqdB/sWZcT43UIjQ/b7N6RP1qlYQuOrFfnI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrImO-000132-Er;
	Tue, 04 Aug 2026 17:18:17 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <daeho43@gmail.com>) id 1wrImN-00012m-2f
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 17:18:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qYjqkukOCUBBX3l/sXn/dfJXEIcw36wAKJIGPbMHdOc=; b=HcYMPPFX462vObYIS40Fp1E28d
 eWFAKXL8M6B7YqsK4vdReDTeRdAq/gnKNpUlcYYWlwwrkmudBwPKKZMuQl8Nnfcop7mVOMqaUca2S
 8YIDFWuED0sa7SMswaEHeFh/NSevQd8H+rypvyCvW1fnHGuVMSTZ5Z0pM+zZUVwXmsUI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qYjqkukOCUBBX3l/sXn/dfJXEIcw36wAKJIGPbMHdOc=; b=a
 dF5cD7fNiQBFIFq7d8sr9lsL3IS8EgXXy6YR8nuWHFeT149FfJKb82s8EwxN7svLmr0R28rmk9BnS
 I6QINwg/ydG5bnNKX9cwb8YsZ8wK9O6RmM9IV0t0vtPPwPq/48gJ4pQiyhqHQKRJhbqEIn+lybmBi
 kD+YCZd3ymBlPbfQ=;
Received: from mail-pl1-f177.google.com ([209.85.214.177])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wrImM-0008T0-GM for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 17:18:15 +0000
Received: by mail-pl1-f177.google.com with SMTP id
 d9443c01a7336-2caed617615so1627155ad.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 04 Aug 2026 10:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785863889; x=1786468689; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=qYjqkukOCUBBX3l/sXn/dfJXEIcw36wAKJIGPbMHdOc=;
 b=kzP7w/NmXIbVndSR08K9YvpIAQh/KwU8s/03Ff5zoypIk3BCF91VN1ctMfwXbEOaHw
 wZKisKOOYeGm85+HqJ5ACybrR9JOG+rp2Am2QO9tQJQqATYmMuvAvbc4nOO9zpXxCCsu
 6B2kuAuivKjbzxn0EBquU0YA8Z4KafZF1C7ESi9/Rqr3DHIYKlIRlclNYndZA5QMMoJo
 t2VQs6rt23qmPtkiQ0dRudqA9d/RjeewfnFt37LzOVDsUbJZKsvlkjq8yKqmh96Odu7G
 B4mes1yqaVmmTXlPEXfSYdQvKyErtO0PQ5gYSkoPj7F1PochW4M2F4JGJ0GRenqXy6Ph
 raFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785863889; x=1786468689;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=qYjqkukOCUBBX3l/sXn/dfJXEIcw36wAKJIGPbMHdOc=;
 b=M0IeqwjPMpDZ0y3OWM/jCnGsVtDARtV7BOygShoHq1Oo87roKKareOOYoBAgDgwY2H
 zUTxGBklNVyTGWfpRJRoTGUlCMd6vn3B6qXr6dbCtdUckdwg8t3E75noj4pwZCJhBIoW
 ctDDWgibMUNC6MargQ6WPBk6bg1/M3HIw1nldq1HAhlrj9jtMEoAifsatZibQbTDqG4G
 r5csmGh5davFauUDlXI6/ynSrdjQR4D08UvlSpTvgHPNaHYYEJXcLN5mVPohny3AAGGL
 hwq+rN+Fx+8/3Wd2IqddqDTVZ7UKDZUz+GjrX3UuWzbK3Hr01qPIHMJ+D2FhJ2TNOtVs
 vBmQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2jcRMbsYyPHuxIq+ol2hVACibjGwXEfT7x8xspbw4/ECm8DPCzICDv3EFIvfsDJYrCrI94ljfDdtErUSMx28Y@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwRnr021vk8F/Eiweuh7qeQGHnKpXckAfepkOreqXPRd2rdWttZ
 xWPjmK8EfNmBPZ4U3cYiDxivAt3BVFKMCEMujLF9qh9ETXO1caoUrFIv
X-Gm-Gg: AR+sD12GTCLOvoa6e4Qy/AUjiPoqezuTscjE0JhDnI9iOzrikulGn7UD7CNtCHUqBbo
 D4tezyoE3NPQ6RhBViMPJ9BUWkuIHpXEPX64hvMhmKOKvgfEWRjkEiZuQ5FuYTU1H0mBNfZ6E39
 Fp3PQm/o+f9LdubbpSJqcdbnj2Ksz+0MTWjwM/FgSxbkQX3ajV4xH9ecSdmyCo8d+nZLMaHLK94
 iRN17M40sIEWJl0mU4Oul9J2KbO06B4gP3DQZNLIZcLftkwcwRU06p1FKGN0WpoPyGjQqo7jgTn
 45fDcVvzYY99PidqGc7kDFBPzrp9JeMwjxKVKLVZn/Aqcn+1i5BmZJvH5fm23Zb0C5hUF7gw7kp
 hOD6fCCFXtJ2/1mHe2yanQ7NqnFRr378Q76baIphXbhhwe82ZtEPrh4ymo2opld4MWFE7nFKr4l
 MlQuvIv2F3gu5LO2Ti3Ej7J248Q5dDBh7PFJiHwVJAQlZVFhWJ9QEj3ndGQSkvJdUIdIPN2iB5i
 fqqUDeTUQMU0KKr5J9oBw9BvDQ2M+l7kR3ZCnZDs5t0pbOTBqTWg5sjlUV2oWKCsC0NvqrZhvwD
 cZI+KX8QAYmJ5Q6PgINUNh4=
X-Received: by 2002:a17:903:2ac5:b0:2c9:b8b7:5d27 with SMTP id
 d9443c01a7336-2d0ca712d8fmr4095955ad.1.1785863888716; 
 Tue, 04 Aug 2026 10:18:08 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com
 ([2a00:79e0:2e7c:8:a145:23df:65c7:83db])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315863b0c61sm7035841eec.6.2026.08.04.10.18.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Aug 2026 10:18:07 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Tue,  4 Aug 2026 10:18:03 -0700
Message-ID: <20260804171804.28860-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
MIME-Version: 1.0
X-Headers-End: 1wrImM-0008T0-GM
Subject: [f2fs-dev] [PATCH v3] fsck.f2fs: sanitize invalid segment type
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
v3: do not update se->orig_type.
v2: used ASSERT_MSG() instead of ERR_MSG().
    used the correct type info for fixed_type.
    fixed se->type on top of fixing the local type only.
---
 fsck/mount.c   |  5 +++++
 fsck/segment.c | 20 ++++++++++++++++++--
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/fsck/mount.c b/fsck/mount.c
index 6f640a0..1804403 100644
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
index 96de22a..9f3fa0c 100644
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
+		se->type = type = fixed_type;
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
