Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38C4FFD064E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Mar 2026 08:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r6I72Cl+r/Z8ZOEGXUTIoQ7OuNtVJa7BIQpsR9R8TiY=; b=MA20jTEKdCdVnW6q32t78Fci69
	DbCgsHPv4N2WGPDnNpIrC8so/6gRvaTBI/igjQm1I1faEIZkjiE/9VH6ZsorfA/aTU1OoBDp62t0A
	4i2vyV/ruYC+S/WXwi3tEfQXGjcUql9/g3z1u2ovXfhvRU1oo/GfghlW1B6oqOzQECkg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w0F3i-0002xu-QN;
	Wed, 11 Mar 2026 08:36:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zangyangyang66@gmail.com>) id 1w0F3i-0002xo-14
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Mar 2026 08:36:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=mrrdoATGhbk4f9r5HODLnujYVTXhmAKUzyFXdfkxne8=; b=Me++E+9XaCNwMraMkaJXQzdaVe
 9IFYE4Xnfrg92NTNO9ajLjOAu6sm8mNGGTghimXGIDtamKmDUI42WyvDDY5g2s0TfmhC7r4JSZ9mw
 pkn9rfebiciu3xBVZoOl8c57q9QAeG05eaV4rgTe32bZGs3iv3xoYxR93M88d+uRbwHQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=mrrdoATGhbk4f9r5HODLnujYVTXhmAKUzyFXdfkxne8=; b=VG6dAqHoAc1huqBctWZWTpwInl
 aSThDSm1PThsUoEadpzROkQYQo2ts06KhbV51vptUofLtc5philUp54TFvjOTjOMnNDFBZSmp0Dd4
 GItzDva9zp44eGVuk8FzSlF69FCDCDrsgU68DpNCd+I5fuPh8ttR9oB+okkG7PpYieis=;
Received: from mail-pf1-f169.google.com ([209.85.210.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1w0F3h-0004fa-K4 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Mar 2026 08:36:49 +0000
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-82987437624so415626b3a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Mar 2026 01:36:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773218204; x=1773823004; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mrrdoATGhbk4f9r5HODLnujYVTXhmAKUzyFXdfkxne8=;
 b=hSz+E6w2IkxfY5qsyi/TGED+D/9DKFvzs1RHLy39jCF84fOH1EEEBVbu47DhuUixzQ
 icWzij+bHuY+6NL7Kv8iJvCy0UplMxw7H2xupGPd1CHl040dy6mi4T9mTnrVnPj6Nv3x
 tnx0gA/zQZpKgaQUPM592KnRSAQbYngawnbdl82gABNhyY//AFuXbVUtJCDPvSVRs74F
 DkE2j0WZbVjU9VvaBO0u1yOOpjQxBhV6UuPFC2r470R54d80Au9GNaN0QqoeFTFSg0PB
 vDL7uiyR61S7WS5MqmVE0BVXWzHvdr5eZnbOGPSfWi7nO06ZS+Wf7tzEyOb6xHiQeYXH
 AchQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773218204; x=1773823004;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mrrdoATGhbk4f9r5HODLnujYVTXhmAKUzyFXdfkxne8=;
 b=X6xH8ONMnfGO5QLsT1t7C4Fh10lCHzAedKRR1YKCllGR8szpVqPrqGmpu+LrOaW1Eu
 2HHhT5qNZKrtE/cAwY0bAb89cZgecGm1vB0k9WiqrvUvUWlDwzZd49FuYHWVaGdhfTwp
 IuwwaDCDGdxfI7JThP7T6KhGVzASim6/pnCE6FvJ2amhcsIjaKb/tUoszQQDf1nwNRgq
 wx/YoXzZXtseL8HtibcgYZxQkup52NcN8dzOh6nRNRjms8RTTBexU0gzXgz7SvJBcdvL
 COdd3rBQumzvcVnMlHpyDPDYYAvGIlqnH0KEJEIqC7xh5ZFRpFcauEOcltI/bCfVDcvG
 gbrw==
X-Gm-Message-State: AOJu0YxSpWQUzfEQ/IbjkpCUFHEFdDmr0M1fzCSyUwmrcUtxk89L4LQr
 F21S2Y1CdfjwWK6hVZIXNVvRFZrEOAPPR+/HxehGUCDpO3VfF97nxbsQ
X-Gm-Gg: ATEYQzzyIb15t1scYIOYnec/RT2a0SJ+05POY6pbXsalpY6XheQ+Tm1wGTFPYJLkQgP
 N/Fy8Y+r1s+KQOPQ0x1aJ+dkxH4kNc+1AdhEdsFfeCMby3hWAsV0Me088xQrBV3KdxqWY7DFU1A
 9DfVJtdTBnd7lKtCjAh7tcOJtM4roMgT9HYsStbLKKubsaro/Jk1+pGGfsXJJpt17IyDtRZwLgE
 Vyl7Z0AHz02XIgXK8eGMjkMCk/RsLfWvJ3viKbMmz4PM0lzK3QNYULXPhRX3pUAZwy99kcF+AWF
 WMYrr+QSMRpwKpmXVQda3xiyuPFyl2P4nybAHE9scQpKd4GdPP2Poqj7xsW+8eH4fMwJXjXjUTP
 pocYJVILAWV4KT1D009xnCxeWcMcqnTWvbVQ7k5TmF2R6i7UVMj9pBaCs2su7/8e2kMDizOXDDN
 EyCeNKroPQAsKkW0vFGeh6ncTPJWb9SYQoLzMnS4+2EA==
X-Received: by 2002:a05:6a00:349a:b0:81f:4e1c:1d3b with SMTP id
 d2e1a72fcca58-829f7ae6a79mr1534046b3a.23.1773218203896; 
 Wed, 11 Mar 2026 01:36:43 -0700 (PDT)
Received: from zyy.mioffice.cn ([2408:8607:1b00:8:d2d5:a44:599c:b689])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829f6dc2d76sm1592503b3a.8.2026.03.11.01.36.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Mar 2026 01:36:43 -0700 (PDT)
From: Yangyang Zang <zangyangyang66@gmail.com>
X-Google-Original-From: Yangyang Zang <zangyangyang1@xiaomi.com>
To: chao@kernel.org,
	jaegeuk@kernel.org,
	daehojeong@google.com
Date: Wed, 11 Mar 2026 16:35:29 +0800
Message-ID: <20260311083530.2582720-2-zangyangyang1@xiaomi.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20260311083530.2582720-1-zangyangyang1@xiaomi.com>
References: <20260311083530.2582720-1-zangyangyang1@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1w0F3h-0004fa-K4
Subject: [f2fs-dev] [PATCH v3 2/3] resize.f2fs: clean up the code in
 migrate_ssa()
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
Cc: Yangyang Zang <zangyangyang1@xiaomi.com>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Clean up the code to make its semantics more logical, no
logic changes.

Signed-off-by: Yangyang Zang <zangyangyang1@xiaomi.com>
---
 fsck/resize.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/fsck/resize.c b/fsck/resize.c
index b73a2529dc75..79db7eede65c 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -257,48 +257,48 @@ static void migrate_ssa(struct f2fs_sb_info *sbi,
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	block_t old_sum_blkaddr = get_sb(ssa_blkaddr);
 	block_t new_sum_blkaddr = get_newsb(ssa_blkaddr);
-	unsigned int expand_segno = MAIN_SEGS(sbi) - offset;
-	unsigned int new_seg_total = get_newsb(main_blkaddr) - new_sum_blkaddr;
-	int new_segno;
+	unsigned int expand_sum_blocks = MAIN_SEGS(sbi) - offset;
+	unsigned int new_sum_blocks = get_newsb(main_blkaddr) - new_sum_blkaddr;
+	int new_sum_blkoff;
 	int ret = 0;
 	void *zero_block = calloc(F2FS_SUM_BLKSIZE, 1);
 	ASSERT(zero_block);
 
 	if (offset && new_sum_blkaddr <= (old_sum_blkaddr +
 				offset / SUMS_PER_BLOCK)) {
-		new_segno = 0;
-		while (new_segno < new_seg_total) {
-			if (new_segno < expand_segno)
-				move_ssa(sbi, new_sb, offset++, new_segno);
+		new_sum_blkoff = 0;
+		while (new_sum_blkoff < new_sum_blocks) {
+			if (new_sum_blkoff < expand_sum_blocks)
+				move_ssa(sbi, new_sb, offset++, new_sum_blkoff);
 			else if (c.feature & F2FS_FEATURE_PACKED_SSA)
 				ret = dev_write_4k_block(zero_block,
-					GET_SUM_NEW_BLKADDR(new_sb, new_segno),
-					GET_SUM_NEW_BLKOFF(new_sb, new_segno),
+					GET_SUM_NEW_BLKADDR(new_sb, new_sum_blkoff),
+					GET_SUM_NEW_BLKOFF(new_sb, new_sum_blkoff),
 					WRITE_LIFE_NONE);
 			else
 				ret = dev_write_block(zero_block,
-					GET_SUM_NEW_BLKADDR(new_sb, new_segno),
+					GET_SUM_NEW_BLKADDR(new_sb, new_sum_blkoff),
 					WRITE_LIFE_NONE);
 			ASSERT(ret >= 0);
-			new_segno++;
+			new_sum_blkoff++;
 		}
 	} else {
-		new_segno = new_seg_total - 1;
+		new_sum_blkoff = new_sum_blocks - 1;
 		offset = MAIN_SEGS(sbi) - 1;
-		while (new_segno >= 0) {
-			if (new_segno < expand_segno)
-				move_ssa(sbi, new_sb, offset--, new_segno);
+		while (new_sum_blkoff >= 0) {
+			if (new_sum_blkoff < expand_sum_blocks)
+				move_ssa(sbi, new_sb, offset--, new_sum_blkoff);
 			else if (c.feature & F2FS_FEATURE_PACKED_SSA)
 				ret = dev_write_4k_block(zero_block,
-					GET_SUM_NEW_BLKADDR(new_sb, new_segno),
-					GET_SUM_NEW_BLKOFF(new_sb, new_segno),
+					GET_SUM_NEW_BLKADDR(new_sb, new_sum_blkoff),
+					GET_SUM_NEW_BLKOFF(new_sb, new_sum_blkoff),
 					WRITE_LIFE_NONE);
 			else
 				ret = dev_write_block(zero_block,
-					GET_SUM_NEW_BLKADDR(new_sb, new_segno),
+					GET_SUM_NEW_BLKADDR(new_sb, new_sum_blkoff),
 					WRITE_LIFE_NONE);
 			ASSERT(ret >= 0);
-			new_segno--;
+			new_sum_blkoff--;
 		}
 	}
 
-- 
2.43.2



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
