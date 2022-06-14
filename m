Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12742C43334
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 14 Jun 2022 11:50:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o1542-0004yV-Ns; Tue, 14 Jun 2022 11:50:29 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <qxy65535@gmail.com>) id 1o1541-0004yP-L0
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Jun 2022 11:50:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=A0t+59JTGCJhzXFr0zxUoQWdhw1kozX+twzUZvLphEI=; b=fNMt6cZU41wLSaIJf2OLCDvx/1
 JpTKdcvuSBhUqlj7rrNezNgyzKd3f3gbeKYXigJL3CbiDOiY+NRLtRasNcFphhnG4Q+nfC5gHD09F
 o+zSnhTTKMKXd3W/SCCVLUltVYc6xgHMJ66jGE6AEPm+8gLnzZHts8yhKwX2X+hB7ROU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=A0t+59JTGCJhzXFr0zxUoQWdhw1kozX+twzUZvLphEI=; b=bViV5KJf0d+798lj9fd4mO4kDI
 /PEHlG1dq6nylPtkdkDsfXcJOTmg4ZoZuJV1lcnEizXV6iKNhO/IpuP4KHdY6dsWXDpZy8OQeugr4
 VTgzl3LhIBS40EA7zAE0g1GKwKyTcs8S/AMJK3VWL6pGJAz22vy/M3fogT3Am1W066/0=;
Received: from mail-pj1-f49.google.com ([209.85.216.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1o153u-0006lp-IX
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 14 Jun 2022 11:50:28 +0000
Received: by mail-pj1-f49.google.com with SMTP id
 mh16-20020a17090b4ad000b001e8313301f1so1142329pjb.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 14 Jun 2022 04:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=A0t+59JTGCJhzXFr0zxUoQWdhw1kozX+twzUZvLphEI=;
 b=F3dA6Eu5MXASMIfexqV07GCk3QkS5c8VuNH6YdrBBkCX8OS6cYMYpuxBWYZpQy9GY2
 Hyj5aQZelm82gUh3a5iqvyGqHzz31LvMjiN58PiDsfnZOpUD0Y4uIfbYSU/Oj6HS+dz/
 3+ynscwaddW/3z8crG2VjTLFSMxpcSAP4FzPMkEkg5kXrrsGPXiFBHgpJl22bc6Pe23U
 XmI9aWoR+VWXIxye8yexVTe4UKFLSDeLoXMQ2imYdb+gLyf3rUaZUxW84rlNww2HfU2T
 2tiTaGpRRXzflSECub9VdAzHXVRpWm7oCAtb6IFOYB/CTPsF/sDL5KTCdY6hrSRQLCME
 rEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=A0t+59JTGCJhzXFr0zxUoQWdhw1kozX+twzUZvLphEI=;
 b=61uSvHnXn0A+fHd48EN0rMltO0f9stAVQxK2rEHt4F+ihBWBeD3xZsVifBexU6Zs1o
 wkRPXT/r3HoyJKFWmtRMP+8v7a5MiUaD6zB2hlqgY7+tgTfYQdqQc+xwB5KRTqBOS5/I
 pQfoc6OcicCIJFSoyrGHbWbCdhO3hOGFrnvcnCbK9ofCvSg+IU83EOvToTpnMmIh57yT
 71szsf1eHhJ4hRRTaZ/tveXA5elOLfqdNy153LGVTDcLk4zH9anbiudUbgqENHdIqfIX
 05XekBdJJUXKFH73U6QRkGO58XBF7tmis7Z0wNDn735Puw+OO11DZnh8ilUrBOc3ClPO
 P4Hw==
X-Gm-Message-State: AJIora/rccFiAN2k/ATcrNZY+pDNsdAgIYRzxxFQ1Vj91ZSHUzQ3UxgN
 xX9SAETpUu5PT2n5VP7ZxvM=
X-Google-Smtp-Source: AGRyM1uvH8uvscKQstVODrvJnevEYuArUZv/5c6h2w0iTRtaH4LPDFGbyxXjDueXCmhu0Sjxlm5uig==
X-Received: by 2002:a17:902:a704:b0:168:f037:98cd with SMTP id
 w4-20020a170902a70400b00168f03798cdmr1623074plq.87.1655207418352; 
 Tue, 14 Jun 2022 04:50:18 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G4-MT.mioffice.cn ([43.224.245.250])
 by smtp.gmail.com with ESMTPSA id
 ay21-20020a056a00301500b0051bc3a2355csm7291268pfb.64.2022.06.14.04.50.15
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 14 Jun 2022 04:50:17 -0700 (PDT)
From: qixiaoyu1 <qxy65535@gmail.com>
X-Google-Original-From: qixiaoyu1 <qixiaoyu1@xiaomi.com>
To: jaegeuk@kernel.org
Date: Tue, 14 Jun 2022 19:49:29 +0800
Message-Id: <20220614114929.6897-2-qixiaoyu1@xiaomi.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220614114929.6897-1-qixiaoyu1@xiaomi.com>
References: <20220614114929.6897-1-qixiaoyu1@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1o153u-0006lp-IX
Subject: [f2fs-dev] [PATCH 2/2] f2fs-tools: fix to check free space before
 grow
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
Cc: qixiaoyu1 <qixiaoyu1@xiaomi.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Otherwise, after grow, kernel may report below error message
when we mount the image if -o parameter is specified during resize:

F2FS-fs (loop0): invalid crc_offset: 0
F2FS-fs (loop0): Wrong valid_user_blocks: 16404, user_block_count: 13312
F2FS-fs (loop0): Failed to get valid F2FS checkpoint
mount(2) system call failed: Structure needs cleaning.

Signed-off-by: qixiaoyu1 <qixiaoyu1@xiaomi.com>
---
 fsck/resize.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/fsck/resize.c b/fsck/resize.c
index d19c6fa..e135b66 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -599,6 +599,26 @@ static void rebuild_checkpoint(struct f2fs_sb_info *sbi,
 	DBG(0, "Info: Done to rebuild checkpoint blocks\n");
 }
 
+static int f2fs_resize_check(struct f2fs_sb_info *sbi, struct f2fs_super_block *new_sb)
+{
+	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
+	block_t user_block_count;
+	unsigned int overprov_segment_count;
+
+	overprov_segment_count = (get_newsb(segment_count_main) -
+			c.new_reserved_segments) *
+			c.new_overprovision / 100;
+	overprov_segment_count += c.new_reserved_segments;
+
+	user_block_count = (get_newsb(segment_count_main) -
+			overprov_segment_count) * c.blks_per_seg;
+
+	if (get_cp(valid_block_count) > user_block_count)
+		return -1;
+
+	return 0;
+}
+
 static int f2fs_resize_grow(struct f2fs_sb_info *sbi)
 {
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
@@ -616,6 +636,9 @@ static int f2fs_resize_grow(struct f2fs_sb_info *sbi)
 	if (get_new_sb(new_sb))
 		return -1;
 
+	if (f2fs_resize_check(sbi, new_sb) < 0)
+		return -1;
+
 	/* check nat availability */
 	if (get_sb(segment_count_nat) > get_newsb(segment_count_nat)) {
 		err = shrink_nats(sbi, new_sb);
@@ -659,11 +682,8 @@ static int f2fs_resize_shrink(struct f2fs_sb_info *sbi)
 	struct f2fs_super_block *sb = F2FS_RAW_SUPER(sbi);
 	struct f2fs_super_block new_sb_raw;
 	struct f2fs_super_block *new_sb = &new_sb_raw;
-	struct f2fs_checkpoint *cp = F2FS_CKPT(sbi);
 	block_t old_end_blkaddr, old_main_blkaddr;
 	block_t new_end_blkaddr, new_main_blkaddr, tmp_end_blkaddr;
-	block_t user_block_count;
-	unsigned int overprov_segment_count;
 	unsigned int offset;
 	int err = -1;
 
@@ -674,15 +694,7 @@ static int f2fs_resize_shrink(struct f2fs_sb_info *sbi)
 	if (get_new_sb(new_sb))
 		return -1;
 
-	overprov_segment_count = (get_newsb(segment_count_main) -
-			c.new_reserved_segments) *
-			c.new_overprovision / 100;
-	overprov_segment_count += c.new_reserved_segments;
-
-	user_block_count = (get_newsb(segment_count_main) -
-			overprov_segment_count) * c.blks_per_seg;
-
-	if (get_cp(valid_block_count) > user_block_count)
+	if (f2fs_resize_check(sbi, new_sb) < 0)
 		return -1;
 
 	/* check nat availability */
-- 
2.36.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
