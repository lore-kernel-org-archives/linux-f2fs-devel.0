Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F50606A33E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=TX/QBret;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=m3aH5XHK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=YaW8oN38;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=svw5JqHU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=IrNo2LZVFgZG4hFSzCT9CWzLVSi6q2NzCYrfMRJPBrE=; b=TX/QBret+x1kzKsFgeMcVJXZdw
	6IvVKn7MNIj5vxLdd4SaAKmsjYKy16EexaCAMRkxed7L+0BL9i17osPmvGz32T4Gin+/zNdOR1zkR
	XvmOfjzj27NKYMgMMyPNFBw0FfrYzQyE41kbYct1CA61yG8Wc2C6UOKzPB8Jj6BEHLcI=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSo28-000000007uU-0qed;
	Mon, 16 Nov 2026 04:09:32 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSo27-000000007uF-0Deh
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=133HbCo60K4Fb2CifrvokXMCTgGuA8mmVi7WhyYrJ4M=; b=m3aH5XHKfZSrC9MRgBgXL8BupD
 rl8uvKUBzg49eARsCXYNArpcwk5mFv9F7akqmbJ4yKeyjpalFsacPXbHC/f8M/VI7KbtlpDp20tRC
 S3WUwcyv2s597qAkGI4k2T3oIO120bop//tbpy2jIHVhvHvAeLq3+9pE7uw5k6eqxVvk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=133HbCo60K4Fb2CifrvokXMCTgGuA8mmVi7WhyYrJ4M=; b=YaW8oN38P2WqMl9G4Uhq6nCGLU
 FCUZswqGZ6IgMIsd7wdH6Uyv1dasg1YD+BpyOasggHLwHv3IktWJJl/I3VgK5MQMX1dNBr298SXqp
 q2jepX/oz3t2ADfDyzvU/QgvbpxC9VdcHUeK4KE/fUf35JoFUKIb+2pOUlE5/f7K78D4=;
Received: from mail-pj1-f49.google.com ([209.85.216.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSo25-000000007cc-2nWK
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:30 +0000
Received: by mail-pj1-f49.google.com with SMTP id
 98e67ed59e1d1-3b0d09df973so3596820a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 20:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794802164; x=1795406964; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=133HbCo60K4Fb2CifrvokXMCTgGuA8mmVi7WhyYrJ4M=;
 b=svw5JqHUhEwFNRxxF+jqUP2vnwZMGhP9EpZu4cz+wo3TnAYNtLb2AF6Exxpt3mpuef
 /BrlrpsQqVWUNnLzbMt96EnZcuvGfx+YsyBtAFMA+BMnxenRNEnTeQd1TxHRVwQAVf7U
 CbOrws5uJzYKnrJzsVXUGuRbEqxY8arGriSlazNajIuwwyBny6nfvIv/UhWEx0czKCiM
 nMSpHP/Ccl8+k/EP6HQjrnSdf61Br4s7HxEGA3Aadg68IWm7pM8ZBhukTzhD7PxihkQI
 0XFODHepwm77cNtjjVZmvlU9DQZ3g5HjW3DMRnzyIclfaIgI7oczCTuNFwMKdGaQ277b
 wv9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794802164; x=1795406964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=133HbCo60K4Fb2CifrvokXMCTgGuA8mmVi7WhyYrJ4M=;
 b=PyxvzQe4dOoRCb19coqMEd96zHm8GJWUNBUrDKsCwm0uHE30BZ+PpYhehj2odNAESu
 DFp/YRVQ2qXJUUs1g8G9887tSdfYpezUyxPxbBrZHVZ5BYW2FMdYqdh/ethZGKuyharB
 WqB7gBh/N2ai0+l5GHIyjNXPuW9sZ+N/hIwCBb9/uZCM4NZEkDLYlnVt8SgnRX7Kbo2q
 Cto2Er2j2/Go6Npy4JJnML7mQn47ZzDWcjd43CyREvDCc6P8yd84gIAUzRa9r93OXMbz
 VvqoExE1lnt59ZYuHwQHJRCK05Jt3d88rLq+kWcWZkWwX0DVBQRw7X9bnJR6byY76Qe3
 ALYQ==
X-Forwarded-Encrypted: i=1;
 AL+hErEhGtnoyRt2l1DugclhtVQXzVLAgeZT4JelE2pS6VSFWdzkmSsLCcQx9Q23x/DPPfwl6eOUkT+bo7UME2ln3hlp@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9AEqar2fqpb6sO7MXV3mP4TqkZHjqPDppKY8AMVRfNSy8tW8R4
 tbIAnfmB8IA8I602jY7fs/JDA5SmTUYKPC41onsSIf8dMj+T5eUUsoZSqiDarQ==
X-Gm-Gg: AYBFou0U+T/XmuOM2NeiFSOQixmWwl8oCkR/aj0epI3nJnp9gPnC5NC5383w8/1I7b1
 eNDbJk6uS3A4U+aCbosYmTWbJnS0KvS2qaJSKgm+Zwgw2bLPQ4bJrQjdzSju6CIJ3HdQziS3zo6
 ewFbN5Bt6K8MqLXfHd2O6uiWSehuLDXO5a8QOXARGz8K7PDrGZr53VVKosY6ptqx03sDyq0jFqJ
 oyDNLVY61OJCi/z+U+0HHuOhS5ag8c4FvRyc8Lo3QgtfRQKnrBy7fy4M85W4Fv/xqC5jRAEJdXN
 2FA9lSHXn4smr5e2seSd/SGY16Ll00ECLy659u2WOLrItvo0/d6rk9yCoT3Z+Dsj0cj04hjyDtb
 6Ad2oAQsl1PEUMWfzG9ge8N4sHpz5IxG9XUo+PobVg3u44YoKL698ovFy/9l7pxik9WrNG6zfPQ
 qvlU2d93YAxyFDhZJsxr9T5bsQq1pS0I0zqCKcmrgKxZCWyACyjbpaoaJ7fG7ex/bB31yzcfAvR
 ZeD5L1oJhZrgaBYTWHDbTeBU/VxMdy39/ZcaB222rMHVaaFH1/nF9TwA6h845x522nxiuYGYNy9
 MnFbjBlhvooE3l3+0qdbH7SF3p+mOY7vrrxjbZ8vtbv7FU725JPFeNxu4geluidl1HshCWydpbe
 Mz3MupjsZfI8TH94VAIUkXxVk4E8dUt1fOnsB31/Y21Ol/fY=
X-Received: by 2002:a17:90b:1cce:b0:3ad:13fe:41ba with SMTP id
 98e67ed59e1d1-3b1b0a4a16amr9226007a91.52.1794802164013; 
 Sun, 15 Nov 2026 20:09:24 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3f09b92sm7191989a91.4.2026.11.15.20.09.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 20:09:22 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 20:08:44 -0800
Message-ID: <20261116040851.2849696-14-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116040851.2849696-1-daeho43@gmail.com>
References: <20261116040851.2849696-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSo25-000000007cc-2nWK
Subject: [f2fs-dev] [PATCH v2 13/20] f2fs: support subpage blocks in
 swapfile activation
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
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,
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
index 98ceea49e426..f23f29d45763 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -6007,8 +6007,8 @@ static int f2fs_migrate_blocks(struct inode *inode, block_t start_blk,
 			}
 
 			f2fs_ffs_mark_subrange_dirty(folio,
-				offset_in_folio(folio, (loff_t)blkidx << PAGE_SHIFT),
-				PAGE_SIZE);
+				f2fs_folio_byte_offset(sbi, folio, blkidx),
+				F2FS_BLKSIZE(sbi));
 			f2fs_folio_mark_dirty(folio);
 			f2fs_folio_put(folio, true);
 		}
@@ -6040,8 +6040,10 @@ static int check_swap_activate(struct swap_info_struct *sis,
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
@@ -6056,9 +6058,12 @@ static int check_swap_activate(struct swap_info_struct *sis,
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
@@ -6093,7 +6098,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 			not_aligned++;
 
 			nr_pblocks = roundup(nr_pblocks, blks_per_sec);
-			if (cur_lblock + nr_pblocks > sis->max)
+			if (cur_lblock + nr_pblocks > max_lblock)
 				nr_pblocks -= blks_per_sec;
 
 			/* this extent is last one */
@@ -6114,20 +6119,28 @@ static int check_swap_activate(struct swap_info_struct *sis,
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
@@ -6136,9 +6149,9 @@ static int check_swap_activate(struct swap_info_struct *sis,
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
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
