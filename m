Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D9C860705C8
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 15:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jhVM/mrC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MlxU/Hb3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=K5vERKMD;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=LlkbO61o
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2LQueAhgg/YO1u1G6DhaOGtzf8vAfIWgPVXmtWZP3ho=; b=jhVM/mrCVM/9SmUJolqcybkBtv
	nHdD2keH54HRi5d5LvAEcZVCbSuDkNYwTieoVTep5/S3y5QujNc1Eg/ShJTmzrr8efHlP8V5Dxcn2
	W/SptVnh56IEiV+q06X/+GjVX3wMvVhuhbKcAQwWi+MKSJUdDfdunb5/QyH81ZZuWzsQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xIpRC-0005mY-Tt;
	Mon, 19 Oct 2026 15:38:10 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <filip.chromy04@gmail.com>) id 1xIpRB-0005mS-RX
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:38:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VwwiUKNaLm+wVhflONeIC5Wz4r3USU80aAld9TnpRGs=; b=MlxU/Hb3IGYwOLqHZSOGWNzc/4
 ZbhmPfVL26lrS7e02jf+xe5Gs4kpuaHGmwskwm6fIUTt6TSMxOJsiNZMHmCrTAWO+UOP8gUjtD+L5
 CEuKGP7XXEyw3dqWfqIuNuE4VW+GneqVQ1DllBJmB8/WcTj7ltdbAXO7kfq+hMPAUg7I=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VwwiUKNaLm+wVhflONeIC5Wz4r3USU80aAld9TnpRGs=; b=K
 5vERKMDTV70ZaPSoG/g+q4WqO93xbQdpqod1s1+SLdwdZsFOItWeJAKF8TLRKokH1skGYTwa4o1RC
 nwqBsLyfgNprfK+FhyuK9u7MrQwVk8mgmjPMKQWLpMopfIRwqrxFqiXHlDEzj/j9yLipPD7wRpCCn
 6GrlbFo0CdZ+/IfY=;
Received: from mail-wr1-f42.google.com ([209.85.221.42])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xIpRB-0006qx-7R for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 15:38:09 +0000
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-48df0fa43c5so1693717f8f.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 19 Oct 2026 08:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792424283; x=1793029083; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VwwiUKNaLm+wVhflONeIC5Wz4r3USU80aAld9TnpRGs=;
 b=LlkbO61oouK7kdH3btLvLK5XdBpxqUrnK+VWk/DUm6MwvwZy+C/o8ZdoDnSauCu2bJ
 b67brNd6X/n2MBB3yfslqo5pVZ5HrEfunucEcXFFGpfA2SIT3k1H7yIEsKTkuqZ1n2mP
 DQJxEf8fNORl23Xi2xlw+SjHFlTMHBs8l4wzrG1bGGqqEvwnSc2PbKtgqgnKUKXQRGXX
 Fg8EPzIHktELVXQH1oqFSqVeLnw9gGX0RVvSne8MHdc06ygPwkG5GelZBhEmMOs4YO6E
 BVrb88GCa/iFbCh/GYiQCFejqz64QEXXFp4egqYyr4fTkLlNFC724zgmSkaAyEJhEGzi
 jIAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792424283; x=1793029083;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VwwiUKNaLm+wVhflONeIC5Wz4r3USU80aAld9TnpRGs=;
 b=bQAe8aRdY6Ufs3qWMCrEqKvHq8gWwvhY+LN92q/7ojoOWWCbBg9gjnJou587BCkl4p
 mddZBKyvlxMCG6Wr50lpcE6O6EEe0P41IVOaZWmLcb/koJC7dumfzpBIq+Pc4KPdY9Xl
 vdIANKzaiYef+2Ah0QGZkVy3KCt70rTwi5zEMGfOLQ5uKGUNR3ZMiP2hWCJzK3U7Dr/F
 JOEeQtr5oEXvwjLc6DXLs+GZCcAwYTbPvIdPHIQpB88NQAvp4M+n0ADMex1nHk8oYGQa
 Pq3R82zvfd4IfCTMUMko07dIf8brI43FskXDLCQXYRUKePDI7SABKYXa5/tcQlC7pmbc
 GDuA==
X-Gm-Message-State: AFq9FYJ2Lvz2PMIJyOqQ3fjHCbJ73KovOg0QZTYuTtMw69uKsAFnVNnj
 QLFfE8X+6fOIoxeBA44+zqPWwXq8AzKUZ9IMGsTJDjuWjqlG/cPHQFbleTOVjJeDRg==
X-Gm-Gg: AYBFou2FEP+qtYm5xIVf2THe8OO2boBVvG+I4QwPFaq1++8Ea8z3c7Ai7RI/xTEEwJ4
 TR2XAqQWQ1PK9jDy8s0WpAZb/5nQlc6mfWtuipApTQVV3MEuFAMXX1USMvUdzDzSe9dvjUI/stB
 8devsRIyt+U4JIbKGR/sG0EI2wKg7ArxvOV//FSrhgh2S8JWvQzIYXv9Jd7GjGQK9ZsLPd7ByOM
 /NySvR1CKzkIIjVZy/caTjr9sEQMS4cc4zSBftBf68Yavryd+4lybAx28a9ykhAF7fT5jv0jNUE
 F7C2bPprPjXGYthe4w/ji+mlf2Y48UZijgSmqkWx8wR+jtDkBuhSqre2toWDO+EZew6oT9uvfOU
 9HTKm2318ovCaT4oyucgu/uJAcosH/iYeI/cC+btJ2C8hoyFR47Nag8oR8t2w6eI1XzlorIwpXO
 ioqgsDmXtFGKv2OmNG020+RS4+p/WOaJxzk/JHh5flYOFm67SPN/rTg6puPTvSQwZKPtJRth4jO
 zQWnjZ+GzKf6pI/JqLfwFvt0HFyg24G
X-Received: by 2002:adf:e199:0:b0:48a:fe00:ad1 with SMTP id
 ffacd0b85a97d-48e07bab909mr18375270f8f.6.1792424282631; 
 Mon, 19 Oct 2026 08:38:02 -0700 (PDT)
Received: from localhost.localdomain (nat38-9.hdinternet.cz. [194.12.38.9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd4f5177sm23550902f8f.30.2026.10.19.08.38.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 08:38:02 -0700 (PDT)
From: ChromMob <filip.chromy04@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 19 Oct 2026 17:37:33 +0200
Message-ID: <20261019153733.1210512-1-filip.chromy04@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xIpRB-0006qx-7R
Subject: [f2fs-dev] [PATCH] resize.f2fs: fix corruption when expanding after
 a safe shrink
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, ChromMob <chrommob@proton.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
	RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: ChromMob <chrommob@proton.me>

w/ below testcase, expanding an image that was shrunk with -s to a size
below its original size corrupts it:

truncate -s 4G img
mkfs.f2fs -f img
sload.f2fs -f <some dir> img
resize.f2fs -s -t $((2*1024*1024*1024/512)) img
truncate -s 2G img
truncate -s 3G img
resize.f2fs img
fsck.f2fs --dry-run img

Depending on the image, resize.f2fs hits an ASSERT in
update_data_blkaddr() or BLKOFF_FROM_MAIN(), or segfaults, after it has
already modified the image, and fsck.f2fs then reports unreachable NAT
entries and SIT/node count mismatches.

The root cause is that safe resize keeps the SIT, NAT and SSA areas
sized for the original volume, while expanding lays them out again for
the target size. When the target is below the original size, the new
areas are smaller and main_blkaddr moves backward, but
f2fs_resize_grow() assumes the main area only moves forward: offset =
new_main_blkaddr - old_main_blkaddr underflows, so f2fs_defragment()
walks far past the end of the main area and migrate_main() writes
blocks to wrapped-around addresses.

When the new layout would move main_blkaddr backward, keep the current
metadata areas instead, as long as SIT and SSA still cover the new main
area, i.e. the newly computed SIT and SSA are not larger. Not having
enough SIT for the new size is what commit f614bccc18cf ("resize.f2fs:
fix to always change metadata for expand resize") found for -s
expansion; here the areas were sized for a larger volume, so the SIT
bitmap still addresses every main segment. NAT is not compared: it is
capped by the checkpoint bitmap and can come out larger for a smaller
volume (e.g. 86 segments for 900GiB vs 88 for 850GiB), and the current
NAT already served the original size. The resulting layout is the same
as when expanding back to the original size, which already works.
Otherwise, fail instead of corrupting the image.

Tested on image files populated with sload.f2fs: shrink with -s, then
expand below, to and above the original size, including several
expansions in a row, for 4GiB, 64GiB and 880.5GiB images. After each
step fsck.f2fs --dry-run is clean, and dump.f2fs -r output matches the
contents before resizing.

Signed-off-by: ChromMob <chrommob@proton.me>
---
 fsck/resize.c | 30 ++++++++++++++++++++++++++----
 1 file changed, 26 insertions(+), 4 deletions(-)

diff --git a/fsck/resize.c b/fsck/resize.c
index beb7ce0..4b71a35 100644
--- a/fsck/resize.c
+++ b/fsck/resize.c
@@ -9,7 +9,7 @@
  */
 #include "fsck.h"
 
-static int get_new_sb(struct f2fs_super_block *sb)
+static int get_new_sb(struct f2fs_super_block *sb, bool keep_meta)
 {
 	uint32_t zone_size_bytes;
 	uint64_t zone_align_start_offset;
@@ -37,7 +37,7 @@ static int get_new_sb(struct f2fs_super_block *sb)
 				zone_align_start_offset) / segment_size_bytes /
 				c.segs_per_sec * c.segs_per_sec);
 
-	if (c.safe_resize)
+	if (c.safe_resize || keep_meta)
 		goto safe_resize;
 
 	blocks_for_sit = SIZE_ALIGN(get_sb(segment_count), SIT_ENTRY_PER_BLOCK);
@@ -675,15 +675,37 @@ static int f2fs_resize_grow(struct f2fs_sb_info *sbi)
 	block_t end_blkaddr, old_main_blkaddr, new_main_blkaddr;
 	unsigned int offset;
 	unsigned int offset_seg = 0;
+	double overprovision = c.new_overprovision;
 	int err = -1;
 
 	/* flush NAT/SIT journal entries */
 	flush_journal_entries(sbi);
 
 	memcpy(new_sb, F2FS_RAW_SUPER(sbi), sizeof(*new_sb));
-	if (get_new_sb(new_sb))
+	if (get_new_sb(new_sb, false))
 		return -1;
 
+	/*
+	 * A safe resize shrink keeps the metadata areas sized for the old,
+	 * larger volume. Laying them out again for a smaller target would
+	 * move the main area backward, which the migration below cannot do,
+	 * so keep the current areas when SIT and SSA still cover the new
+	 * main area. NAT is not compared: it is capped by the checkpoint
+	 * bitmap, so it can come out larger for a smaller volume, and the
+	 * current one already served the old size.
+	 */
+	if (get_newsb(main_blkaddr) < get_sb(main_blkaddr)) {
+		if (get_newsb(segment_count_sit) > get_sb(segment_count_sit) ||
+		    get_newsb(segment_count_ssa) > get_sb(segment_count_ssa)) {
+			MSG(0, "\tError: Cannot move main area backward\n");
+			return -1;
+		}
+		memcpy(new_sb, F2FS_RAW_SUPER(sbi), sizeof(*new_sb));
+		c.new_overprovision = overprovision;
+		if (get_new_sb(new_sb, true))
+			return -1;
+	}
+
 	if (f2fs_resize_check(sbi, new_sb) < 0)
 		return -1;
 
@@ -739,7 +761,7 @@ static int f2fs_resize_shrink(struct f2fs_sb_info *sbi)
 	flush_journal_entries(sbi);
 
 	memcpy(new_sb, F2FS_RAW_SUPER(sbi), sizeof(*new_sb));
-	if (get_new_sb(new_sb))
+	if (get_new_sb(new_sb, false))
 		return -1;
 
 	if (f2fs_resize_check(sbi, new_sb) < 0)
-- 
2.56.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
