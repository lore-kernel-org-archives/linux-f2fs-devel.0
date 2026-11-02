Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3B3606A324
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 19:41:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=eDOi5meh;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=jwoh7z6B;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NC+v7sEK;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LkbIidrZ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=F3nFqMUhznuliVku+S2FJl+SlfPddYr1lPplAPcwP3I=; b=eDOi5mehNfoXvCcgQxD484QOXS
	RlcpFwxV2TiPIyiaSpRNq33sVauhf1wfysqs+80iHeG2+DuJGlbeq1+8Dh7V2lA11IoBF4KGkoCYC
	JnPGlo0WpgaBaXWlnlyZVGDf4qrvhL4oPYpulPGMobYVcvWJmjyVRp+TgELOEYK1u4Xg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNxu1-000000003UU-0vfE;
	Mon, 02 Nov 2026 19:41:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xNxtW-000000003Ql-2I6f
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Uylky+Z6UrkBhMKIZnvpLNSYYgiE4zCBO5CqWl99wZ4=; b=jwoh7z6B9W/WF79A/hOx6lmmZ/
 A+M7d1fTzQq9HjyZIR9AbgRJuPrEirbqMqsq5/Ao3NXMlucnciDgbpeHlQwoaEwV6PdSYYy63hmBr
 F2ebqrCt7eCjLWqj0FZV0MOxk8n4xp4F8hgwKucSHdOYRQ3d9pk0hFH+IIIjMNZa9MAM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Uylky+Z6UrkBhMKIZnvpLNSYYgiE4zCBO5CqWl99wZ4=; b=NC+v7sEKFpRLGVduUAseOrN16Y
 aZgahWPIQIzDgcPeNvEjsS7xkY3mG6AEceMtosRtHvp/i2ruulQJEq9/tN/3IRKqj2LE8u+2n18d/
 GIgHTcsjSx9FjQBv60/ymknpCvcXLGhS9EaiJidtPEYiWKvb/SCJBMBOKKM8cp/sGhao=;
Received: from mail-pf1-f169.google.com ([209.85.210.169])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xNxtV-000000002Zs-3x9P
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 19:40:38 +0000
Received: by mail-pf1-f169.google.com with SMTP id
 d2e1a72fcca58-8ac1f2ff78dso730775b3a.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 02 Nov 2026 11:40:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793648432; x=1794253232; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Uylky+Z6UrkBhMKIZnvpLNSYYgiE4zCBO5CqWl99wZ4=;
 b=LkbIidrZBrGrvdfGA0ddFYHiimMy0ys8xx/5CpWX9Hk7stsC9F6fm+0fkJp6fOoOj2
 3/b66rea2nA9LpWepPci8T+f3iKSdRTk9FIaxSw12UnX7E7fa2/BxhUvloya/5AR6w07
 tob6O/JdyOXbRKWjkELGCLl18NsXLJ1yBgn4XYf4gHVCIPDZ8JTqm1aglLMxV9n6lK0S
 pLO7BVBBRSIOIb1HFcdvnb1ObfU1/vuOZtRFqSqTqWgzciuq4fkO2LID/nxnjjjt2MRf
 HaOr7tGX7e7lxZXxbrMD6z4hEqz21SEqTIBVUoC87fb4wQ9mELyaLwyw8R57VqWCxzy7
 EL/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793648432; x=1794253232;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Uylky+Z6UrkBhMKIZnvpLNSYYgiE4zCBO5CqWl99wZ4=;
 b=bwpTmh6qQOqnBrJqHXfZNOr3//JXzM/D0xpLR1gY7umiIPVsGMSngCkuvjd4WGpANq
 +YWkvE6bKgVkd6L/39rDPMkZ1IbIlW56a8ImuGHbS93JdeQ811Fqmp7i1p0TEJ1cbJ8M
 raDVXG15EX2HcQeAlsVOoAlB7zIDlH7ANvuvs6Phm21Sbf3gX1FfybtVjg8UxgpghRRX
 BEXcIHFBr5yCWXYYBJjQXoEwcTrDsRAm9Rf22cBQrb6blXISckSewYH31zVogZDI16gL
 Oe1xVpOue+T0B7UHCqUbu0t1Dvth84KG0daalAOA+ozI+tcbotAHYF47YfZkbBi2M8Zt
 iY1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBxe6qwZveGEiGfUkJ4slHyWM+mehsGcVh1XS5jpJFr7R1GMEKRZuaFw8FngUeB4oa7Y403Zk6UmS4XV6lqXhkFk@lists.sourceforge.net
X-Gm-Message-State: AFq9FYISit/eQt1folRvBc2U1IhWcax8eAFcVdXSEVnneJ7EKwI72luM
 9UPGUKB7GTXObAUTqi+DrMrRbzEm3QuowPXYhuZAP8xVCT19z+mA75+V
X-Gm-Gg: AYBFou1yDi3/DaWXT6Bmq7hMSexMPJF5JwMQhBPl/wPaM6dORLcZioH4t6rZoV2JWDx
 VLsoJVymPxAkqJOT1/PNcRcA9s5JwYEwuwfJ9tEvgTBapi7fBJnOo/ZSwFFemmOGhUiWWsGuomP
 CZ7R9eKPUxJIjBSUR2YTN19KjnRW/2V9XyM2+29vUyGnnOE2p8czcGm/nTWYQ4G/Mhjqvjy3DbW
 aHAYn7nhRBJoSh4X/mwhu4rtoik54hEcgESBCwvPHTBu729y3eJLWkVHkTOCsH9KqFb6LS4s6jr
 NlzJVMSGd6rOaAoXfCoKgzy+HEwTj0lfK1hg/1eQFouCKHKFa4WA+I3s1gTz3p068wxoZC+dwqM
 rlGFbtAxqGU82nu6UQ/fw21BSjNyOKfd8TpvI6yPdvcLGLciNdgCdJakBeK0nqyGGo7O2ss2NBp
 SMswe7nSOoGi/mpW6KHzUxPIR7RoILCkITxrkfVfJM/bQdI3j2zGjUfl6doB61JMbdy9tu2l14u
 kV0IVaJcylM37miyoQc5WLtSqJv4UY5pceHUSyudfgSfDJTmLXlIBCk7ALSPiQPbuzXoMpfzWTs
 CBMWbSz+if1R5EGDSXfRmPYpjudFVUOG5aFXSc0X6DMgPlngBpLZKEfAI522lzrgpZtwNMJGzrU
 C3CCQEVOISvXN4yw6+ydHcWLTxMi0I0onWazXLd1sHLmpuQ==
X-Received: by 2002:a05:6a20:be87:b0:3eb:50c9:b3c6 with SMTP id
 adf61e73a8af0-3eb50c9b862mr1792549637.22.1793648432182; 
 Mon, 02 Nov 2026 11:40:32 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cdb364c48d4sm241826a12.27.2026.11.02.11.40.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2026 11:40:31 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Mon,  2 Nov 2026 11:39:45 -0800
Message-ID: <20261102193952.3002018-14-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.385.gac671c819a-goog
In-Reply-To: <20261102193952.3002018-1-daeho43@gmail.com>
References: <20261102193952.3002018-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xNxtV-000000002Zs-3x9P
Subject: [f2fs-dev] [PATCH 13/20] f2fs: support subpage blocks in swapfile
 activation
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Daeho Jeong <daehojeong@google.com>

The swap subsystem works in PAGE_SIZE units. Ignore a partial tail
page, require PAGE_SIZE aligned extents, and convert block counts and
addresses to pages for swap. When migrating blocks, mark only the
migrated block, not its whole page, dirty in the folio state.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/data.c | 43 ++++++++++++++++++++++++++++---------------
 1 file changed, 28 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 77915a2eb190..929a2beef379 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -5876,8 +5876,8 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 			}
 
 			f2fs_ffs_mark_subrange_dirty(folio,
-				offset_in_folio(folio, (loff_t)blkidx << PAGE_SHIFT),
-				PAGE_SIZE);
+				f2fs_folio_byte_offset(sbi, folio, blkidx),
+				F2FS_BLKSIZE(sbi));
 			folio_mark_dirty(folio);
 			f2fs_folio_put(folio, true);
 		}
@@ -5909,8 +5909,10 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	struct address_space *mapping = swap_file->f_mapping;
 	struct inode *inode = mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	unsigned int blks_per_page = F2FS_BLKS_PER_PAGE(sbi);
 	block_t cur_lblock;
 	block_t last_lblock;
+	block_t max_lblock;
 	block_t pblock;
 	block_t lowest_pblock = -1;
 	block_t highest_pblock = 0;
@@ -5925,9 +5927,12 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	 * to be very smart.
 	 */
 	cur_lblock = 0;
-	last_lblock = F2FS_BYTES_TO_BLK(sbi, i_size_read(inode));
+	/* swap uses whole pages only; ignore a partial tail page */
+	last_lblock = round_down(F2FS_BYTES_TO_BLK(sbi, i_size_read(inode)),
+				 blks_per_page);
+	max_lblock = min_t(u64, last_lblock, (u64)sis->max * blks_per_page);
 
-	while (cur_lblock < last_lblock && cur_lblock < sis->max) {
+	while (cur_lblock < max_lblock) {
 		struct f2fs_map_blocks map;
 		bool last_extent = false;
 retry:
@@ -5962,7 +5967,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 			not_aligned++;
 
 			nr_pblocks = roundup(nr_pblocks, blks_per_sec);
-			if (cur_lblock + nr_pblocks > sis->max)
+			if (cur_lblock + nr_pblocks > max_lblock)
 				nr_pblocks -= blks_per_sec;
 
 			/* this extent is last one */
@@ -5983,20 +5988,28 @@ static int check_swap_activate(struct swap_info_struct *sis,
 			goto retry;
 		}
 
-		if (cur_lblock + nr_pblocks >= sis->max)
-			nr_pblocks = sis->max - cur_lblock;
+		if (cur_lblock + nr_pblocks >= max_lblock)
+			nr_pblocks = max_lblock - cur_lblock;
+
+		if (pblock % blks_per_page || nr_pblocks % blks_per_page) {
+			f2fs_err(sbi, "Swapfile extent is not aligned to PAGE_SIZE");
+			ret = -EINVAL;
+			goto out;
+		}
 
 		if (cur_lblock) {	/* exclude the header page */
-			if (pblock < lowest_pblock)
-				lowest_pblock = pblock;
-			if (pblock + nr_pblocks - 1 > highest_pblock)
-				highest_pblock = pblock + nr_pblocks - 1;
+			if (pblock / blks_per_page < lowest_pblock)
+				lowest_pblock = pblock / blks_per_page;
+			if ((pblock + nr_pblocks) / blks_per_page - 1 > highest_pblock)
+				highest_pblock = (pblock + nr_pblocks) / blks_per_page - 1;
 		}
 
 		/*
 		 * We found a PAGE_SIZE-length, PAGE_SIZE-aligned run of blocks
 		 */
-		ret = add_swap_extent(sis, cur_lblock, nr_pblocks, pblock);
+		ret = add_swap_extent(sis, cur_lblock / blks_per_page,
+				      nr_pblocks / blks_per_page,
+				      pblock / blks_per_page);
 		if (ret < 0)
 			goto out;
 		nr_extents += ret;
@@ -6005,9 +6018,9 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	ret = nr_extents;
 	*span = 1 + highest_pblock - lowest_pblock;
 	if (cur_lblock == 0)
-		cur_lblock = 1;	/* force Empty message */
-	sis->max = cur_lblock;
-	sis->pages = cur_lblock - 1;
+		cur_lblock = blks_per_page;	/* force Empty message */
+	sis->max = cur_lblock / blks_per_page;
+	sis->pages = sis->max - 1;
 out:
 	if (not_aligned)
 		f2fs_warn(sbi, "Swapfile (%u) is not align to section: 1) creat(), 2) ioctl(F2FS_IOC_SET_PIN_FILE), 3) fallocate(%lu * N)",
-- 
2.56.0.317.g454f8302e1-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
