Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A890606A33F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Nov 2026 04:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VyXWhI73;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NHgR1YPK;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=Qpa/wNes;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=cdkXCpIu
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=vi+Qpe9YAqyUMrIT739B9+5E4k3i7Tp2yl3XjJxoMm0=; b=VyXWhI73NAgqREeQNG7MWIrvuF
	A++ufbw6AXgJcVRunNrGA4relqONQrpWvNdSpSFb4KVb6oAEgZj68DRBKpK9y0XwVs7diMpZC7axg
	N3pHF4XIcWqYQr75xvYbGo42reyj2dECiI3gy9559xKmCNUO1Ow+cPJLs54K5bSAUj0E=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xSo2V-000000006nJ-38LK;
	Mon, 16 Nov 2026 04:09:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <daeho43@gmail.com>) id 1xSo2U-000000006mn-0uWb
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AEPtTsE9+BqPUNyu/7Xs4ryEKfYw2UJCJ0kkerQVg/8=; b=NHgR1YPK0z3+Bv+IRTEkBlKnvL
 MM/mYzblc+BBAZ1fVJ0hvhpJot4zVDiPEqRn0B5L3HHwMsiG0zjMmnvtgnclrNH1FOMUw3vDI4BFz
 /8JKMQH3xoqcjl8iZFPAMfJqMAkx3WjlSq9xW2lCVythi/NcJ7M9aqhu0S17mUUS7rGA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=AEPtTsE9+BqPUNyu/7Xs4ryEKfYw2UJCJ0kkerQVg/8=; b=Qpa/wNesoVMUz4WAXgGSsTgBai
 LWxabrjMqDFlhOrxwgjS6/H4eu+HF3QfcFEAGN3SO2gUgM64yl/DKoq21SorFSwIIU7HCiFxngx3U
 gLNQxBHuKE/zNLjoleL5GtLS7uLfuESDjmb5B7DYTl6+ppU6iSMUwRWu618Ozh3t87Cs=;
Received: from mail-pg1-f170.google.com ([209.85.215.170])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xSo2J-000000007d3-1bRc
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Nov 2026 04:09:54 +0000
Received: by mail-pg1-f170.google.com with SMTP id
 41be03b00d2f7-cdb75699c7cso1101244a12.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 15 Nov 2026 20:09:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794802178; x=1795406978; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AEPtTsE9+BqPUNyu/7Xs4ryEKfYw2UJCJ0kkerQVg/8=;
 b=cdkXCpIu/mB5ltr0h4lwyov/Zfdhbj8mrz40g4gEoYDGxvRGBtX9kYRm+HC1nfroZM
 WSnIgUw5wLX/GI56MHqM45g0nGGb92laRrDMqzdVy2IJRyFfcdoSN2WFn1neC97yKJ6I
 a3X0JIob5ScgK4RslcuPLlJ513OR2GPRv83xQ7i4wtqOKZ6eoh40vsI8WVkFcWkdeYdk
 InaedRqW03SjbjBaoXunviYEtXd5QgNE9auXjq8zRSQusJGDEAYeuRfLnwlir7pTA6lb
 /11goIQmM924FQu1nu4/6M+NWVdw8oYRWwzumn13sf81zjz6PM4j8JG1lL3A7MWnXCOo
 ZY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794802178; x=1795406978;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=AEPtTsE9+BqPUNyu/7Xs4ryEKfYw2UJCJ0kkerQVg/8=;
 b=PdetDn/vGmsWpdSrTA6Cen5h4VQgxwSFoIOUp66b6hyYDIKHZSqrWUCBOIUmxXFhdB
 qi7DSWk0Onu9/kmaW1S2wgguKbuWJ1H1pORcC2qcZaKZ8sHT0TltmAN4jo32qILByCXW
 Yg3INJQLV8hINruKkFyRsPQZKwNUHYYeqMqwGi9GPyQLRMGFcVCmRrwR2kqt87BGqxgM
 CAHLCruakyDHtiarnmdm+VF4a/O0I1sz5uDe9qrjoiFGID/2dDv6MlZl7PrLq2t24tA3
 Qp32rZJDAhzzUd4Lse/W48WEJufkvbd/wWV7FFnMM/67r3Lnhg900YUZzpKdl2uw1J0L
 LpwQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGQxYiplvNz4pIsv0w0IZOwvK7R+Ead4N/iCQN9WJrMHxUBs/Dwj9Geyv4mfmWquHLch3/3YW7fFRa5C8JgmCWq@lists.sourceforge.net
X-Gm-Message-State: APuU4Z8f3+rsf1F2z63O8zlkyTOuNFOQZh7MkqDS7F44Jk/o852wKIAO
 FKCkz3Gfh8FOamMww9P8L6MxquRF3bbQrlQHWb14cyJ1qpyNBf+Ne6lv
X-Gm-Gg: AYBFou0fpvUIaR5noM+jERGnwmL2vqx5B5LeEs9/MTHitr4D6GzcrQyq8hFs0LEEW27
 bHaZ1mw6ABs3NY24lQanYZuD6aru2AA1y/l5n03Ec/IqtxYs04gz+8l6bJ8jGLasfUFd0w9DxNy
 AjbRVkVBxamRcIrYlJP0QI+y+KlDuu52+cbhFX9AfrDwOGy3bzvoyfeZNmOD3PYUQNDcXzKM2k9
 6dnlw2LHdRWvOrPpVjJZP9gHiIjC1d8qolO9XfdQ93/85BtgaK88eOZJ74s2HF3xGBJHDhp2VlK
 8fh2G0LEX1Lj8tFvhcJqFv4PpBSJp+fRCELhVPFDny0/eNEitDSkw0zuiaeCw3DHbC9oF6g5b7X
 X43j3P/+rmhZsHbnJGuDwdsq5f/4EndlD//xqqUbkD3n6ElcRv6bUaVLFroUbkERSk9QAQiGSk7
 slmE6KDcazY4DkiXCnfaX4o+64RLntkJxHak1nLI/HNnWNlDv+cuV3xpkN+lYgJ0Jt7dgeV1II6
 THdnofi8naJ0jNERJEnuDO0BBD7raAOfJN25utCpBkeWLPridr2JRojtJ0WeE2WvS+rqCUVL3lq
 PJVEh7yVrqlUBAchD3cjzmThKZ/Zn9sQnnlBGzSmS58mocjrNj6jLRpC4S5Aw7mOC0HZOa/EI8r
 NYHOs/62eWCu205F2BDzum/zW1LBzGTcVTK7Xo1nDwDE+djc=
X-Received: by 2002:a17:90b:5806:b0:3ab:e588:c275 with SMTP id
 98e67ed59e1d1-3b1b0a0e864mr8062401a91.20.1794802177113; 
 Sun, 15 Nov 2026 20:09:37 -0800 (PST)
Received: from f2fs-test.c.googlers.com.com
 (193.67.125.34.bc.googleusercontent.com. [34.125.67.193])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1b3f09b92sm7191989a91.4.2026.11.15.20.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 15 Nov 2026 20:09:35 -0800 (PST)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 kernel-team@android.com
Date: Sun, 15 Nov 2026 20:08:49 -0800
Message-ID: <20261116040851.2849696-19-daeho43@gmail.com>
X-Mailer: git-send-email 2.56.0.611.g1030f0b940-goog
In-Reply-To: <20261116040851.2849696-1-daeho43@gmail.com>
References: <20261116040851.2849696-1-daeho43@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: 1.1 (+)
X-Headers-End: 1xSo2J-000000007d3-1bRc
Subject: [f2fs-dev] [PATCH v2 18/20] f2fs: support subpage blocks in
 compression
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

With subpage blocks, a cluster spans fewer folios than blocks, and
several compressed blocks share a bounce folio.

- Require a cluster to cover at least one page. This raises the minimum
  compress_log_size only when a page has more than four blocks, e.g. to
  64KB for 4KB blocks on a 64KB page kernel, where the mount option and
  F2FS_IOC_SET_COMPRESS_OPTION reject a smaller one. A file that already
  has a smaller cluster is handled like one with an unsupported
  compression algorithm: it can be looked up and removed, but opening it
  fails with -EOPNOTSUPP.
- Use block offsets and sizes for compressed data, keep each compressed
  block at its block offset within the cluster, and count pending
  compressed I/O in blocks so that a shared bounce folio is not
  decompressed or freed early.
- Submit only the written block of a shared bounce folio in
  f2fs_submit_page_write(), at its offset in the folio.
- Keep compressed files on the page based read and write paths, and
  compress a cluster only when all of its blocks are dirty and below
  EOF.
- A folio with per-block state may hold uptodate blocks newer than the
  on-disk cluster, so decompress into a bounce page and copy back only
  the blocks that are not uptodate.
- Cache compressed blocks one block at a time in the compress cache.
- Lock only the unlocked pages in cancel_cluster_writeback() to avoid a
  self-deadlock.
- Attach a folio state to the multi-block folios of a rewritten cluster
  before they are dirtied, as the other write paths do.
- Attach a folio state to multi-block folios that have none when
  compressed writeback starts, as the raw write path does. Otherwise the
  write completion, which does not hold the folio lock, can detach the
  page private flags while a task is moving them into a new folio state.
- Take sbi from the dic to count the blocks of a compressed page in
  f2fs_finish_read_bio().
- Write the blocks of a multi-block folio in
  f2fs_write_single_data_page() as f2fs_write_cache_folios() does,
  taking the write_blocks_pending bias with a new helper shared by the
  two and dropping it with f2fs_ffs_put_write_pending().
- Count a read folio of a compressed file once in the iostat:
  f2fs_mpage_readpages() counts the folios that go through its loop,
  and f2fs_read_data_large_folio() counts the others.
- Remove the -EOPNOTSUPP checks.
- Remove inode_inc_dirty_block() and inode_dec_dirty_block(), which
  have no caller left.

The bounce folios are now freed when the last block of a cluster
completes, also when the block size equals PAGE_SIZE.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 Documentation/filesystems/f2fs.rst |   7 +-
 fs/f2fs/compress.c                 | 567 ++++++++++++++++++++---------
 fs/f2fs/data.c                     | 293 +++++++++------
 fs/f2fs/f2fs.h                     |  71 ++--
 fs/f2fs/file.c                     |  55 +--
 fs/f2fs/super.c                    |   7 +-
 6 files changed, 657 insertions(+), 343 deletions(-)

diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
index b79bb67ee78e..4d827c8a98d8 100644
--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -319,7 +319,12 @@ compress_algorithm=%s:%d Control compress algorithm and its compress level, now,
 				 =========      ===========
 
 compress_log_size=%u	 Support configuring compress cluster size. The size will
-			 be 4KB * (1 << %u). The default and minimum sizes are 16KB.
+			 be block size * (1 << %u). The default and minimum sizes
+			 are four blocks, i.e. 16KB with 4KB blocks. A cluster has
+			 to cover at least one page, so they are one page if a page
+			 has more than four blocks, e.g. 64KB with 4KB blocks on a
+			 64KB page kernel, where a file with a smaller cluster
+			 cannot be opened (-EOPNOTSUPP).
 compress_extension=%s	 Support adding specified extension, so that f2fs can enable
 			 compression on those corresponding files, e.g. if all files
 			 with '.ext' has high compression rate, we can set the '.ext'
diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index c63622b6c49a..d0e989254ffe 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -57,14 +57,15 @@ struct f2fs_compress_ops {
 	bool (*is_level_valid)(int level);
 };
 
-static unsigned int offset_in_cluster(struct compress_ctx *cc, pgoff_t index)
+static unsigned int offset_in_cluster(struct compress_ctx *cc, pgoff_t lblk)
 {
-	return index & (cc->cluster_size - 1);
+	return (lblk & (cc->cluster_size - 1)) >>
+		F2FS_LOG_BLKS_PER_PAGE(F2FS_I_SB(cc->inode));
 }
 
-static pgoff_t cluster_idx(struct compress_ctx *cc, pgoff_t index)
+static pgoff_t cluster_idx(struct compress_ctx *cc, pgoff_t lblk)
 {
-	return index >> cc->log_cluster_size;
+	return lblk >> cc->log_cluster_size;
 }
 
 static pgoff_t start_idx_of_cluster(struct compress_ctx *cc)
@@ -114,7 +115,9 @@ static void f2fs_drop_rpages(struct compress_ctx *cc, int len, bool unlock)
 
 static void f2fs_put_rpages(struct compress_ctx *cc)
 {
-	f2fs_drop_rpages(cc, cc->cluster_size, false);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
+
+	f2fs_drop_rpages(cc, cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi), false);
 }
 
 static void f2fs_unlock_rpages(struct compress_ctx *cc, int len)
@@ -125,9 +128,11 @@ static void f2fs_unlock_rpages(struct compress_ctx *cc, int len)
 static void f2fs_put_rpages_wbc(struct compress_ctx *cc,
 		struct writeback_control *wbc, bool redirty, bool unlock)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
+	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
 	unsigned int i;
 
-	for (i = 0; i < cc->cluster_size; i++) {
+	for (i = 0; i < nr_folios; i++) {
 		if (!cc->rpages[i])
 			continue;
 		if (redirty)
@@ -158,22 +163,24 @@ void f2fs_destroy_compress_ctx(struct compress_ctx *cc, bool reuse)
 	cc->rpages = NULL;
 	cc->nr_rpages = 0;
 	cc->nr_cpages = 0;
-	cc->valid_nr_cpages = 0;
+	cc->valid_nr_cblocks = 0;
 	if (!reuse)
 		cc->cluster_idx = NULL_CLUSTER;
 }
 
 void f2fs_compress_ctx_add_page(struct compress_ctx *cc, struct folio *folio)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
 	unsigned int cluster_ofs;
+	pgoff_t lblk = f2fs_folio_lblk(sbi, folio);
 
-	if (!f2fs_cluster_can_merge_page(cc, folio->index))
-		f2fs_bug_on(F2FS_I_SB(cc->inode), 1);
+	if (!f2fs_cluster_can_merge_block(cc, lblk))
+		f2fs_bug_on(sbi, 1);
 
-	cluster_ofs = offset_in_cluster(cc, folio->index);
+	cluster_ofs = offset_in_cluster(cc, lblk);
 	cc->rpages[cluster_ofs] = folio_page(folio, 0);
 	cc->nr_rpages++;
-	cc->cluster_idx = cluster_idx(cc, folio->index);
+	cc->cluster_idx = cluster_idx(cc, lblk);
 }
 
 #ifdef CONFIG_F2FS_FS_LZO
@@ -184,7 +191,7 @@ static int lzo_init_compress_ctx(struct compress_ctx *cc)
 	if (!cc->private)
 		return -ENOMEM;
 
-	cc->clen = lzo1x_worst_compress(PAGE_SIZE << cc->log_cluster_size);
+	cc->clen = lzo1x_worst_compress(F2FS_BLKSIZE(F2FS_I_SB(cc->inode)) << cc->log_cluster_size);
 	return 0;
 }
 
@@ -220,10 +227,11 @@ static int lzo_decompress_pages(struct decompress_io_ctx *dic)
 		return -EIO;
 	}
 
-	if (dic->rlen != PAGE_SIZE << dic->log_cluster_size) {
+	if (dic->rlen != F2FS_BLKSIZE(dic->sbi) << dic->log_cluster_size) {
 		f2fs_err_ratelimited(dic->sbi,
 				"lzo invalid rlen:%zu, expected:%lu",
-				dic->rlen, PAGE_SIZE << dic->log_cluster_size);
+				dic->rlen, (unsigned long)F2FS_BLKSIZE(dic->sbi) <<
+						dic->log_cluster_size);
 		return -EIO;
 	}
 	return 0;
@@ -256,7 +264,7 @@ static int lz4_init_compress_ctx(struct compress_ctx *cc)
 	 * adapt worst compress case, because lz4 compressor can handle
 	 * output budget properly.
 	 */
-	cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
+	cc->clen = cc->rlen - F2FS_BLKSIZE(F2FS_I_SB(cc->inode)) - COMPRESS_HEADER_SIZE;
 	return 0;
 }
 
@@ -300,10 +308,11 @@ static int lz4_decompress_pages(struct decompress_io_ctx *dic)
 		return -EIO;
 	}
 
-	if (ret != PAGE_SIZE << dic->log_cluster_size) {
+	if (ret != F2FS_BLKSIZE(dic->sbi) << dic->log_cluster_size) {
 		f2fs_err_ratelimited(dic->sbi,
 				"lz4 invalid ret:%d, expected:%lu",
-				ret, PAGE_SIZE << dic->log_cluster_size);
+				ret, (unsigned long)F2FS_BLKSIZE(dic->sbi) <<
+						dic->log_cluster_size);
 		return -EIO;
 	}
 	return 0;
@@ -358,7 +367,7 @@ static int zstd_init_compress_ctx(struct compress_ctx *cc)
 	cc->private = workspace;
 	cc->private2 = stream;
 
-	cc->clen = cc->rlen - PAGE_SIZE - COMPRESS_HEADER_SIZE;
+	cc->clen = cc->rlen - F2FS_BLKSIZE(F2FS_I_SB(cc->inode)) - COMPRESS_HEADER_SIZE;
 	return 0;
 }
 
@@ -375,7 +384,7 @@ static int zstd_compress_pages(struct compress_ctx *cc)
 	zstd_in_buffer inbuf;
 	zstd_out_buffer outbuf;
 	int src_size = cc->rlen;
-	int dst_size = src_size - PAGE_SIZE - COMPRESS_HEADER_SIZE;
+	int dst_size = src_size - F2FS_BLKSIZE(F2FS_I_SB(cc->inode)) - COMPRESS_HEADER_SIZE;
 	int ret;
 
 	inbuf.pos = 0;
@@ -419,7 +428,7 @@ static int zstd_init_decompress_ctx(struct decompress_io_ctx *dic)
 	void *workspace;
 	unsigned int workspace_size;
 	unsigned int max_window_size =
-			MAX_COMPRESS_WINDOW_SIZE(dic->log_cluster_size);
+			MAX_COMPRESS_WINDOW_SIZE(dic->sbi, dic->log_cluster_size);
 
 	workspace_size = zstd_dstream_workspace_bound(max_window_size);
 
@@ -475,7 +484,7 @@ static int zstd_decompress_pages(struct decompress_io_ctx *dic)
 		f2fs_err_ratelimited(dic->sbi,
 				"%s ZSTD invalid rlen:%zu, expected:%lu",
 				__func__, dic->rlen,
-				PAGE_SIZE << dic->log_cluster_size);
+				(unsigned long)F2FS_BLKSIZE(dic->sbi) << dic->log_cluster_size);
 		return -EIO;
 	}
 
@@ -550,7 +559,9 @@ bool f2fs_is_compress_backend_ready(struct inode *inode)
 {
 	if (!f2fs_compressed_file(inode))
 		return true;
-	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode)))
+	/* A cluster smaller than a page is not supported */
+	if (F2FS_I(inode)->i_log_cluster_size <
+			F2FS_LOG_BLKS_PER_PAGE(F2FS_I_SB(inode)))
 		return false;
 	return f2fs_cops[F2FS_I(inode)->i_compress_algorithm];
 }
@@ -621,13 +632,23 @@ static void *f2fs_vmap(struct page **pages, unsigned int count)
 	return buf;
 }
 
+static void f2fs_vunmap(void *vaddr, unsigned int count)
+{
+	if (!vaddr)
+		return;
+	vm_unmap_ram((void *)((unsigned long)vaddr & PAGE_MASK), count);
+}
+
 static int f2fs_compress_pages(struct compress_ctx *cc)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
 	struct f2fs_inode_info *fi = F2FS_I(cc->inode);
 	const struct f2fs_compress_ops *cops =
 				f2fs_cops[fi->i_compress_algorithm];
-	unsigned int max_len, new_nr_cpages;
+	unsigned int max_len, new_cblocks;
+	unsigned int nr_rfolios, needed_folios;
+	unsigned int cbuf_blk_ofs = f2fs_has_subpage_blocks(sbi) ? 1 : 0;
+	void *cbuf_vaddr;
 	u32 chksum = 0;
 	int i, ret;
 
@@ -640,9 +661,12 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 			goto out;
 	}
 
+	nr_rfolios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
+
 	max_len = COMPRESS_HEADER_SIZE + cc->clen;
-	cc->nr_cpages = DIV_ROUND_UP(max_len, PAGE_SIZE);
-	cc->valid_nr_cpages = cc->nr_cpages;
+	cc->valid_nr_cblocks = F2FS_BLK_ALIGN(sbi, max_len);
+	cc->nr_cpages = DIV_ROUND_UP(cbuf_blk_ofs + cc->valid_nr_cblocks,
+					F2FS_BLKS_PER_PAGE(sbi));
 
 	cc->cpages = page_array_alloc(sbi, cc->nr_cpages);
 	if (!cc->cpages) {
@@ -653,23 +677,24 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 	for (i = 0; i < cc->nr_cpages; i++)
 		cc->cpages[i] = f2fs_compress_alloc_page();
 
-	cc->rbuf = f2fs_vmap(cc->rpages, cc->cluster_size);
+	cc->rbuf = f2fs_vmap(cc->rpages, nr_rfolios);
 	if (!cc->rbuf) {
 		ret = -ENOMEM;
 		goto out_free_cpages;
 	}
 
-	cc->cbuf = f2fs_vmap(cc->cpages, cc->nr_cpages);
-	if (!cc->cbuf) {
+	cbuf_vaddr = f2fs_vmap(cc->cpages, cc->nr_cpages);
+	if (!cbuf_vaddr) {
 		ret = -ENOMEM;
 		goto out_vunmap_rbuf;
 	}
+	cc->cbuf = cbuf_vaddr + F2FS_BLK_TO_BYTES(sbi, cbuf_blk_ofs);
 
 	ret = cops->compress_pages(cc);
 	if (ret)
 		goto out_vunmap_cbuf;
 
-	max_len = PAGE_SIZE * (cc->cluster_size - 1) - COMPRESS_HEADER_SIZE;
+	max_len = F2FS_BLK_TO_BYTES(sbi, cc->cluster_size - 1) - COMPRESS_HEADER_SIZE;
 
 	if (cc->clen > max_len) {
 		ret = -EAGAIN;
@@ -685,17 +710,19 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 	for (i = 0; i < COMPRESS_DATA_RESERVED_SIZE; i++)
 		cc->cbuf->reserved[i] = cpu_to_le32(0);
 
-	new_nr_cpages = DIV_ROUND_UP(cc->clen + COMPRESS_HEADER_SIZE, PAGE_SIZE);
+	new_cblocks = F2FS_BLK_ALIGN(sbi, cc->clen + COMPRESS_HEADER_SIZE);
 
-	/* zero out any unused part of the last page */
+	/* zero out any unused part of the last block */
 	memset(&cc->cbuf->cdata[cc->clen], 0,
-			(new_nr_cpages * PAGE_SIZE) -
+			F2FS_BLK_TO_BYTES(sbi, new_cblocks) -
 			(cc->clen + COMPRESS_HEADER_SIZE));
 
-	vm_unmap_ram(cc->cbuf, cc->nr_cpages);
-	vm_unmap_ram(cc->rbuf, cc->cluster_size);
+	f2fs_vunmap(cc->cbuf, cc->nr_cpages);
+	f2fs_vunmap(cc->rbuf, nr_rfolios);
 
-	for (i = new_nr_cpages; i < cc->nr_cpages; i++) {
+	needed_folios = DIV_ROUND_UP(cbuf_blk_ofs + new_cblocks,
+					F2FS_BLKS_PER_PAGE(sbi));
+	for (i = needed_folios; i < cc->nr_cpages; i++) {
 		f2fs_compress_free_page(cc->cpages[i]);
 		cc->cpages[i] = NULL;
 	}
@@ -703,16 +730,16 @@ static int f2fs_compress_pages(struct compress_ctx *cc)
 	if (cops->destroy_compress_ctx)
 		cops->destroy_compress_ctx(cc);
 
-	cc->valid_nr_cpages = new_nr_cpages;
+	cc->valid_nr_cblocks = new_cblocks;
 
 	trace_f2fs_compress_pages_end(cc->inode, cc->cluster_idx,
 							cc->clen, ret);
 	return 0;
 
 out_vunmap_cbuf:
-	vm_unmap_ram(cc->cbuf, cc->nr_cpages);
+	f2fs_vunmap(cc->cbuf, cc->nr_cpages);
 out_vunmap_rbuf:
-	vm_unmap_ram(cc->rbuf, cc->cluster_size);
+	f2fs_vunmap(cc->rbuf, nr_rfolios);
 out_free_cpages:
 	for (i = 0; i < cc->nr_cpages; i++) {
 		if (cc->cpages[i])
@@ -741,7 +768,7 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 	const struct f2fs_compress_ops *cops =
 			f2fs_cops[fi->i_compress_algorithm];
 	bool bypass_callback = false;
-	int ret;
+	int i, ret;
 
 	trace_f2fs_decompress_pages_start(dic->inode, dic->cluster_idx,
 				dic->cluster_size, fi->i_compress_algorithm);
@@ -758,9 +785,9 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 	}
 
 	dic->clen = le32_to_cpu(dic->cbuf->clen);
-	dic->rlen = PAGE_SIZE << dic->log_cluster_size;
+	dic->rlen = F2FS_BLKSIZE(sbi) << dic->log_cluster_size;
 
-	if (dic->clen > PAGE_SIZE * dic->nr_cpages - COMPRESS_HEADER_SIZE) {
+	if (dic->clen > F2FS_BLK_TO_BYTES(sbi, dic->valid_nr_cblocks) - COMPRESS_HEADER_SIZE) {
 		ret = -EFSCORRUPTED;
 
 		/* Avoid f2fs_commit_super in irq context */
@@ -787,6 +814,31 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 		}
 	}
 
+	/*
+	 * Folios with f2fs_folio_state were decompressed into bounce pages.
+	 * Copy only the blocks that are not uptodate, so that newer data in
+	 * the uptodate (possibly dirty) blocks is kept.
+	 */
+	for (i = 0; !ret && i < dic->nr_rpages; i++) {
+		struct page *rpage = dic->rpages[i];
+		struct folio *folio;
+		pgoff_t lblk;
+		unsigned int b;
+
+		if (!rpage || dic->tpages[i] == rpage)
+			continue;
+
+		folio = page_folio(rpage);
+		lblk = f2fs_folio_lblk(sbi, folio);
+		for (b = 0; b < f2fs_blocks_per_folio(sbi, folio); b++) {
+			size_t off = F2FS_BLK_TO_BYTES(sbi, b);
+
+			if (!f2fs_ffs_test_blk_uptodate(folio, lblk + b))
+				memcpy_page(rpage, off, dic->tpages[i], off,
+					    F2FS_BLKSIZE(sbi));
+		}
+	}
+
 out_release:
 	f2fs_release_decomp_mem(dic, bypass_callback, false);
 
@@ -796,8 +848,8 @@ void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task)
 	f2fs_decompress_end_io(dic, ret, in_task);
 }
 
-static void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
-		struct folio *folio, nid_t ino, block_t blkaddr);
+static void f2fs_cache_compressed_block(struct f2fs_sb_info *sbi,
+		struct folio *folio, size_t offset, nid_t ino, block_t blkaddr);
 
 /*
  * This is called when a page of a compressed cluster has been read from disk
@@ -805,29 +857,35 @@ static void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
  * page being waited on in the cluster, and if so, it decompresses the cluster
  * (or in the case of a failure, cleans up without actually decompressing).
  */
-void f2fs_end_read_compressed_page(struct folio *folio, bool failed,
-		block_t blkaddr, bool in_task)
+void f2fs_end_read_compressed_page(struct folio *folio, size_t offset,
+		bool failed, block_t blkaddr, unsigned int nr_blocks,
+		bool in_task)
 {
 	struct decompress_io_ctx *dic = folio->private;
 	struct f2fs_sb_info *sbi = dic->sbi;
+	int i;
 
-	dec_cache_count(sbi, F2FS_RD_DATA);
+	sub_cache_counts(sbi, F2FS_RD_DATA, nr_blocks);
 
 	if (failed)
 		WRITE_ONCE(dic->failed, true);
-	else if (blkaddr && in_task)
-		f2fs_cache_compressed_page(sbi, folio,
-					dic->inode->i_ino, blkaddr);
+	else if (blkaddr && in_task) {
+		for (i = 0; i < nr_blocks; i++)
+			f2fs_cache_compressed_block(sbi, folio,
+					offset + F2FS_BLK_TO_BYTES(sbi, i),
+					dic->inode->i_ino,
+					blkaddr + i);
+	}
 
-	if (atomic_dec_and_test(&dic->remaining_pages))
+	if (atomic_sub_and_test(nr_blocks, &dic->remaining_blocks))
 		f2fs_decompress_cluster(dic, in_task);
 }
 
-static bool is_page_in_cluster(struct compress_ctx *cc, pgoff_t index)
+static bool is_block_in_cluster(struct compress_ctx *cc, pgoff_t lblk)
 {
 	if (cc->cluster_idx == NULL_CLUSTER)
 		return true;
-	return cc->cluster_idx == cluster_idx(cc, index);
+	return cc->cluster_idx == cluster_idx(cc, lblk);
 }
 
 bool f2fs_cluster_is_empty(struct compress_ctx *cc)
@@ -837,19 +895,40 @@ bool f2fs_cluster_is_empty(struct compress_ctx *cc)
 
 static bool f2fs_cluster_is_full(struct compress_ctx *cc)
 {
-	return cc->cluster_size == cc->nr_rpages;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
+	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
+	int i;
+
+	if (cc->nr_rpages != nr_folios)
+		return false;
+
+	/* PG_dirty is cleared for writeback; without ffs it covered every block */
+	for (i = 0; i < nr_folios; i++) {
+		struct folio *folio = page_folio(cc->rpages[i]);
+		unsigned int nr_blocks = f2fs_blocks_per_folio(sbi, folio);
+		unsigned int start, count;
+
+		if (f2fs_folio_has_ffs(folio) &&
+		    (!f2fs_ffs_dirty_blk_range(folio, 0, nr_blocks,
+					       &start, &count) ||
+		     count != nr_blocks))
+			return false;
+	}
+	return true;
 }
 
-bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index)
+bool f2fs_cluster_can_merge_block(struct compress_ctx *cc, pgoff_t lblk)
 {
 	if (f2fs_cluster_is_empty(cc))
 		return true;
-	return is_page_in_cluster(cc, index);
+	return is_block_in_cluster(cc, lblk);
 }
 
 bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
 				int index, int nr_pages, bool uptodate)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
+	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
 	unsigned long pgidx = page_folio(pages[index])->index;
 	int i = uptodate ? 0 : 1;
 
@@ -857,13 +936,13 @@ bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
 	 * when uptodate set to true, try to check all pages in cluster is
 	 * uptodate or not.
 	 */
-	if (uptodate && (pgidx % cc->cluster_size))
+	if (uptodate && (pgidx % nr_folios))
 		return false;
 
-	if (nr_pages - index < cc->cluster_size)
+	if (nr_pages - index < nr_folios)
 		return false;
 
-	for (; i < cc->cluster_size; i++) {
+	for (; i < nr_folios; i++) {
 		struct folio *folio = page_folio(pages[index + i]);
 
 		if (folio->index != pgidx + i)
@@ -877,17 +956,19 @@ bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
 
 static bool cluster_has_invalid_data(struct compress_ctx *cc)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
 	loff_t i_size = i_size_read(cc->inode);
-	unsigned nr_pages = DIV_ROUND_UP(i_size, PAGE_SIZE);
+	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
 	int i;
 
-	for (i = 0; i < cc->cluster_size; i++) {
+	for (i = 0; i < nr_folios; i++) {
 		struct page *page = cc->rpages[i];
 
-		f2fs_bug_on(F2FS_I_SB(cc->inode), !page);
+		f2fs_bug_on(sbi, !page);
 
-		/* beyond EOF */
-		if (page_folio(page)->index >= nr_pages)
+		/* any block beyond EOF */
+		if (folio_pos(page_folio(page)) +
+		    folio_size(page_folio(page)) - F2FS_BLKSIZE(sbi) >= i_size)
 			return true;
 	}
 	return false;
@@ -1014,17 +1095,17 @@ static int f2fs_decompressed_blocks(struct inode *inode,
 }
 
 /* return whether cluster is compressed one or not */
-int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index)
+int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t lblk)
 {
 	return __f2fs_cluster_blocks(inode,
-		index >> F2FS_I(inode)->i_log_cluster_size,
+		lblk >> F2FS_I(inode)->i_log_cluster_size,
 		CLUSTER_IS_COMPR);
 }
 
 /* return whether cluster contains non raw blocks or not */
-bool f2fs_is_sparse_cluster(struct inode *inode, pgoff_t index)
+bool f2fs_is_sparse_cluster(struct inode *inode, pgoff_t lblk)
 {
-	unsigned int cluster_idx = index >> F2FS_I(inode)->i_log_cluster_size;
+	unsigned int cluster_idx = lblk >> F2FS_I(inode)->i_log_cluster_size;
 
 	return f2fs_decompressed_blocks(inode, cluster_idx) !=
 		F2FS_I(inode)->i_cluster_size;
@@ -1045,34 +1126,65 @@ static bool cluster_may_compress(struct compress_ctx *cc)
 
 static void set_cluster_writeback(struct compress_ctx *cc)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
+	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
 	int i;
 
-	for (i = 0; i < cc->cluster_size; i++) {
-		if (cc->rpages[i])
-			set_page_writeback(cc->rpages[i]);
+	for (i = 0; i < nr_folios; i++) {
+		struct folio *folio;
+
+		if (!cc->rpages[i])
+			continue;
+
+		folio = page_folio(cc->rpages[i]);
+		set_page_writeback(cc->rpages[i]);
+		/*
+		 * Attach a folio state before the I/O, as the raw write path
+		 * does, so that the write completion, which does not hold the
+		 * folio lock, never detaches the page private flags kept in
+		 * folio->private. Without it, the cleared PG_dirty covered
+		 * every block, so mark them dirty.
+		 */
+		if (f2fs_is_multiblock_folio(sbi, folio) &&
+		    !f2fs_folio_has_ffs(folio)) {
+			f2fs_ffs_mark_subrange_dirty(folio, 0, folio_size(folio));
+			/* It was accounted as a whole, now its dirty bits are. */
+			f2fs_account_dirty_blocks(cc->inode,
+				-(int)f2fs_blocks_per_folio(sbi, folio));
+		}
 	}
 }
 
 static void cancel_cluster_writeback(struct compress_ctx *cc,
-			struct compress_io_ctx *cic, int submitted)
+			struct compress_io_ctx *cic, int failed_blk)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
+	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
 	int i;
 
 	/* Wait for submitted IOs. */
-	if (submitted > 1) {
+	if (failed_blk > 1) {
 		f2fs_submit_merged_write(F2FS_I_SB(cc->inode), DATA);
-		while (atomic_read(&cic->pending_pages) !=
-					(cc->valid_nr_cpages - submitted + 1))
+		while (atomic_read(&cic->pending_blocks) !=
+					(cc->valid_nr_cblocks - failed_blk + 1))
 			f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
 	}
 
 	/* Cancel writeback and stay locked. */
-	for (i = 0; i < cc->cluster_size; i++) {
+	for (i = 0; i < nr_folios; i++) {
 		struct folio *folio = page_folio(cc->rpages[i]);
+		unsigned int last_blk_in_folio =
+			((i + 1) << F2FS_LOG_BLKS_PER_PAGE(sbi)) - 1;
 
-		if (i < submitted) {
-			inode_inc_dirty_block(cc->inode);
+		if (last_blk_in_folio < failed_blk) {
 			folio_lock(folio);
+			/* f2fs_write_compressed_pages() cleared its dirty blocks */
+			if (f2fs_folio_has_ffs(folio))
+				f2fs_ffs_mark_subrange_dirty(folio, 0,
+							folio_size(folio));
+			else
+				f2fs_account_dirty_blocks(cc->inode,
+					f2fs_blocks_per_folio(sbi, folio));
 		}
 		folio_clear_f2fs_gcing(folio);
 		if (folio_test_writeback(folio))
@@ -1082,21 +1194,28 @@ static void cancel_cluster_writeback(struct compress_ctx *cc,
 
 static void set_cluster_dirty(struct compress_ctx *cc)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
+	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
 	int i;
 
-	for (i = 0; i < cc->cluster_size; i++) {
+	for (i = 0; i < nr_folios; i++) {
 		struct folio *folio;
 
 		if (!cc->rpages[i])
 			continue;
 		folio = page_folio(cc->rpages[i]);
+		/*
+		 * The whole cluster is rewritten. This also attaches a folio
+		 * state to a multi-block folio before it is dirtied.
+		 */
+		f2fs_ffs_mark_subrange_dirty(folio, 0, folio_size(folio));
 		f2fs_folio_mark_dirty(folio);
 		folio_set_f2fs_gcing(folio);
 	}
 }
 
 static int prepare_compress_overwrite(struct compress_ctx *cc,
-		struct page **pagep, pgoff_t index, void **fsdata)
+		struct page **pagep, pgoff_t lblk, void **fsdata)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
 	struct address_space *mapping = cc->inode->i_mapping;
@@ -1115,9 +1234,13 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 	if (ret)
 		return ret;
 
+	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
+
 	/* keep folio reference to avoid page reclaim */
-	for (i = 0; i < cc->cluster_size; i++) {
-		folio = f2fs_filemap_get_folio(mapping, start_idx + i,
+	for (i = 0; i < nr_folios; i++) {
+		pgoff_t f_index = f2fs_lblk_to_folio_index(sbi, start_idx) + i;
+
+		folio = f2fs_filemap_get_folio(mapping, f_index,
 				fgp_flag, GFP_NOFS);
 		if (IS_ERR(folio)) {
 			ret = PTR_ERR(folio);
@@ -1147,10 +1270,12 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 			goto out;
 	}
 
-	for (i = 0; i < cc->cluster_size; i++) {
+	for (i = 0; i < nr_folios; i++) {
+		pgoff_t f_index = f2fs_lblk_to_folio_index(sbi, start_idx) + i;
+
 		f2fs_bug_on(sbi, cc->rpages[i]);
 
-		folio = filemap_lock_folio(mapping, start_idx + i);
+		folio = filemap_lock_folio(mapping, f_index);
 		if (IS_ERR(folio)) {
 			/* folio could be truncated */
 			goto release_and_retry;
@@ -1171,7 +1296,7 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 
 	if (likely(!ret)) {
 		*fsdata = cc->rpages;
-		*pagep = cc->rpages[offset_in_cluster(cc, index)];
+		*pagep = cc->rpages[offset_in_cluster(cc, lblk)];
 		return cc->cluster_size;
 	}
 
@@ -1184,23 +1309,23 @@ static int prepare_compress_overwrite(struct compress_ctx *cc,
 }
 
 int f2fs_prepare_compress_overwrite(struct inode *inode,
-		struct page **pagep, pgoff_t index, void **fsdata)
+		struct page **pagep, pgoff_t lblk, void **fsdata)
 {
 	struct compress_ctx cc = {
 		.inode = inode,
 		.log_cluster_size = F2FS_I(inode)->i_log_cluster_size,
 		.cluster_size = F2FS_I(inode)->i_cluster_size,
-		.cluster_idx = index >> F2FS_I(inode)->i_log_cluster_size,
+		.cluster_idx = lblk >> F2FS_I(inode)->i_log_cluster_size,
 		.rpages = NULL,
 		.nr_rpages = 0,
 		.vi = NULL, /* can't write to fsverity files */
 	};
 
-	return prepare_compress_overwrite(&cc, pagep, index, fsdata);
+	return prepare_compress_overwrite(&cc, pagep, lblk, fsdata);
 }
 
 bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
-					pgoff_t index, unsigned copied)
+					pgoff_t lblk, unsigned int copied)
 
 {
 	struct compress_ctx cc = {
@@ -1210,7 +1335,7 @@ bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
 		.rpages = fsdata,
 	};
 	struct folio *folio = page_folio(cc.rpages[0]);
-	bool first_index = (index == folio->index);
+	bool first_index = (lblk == f2fs_folio_lblk(F2FS_I_SB(inode), folio));
 
 	if (copied)
 		set_cluster_dirty(&cc);
@@ -1223,12 +1348,15 @@ bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
 
 int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 {
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	void *fsdata = NULL;
 	struct page *pagep;
 	struct page **rpages;
 	int log_cluster_size = F2FS_I(inode)->i_log_cluster_size;
-	pgoff_t start_idx = from >> (PAGE_SHIFT + log_cluster_size) <<
+	pgoff_t start_idx = (from >> (sbi->log_blocksize + log_cluster_size)) <<
 							log_cluster_size;
+	unsigned int nr_folios = (1 << log_cluster_size) >>
+					F2FS_LOG_BLKS_PER_PAGE(sbi);
 	int i;
 	int err;
 
@@ -1252,9 +1380,9 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 
 	rpages = fsdata;
 
-	for (i = (1 << log_cluster_size) - 1; i >= 0; i--) {
+	for (i = nr_folios - 1; i >= 0; i--) {
 		struct folio *folio = page_folio(rpages[i]);
-		loff_t start = (loff_t)folio->index << PAGE_SHIFT;
+		loff_t start = folio_pos(folio);
 		loff_t offset = from > start ? from - start : 0;
 
 		folio_zero_segment(folio, offset, folio_size(folio));
@@ -1266,14 +1394,31 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 	f2fs_compress_write_end(inode, fsdata, start_idx, true);
 
 	err = filemap_write_and_wait_range(inode->i_mapping,
-			round_down(from, 1 << log_cluster_size << PAGE_SHIFT),
+			round_down(from, 1 << log_cluster_size << sbi->log_blocksize),
 			LLONG_MAX);
 	if (err)
 		return err;
 
 	truncate_pagecache(inode, from);
 
-	return f2fs_do_truncate_blocks(inode, round_up(from, PAGE_SIZE), lock);
+	return f2fs_do_truncate_blocks(inode, round_up(from, F2FS_BLKSIZE(sbi)),
+				       lock);
+}
+
+/*
+ * Page cache index tagged on the @i-th bounce page of a cluster.  With
+ * subpage blocks, compressed block k is kept at block offset k of the
+ * cluster, so the first bounce page also covers the unused slot of the
+ * COMPRESS_ADDR block and the bounce pages map 1:1 to the folios of the
+ * cluster.  Otherwise there is no bounce page for COMPRESS_ADDR and page
+ * i holds block i + 1.
+ */
+static pgoff_t f2fs_cpage_index(struct f2fs_sb_info *sbi, pgoff_t start_idx,
+				unsigned int i)
+{
+	if (f2fs_has_subpage_blocks(sbi))
+		return f2fs_lblk_to_folio_index(sbi, start_idx) + i;
+	return start_idx + 1 + i;
 }
 
 static int f2fs_write_compressed_pages(struct compress_ctx *cc,
@@ -1303,8 +1448,9 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	struct node_info ni;
 	struct compress_io_ctx *cic;
 	struct f2fs_lock_context lc;
+	unsigned int nr_rfolios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
 	pgoff_t start_idx = start_idx_of_cluster(cc);
-	unsigned int last_index = cc->cluster_size - 1;
+	unsigned int blk_idx, c_folio_idx, c_folio_ofs;
 	loff_t psize;
 	int i, err;
 	bool quota_inode = IS_NOQUOTA(inode);
@@ -1338,10 +1484,10 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 			goto out_put_dnode;
 	}
 
-	folio = page_folio(cc->rpages[last_index]);
+	folio = page_folio(cc->rpages[nr_rfolios - 1]);
 	psize = folio_next_pos(folio);
 
-	err = f2fs_get_node_info(fio.sbi, dn.nid, &ni, false);
+	err = f2fs_get_node_info(sbi, dn.nid, &ni, false);
 	if (err)
 		goto out_put_dnode;
 
@@ -1353,18 +1499,25 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 
 	cic->magic = F2FS_COMPRESSED_PAGE_MAGIC;
 	cic->inode = inode;
-	atomic_set(&cic->pending_pages, cc->valid_nr_cpages);
-	cic->rpages = page_array_alloc(sbi, cc->cluster_size);
+	atomic_set(&cic->pending_blocks, cc->valid_nr_cblocks);
+	cic->rpages = page_array_alloc(sbi, nr_rfolios);
 	if (!cic->rpages)
 		goto out_put_cic;
 
-	cic->nr_rpages = cc->cluster_size;
+	cic->nr_rpages = nr_rfolios;
+	cic->cpages = cc->cpages;
+	cic->nr_cpages = cc->nr_cpages;
+	cc->cpages = NULL;
 
-	for (i = 0; i < cc->valid_nr_cpages; i++) {
-		f2fs_set_compressed_page(cc->cpages[i], inode,
-				page_folio(cc->rpages[i + 1])->index, cic);
-		fio.compressed_page = cc->cpages[i];
+	for (i = 0; i < cic->nr_cpages; i++) {
+		if (!cic->cpages[i])
+			break;
+
+		f2fs_set_compressed_page(cic->cpages[i], inode,
+				f2fs_cpage_index(sbi, start_idx, i), cic);
+	}
 
+	for (i = 0; i < cc->valid_nr_cblocks; i++) {
 		fio.old_blkaddr = data_blkaddr(dn.inode, dn.node_entry,
 						dn.ofs_in_node + i + 1);
 
@@ -1374,14 +1527,15 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 
 	set_cluster_writeback(cc);
 
-	for (i = 0; i < cc->cluster_size; i++)
+	for (i = 0; i < nr_rfolios; i++)
 		cic->rpages[i] = cc->rpages[i];
 
 	for (i = 0; i < cc->cluster_size; i++, dn.ofs_in_node++) {
 		block_t blkaddr;
+		unsigned int r_idx = i >> F2FS_LOG_BLKS_PER_PAGE(sbi);
 
 		blkaddr = f2fs_data_blkaddr(&dn);
-		fio.folio = page_folio(cc->rpages[i]);
+		fio.folio = page_folio(cc->rpages[r_idx]);
 		fio.old_blkaddr = blkaddr;
 
 		/* cluster header */
@@ -1397,7 +1551,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		if (fio.compr_blocks && __is_valid_data_blkaddr(blkaddr))
 			fio.compr_blocks++;
 
-		if (i > cc->valid_nr_cpages) {
+		if (i > cc->valid_nr_cblocks) {
 			if (__is_valid_data_blkaddr(blkaddr)) {
 				f2fs_invalidate_blocks(sbi, blkaddr, 1);
 				f2fs_update_data_blkaddr(&dn, NEW_ADDR);
@@ -1407,9 +1561,13 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 
 		f2fs_bug_on(fio.sbi, blkaddr == NULL_ADDR);
 
-		fio.compressed_page = cc->cpages[i - 1];
+		blk_idx = f2fs_has_subpage_blocks(sbi) ? i : (i - 1);
+		c_folio_idx = blk_idx >> F2FS_LOG_BLKS_PER_PAGE(sbi);
+		c_folio_ofs = blk_idx % F2FS_BLKS_PER_PAGE(sbi);
+
+		fio.compressed_page = cic->cpages[c_folio_idx];
+		fio.folio_offset = c_folio_ofs;
 
-		cc->cpages[i - 1] = NULL;
 		fio.submitted = 0;
 		f2fs_outplace_write_data(&dn, &fio);
 		if (unlikely(!fio.submitted)) {
@@ -1419,14 +1577,19 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		}
 		(*submitted)++;
 unlock_continue:
-		inode_dec_dirty_block(cc->inode);
-		folio_unlock(fio.folio);
+		if ((i + 1) % F2FS_BLKS_PER_PAGE(sbi) == 0) {
+			f2fs_folio_clear_dirty_blocks(fio.folio, true);
+			folio_unlock(fio.folio);
+		}
 	}
 
+	/* count pages like the raw write path */
+	*submitted = DIV_ROUND_UP(*submitted, F2FS_BLKS_PER_PAGE(sbi));
+
 	if (fio.compr_blocks)
 		f2fs_i_compr_blocks_update(inode, fio.compr_blocks - 1, false);
-	f2fs_i_compr_blocks_update(inode, cc->valid_nr_cpages, true);
-	add_compr_block_stat(inode, cc->valid_nr_cpages);
+	f2fs_i_compr_blocks_update(inode, cc->valid_nr_cblocks, true);
+	add_compr_block_stat(inode, cc->valid_nr_cblocks);
 
 	set_inode_flag(cc->inode, FI_APPEND_WRITE);
 
@@ -1442,13 +1605,18 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	spin_unlock(&fi->i_size_lock);
 
 	f2fs_put_rpages(cc);
-	page_array_free(sbi, cc->cpages, cc->nr_cpages);
-	cc->cpages = NULL;
 	f2fs_destroy_compress_ctx(cc, false);
 	return 0;
 
 out_free_page_array:
-	page_array_free(sbi, cic->rpages, cc->cluster_size);
+	page_array_free(sbi, cic->rpages, nr_rfolios);
+
+	for (i = 0; i < cic->nr_cpages; i++) {
+		if (!cic->cpages[i])
+			continue;
+		f2fs_compress_free_page(cic->cpages[i]);
+	}
+	page_array_free(sbi, cic->cpages, cic->nr_cpages);
 out_put_cic:
 	kmem_cache_free(cic_entry_slab, cic);
 out_put_dnode:
@@ -1459,18 +1627,21 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	else
 		f2fs_unlock_op(sbi, &lc);
 out_free:
-	for (i = 0; i < cc->valid_nr_cpages; i++) {
-		f2fs_compress_free_page(cc->cpages[i]);
-		cc->cpages[i] = NULL;
+	if (cc->cpages) {
+		for (i = 0; i < cc->nr_cpages; i++) {
+			if (!cc->cpages[i])
+				continue;
+			f2fs_compress_free_page(cc->cpages[i]);
+		}
+		page_array_free(sbi, cc->cpages, cc->nr_cpages);
+		cc->cpages = NULL;
 	}
-	page_array_free(sbi, cc->cpages, cc->nr_cpages);
-	cc->cpages = NULL;
 	return -EAGAIN;
 }
 
-void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
+void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio,
+				unsigned int nr_blocks)
 {
-	struct page *page = &folio->page;
 	struct f2fs_sb_info *sbi = bio->bi_private;
 	struct compress_io_ctx *cic = folio->private;
 	enum count_type type = WB_DATA_TYPE(folio, true);
@@ -1479,13 +1650,17 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 	if (unlikely(bio->bi_status != BLK_STS_OK))
 		mapping_set_error(cic->inode->i_mapping, -EIO);
 
-	f2fs_compress_free_page(page);
-
-	if (atomic_dec_return(&cic->pending_pages)) {
-		dec_cache_count(sbi, type);
+	if (!atomic_sub_and_test(nr_blocks, &cic->pending_blocks)) {
+		sub_cache_counts(sbi, type, nr_blocks);
 		return;
 	}
 
+	for (i = 0; i < cic->nr_cpages; i++) {
+		if (cic->cpages[i])
+			f2fs_compress_free_page(cic->cpages[i]);
+	}
+	page_array_free(sbi, cic->cpages, cic->nr_cpages);
+
 	for (i = 0; i < cic->nr_rpages; i++) {
 		struct folio *rfolio;
 
@@ -1499,12 +1674,12 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 	kmem_cache_free(cic_entry_slab, cic);
 
 	/*
-	 * Make sure dec_cache_count() is the last access to sbi.
+	 * Make sure sub_cache_counts() is the last access to sbi.
 	 * Once it drops the F2FS_WB_CP_DATA counter to zero, the
 	 * unmount thread can proceed to destroy sbi and
 	 * sbi->page_array_slab.
 	 */
-	dec_cache_count(sbi, type);
+	sub_cache_counts(sbi, type, nr_blocks);
 }
 
 static int f2fs_write_raw_pages(struct compress_ctx *cc,
@@ -1517,10 +1692,12 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 	struct f2fs_lock_context lc;
 	int submitted, compr_blocks, i;
 	int ret = 0;
+	unsigned int nr_folios = cc->cluster_size >>
+					F2FS_LOG_BLKS_PER_PAGE(sbi);
 
 	compr_blocks = f2fs_compressed_blocks(cc);
 
-	for (i = 0; i < cc->cluster_size; i++) {
+	for (i = 0; i < nr_folios; i++) {
 		if (!cc->rpages[i])
 			continue;
 
@@ -1535,7 +1712,7 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 	if (compr_blocks > 0)
 		f2fs_lock_op(sbi, &lc);
 
-	for (i = 0; i < cc->cluster_size; i++) {
+	for (i = 0; i < nr_folios; i++) {
 		struct folio *folio;
 
 		if (!cc->rpages[i])
@@ -1595,6 +1772,34 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 	return ret;
 }
 
+/*
+ * A compressed cluster is rewritten as a whole, as set_cluster_dirty() does.
+ * With subpage blocks, a dirty folio can have only some of its blocks dirty
+ * (e.g. defragment), so dirty the rest before trying to compress.
+ */
+static void dirty_partial_compressed_cluster(struct compress_ctx *cc)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
+	unsigned int nr_folios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
+	int i;
+
+	if (cc->nr_rpages != nr_folios || f2fs_cluster_is_full(cc))
+		return;
+	for (i = 0; i < nr_folios; i++)
+		if (!folio_test_uptodate(page_folio(cc->rpages[i])))
+			return;
+	if (f2fs_compressed_blocks(cc) <= 0)
+		return;
+	for (i = 0; i < nr_folios; i++) {
+		struct folio *folio = page_folio(cc->rpages[i]);
+
+		/* A folio without a folio state is dirty as a whole. */
+		if (f2fs_folio_has_ffs(folio))
+			f2fs_ffs_mark_subrange_dirty(folio, 0,
+						     folio_size(folio));
+	}
+}
+
 int f2fs_write_multi_pages(struct compress_ctx *cc,
 					int *submitted,
 					struct writeback_control *wbc,
@@ -1603,6 +1808,8 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 	int err;
 
 	*submitted = 0;
+	if (f2fs_has_subpage_blocks(F2FS_I_SB(cc->inode)))
+		dirty_partial_compressed_cluster(cc);
 	if (cluster_may_compress(cc)) {
 		err = f2fs_compress_pages(cc);
 		if (err == -EAGAIN) {
@@ -1639,17 +1846,27 @@ static int f2fs_prepare_decomp_mem(struct decompress_io_ctx *dic,
 		bool pre_alloc)
 {
 	const struct f2fs_compress_ops *cops = f2fs_cops[dic->compress_algorithm];
+	unsigned int nr_rfolios = dic->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(dic->sbi);
+	unsigned int cbuf_blk_ofs = f2fs_has_subpage_blocks(dic->sbi) ? 1 : 0;
+	void *cbuf_vaddr;
 	int i;
 
 	if (!allow_memalloc_for_decomp(dic->sbi, pre_alloc))
 		return 0;
 
-	dic->tpages = page_array_alloc(dic->sbi, dic->cluster_size);
+	dic->tpages = page_array_alloc(dic->sbi, nr_rfolios);
 	if (!dic->tpages)
 		return -ENOMEM;
 
-	for (i = 0; i < dic->cluster_size; i++) {
-		if (dic->rpages[i]) {
+	for (i = 0; i < nr_rfolios; i++) {
+		/*
+		 * A folio with f2fs_folio_state may have uptodate blocks newer
+		 * than the on-disk cluster (e.g., dirty blocks left after a
+		 * partial truncate). Decompress it into a bounce page instead,
+		 * see f2fs_decompress_cluster().
+		 */
+		if (dic->rpages[i] &&
+		    !f2fs_folio_has_ffs(page_folio(dic->rpages[i]))) {
 			dic->tpages[i] = dic->rpages[i];
 			continue;
 		}
@@ -1657,14 +1874,16 @@ static int f2fs_prepare_decomp_mem(struct decompress_io_ctx *dic,
 		dic->tpages[i] = f2fs_compress_alloc_page();
 	}
 
-	dic->rbuf = f2fs_vmap(dic->tpages, dic->cluster_size);
+	dic->rbuf = f2fs_vmap(dic->tpages, nr_rfolios);
 	if (!dic->rbuf)
 		return -ENOMEM;
 
-	dic->cbuf = f2fs_vmap(dic->cpages, dic->nr_cpages);
-	if (!dic->cbuf)
+	cbuf_vaddr = f2fs_vmap(dic->cpages, dic->nr_cpages);
+	if (!cbuf_vaddr)
 		return -ENOMEM;
 
+	dic->cbuf = cbuf_vaddr + F2FS_BLK_TO_BYTES(dic->sbi, cbuf_blk_ofs);
+
 	if (cops->init_decompress_ctx)
 		return cops->init_decompress_ctx(dic);
 
@@ -1675,6 +1894,7 @@ static void f2fs_release_decomp_mem(struct decompress_io_ctx *dic,
 		bool bypass_destroy_callback, bool pre_alloc)
 {
 	const struct f2fs_compress_ops *cops = f2fs_cops[dic->compress_algorithm];
+	unsigned int nr_rfolios = dic->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(dic->sbi);
 
 	if (!allow_memalloc_for_decomp(dic->sbi, pre_alloc))
 		return;
@@ -1682,11 +1902,15 @@ static void f2fs_release_decomp_mem(struct decompress_io_ctx *dic,
 	if (!bypass_destroy_callback && cops->destroy_decompress_ctx)
 		cops->destroy_decompress_ctx(dic);
 
-	if (dic->cbuf)
-		vm_unmap_ram(dic->cbuf, dic->nr_cpages);
+	if (dic->cbuf) {
+		f2fs_vunmap(dic->cbuf, dic->nr_cpages);
+		dic->cbuf = NULL;
+	}
 
-	if (dic->rbuf)
-		vm_unmap_ram(dic->rbuf, dic->cluster_size);
+	if (dic->rbuf) {
+		f2fs_vunmap(dic->rbuf, nr_rfolios);
+		dic->rbuf = NULL;
+	}
 }
 
 static void f2fs_free_dic(struct decompress_io_ctx *dic,
@@ -1697,13 +1921,17 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 	struct decompress_io_ctx *dic;
 	pgoff_t start_idx = start_idx_of_cluster(cc);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(cc->inode);
+	unsigned int nr_rfolios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
+	unsigned int cbuf_blk_ofs = f2fs_has_subpage_blocks(sbi) ? 1 : 0;
+	unsigned int nr_cpages = DIV_ROUND_UP(cbuf_blk_ofs + cc->valid_nr_cblocks,
+					F2FS_BLKS_PER_PAGE(sbi));
 	int i, ret;
 
 	dic = f2fs_kmem_cache_alloc(dic_entry_slab, GFP_F2FS_ZERO, false, sbi);
 	if (!dic)
 		return ERR_PTR(-ENOMEM);
 
-	dic->rpages = page_array_alloc(sbi, cc->cluster_size);
+	dic->rpages = page_array_alloc(sbi, nr_rfolios);
 	if (!dic->rpages) {
 		kmem_cache_free(dic_entry_slab, dic);
 		return ERR_PTR(-ENOMEM);
@@ -1713,31 +1941,32 @@ struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc)
 	dic->inode = cc->inode;
 	dic->sbi = sbi;
 	dic->compress_algorithm = F2FS_I(cc->inode)->i_compress_algorithm;
-	atomic_set(&dic->remaining_pages, cc->nr_cpages);
+	atomic_set(&dic->remaining_blocks, cc->valid_nr_cblocks);
 	dic->cluster_idx = cc->cluster_idx;
 	dic->cluster_size = cc->cluster_size;
 	dic->log_cluster_size = cc->log_cluster_size;
-	dic->nr_cpages = cc->nr_cpages;
+	dic->valid_nr_cblocks = cc->valid_nr_cblocks;
+	dic->nr_cpages = nr_cpages;
 	refcount_set(&dic->refcnt, 1);
 	dic->failed = false;
 	dic->vi = cc->vi;
 
-	for (i = 0; i < dic->cluster_size; i++)
+	for (i = 0; i < nr_rfolios; i++)
 		dic->rpages[i] = cc->rpages[i];
-	dic->nr_rpages = cc->cluster_size;
+	dic->nr_rpages = nr_rfolios;
 
-	dic->cpages = page_array_alloc(sbi, dic->nr_cpages);
+	dic->cpages = page_array_alloc(sbi, nr_cpages);
 	if (!dic->cpages) {
 		ret = -ENOMEM;
 		goto out_free;
 	}
 
-	for (i = 0; i < dic->nr_cpages; i++) {
+	for (i = 0; i < nr_cpages; i++) {
 		struct page *page;
 
 		page = f2fs_compress_alloc_page();
 		f2fs_set_compressed_page(page, cc->inode,
-					start_idx + i + 1, dic);
+				f2fs_cpage_index(sbi, start_idx, i), dic);
 		dic->cpages[i] = page;
 	}
 
@@ -1758,18 +1987,19 @@ static void f2fs_free_dic(struct decompress_io_ctx *dic,
 	int i;
 	/* use sbi in dic to avoid UFA of dic->inode*/
 	struct f2fs_sb_info *sbi = dic->sbi;
+	unsigned int nr_rfolios = dic->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
 
 	f2fs_release_decomp_mem(dic, bypass_destroy_callback, true);
 
 	if (dic->tpages) {
-		for (i = 0; i < dic->cluster_size; i++) {
-			if (dic->rpages[i])
+		for (i = 0; i < nr_rfolios; i++) {
+			if (dic->tpages[i] == dic->rpages[i])
 				continue;
 			if (!dic->tpages[i])
 				continue;
 			f2fs_compress_free_page(dic->tpages[i]);
 		}
-		page_array_free(sbi, dic->tpages, dic->cluster_size);
+		page_array_free(sbi, dic->tpages, nr_rfolios);
 	}
 
 	if (dic->cpages) {
@@ -1812,15 +2042,19 @@ static void f2fs_verify_cluster(struct work_struct *work)
 	int i;
 
 	/* Verify, update, and unlock the decompressed pages. */
-	for (i = 0; i < dic->cluster_size; i++) {
+	for (i = 0; i < dic->nr_rpages; i++) {
 		struct page *rpage = dic->rpages[i];
 		struct folio *rfolio;
 
 		if (!rpage)
 			continue;
 		rfolio = page_folio(rpage);
-		if (fsverity_verify_folio(dic->vi, rfolio))
+		if (fsverity_verify_folio(dic->vi, rfolio)) {
+			if (f2fs_is_multiblock_folio(dic->sbi, rfolio))
+				f2fs_ffs_mark_subrange_uptodate(rfolio, 0,
+							folio_size(rfolio));
 			folio_mark_uptodate(rfolio);
+		}
 		folio_unlock(rfolio);
 	}
 
@@ -1849,16 +2083,20 @@ void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
 	}
 
 	/* Update and unlock the cluster's pagecache pages. */
-	for (i = 0; i < dic->cluster_size; i++) {
+	for (i = 0; i < dic->nr_rpages; i++) {
 		struct page *rpage = dic->rpages[i];
 
 		if (!rpage)
 			continue;
 
-		if (failed)
+		if (failed) {
 			ClearPageUptodate(rpage);
-		else
+		} else {
+			if (f2fs_is_multiblock_folio(dic->sbi, page_folio(rpage)))
+				f2fs_ffs_mark_subrange_uptodate(page_folio(rpage), 0,
+								folio_size(page_folio(rpage)));
 			SetPageUptodate(rpage);
+		}
 		unlock_page(rpage);
 	}
 
@@ -1916,8 +2154,8 @@ void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
 	f2fs_drop_cache_range(COMPRESS_CACHE(sbi), blkaddr, len, false);
 }
 
-static void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
-		struct folio *folio, nid_t ino, block_t blkaddr)
+static void f2fs_cache_compressed_block(struct f2fs_sb_info *sbi,
+		struct folio *folio, size_t offset, nid_t ino, block_t blkaddr)
 {
 	struct f2fs_cached_block *entry;
 
@@ -1961,13 +2199,14 @@ static void f2fs_cache_compressed_page(struct f2fs_sb_info *sbi,
 	}
 
 	entry->ino = ino;
-	memcpy(cache_address(entry), folio_address(folio), sbi->blocksize);
+	memcpy(cache_address(entry), folio_address(folio) + offset,
+							sbi->blocksize);
 	f2fs_cache_set_uptodate(entry);
 	f2fs_put_cache(entry, true);
 }
 
-bool f2fs_load_compressed_folio(struct f2fs_sb_info *sbi, struct folio *folio,
-								block_t blkaddr)
+bool f2fs_load_compressed_block(struct f2fs_sb_info *sbi, struct folio *folio,
+				size_t offset, block_t blkaddr)
 {
 	struct f2fs_cached_block *entry;
 	bool hitted = false;
@@ -1982,8 +2221,8 @@ bool f2fs_load_compressed_folio(struct f2fs_sb_info *sbi, struct folio *folio,
 		if (f2fs_is_compress_cache(entry) &&
 				f2fs_cache_test_uptodate(entry)) {
 			atomic_inc(&sbi->compress_page_hit);
-			memcpy(folio_address(folio),
-				cache_address(entry), folio_size(folio));
+			memcpy(folio_address(folio) + offset,
+				cache_address(entry), sbi->blocksize);
 			hitted = true;
 		}
 		f2fs_put_cache(entry, true);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 7dd6764a9363..cdc9e6e8633c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -150,12 +150,17 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 		bool finished = true;
 		bool uptodate = bio->bi_status == BLK_STS_OK;
 
-		if (!folio_test_large(folio) &&
-		    f2fs_is_compressed_page(folio)) {
+		if (f2fs_is_compressed_page(folio)) {
+			struct decompress_io_ctx *dic = folio->private;
+
+			/* The cluster may be unlocked, so do not use its inode. */
+			nr_blocks = F2FS_BYTES_TO_BLK(dic->sbi, fi.length);
 			if (ctx && !ctx->decompression_attempted)
-				f2fs_end_read_compressed_page(folio, true, 0,
+				f2fs_end_read_compressed_page(folio, fi.offset,
+							true, 0, nr_blocks,
 							in_task);
-			f2fs_put_folio_dic(folio, in_task);
+			while (nr_blocks--)
+				f2fs_put_folio_dic(folio, in_task);
 			continue;
 		}
 
@@ -259,20 +264,24 @@ static void f2fs_verify_and_finish_bio(struct bio *bio, bool in_task)
 static void f2fs_handle_step_decompress(struct bio_post_read_ctx *ctx,
 		bool in_task)
 {
+	struct f2fs_sb_info *sbi = ctx->sbi;
 	struct folio_iter fi;
 	bool all_compressed = true;
 	block_t blkaddr = ctx->fs_blkaddr;
 
 	bio_for_each_folio_all(fi, ctx->bio) {
 		struct folio *folio = fi.folio;
+		unsigned int nr_blocks = F2FS_BYTES_TO_BLK(sbi, fi.length);
 
-		if (f2fs_is_compressed_page(folio))
-			f2fs_end_read_compressed_page(folio, false, blkaddr,
-						      in_task);
-		else
+		if (f2fs_is_compressed_page(folio)) {
+			f2fs_end_read_compressed_page(folio, fi.offset,
+						      false, blkaddr,
+						      nr_blocks, in_task);
+		} else {
 			all_compressed = false;
+		}
 
-		blkaddr++;
+		blkaddr += nr_blocks;
 	}
 
 	ctx->decompression_attempted = true;
@@ -425,7 +434,7 @@ static void f2fs_write_end_bio(struct bio *bio)
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		if (f2fs_is_compressed_page(folio)) {
-			f2fs_compress_write_end_io(bio, folio);
+			f2fs_compress_write_end_io(bio, folio, nr_blocks);
 			continue;
 		}
 #endif
@@ -1337,9 +1346,14 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		io->fio = *fio;
 	}
 
-	bio_offset = bio_folio == fio->folio ? F2FS_FIO_BIO_OFFSET(fio) : 0;
-	bio_len = bio_folio == fio->folio ? F2FS_FIO_BIO_SIZE(fio) :
-					    folio_size(bio_folio);
+	/* A compressed page holds several blocks with subpage blocks. */
+	if (bio_folio == fio->folio || fio->compressed_page) {
+		bio_offset = F2FS_FIO_BIO_OFFSET(fio);
+		bio_len = F2FS_FIO_BIO_SIZE(fio);
+	} else {
+		bio_offset = 0;
+		bio_len = folio_size(bio_folio);
+	}
 
 	if (!bio_add_folio(io->bio, bio_folio, bio_len, bio_offset)) {
 		__submit_merged_bio(io);
@@ -2741,7 +2755,7 @@ static int f2fs_read_single_page(struct inode *inode, struct fsverity_info *vi,
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
-				unsigned nr_pages, sector_t *last_block_in_bio,
+				unsigned int nr_blocks, sector_t *last_block_in_bio,
 				struct readahead_control *rac, bool for_write)
 {
 	struct dnode_of_data dn;
@@ -2749,6 +2763,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct bio *bio = *bio_ret;
 	unsigned int start_idx = cc->cluster_idx << cc->log_cluster_size;
+	unsigned int nr_rfolios = cc->cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi);
 	sector_t last_block_in_file;
 	const unsigned int blocksize = F2FS_BLKSIZE(sbi);
 	struct decompress_io_ctx *dic = NULL;
@@ -2770,7 +2785,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 							blocksize - 1);
 
 	/* get rid of pages beyond EOF */
-	for (i = 0; i < cc->cluster_size; i++) {
+	for (i = 0; i < nr_rfolios; i++) {
 		struct page *page = cc->rpages[i];
 		struct folio *folio;
 
@@ -2778,10 +2793,9 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 			continue;
 
 		folio = page_folio(page);
-		if ((sector_t)folio->index >= last_block_in_file) {
+		if ((sector_t)f2fs_folio_lblk(sbi, folio) >= last_block_in_file) {
 			folio_zero_segment(folio, 0, folio_size(folio));
-			if (!folio_test_uptodate(folio))
-				folio_mark_uptodate(folio);
+			f2fs_ffs_mark_subrange_uptodate(folio, 0, folio_size(folio));
 		} else if (!folio_test_uptodate(folio)) {
 			continue;
 		}
@@ -2824,14 +2838,14 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 			ret = -EFAULT;
 			goto out_put_dnode;
 		}
-		cc->nr_cpages++;
+		cc->valid_nr_cblocks++;
 
 		if (!from_dnode && i >= ei.c_len)
 			break;
 	}
 
 	/* nothing to decompress */
-	if (cc->nr_cpages == 0) {
+	if (cc->valid_nr_cblocks == 0) {
 		ret = 0;
 		goto out_put_dnode;
 	}
@@ -2842,8 +2856,12 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 		goto out_put_dnode;
 	}
 
-	for (i = 0; i < cc->nr_cpages; i++) {
-		struct folio *folio = page_folio(dic->cpages[i]);
+	for (i = 0; i < cc->valid_nr_cblocks; i++) {
+		unsigned int blk_idx = f2fs_has_subpage_blocks(sbi) ? (1 + i) : i;
+		unsigned int c_folio_idx = blk_idx >> F2FS_LOG_BLKS_PER_PAGE(sbi);
+		unsigned int c_folio_ofs = blk_idx % F2FS_BLKS_PER_PAGE(sbi);
+		struct folio *folio = page_folio(dic->cpages[c_folio_idx]);
+		size_t offset = c_folio_ofs * blocksize;
 		block_t blkaddr;
 		struct bio_post_read_ctx *ctx;
 
@@ -2853,8 +2871,8 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 		f2fs_wait_on_block_writeback(inode, blkaddr);
 
-		if (f2fs_load_compressed_folio(sbi, folio, blkaddr)) {
-			if (atomic_dec_and_test(&dic->remaining_pages)) {
+		if (f2fs_load_compressed_block(sbi, folio, offset, blkaddr)) {
+			if (atomic_dec_and_test(&dic->remaining_blocks)) {
 				f2fs_decompress_cluster(dic, true);
 				break;
 			}
@@ -2863,7 +2881,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 		if (bio && (!page_is_mergeable(sbi, bio,
 					*last_block_in_bio, blkaddr) ||
-		    !f2fs_crypt_mergeable_bio(bio, inode, folio->index, NULL))) {
+		    !f2fs_crypt_mergeable_bio(bio, inode, start_idx + 1 + i, NULL))) {
 submit_and_realloc:
 			f2fs_submit_read_bio(sbi, bio, DATA);
 			bio = NULL;
@@ -2871,11 +2889,11 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 		if (!bio)
 			bio = f2fs_grab_read_bio(inode, cc->vi, blkaddr,
-						 nr_pages - i,
+						 nr_blocks - i,
 						 f2fs_ra_op_flags(rac),
-						 folio->index, for_write);
+						 start_idx + 1 + i, for_write);
 
-		if (!bio_add_folio(bio, folio, blocksize, 0))
+		if (!bio_add_folio(bio, folio, blocksize, offset))
 			goto submit_and_realloc;
 
 		ctx = get_post_read_ctx(bio);
@@ -2898,7 +2916,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	if (from_dnode)
 		f2fs_put_dnode(&dn);
 out:
-	for (i = 0; i < cc->cluster_size; i++) {
+	for (i = 0; i < nr_rfolios; i++) {
 		if (cc->rpages[i]) {
 			ClearPageUptodate(cc->rpages[i]);
 			unlock_page(cc->rpages[i]);
@@ -3408,7 +3426,13 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	if (!folio)
 		goto out;
 
-	f2fs_update_read_folio_count(sbi, folio);
+	/*
+	 * f2fs_mpage_readpages() counts the folios of the compressed files
+	 * that it reads cluster by cluster, i.e. those without large folios.
+	 */
+	if (!f2fs_compressed_file(inode) ||
+	    mapping_large_folio_support(inode->i_mapping))
+		f2fs_update_read_folio_count(sbi, folio);
 
 	folio_in_bio = false;
 	index = f2fs_folio_lblk(sbi, folio);
@@ -3599,7 +3623,7 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 		.rpages = NULL,
 		.cpages = NULL,
 		.nr_rpages = 0,
-		.nr_cpages = 0,
+		.valid_nr_cblocks = 0,
 	};
 	pgoff_t nc_cluster_idx = NULL_CLUSTER;
 	pgoff_t index;
@@ -3609,14 +3633,19 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 	unsigned max_nr_pages = nr_pages;
 	int ret = 0;
 
-	if (f2fs_has_multiblock_folios(inode))
+	if (mapping_large_folio_support(inode->i_mapping) ||
+	    (f2fs_has_subpage_blocks(F2FS_I_SB(inode)) &&
+	     !f2fs_compressed_file(inode)))
 		return f2fs_read_data_large_folio(inode, vi, rac, folio);
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_compressed_file(inode)) {
+		unsigned int nr_rfolios = cc.cluster_size >>
+				F2FS_LOG_BLKS_PER_PAGE(F2FS_I_SB(inode));
+
 		index = rac ? readahead_index(rac) : folio->index;
-		max_nr_pages = round_up(index + nr_pages, cc.cluster_size) -
-				round_down(index, cc.cluster_size);
+		max_nr_pages = round_up(index + nr_pages, nr_rfolios) -
+				round_down(index, nr_rfolios);
 	}
 #endif
 
@@ -3638,16 +3667,17 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 		f2fs_update_read_folio_count(F2FS_I_SB(inode), folio);
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-		index = folio->index;
+		pgoff_t f_lblk = f2fs_folio_lblk(F2FS_I_SB(inode), folio);
 
 		if (!f2fs_compressed_file(inode))
 			goto read_single_page;
 
 		/* there are remained compressed pages, submit them */
-		if (!f2fs_cluster_can_merge_page(&cc, index)) {
+		if (!f2fs_cluster_can_merge_block(&cc, f_lblk)) {
 			cc.vi = vi;
 			ret = f2fs_read_multi_pages(&cc, &bio,
-						max_nr_pages,
+						max_nr_pages <<
+							F2FS_LOG_BLKS_PER_PAGE(F2FS_I_SB(inode)),
 						&last_block_in_bio,
 						rac, false);
 			f2fs_destroy_compress_ctx(&cc, false);
@@ -3655,15 +3685,15 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 				goto set_error_page;
 		}
 		if (cc.cluster_idx == NULL_CLUSTER) {
-			if (nc_cluster_idx == index >> cc.log_cluster_size)
+			if (nc_cluster_idx == f_lblk >> cc.log_cluster_size)
 				goto read_single_page;
 
-			ret = f2fs_is_compressed_cluster(inode, index);
+			ret = f2fs_is_compressed_cluster(inode, f_lblk);
 			if (ret < 0)
 				goto set_error_page;
 			else if (!ret) {
 				nc_cluster_idx =
-					index >> cc.log_cluster_size;
+					f_lblk >> cc.log_cluster_size;
 				goto read_single_page;
 			}
 
@@ -3679,15 +3709,24 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 read_single_page:
 #endif
 
-		ret = f2fs_read_single_page(inode, vi, folio, max_nr_pages,
-					    &map, &bio, &last_block_in_bio,
-					    rac);
-		if (ret) {
+		if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio)) {
+			ret = f2fs_read_data_large_folio(inode, vi, NULL, folio);
+			if (ret)
+				continue;
+		} else {
+			ret = f2fs_read_single_page(inode, vi, folio,
+						    max_nr_pages, &map, &bio,
+						    &last_block_in_bio, rac);
+			if (ret) {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 set_error_page:
 #endif
-			folio_zero_segment(folio, 0, folio_size(folio));
-			folio_unlock(folio);
+				/* Keep the blocks that are uptodate in ffs */
+				if (!f2fs_folio_has_ffs(folio))
+					folio_zero_segment(folio, 0,
+							   folio_size(folio));
+				folio_unlock(folio);
+			}
 		}
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 next_page:
@@ -3699,7 +3738,8 @@ static int f2fs_mpage_readpages(struct inode *inode, struct fsverity_info *vi,
 			if (nr_pages == 1 && !f2fs_cluster_is_empty(&cc)) {
 				cc.vi = vi;
 				ret = f2fs_read_multi_pages(&cc, &bio,
-							max_nr_pages,
+							max_nr_pages <<
+							F2FS_LOG_BLKS_PER_PAGE(F2FS_I_SB(inode)),
 							&last_block_in_bio,
 							rac, false);
 				f2fs_destroy_compress_ctx(&cc, false);
@@ -4008,7 +4048,8 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 					struct writeback_control *wbc,
 					enum iostat_type io_type,
-					u64 start, u64 end)
+					u64 start, u64 end,
+					int compr_blocks)
 {
 	struct inode *inode = folio->mapping->host;
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -4041,6 +4082,7 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 			.folio_blkcnt = 1,
 			.encrypted_page = NULL,
 			.submitted = 0,
+			.compr_blocks = (i == 0) ? compr_blocks : 0,
 			.need_lock = LOCK_DONE,
 			.meta_gc = f2fs_meta_inode_gc_required(inode) ? 1 : 0,
 			.io_type = io_type,
@@ -4051,8 +4093,12 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 			struct f2fs_folio_state *ffs =
 				(struct f2fs_folio_state *)folio->private;
 
-			/* Write only dirty blocks */
-			if (!f2fs_ffs_test_blk_dirty(folio, data_idx))
+			/*
+			 * Write only dirty blocks, or all blocks of a
+			 * compressed cluster.
+			 */
+			if (!compr_blocks &&
+			    !f2fs_ffs_test_blk_dirty(folio, data_idx))
 				continue;
 			atomic_inc(&ffs->write_blocks_pending);
 		}
@@ -4127,6 +4173,9 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 
 		fio.version = ni.version;
 
+		if (fio.compr_blocks && fio.old_blkaddr == COMPRESS_ADDR)
+			f2fs_i_compr_blocks_update(inode, fio.compr_blocks - 1, false);
+
 		f2fs_outplace_write_data(&dn, &fio);
 		f2fs_put_dnode(&dn);
 		/* The outplace write path failed to submit this block. */
@@ -4213,6 +4262,33 @@ static enum f2fs_wb_action f2fs_wb_folio_action(struct f2fs_sb_info *sbi,
 	return F2FS_WB_WRITE;
 }
 
+/*
+ * Hold a bias on write_blocks_pending while the blocks of a multi-block
+ * folio are submitted, so that their completions cannot end the folio
+ * writeback early. Without ffs, the folio dirty flag covered @len bytes.
+ */
+static void f2fs_folio_get_write_bias(struct folio *folio, size_t len)
+{
+	struct f2fs_folio_state *ffs;
+
+	if (!f2fs_folio_has_ffs(folio)) {
+		struct inode *inode = folio->mapping->host;
+
+		/*
+		 * PG_dirty, which was cleared for writeback, covered every
+		 * block and the folio was accounted as a whole. Account its
+		 * dirty bits instead.
+		 */
+		WARN_ON_ONCE(folio_test_dirty(folio));
+		f2fs_ffs_mark_subrange_dirty(folio, 0, len);
+		f2fs_account_dirty_blocks(inode,
+			-(int)f2fs_blocks_per_folio(F2FS_I_SB(inode), folio));
+	}
+	ffs = folio->private;
+	WARN_ON_ONCE(atomic_read(&ffs->write_blocks_pending) != 0);
+	atomic_inc(&ffs->write_blocks_pending);
+}
+
 int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 				struct bio **bio,
 				sector_t *last_block,
@@ -4231,6 +4307,7 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 	bool need_balance_fs = false;
 	bool quota_inode = IS_NOQUOTA(inode);
 	int err = 0;
+	int local_submitted = 0;
 	struct f2fs_io_info fio = {
 		.sbi = sbi,
 		.ino = inode->i_ino,
@@ -4277,6 +4354,46 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 
 	folio_zero_segment(folio, offset, folio_size(folio));
 write:
+	if (f2fs_is_multiblock_folio(sbi, folio)) {
+		struct f2fs_lock_context lc;
+		unsigned int to_blk = f2fs_blocks_per_folio(sbi, folio);
+		u64 pos = folio_pos(folio);
+
+		if (!compr_blocks && !f2fs_verity_in_progress(inode))
+			to_blk = min_t(unsigned int,
+					F2FS_BLK_ALIGN(sbi, i_size - pos),
+					to_blk);
+
+		/* Deadlock due to between page->lock and f2fs_lock_op */
+		if (!compr_blocks && !f2fs_trylock_op(sbi, &lc)) {
+			err = -EAGAIN;
+			goto redirty_out;
+		}
+
+		folio_start_writeback(folio);
+		f2fs_folio_get_write_bias(folio, F2FS_BLK_TO_BYTES(sbi, to_blk));
+
+		err = f2fs_write_folio_dirty_range(folio, &local_submitted,
+					wbc, io_type, pos,
+					pos + F2FS_BLK_TO_BYTES(sbi, to_blk),
+					compr_blocks);
+
+		if (!compr_blocks)
+			f2fs_unlock_op(sbi, &lc);
+
+		/* The callers drop the submitted count on error. */
+		if (err && local_submitted)
+			f2fs_submit_merged_write_cond(sbi, NULL, folio);
+
+		if (!err)
+			f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
+					folio_size(folio));
+
+		f2fs_ffs_put_write_pending(folio, 1);
+
+		goto done;
+	}
+
 	if (f2fs_cp_controlled_inode(inode)) {
 		struct f2fs_lock_context lc;
 
@@ -4346,7 +4463,9 @@ int f2fs_write_single_data_page(struct folio *folio, int *submitted,
 	}
 
 	if (submitted)
-		*submitted = fio.submitted;
+		*submitted = f2fs_is_multiblock_folio(sbi, folio) ?
+			DIV_ROUND_UP(local_submitted, F2FS_BLKS_PER_PAGE(sbi)) :
+			fio.submitted;
 
 	return 0;
 
@@ -4391,10 +4510,10 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 		.rpages = NULL,
 		.nr_rpages = 0,
 		.cpages = NULL,
-		.valid_nr_cpages = 0,
+		.valid_nr_cblocks = 0,
 		.rbuf = NULL,
 		.cbuf = NULL,
-		.rlen = PAGE_SIZE * F2FS_I(inode)->i_cluster_size,
+		.rlen = F2FS_BLK_TO_BYTES(sbi, F2FS_I(inode)->i_cluster_size),
 		.private = NULL,
 	};
 #endif
@@ -4483,6 +4602,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 				void *fsdata = NULL;
 				struct page *pagep;
 				int ret2;
+				pgoff_t f_lblk = f2fs_folio_lblk(sbi, folio);
 
 				ret = f2fs_init_compress_ctx(&cc);
 				if (ret) {
@@ -4490,8 +4610,7 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 					break;
 				}
 
-				if (!f2fs_cluster_can_merge_page(&cc,
-								folio->index)) {
+				if (!f2fs_cluster_can_merge_block(&cc, f_lblk)) {
 					ret = f2fs_write_multi_pages(&cc,
 						&submitted, wbc, io_type);
 					if (!ret)
@@ -4511,14 +4630,14 @@ static int f2fs_write_cache_pages(struct address_space *mapping,
 
 				ret2 = f2fs_prepare_compress_overwrite(
 							inode, &pagep,
-							folio->index, &fsdata);
+							f_lblk, &fsdata);
 				if (ret2 < 0) {
 					ret = ret2;
 					done = 1;
 					break;
 				} else if (ret2 &&
 					(!f2fs_compress_write_end(inode,
-						fsdata, folio->index, 1) ||
+						fsdata, f_lblk, 1) ||
 					 !f2fs_all_cluster_page_ready(&cc,
 						pages, i, nr_pages,
 						false))) {
@@ -4673,7 +4792,6 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		clear_inode_flag(inode, FI_HOT_DATA);
 
 	while ((folio = writeback_iter(mapping, wbc, folio, &err))) {
-		struct f2fs_folio_state *ffs = NULL;
 		u64 isize;
 		size_t poff;
 		pgoff_t end_index;
@@ -4697,16 +4815,6 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 			goto retry_out;
 		}
 
-		if (f2fs_has_subpage_blocks(sbi) &&
-		    f2fs_compressed_file(inode)) {
-			WARN_ON_ONCE(1);
-			mapping_set_error(mapping, -EOPNOTSUPP);
-			folio_clear_dirty_for_io(folio);
-			f2fs_folio_clear_dirty_blocks(folio, true);
-			err = -EOPNOTSUPP;
-			goto retry_out;
-		}
-
 		/*
 		 * Writing back one large folio performs multiple block allocations, so
 		 * best-effort balance the filesystem before writing it back.
@@ -4821,35 +4929,12 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		 * folio has no ffs, so its whole folio is written.
 		 */
 		if (f2fs_is_multiblock_folio(sbi, folio)) {
-			if (!f2fs_folio_has_ffs(folio)) {
-				/*
-				 * PG_dirty, which was cleared for writeback,
-				 * covered every block and the folio was
-				 * accounted as a whole. Account its dirty
-				 * bits instead.
-				 */
-				WARN_ON_ONCE(folio_test_dirty(folio));
-				f2fs_ffs_mark_subrange_dirty(folio, 0, end_pos - pos);
-				f2fs_account_dirty_blocks(inode,
-					-(int)f2fs_blocks_per_folio(sbi, folio));
-			}
-			ffs = (struct f2fs_folio_state *)folio->private;
-			/*
-			 * Multiblock folios can be submitted as multiple bios,
-			 * which may complete while we are still submitting the
-			 * remaining dirty ranges.  Hold a bias on
-			 * write_blocks_pending to prevent folio_end_writeback()
-			 * from being called early.
-			 */
-			if (!bias_added) {
-				WARN_ON_ONCE(atomic_read(&ffs->write_blocks_pending) != 0);
-				atomic_inc(&ffs->write_blocks_pending);
-				bias_added = true;
-			}
+			f2fs_folio_get_write_bias(folio, end_pos - pos);
+			bias_added = true;
 		}
 
 		err = f2fs_write_folio_dirty_range(folio, &submitted, wbc, io_type,
-						   pos, end_pos);
+						   pos, end_pos, 0);
 		folio_submitted += submitted;
 		nwritten += submitted;
 		if (err)
@@ -5002,7 +5087,8 @@ static int __f2fs_write_data_pages(struct address_space *mapping,
 	account_writeback(inode, true);
 
 	blk_start_plug(&plug);
-	if (f2fs_has_multiblock_folios(inode))
+	if (mapping_large_folio_support(mapping) ||
+	    (f2fs_has_subpage_blocks(sbi) && !f2fs_compressed_file(inode)))
 		ret = f2fs_write_cache_folios(mapping, wbc, io_type);
 	else
 		ret = f2fs_write_cache_pages(mapping, wbc, io_type);
@@ -5340,10 +5426,6 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 	size_t need_off = ori_off;
 	int err = 0;
 
-	if (f2fs_has_subpage_blocks(sbi) &&
-	    f2fs_compressed_file(inode))
-		return -EOPNOTSUPP;
-
 	/*
 	 * f2fs_balance_fs_folio_locked() unlocks the folio to balance. Skip it
 	 * for page_mkwrite (!@balance), which cannot unlock the folio and has
@@ -5540,12 +5622,6 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 		goto fail;
 	}
 
-	if (f2fs_has_subpage_blocks(sbi) &&
-	    f2fs_compressed_file(inode)) {
-		err = -EOPNOTSUPP;
-		goto fail;
-	}
-
 	/*
 	 * We should check this at this moment to avoid deadlock on inode page
 	 * and #0 page. The locking rule for inline_data conversion should be:
@@ -5566,11 +5642,13 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 
 		*fsdata = NULL;
 
+		pgoff_t f_lblk = F2FS_BYTES_TO_BLK(sbi, pos);
+
 		if (len == PAGE_SIZE && !(f2fs_is_atomic_file(inode)))
 			goto repeat;
 
 		ret = f2fs_prepare_compress_overwrite(inode, &page,
-							index, fsdata);
+							f_lblk, fsdata);
 		if (ret < 0) {
 			err = ret;
 			goto fail;
@@ -5747,7 +5825,8 @@ static int f2fs_write_end(const struct kiocb *iocb,
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	/* overwrite compressed file */
 	if (f2fs_compressed_file(inode) && fsdata) {
-		f2fs_compress_write_end(inode, fsdata, folio->index, copied);
+		f2fs_compress_write_end(inode, fsdata,
+				f2fs_folio_lblk(F2FS_I_SB(inode), folio), copied);
 		f2fs_update_time(F2FS_I_SB(inode), REQ_TIME);
 
 		if (pos + copied > i_size_read(inode) &&
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index f84d6f4cd1eb..013df25ccbac 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1696,7 +1696,7 @@ struct compress_ctx {
 	unsigned int nr_rpages;		/* total page number in rpages */
 	struct page **cpages;		/* pages store compressed data in cluster */
 	unsigned int nr_cpages;		/* total page number in cpages */
-	unsigned int valid_nr_cpages;	/* valid page number in cpages */
+	unsigned int valid_nr_cblocks;	/* valid block number in cpages */
 	void *rbuf;			/* virtual mapped address on rpages */
 	struct compress_data *cbuf;	/* virtual mapped address on cpages */
 	size_t rlen;			/* valid data length in rbuf */
@@ -1712,7 +1712,9 @@ struct compress_io_ctx {
 	struct inode *inode;		/* inode the context belong to */
 	struct page **rpages;		/* pages store raw data in cluster */
 	unsigned int nr_rpages;		/* total page number in rpages */
-	atomic_t pending_pages;		/* in-flight compressed page count */
+	atomic_t pending_blocks;	/* in-flight compressed block count */
+	struct page **cpages;		/* bounce pages store compressed data */
+	unsigned int nr_cpages;		/* total page number in cpages */
 };
 
 /* Context for decompressing one cluster on the read IO path */
@@ -1727,6 +1729,7 @@ struct decompress_io_ctx {
 	unsigned int nr_rpages;		/* total page number in rpages */
 	struct page **cpages;		/* pages store compressed data in cluster */
 	unsigned int nr_cpages;		/* total page number in cpages */
+	unsigned int valid_nr_cblocks;	/* valid compressed block number */
 	struct page **tpages;		/* temp pages to pad holes in cluster */
 	void *rbuf;			/* virtual mapped address on rpages */
 	struct compress_data *cbuf;	/* virtual mapped address on cpages */
@@ -1734,16 +1737,16 @@ struct decompress_io_ctx {
 	size_t clen;			/* valid data length in cbuf */
 
 	/*
-	 * The number of compressed pages remaining to be read in this cluster.
-	 * This is initially nr_cpages.  It is decremented by 1 each time a page
-	 * has been read (or failed to be read).  When it reaches 0, the cluster
-	 * is decompressed (or an error is reported).
+	 * The number of compressed blocks remaining to be read in this cluster.
+	 * This is initially valid_nr_cblocks.  It is decremented by the number
+	 * of blocks each time they have been read (or failed to be read).  When
+	 * it reaches 0, the cluster is decompressed (or an error is reported).
 	 *
 	 * If an error occurs before all the pages have been submitted for I/O,
 	 * then this will never reach 0.  In this case the I/O submitter is
 	 * responsible for calling f2fs_decompress_end_io() instead.
 	 */
-	atomic_t remaining_pages;
+	atomic_t remaining_blocks;
 
 	/*
 	 * Number of references to this decompress_io_ctx.
@@ -1770,7 +1773,7 @@ struct decompress_io_ctx {
 #define NULL_CLUSTER			((unsigned int)(~0))
 #define MIN_COMPRESS_LOG_SIZE		2
 #define MAX_COMPRESS_LOG_SIZE		8
-#define MAX_COMPRESS_WINDOW_SIZE(log_size)	((PAGE_SIZE) << (log_size))
+#define MAX_COMPRESS_WINDOW_SIZE(sbi, log_size)	((F2FS_BLKSIZE(sbi)) << (log_size))
 
 struct f2fs_gc_kthread {
 	struct task_struct *f2fs_gc_task;
@@ -2338,6 +2341,12 @@ static inline unsigned int f2fs_blocks_per_folio(struct f2fs_sb_info *sbi,
 
 #define F2FS_LOG_BLKS_PER_PAGE(sbi)	(PAGE_SHIFT - (sbi)->log_blocksize)
 
+static inline unsigned int min_compress_log_size(struct f2fs_sb_info *sbi)
+{
+	return max_t(unsigned int, MIN_COMPRESS_LOG_SIZE,
+			F2FS_LOG_BLKS_PER_PAGE(sbi));
+}
+
 static inline bool f2fs_has_subpage_blocks(struct f2fs_sb_info *sbi)
 {
 	return F2FS_BLKSIZE(sbi) < PAGE_SIZE;
@@ -3019,16 +3028,6 @@ static inline void inode_sub_dirty_blocks(struct inode *inode,
 		sub_cache_counts(sbi, F2FS_DIRTY_QDATA, nr_blocks);
 }
 
-static inline void inode_inc_dirty_block(struct inode *inode)
-{
-	inode_add_dirty_blocks(inode, 1);
-}
-
-static inline void inode_dec_dirty_block(struct inode *inode)
-{
-	inode_sub_dirty_blocks(inode, 1);
-}
-
 static inline void inc_atomic_write_cnt(struct inode *inode)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
@@ -4994,20 +4993,22 @@ enum cluster_check_type {
 bool f2fs_is_compressed_page(struct folio *folio);
 struct folio *f2fs_compress_control_folio(struct folio *folio);
 int f2fs_prepare_compress_overwrite(struct inode *inode,
-			struct page **pagep, pgoff_t index, void **fsdata);
+			struct page **pagep, pgoff_t lblk, void **fsdata);
 bool f2fs_compress_write_end(struct inode *inode, void *fsdata,
-					pgoff_t index, unsigned copied);
+					pgoff_t lblk, unsigned int copied);
 int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock);
-void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio);
+void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio,
+				unsigned int nr_blocks);
 bool f2fs_is_compress_backend_ready(struct inode *inode);
 bool f2fs_is_compress_level_valid(int alg, int lvl);
 int __init f2fs_init_compress_mempool(void);
 void f2fs_destroy_compress_mempool(void);
 void f2fs_decompress_cluster(struct decompress_io_ctx *dic, bool in_task);
-void f2fs_end_read_compressed_page(struct folio *folio, bool failed,
-				block_t blkaddr, bool in_task);
+void f2fs_end_read_compressed_page(struct folio *folio, size_t offset,
+				bool failed, block_t blkaddr,
+				unsigned int nr_blocks, bool in_task);
 bool f2fs_cluster_is_empty(struct compress_ctx *cc);
-bool f2fs_cluster_can_merge_page(struct compress_ctx *cc, pgoff_t index);
+bool f2fs_cluster_can_merge_block(struct compress_ctx *cc, pgoff_t lblk);
 bool f2fs_all_cluster_page_ready(struct compress_ctx *cc, struct page **pages,
 				int index, int nr_pages, bool uptodate);
 bool f2fs_sanity_check_cluster(struct dnode_of_data *dn);
@@ -5016,13 +5017,13 @@ int f2fs_write_multi_pages(struct compress_ctx *cc,
 						int *submitted,
 						struct writeback_control *wbc,
 						enum iostat_type io_type);
-int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t index);
-bool f2fs_is_sparse_cluster(struct inode *inode, pgoff_t index);
+int f2fs_is_compressed_cluster(struct inode *inode, pgoff_t lblk);
+bool f2fs_is_sparse_cluster(struct inode *inode, pgoff_t lblk);
 void f2fs_update_read_extent_tree_range_compressed(struct inode *inode,
 				pgoff_t fofs, block_t blkaddr,
 				unsigned int llen, unsigned int c_len);
 int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
-				unsigned nr_pages, sector_t *last_block_in_bio,
+				unsigned int nr_blocks, sector_t *last_block_in_bio,
 				struct readahead_control *rac, bool for_write);
 struct decompress_io_ctx *f2fs_alloc_dic(struct compress_ctx *cc);
 void f2fs_decompress_end_io(struct decompress_io_ctx *dic, bool failed,
@@ -5040,8 +5041,8 @@ int __init f2fs_init_compress_cache(void);
 void f2fs_destroy_compress_cache(void);
 void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
 					block_t blkaddr, unsigned int len);
-bool f2fs_load_compressed_folio(struct f2fs_sb_info *sbi, struct folio *folio,
-								block_t blkaddr);
+bool f2fs_load_compressed_block(struct f2fs_sb_info *sbi, struct folio *folio,
+				size_t offset, block_t blkaddr);
 void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi, nid_t ino);
 #define inc_compr_inode_stat(inode)					\
 	do {								\
@@ -5075,7 +5076,8 @@ static inline void f2fs_destroy_compress_mempool(void) { }
 static inline void f2fs_decompress_cluster(struct decompress_io_ctx *dic,
 				bool in_task) { }
 static inline void f2fs_end_read_compressed_page(struct folio *folio,
-				bool failed, block_t blkaddr, bool in_task)
+				size_t offset, bool failed, block_t blkaddr,
+				unsigned int nr_blocks, bool in_task)
 {
 	WARN_ON_ONCE(1);
 }
@@ -5093,17 +5095,18 @@ static inline int __init f2fs_init_compress_cache(void) { return 0; }
 static inline void f2fs_destroy_compress_cache(void) { }
 static inline void f2fs_invalidate_compress_pages_range(struct f2fs_sb_info *sbi,
 				block_t blkaddr, unsigned int len) { }
-static inline bool f2fs_load_compressed_folio(struct f2fs_sb_info *sbi,
-		struct folio *folio, block_t blkaddr) { return false; }
+static inline bool f2fs_load_compressed_block(struct f2fs_sb_info *sbi,
+		struct folio *folio, size_t offset,
+		block_t blkaddr) { return false; }
 static inline void f2fs_invalidate_compress_pages(struct f2fs_sb_info *sbi,
 							nid_t ino) { }
 #define inc_compr_inode_stat(inode)		do { } while (0)
 static inline int f2fs_is_compressed_cluster(
 				struct inode *inode,
-				pgoff_t index) { return 0; }
+				pgoff_t lblk) { return 0; }
 static inline bool f2fs_is_sparse_cluster(
 				struct inode *inode,
-				pgoff_t index) { return true; }
+				pgoff_t lblk) { return true; }
 static inline void f2fs_update_read_extent_tree_range_compressed(
 				struct inode *inode,
 				pgoff_t fofs, block_t blkaddr,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 64c91827a5f4..c80dbbe76f8f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -179,7 +179,7 @@ static vm_fault_t f2fs_vm_page_mkwrite(struct vm_fault *vmf)
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 	if (f2fs_compressed_file(inode)) {
-		int ret = f2fs_is_compressed_cluster(inode, pidx);
+		int ret = f2fs_is_compressed_cluster(inode, bidx);
 
 		if (ret < 0) {
 			err = ret;
@@ -1032,7 +1032,8 @@ int f2fs_truncate_blocks(struct inode *inode, u64 from, bool lock)
 	 */
 	if (f2fs_compressed_file(inode))
 		free_from = round_up(from,
-				F2FS_I(inode)->i_cluster_size << PAGE_SHIFT);
+				F2FS_BLK_TO_BYTES(F2FS_I_SB(inode),
+					F2FS_I(inode)->i_cluster_size));
 #endif
 
 	err = f2fs_do_truncate_blocks(inode, free_from, lock);
@@ -2313,13 +2314,6 @@ static long f2fs_fallocate(struct file *file, int mode,
 		goto out;
 	}
 
-	if (f2fs_has_subpage_blocks(F2FS_I_SB(inode))) {
-		if (f2fs_compressed_file(inode)) {
-			ret = -EOPNOTSUPP;
-			goto out;
-		}
-	}
-
 	ret = file_modified(file);
 	if (ret)
 		goto out;
@@ -4522,9 +4516,6 @@ static int f2fs_release_compress_blocks(struct file *filp, unsigned long arg)
 	int ret;
 	int writecount;
 
-	if (f2fs_has_subpage_blocks(sbi))
-		return -EOPNOTSUPP;
-
 	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
@@ -4720,9 +4711,6 @@ static int f2fs_reserve_compress_blocks(struct file *filp, unsigned long arg)
 	unsigned int reserved_blocks = 0;
 	int ret;
 
-	if (f2fs_has_subpage_blocks(sbi))
-		return -EOPNOTSUPP;
-
 	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
@@ -5044,9 +5032,6 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 	struct f2fs_comp_option option;
 	int ret = 0;
 
-	if (f2fs_has_subpage_blocks(sbi))
-		return -EOPNOTSUPP;
-
 	if (!f2fs_sb_has_compression(sbi))
 		return -EOPNOTSUPP;
 
@@ -5057,7 +5042,7 @@ static int f2fs_ioc_set_compress_option(struct file *filp, unsigned long arg)
 				sizeof(option)))
 		return -EFAULT;
 
-	if (option.log_cluster_size < MIN_COMPRESS_LOG_SIZE ||
+	if (option.log_cluster_size < min_compress_log_size(sbi) ||
 		option.log_cluster_size > MAX_COMPRESS_LOG_SIZE ||
 		option.algorithm >= COMPRESS_MAX)
 		return -EINVAL;
@@ -5151,15 +5136,15 @@ static int redirty_blocks(struct inode *inode, pgoff_t page_idx, int len)
 		off = offset_in_folio(folio, (loff_t)redirty_idx << PAGE_SHIFT);
 		dlen = (size_t)(next_idx - redirty_idx) << PAGE_SHIFT;
 
-		if (folio_test_large(folio)) {
+		if (f2fs_is_multiblock_folio(F2FS_I_SB(inode), folio)) {
 			/*
-			 * A compressed inode can keep using large folios, in
+			 * f2fs_folio_mark_dirty() does not dirty the blocks of a folio
+			 * state.  A compressed inode can keep using large folios, in
 			 * which case the compression flag only works as a hint
 			 * until the inode is evicted.  Update the subpage dirty
 			 * bitmap as well, otherwise f2fs_write_cache_folios()
 			 * finds no dirty range and skips the whole folio.
 			 */
-			f2fs_ffs_find_or_alloc(folio);
 			f2fs_ffs_mark_subrange_dirty(folio, off, dlen);
 		}
 
@@ -5178,12 +5163,9 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	pgoff_t page_idx = 0, last_idx, cluster_idx;
+	pgoff_t lblk = 0, last_idx, cluster_idx;
 	int ret;
 
-	if (f2fs_has_subpage_blocks(sbi))
-		return -EOPNOTSUPP;
-
 	if (!f2fs_sb_has_compression(sbi) ||
 			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
 		return -EOPNOTSUPP;
@@ -5220,12 +5202,14 @@ static int f2fs_ioc_decompress_file(struct file *filp)
 	last_idx >>= fi->i_log_cluster_size;
 
 	for (cluster_idx = 0; cluster_idx < last_idx; cluster_idx++) {
-		page_idx = cluster_idx << fi->i_log_cluster_size;
+		lblk = cluster_idx << fi->i_log_cluster_size;
 
-		if (!f2fs_is_compressed_cluster(inode, page_idx))
+		if (!f2fs_is_compressed_cluster(inode, lblk))
 			continue;
 
-		ret = redirty_blocks(inode, page_idx, fi->i_cluster_size);
+		ret = redirty_blocks(inode,
+			f2fs_lblk_to_folio_index(sbi, lblk),
+			fi->i_cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi));
 		if (ret < 0)
 			break;
 
@@ -5262,12 +5246,9 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	struct inode *inode = file_inode(filp);
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct f2fs_inode_info *fi = F2FS_I(inode);
-	pgoff_t page_idx = 0, last_idx, cluster_idx;
+	pgoff_t lblk = 0, last_idx, cluster_idx;
 	int ret;
 
-	if (f2fs_has_subpage_blocks(sbi))
-		return -EOPNOTSUPP;
-
 	if (!f2fs_sb_has_compression(sbi) ||
 			F2FS_OPTION(sbi).compress_mode != COMPR_MODE_USER)
 		return -EOPNOTSUPP;
@@ -5310,12 +5291,14 @@ static int f2fs_ioc_compress_file(struct file *filp)
 	last_idx >>= fi->i_log_cluster_size;
 
 	for (cluster_idx = 0; cluster_idx < last_idx; cluster_idx++) {
-		page_idx = cluster_idx << fi->i_log_cluster_size;
+		lblk = cluster_idx << fi->i_log_cluster_size;
 
-		if (f2fs_is_sparse_cluster(inode, page_idx))
+		if (f2fs_is_sparse_cluster(inode, lblk))
 			continue;
 
-		ret = redirty_blocks(inode, page_idx, fi->i_cluster_size);
+		ret = redirty_blocks(inode,
+			f2fs_lblk_to_folio_index(sbi, lblk),
+			fi->i_cluster_size >> F2FS_LOG_BLKS_PER_PAGE(sbi));
 		if (ret < 0)
 			break;
 
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 9b01ead00edc..ac024c089710 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1447,6 +1447,11 @@ static int f2fs_check_compression(struct fs_context *fc,
 		ctx_clear_opt_mask(ctx, F2FS_MOUNT_COMPRESS_CACHE);
 		return 0;
 	}
+	if ((ctx->spec_mask & F2FS_SPEC_compress_log_size) &&
+	    F2FS_CTX_INFO(ctx).compress_log_size < min_compress_log_size(sbi)) {
+		f2fs_err(sbi, "Compress cluster log size is out of range");
+		return -EINVAL;
+	}
 	if (ctx->spec_mask & F2FS_SPEC_compress_extension) {
 		cnt = F2FS_CTX_INFO(ctx).compress_ext_cnt;
 		for (i = 0; i < F2FS_CTX_INFO(ctx).compress_ext_cnt; i++) {
@@ -2630,7 +2635,7 @@ static void default_options(struct f2fs_sb_info *sbi, bool remount)
 	F2FS_OPTION(sbi).s_resgid = make_kgid(&init_user_ns, F2FS_DEF_RESGID);
 	if (f2fs_sb_has_compression(sbi)) {
 		F2FS_OPTION(sbi).compress_algorithm = COMPRESS_LZ4;
-		F2FS_OPTION(sbi).compress_log_size = MIN_COMPRESS_LOG_SIZE;
+		F2FS_OPTION(sbi).compress_log_size = min_compress_log_size(sbi);
 		F2FS_OPTION(sbi).compress_ext_cnt = 0;
 		F2FS_OPTION(sbi).compress_mode = COMPR_MODE_FS;
 	}
-- 
2.56.0.611.g1030f0b940-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
