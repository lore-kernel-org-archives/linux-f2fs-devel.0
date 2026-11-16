Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2E2606A32A
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=SlTmDhL7;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JkrsrqJk;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=fjjJzwNl;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AFQF5ZQr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=JlWt57QMw1AzWVOKCZmunFUgl6ahaGuKd+8PyqvVbSo=; b=SlTmDhL7uSfjP+KhR7cpku3e2C
	os9844FIF9/wy5kdYj5AMD07j3xKbdEeUrqhpX0pH4/H/QmI9ooo55gRof4SVViFIcKvCXcLoMOr6
	AjlE2dQK60V7wC4jPwR7QoyhcQjaC1j8kkm1DP2hQAJZTpNXG/oB3ZxwxoBC9pvtoVGs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSo2A-000000005C2-0w9q;
	Mon, 16 Nov 2026 04:09:34 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSo28-000000005Bj-3qkQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zFy7dE+9TYlqdjzVOGIle0ydaLPC/hfnQSo/dWdrLPs=; b=JkrsrqJkDsKwbCqHcLx9nawx9v
 Bffmd6Nyj+RrmnjN6PaPRC9vNfBbAA4Zzj21qi/AsXvocNs4H4B2XT31mFXiH3YLiaeuAbOJTT6q9
 C2ep24zOLYaroW/aCA2S0haYEPaNg0mZfhr74S7/rSygFGZ8VtX8+Uy2IDD4uM+Z4JbM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zFy7dE+9TYlqdjzVOGIle0ydaLPC/hfnQSo/dWdrLPs=; b=fjjJzwNl1r77eRN48cCt55aYhj
 mZi+sYyqdRpx7FCjwqsN/XdybOGyfblpLIckOQTldzv5FekMFV2dJ+QS65xeLgQ9Z/sEzvxx3/4tz
 j0poW9cGS5fn1PwykJfh5SJzcjsK8vAofEbOfHZ/p3hEiMK2xlWXoNtz5qHlTaFcu2z0=;
Received: from mail-pj1-f54.google.com ([209.85.216.54])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSo28-000000007ce-1Ms2
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:32 +0000
Received: by mail-pj1-f54.google.com with SMTP id
 98e67ed59e1d1-3b179528d56so1336326a91.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 20:09:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794802166; x=1795406966; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zFy7dE+9TYlqdjzVOGIle0ydaLPC/hfnQSo/dWdrLPs=;
 b=AFQF5ZQrfmVjLwItCUEYp6jpHeZP2kfIVf+yXbs1o9eKQ+PnUAU41LxCH46ROxfbQx
 7osYICfilou/GpfMZqycVyyc3+3J/6LQP0aqs6+BX6g+cFwVguUvyPauFe5eg6juBZ7e
 65GRtLQU78aYXVA51smbecvP5ajh4DOS7uoqG4HEUrwDCBfnyEbqP9hjJ/eKrjUPvQDz
 VQkeeaDdTvgktlavOmu1rcLOKVh9VJZ2CwBPLlnitWSFJ28CxBvVpI37+lGDMCwqTcVj
 30Ta70rmv1fhmpLSc1vhwRKeSBcvKmm5bXvYu1ysfotANCWHztklvVoW0qC2Pj2D3ibz
 e3lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794802166; x=1795406966;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zFy7dE+9TYlqdjzVOGIle0ydaLPC/hfnQSo/dWdrLPs=;
 b=N7m6sWGvvz2iAId0ou6XAzu6ddDiH9BVF9WbU880RW+i4t3cij1nlQzMyHB+bvt2uQ
 gq+oJwr9kocjYG9aKEF0GAIMsdAzJZEVWD0jhKVxWDGU8NGPKe9W7EOCLLqLQXKO3aZj
 es3q/EzdThEFdKIl/k8J0gXy+ooD6Z++0gfxbcGDiKtWHQ3P79Hq5QvW0IDfCkdZ5jUb
 wKbvjuEVvfqgpKZA4hXHp5KHLqpmk7NvybiBxMoVTi98ezW7k6QxN+3H2FU2vrsNQrVz
 Z9mXdccC2/KKXQAvK0DdRoaE9K4fCgq7qlGXyNwgSsOilzgG+DtBZpsXjhhCNiXffdTL
 FcIA==
X-Forwarded-Encrypted: i=1;
 AL+hErG/g3nUGZ8AwsOdS/leNHws+z6Bpj7N7Uqe9lPYNwqv0KyGS1kElqPm5woUyqD1aRJhwldFMQs59EXVIkgNXGUH@lists.sourceforge.net
X-Gm-Message-State: APuU4Z/+g7pxmmMZQjmvfiDX5caQKjLwcdiyGtxWbjNRkDfJsiI2peIK
 7JvMp2L189TjmLA4I23pcz1oqf4LlWm7MVR01+OatBGj8iV3PJTdZOy2
X-Gm-Gg: AYBFou12UDKJ8Sif6s+rP4hWdEydjlQKT0jjjLA8Ned4e6xovv57aKGw4p75bP432M+
 JFgJxAcLLoCCfV9i9CWhSbbuBp7K12HO9NL4tp4obHi7NX0p6TLBkw8/KBq4mm3xXcuQOpAobFm
 NlqJlEgAbDCkWgt95wtBCcecnljfajr+dEkoj4pJIjKzK8HLFiFkVuDY7qaXUXTr7v5OHmQq7Q9
 tEqE57Udd27pYwaz7S5QGSG48Y0Mfx328hiq5uCUbAMiRxa/99dM0hPxDw3rVdqQKu0tITDrHk+
 QQT90e3POg4uqDBMrqrR5T3sZIvG0WK/RvG9u1ixw9EGEmEdgZOP1IZyU+geypJg/WwgBXnDieG
 pGTTOHbbqL7rYf/y2CMfyf+BURcMzEuAzpyU65N300JRre2TNJuhGug2Jl9Sto0VaY1xSaymjrY
 Hn5MzlxEjj5gYSU/x59VTXslS0eBwEhZ+j9OqabNDrxA2UlOIFpyTpMaxBvBKHP1jrUsKcJuzYo
 7cXZVpZ5Mv5ry8ZnfNFuO3j7xJO+OJulTbdtpUQFh4CUoP/tJ0DI+X7AQ8Ab/+l+gIufx4bndW5
 K6ca5ttvH/bRQ3psSneHD0IIgKNBiGx7rN15gF4wXSCSEtbFisvLvI1L3MQsLKQIRiWYgp2lp6V
 c9JhuLpl6feOg9ZwH1KA5GORorwZ1QRqiHC4uEdh4QbjhSpY=
X-Received: by 2002:a17:90b:2d88:b0:3b0:9e2c:9b60 with SMTP id
 98e67ed59e1d1-3b1b09facb7mr8472507a91.21.1794802166505; 
 Sun, 15 Nov 2026 20:09:26 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3f09b92sm7191989a91.4.2026.11.15.20.09.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 20:09:24 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 20:08:45 -0800
Message-ID: <20261116040851.2849696-15-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116040851.2849696-1-daeho43@gmail.com>
References: <20261116040851.2849696-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSo28-000000007ce-1Ms2
Subject: [f2fs-dev] [PATCH v2 14/20] f2fs: support subpage blocks in
 fs-verity enablement
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

Check verity per block. While enabling verity, dirty and write back
only the data blocks below i_size in the folios before the verity
metadata. Do not zero the blocks past i_size on read while enabling
verity, since GC can read a folio of the verity metadata that is already
written. Remove the -EOPNOTSUPP checks. The changes for enabling
verity also apply to large folios when the block size equals PAGE_SIZE.

Stop the data reads of a verity file at i_size in
f2fs_read_data_large_folio(), so that the blocks past EOF in the folio
that spans EOF are zeroed instead of read. A pinned file can have such
blocks allocated without being zeroed, and fs-verity rejects non-zero
data past EOF. The reads of the verity metadata still go past i_size.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/data.c   | 29 +++++++++++++++++++++--------
 fs/f2fs/f2fs.h   |  5 +++++
 fs/f2fs/file.c   |  3 ---
 fs/f2fs/verity.c |  8 --------
 4 files changed, 26 insertions(+), 19 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index f23f29d45763..9f7f8214d10e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1671,7 +1671,7 @@ int f2fs_reserve_block(struct dnode_of_data *dn, pgoff_t index)
 static inline struct fsverity_info *f2fs_need_verity(const struct inode *inode,
 						     pgoff_t idx)
 {
-	if (idx < DIV_ROUND_UP(inode->i_size, PAGE_SIZE))
+	if (idx < F2FS_BLK_ALIGN(F2FS_SB(inode->i_sb), inode->i_size))
 		return fsverity_get_info(inode);
 	return NULL;
 }
@@ -2619,7 +2619,12 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 
 static inline loff_t f2fs_readpage_limit(struct inode *inode)
 {
-	if (IS_ENABLED(CONFIG_FS_VERITY) && IS_VERITY(inode))
+	/*
+	 * The verity metadata is past i_size. GC can read it while verity is
+	 * being enabled, so do not zero it.
+	 */
+	if (IS_ENABLED(CONFIG_FS_VERITY) &&
+	    (IS_VERITY(inode) || f2fs_verity_in_progress(inode)))
 		return F2FS_BLK_TO_BYTES(F2FS_I_SB(inode),
 				max_file_blocks(F2FS_I_SB(inode), inode));
 
@@ -2913,10 +2918,10 @@ static unsigned int f2fs_folio_valid_blocks(struct inode *inode,
 	pgoff_t last_lblk = F2FS_BLK_ALIGN(sbi, i_size_read(inode));
 	pgoff_t first_lblk = f2fs_folio_lblk(sbi, folio);
 
-	if (f2fs_verity_in_progress(inode))
-		return nr_blocks;
 	if (first_lblk < last_lblk)
 		return min_t(pgoff_t, nr_blocks, last_lblk - first_lblk);
+	if (f2fs_verity_in_progress(inode))
+		return nr_blocks;
 	return 0;
 }
 
@@ -3409,7 +3414,14 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	index = f2fs_folio_lblk(sbi, folio);
 	offset = 0;
 	nr_blocks = f2fs_blocks_per_folio(sbi, folio);
-	last_block_in_file = F2FS_BLK_ALIGN(sbi, f2fs_readpage_limit(inode));
+	/*
+	 * A data read of a verity file, which has vi, stops at i_size. A
+	 * pinned file can have blocks past EOF that were allocated without
+	 * being zeroed, and fs-verity rejects non-zero data past EOF. Only
+	 * the reads of the verity metadata, which have no vi, go past i_size.
+	 */
+	last_block_in_file = F2FS_BLK_ALIGN(sbi, vi ? i_size_read(inode) :
+					    f2fs_readpage_limit(inode));
 
 	for (; nr_blocks;
 	     nr_blocks -= len_blks, max_nr_blocks -= len_blks,
@@ -3719,7 +3731,7 @@ static int f2fs_read_data_folio(struct file *file, struct folio *folio)
 			return ret;
 	}
 
-	vi = f2fs_need_verity(inode, folio->index);
+	vi = f2fs_need_verity(inode, f2fs_folio_lblk(F2FS_I_SB(inode), folio));
 	if (vi)
 		fsverity_readahead(vi, folio->index, folio_nr_pages(folio));
 	return f2fs_mpage_readpages(inode, vi, NULL, folio);
@@ -3739,7 +3751,8 @@ static void f2fs_readahead(struct readahead_control *rac)
 	if (f2fs_has_inline_data(inode))
 		return;
 
-	vi = f2fs_need_verity(inode, readahead_index(rac));
+	vi = f2fs_need_verity(inode, F2FS_BYTES_TO_BLK(F2FS_I_SB(inode),
+						      readahead_pos(rac)));
 	if (vi)
 		fsverity_readahead(vi, readahead_index(rac),
 				   readahead_count(rac));
@@ -4777,7 +4790,7 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 			op_locked = true;
 		}
 
-		if (!verity_in_progress) {
+		if (!verity_in_progress || end_pos <= f2fs_verity_metadata_pos(inode)) {
 			poff = offset_in_folio(folio, isize);
 			end_index = isize >> PAGE_SHIFT;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f588603dd1d0..f84d6f4cd1eb 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -5349,6 +5349,11 @@ static inline bool f2fs_allow_multi_device_dio(struct f2fs_sb_info *sbi,
 	return sbi->aligned_blksize;
 }
 
+static inline loff_t f2fs_verity_metadata_pos(const struct inode *inode)
+{
+	return round_up(i_size_read(inode), 65536);
+}
+
 #ifdef CONFIG_F2FS_FAULT_INJECTION
 extern int f2fs_build_fault_attr(struct f2fs_sb_info *sbi, unsigned long rate,
 					unsigned long type, enum fault_option fo);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 26dd06961389..8540613e3b22 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -4331,9 +4331,6 @@ static int f2fs_ioc_enable_verity(struct file *filp, unsigned long arg)
 {
 	struct inode *inode = file_inode(filp);
 
-	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode)))
-		return -EOPNOTSUPP;
-
 	f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 
 	if (!f2fs_sb_has_verity(F2FS_I_SB(inode))) {
diff --git a/fs/f2fs/verity.c b/fs/f2fs/verity.c
index af1b7f21c1d8..5f579d0b917b 100644
--- a/fs/f2fs/verity.c
+++ b/fs/f2fs/verity.c
@@ -32,11 +32,6 @@
 
 #define F2FS_VERIFY_VER	(1)
 
-static inline loff_t f2fs_verity_metadata_pos(const struct inode *inode)
-{
-	return round_up(inode->i_size, 65536);
-}
-
 /*
  * Write some verity metadata to the inode for FS_IOC_ENABLE_VERITY.
  * kernel_write() can't be used because the file descriptor is readonly.
@@ -94,9 +89,6 @@ static int f2fs_begin_enable_verity(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	int err;
 
-	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode)))
-		return -EOPNOTSUPP;
-
 	if (f2fs_verity_in_progress(inode))
 		return -EBUSY;
 
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
