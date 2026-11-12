Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F96606A8B3
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 15:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=E2QwTbbq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=INkiVP/B;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=GRY+r3rw;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=Jhden7cz
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=NwQdmufq22BgedooCvaVDyCgdKSo0XcAbSQacFlrkG4=; b=E2QwTbbq7I7jNHp2IjJGPkTGJ4
	hrzRv3N8/ZmUpVcFzAi/cm2Tirg7jFYcHxKci/60DRNLbx4mBGmLiOK8MgxMAOXxnGFtI+/mMs0++
	zTOQmZcbQmeC87gtNuPma0lM9aK8pDRsu97+H8Uap5XE0hkava0IJbcgGsj0h2ua41HA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRWo0-000000001D7-2Xes;
	Thu, 12 Nov 2026 15:33:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3as_1agwKAD8kqsvtblpxtljhpphmf.dpn@flex--jprusakowski.bounces.google.com>)
 id 1xRWnz-000000001D1-1AMZ
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 15:33:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=zVcIRGLQacKFTiD51by9bgJAXsfg9Q9oQjRTHChvRJQ=; b=I
 NkiVP/BnwnBsU9kpLKaiX2ggQBT8ClinhbXYxWgmJ1ChUKs4eKT5asTzhRzEqKAyE3SSt9dqGvr+Q
 XnNmfZ63LhQx80nVABAWIF8FBFN/48h4B1L7OcORthruaCyJWdfzCZ1+YFTh3FvnGmvjE7KM07NYG
 KTECskcmwOzdgcqc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zVcIRGLQacKFTiD51by9bgJAXsfg9Q9oQjRTHChvRJQ=; b=GRY+r3rwIe1M97qfp+xrQgKeBl
 djWNW3v3rnK9INjLVX8aFbxUy9J/914Z0FJe//2t2z8MFqPPTI2GHFZg9gJWOn036DUZRt33oBQuP
 d70ikGK8XcUrSDV4W2NHqIq+hsPh+5eHQVrSrkb5L9CxJSnMIdWaqvvI5+ScHrZtpTes=;
Received: from mail-wr1-f72.google.com ([209.85.221.72])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRWnx-000000000l6-3nby
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 15:33:39 +0000
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48e4d1e29f3so4331217f8f.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 07:33:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794497611; x=1795102411;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=zVcIRGLQacKFTiD51by9bgJAXsfg9Q9oQjRTHChvRJQ=;
 b=Jhden7czzkmsMav7vOpdKo7kRYwSKmBgHCiLLsjeGl4i2shXJv8OWXw5SPJIgPlrQG
 3s6m9DUxRTJh5MGxe4M0yO6JS8QXdl0Q5DbWMfvEnbwtj2u7g93s7dKQjrGjOBJabfoW
 Kl2CqnK/xPQOe0UFXSRJB4xIfsgcfaTfazn49c4Y8gjf6T0/LZNEpOC1mFZ6Vnr6Koyd
 7pvI6UbHhd56w+uCx6COY6Z7GkzZ/2MBL3w0g1j0oAgA9LEDEmCOevZHrIJ1KAf3nYjX
 3McE/elILn5UW1uhqnYzZ4049TIW2v9+LhgYMEl/LoCegbK1YPebR60r/MjWC/Q2alVR
 6HTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794497611; x=1795102411;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zVcIRGLQacKFTiD51by9bgJAXsfg9Q9oQjRTHChvRJQ=;
 b=pFultlSPmTjlu/mAaP2QXxfeiHOErNgCzaaoybr0hNLzwHB89QSttsR7R8owkiM6gl
 AEQsEAnuQcYIcxVyiv2pQkI/SekIAceDbamOA4ITgq4w5jGx/OOeSvD2sPzvaC0mFqUV
 XvYoq52Y97m8dHWPg4sC4GqiAMf14k9zxDM/7kKhvpDmAMdcG+mABo339SkB1JxQtfpn
 KTMalwBurQygqYAfPh+sH/oOly1vAU3+GwH2/1rPqnsalBW0cS86JCBR5RYJ5e2V+Nob
 539yge/IEVEeLmXFmkVN/rWIXKcMCMgAJRYOrtLuOWxMErXVEB8ReFkGM1Cgdo7myktU
 E/pw==
X-Gm-Message-State: APuU4Z+UESZjPvWxQtM+lWZYOm8jgC8XX641ivQ1QmUfngjPN4PyZkJK
 2Cm2JU8omKyLe9T6lDEUVhWPPs7+I15qastScoMngBxZPjFGX/0f7c7rvO2phs5BbOW/y1KGLIG
 DUezkQlru6V7n1gINQs/mr7tIWUSENQ==
X-Received: from wmbz21.prod.google.com ([2002:a05:600c:c095:b0:4a1:f80d:2f25])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:810c:b0:4a3:59c9:a756 with SMTP id
 5b1f17b1804b1-4ba09364b9emr108555165e9.6.1794494314261; 
 Thu, 12 Nov 2026 06:38:34 -0800 (PST)
Date: Thu, 12 Nov 2026 14:33:55 +0000
In-Reply-To: <20261112143355.2923939-1-jprusakowski@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261112143355.2923939-1-jprusakowski@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112143355.2923939-10-jprusakowski@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xRWnx-000000000l6-3nby
Subject: [f2fs-dev] [PATCH RESEND 9/9] f2fs: compress: roll back failed
 cluster writes of O_DIRECT buffered fallback
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Jan Prusakowski via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jan Prusakowski <jprusakowski@google.com>
Cc: Eric Biggers <ebiggers@google.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

O_DIRECT writes to compressed files always fall back to buffered I/O.
The out-of-place updates done by writeback of compressed files don't go
through f2fs_do_write_data_page(), so they are not tracked for rollback
by the buffered fallback, and a failed write (e.g. with dm-error in
generic/250 and generic/252) leaves the dnode pointing to blocks that
were never written:

- f2fs_write_compressed_pages() points the slots of the cluster to new
  blocks, sets the header to COMPRESS_ADDR and invalidates the old
  blocks before the bios complete.

- f2fs_write_raw_pages(), when overwriting a compressed cluster, writes
  the pages with compr_blocks set, which f2fs_do_write_data_page() does
  not track, and also changes i_compr_blocks.

Track both as one entry per cluster:

- f2fs_write_compressed_pages() records the old and new block addresses
  of all slots, and the number of compressed blocks of the old and new
  cluster, so that f2fs_rollback_dio_opu_entry() can restore
  i_compr_blocks as well. f2fs_compress_write_end_io() marks the entry
  failed on I/O error; compressed pages carry the index of a page of the
  cluster.

- f2fs_write_raw_pages() records the block addresses of the cluster
  before and after writing it. An error other than a failed I/O can
  leave the cluster partially overwritten, so the entry is marked failed
  then too, to restore the old cluster.

Quota files are not tracked, they are written by the kernel, not with
O_DIRECT.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Assisted-by: LLM
Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 fs/f2fs/compress.c | 97 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 92 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index 0147a7e05022..8aed34dcc89e 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1345,8 +1345,10 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	struct node_info ni;
 	struct compress_io_ctx *cic;
 	struct f2fs_lock_context lc;
+	struct f2fs_dio_opu_entry *opu_entry = NULL;
 	block_t old_blkaddr_onstack[F2FS_ONSTACK_CLUSTER_SIZE];
 	block_t *old_blkaddr = old_blkaddr_onstack;
+	block_t *new_blkaddr = NULL;
 	pgoff_t start_idx = start_idx_of_cluster(cc);
 	unsigned int last_index = cc->cluster_size - 1;
 	loff_t psize;
@@ -1404,7 +1406,15 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 
 	cic->nr_rpages = cc->cluster_size;
 
-	if (cc->cluster_size > ARRAY_SIZE(old_blkaddr_onstack)) {
+	if (!quota_inode &&
+	    unlikely(f2fs_should_track_dio_opu(inode, start_idx,
+					       cc->cluster_size)))
+		opu_entry = f2fs_start_dio_opu_track(inode, start_idx,
+						     cc->cluster_size);
+	if (opu_entry) {
+		old_blkaddr = opu_entry->old_blkaddr;
+		new_blkaddr = opu_entry->new_blkaddr;
+	} else if (cc->cluster_size > ARRAY_SIZE(old_blkaddr_onstack)) {
 		/* At most 1 KiB, don't fail the write for it. */
 		old_blkaddr = kmalloc_array(cc->cluster_size, sizeof(block_t),
 					    GFP_NOFS | __GFP_NOFAIL);
@@ -1472,6 +1482,8 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		cc->cpages[i - 1] = NULL;
 		(*submitted)++;
 unlock_continue:
+		if (new_blkaddr)
+			new_blkaddr[i] = f2fs_data_blkaddr(&dn);
 		inode_dec_dirty_block(cc->inode);
 		folio_unlock(fio.folio);
 	}
@@ -1481,8 +1493,13 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	f2fs_i_compr_blocks_update(inode, cc->valid_nr_cpages, true);
 	add_compr_block_stat(inode, cc->valid_nr_cpages);
 
-	if (old_blkaddr != old_blkaddr_onstack)
+	if (unlikely(opu_entry)) {
+		opu_entry->old_compr_blocks = fio.compr_blocks;
+		opu_entry->new_compr_blocks = 1 + cc->valid_nr_cpages;
+		f2fs_end_dio_opu_track(inode, opu_entry, true, false);
+	} else if (old_blkaddr != old_blkaddr_onstack) {
 		kfree(old_blkaddr);
+	}
 
 	set_inode_flag(cc->inode, FI_APPEND_WRITE);
 
@@ -1504,7 +1521,9 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	return 0;
 
 out_submit_err:
-	if (old_blkaddr != old_blkaddr_onstack)
+	if (unlikely(opu_entry))
+		f2fs_end_dio_opu_track(inode, opu_entry, false, false);
+	else if (old_blkaddr != old_blkaddr_onstack)
 		kfree(old_blkaddr);
 	page_array_free(sbi, cic->rpages, cc->cluster_size);
 out_put_cic:
@@ -1534,8 +1553,10 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 	enum count_type type = WB_DATA_TYPE(folio, true);
 	int i;
 
-	if (unlikely(bio->bi_status != BLK_STS_OK))
+	if (unlikely(bio->bi_status != BLK_STS_OK)) {
 		mapping_set_error(cic->inode->i_mapping, -EIO);
+		f2fs_mark_dio_opu_failed(cic->inode, folio->index);
+	}
 
 	f2fs_compress_free_page(page);
 
@@ -1565,6 +1586,58 @@ void f2fs_compress_write_end_io(struct bio *bio, struct folio *folio)
 	dec_cache_count(sbi, type);
 }
 
+/*
+ * Track the overwrite of a compressed cluster with raw pages during the
+ * buffered fallback of an O_DIRECT write. If the dnode can't be read, write
+ * without tracking rather than failing the write for it.
+ */
+static struct f2fs_dio_opu_entry *f2fs_track_raw_cluster(struct compress_ctx *cc,
+							 pgoff_t start_idx)
+{
+	struct f2fs_dio_opu_entry *entry;
+	struct dnode_of_data dn;
+	unsigned int i;
+
+	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
+	if (f2fs_get_dnode_of_data(&dn, start_idx, LOOKUP_NODE))
+		return NULL;
+
+	entry = f2fs_start_dio_opu_track(cc->inode, start_idx,
+					 cc->cluster_size);
+	for (i = 0; entry && i < cc->cluster_size; i++) {
+		entry->old_blkaddr[i] = data_blkaddr(dn.inode, dn.node_entry,
+						     dn.ofs_in_node + i);
+		entry->new_blkaddr[i] = entry->old_blkaddr[i];
+	}
+	f2fs_put_dnode(&dn);
+
+	return entry;
+}
+
+static void f2fs_end_raw_cluster_track(struct compress_ctx *cc,
+				       struct f2fs_dio_opu_entry *entry,
+				       int compr_blocks, bool failed)
+{
+	struct dnode_of_data dn;
+	unsigned int i;
+
+	set_new_dnode(&dn, cc->inode, NULL, NULL, 0);
+	if (!f2fs_get_dnode_of_data(&dn, entry->start_idx, LOOKUP_NODE)) {
+		for (i = 0; i < cc->cluster_size; i++, dn.ofs_in_node++)
+			entry->new_blkaddr[i] = f2fs_data_blkaddr(&dn);
+		f2fs_put_dnode(&dn);
+	} else {
+		failed = true;
+	}
+
+	/* The cluster is no longer compressed if its header was rewritten. */
+	if (entry->old_blkaddr[0] == COMPRESS_ADDR &&
+	    entry->new_blkaddr[0] != COMPRESS_ADDR)
+		entry->old_compr_blocks = compr_blocks;
+
+	f2fs_end_dio_opu_track(cc->inode, entry, true, failed);
+}
+
 static int f2fs_write_raw_pages(struct compress_ctx *cc,
 					int *submitted_p,
 					struct writeback_control *wbc,
@@ -1572,6 +1645,8 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 {
 	struct address_space *mapping = cc->inode->i_mapping;
 	struct f2fs_sb_info *sbi = F2FS_M_SB(mapping);
+	struct f2fs_dio_opu_entry *opu_entry = NULL;
+	pgoff_t start_idx = start_idx_of_cluster(cc);
 	struct f2fs_lock_context lc;
 	int submitted, compr_blocks, i;
 	int ret = 0;
@@ -1590,8 +1665,13 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 		return compr_blocks;
 
 	/* overwrite compressed cluster w/ normal cluster */
-	if (compr_blocks > 0)
+	if (compr_blocks > 0) {
 		f2fs_lock_op(sbi, &lc);
+		if (!IS_NOQUOTA(cc->inode) &&
+		    unlikely(f2fs_should_track_dio_opu(cc->inode, start_idx,
+						       cc->cluster_size)))
+			opu_entry = f2fs_track_raw_cluster(cc, start_idx);
+	}
 
 	for (i = 0; i < cc->cluster_size; i++) {
 		struct folio *folio;
@@ -1646,6 +1726,13 @@ static int f2fs_write_raw_pages(struct compress_ctx *cc,
 	}
 
 out:
+	/*
+	 * An error other than a failed I/O can leave the cluster partially
+	 * overwritten, so mark it failed too, to restore the old cluster.
+	 */
+	if (unlikely(opu_entry))
+		f2fs_end_raw_cluster_track(cc, opu_entry, compr_blocks,
+					   ret || f2fs_cp_error(sbi));
 	if (compr_blocks > 0)
 		f2fs_unlock_op(sbi, &lc);
 
-- 
2.56.0.567.gdb80ae8cd5-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
