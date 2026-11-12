Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A51606A321
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=EvE9wIgv;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TaPf08sM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=EDHTo0Kc;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=L7sSlrGc
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=YlD8N4NssqPiyFMQ6+V+ooliDnnW08R+LCy8sX8pd4k=; b=EvE9wIgvfZl54f9P0x6erPLKgJ
	xaPp7MKQDmvd2MPXrEuCZ4h9AfJB5XoaiM1TQUYrMHkMloPcs6QdX5u2AzSb2CIlZV0H5TeUj5V2L
	km2aECuP2XFKiqPBcndcc6iip0uVRWZw/ZqNAuH6bsHqqAfD5b+/Ii0kC4qD3eF+A4JU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRVxE-000000001ko-0o0Q;
	Thu, 12 Nov 2026 14:39:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3ac_1agwKAD4ouwzxfpt1xpnlttlqj.htr@flex--jprusakowski.bounces.google.com>)
 id 1xRVwv-000000001jI-3crq
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:38:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=hmIEzwpVPZSicrLKtBd9SCjsMRd93+KAzG0uZsTPwwc=; b=T
 aPf08sMb+x2iI8n1hwWEzbafMp9vSiNgQkq80ERGSeqpQuKCnGEuNEsTy/srQvoqRzgrY8rjw2MfH
 1kkalkgQ2wJhBq1iJG05RO8GQQx4DOMGUoaE3hpzKhtga1WKhvQl4qxp/6TqJsiS7Of+AXs1aYbmk
 Phha72fzpExm2Rvg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hmIEzwpVPZSicrLKtBd9SCjsMRd93+KAzG0uZsTPwwc=; b=EDHTo0KcPPjQqgcr/UUYwXTKaa
 xp0kdVLwD503aLV0zTAnHcY2ZBORKMLXpXCJrBnq6V0EpauJJB8iWp+roiiCRoRCx4AcClforquUq
 4kyzZCVWUWa+5MR1I6srlmKtRPilgRDbqtZidnxnmeEBqVb3aTLnkTjWRzY5fnJRtimQ=;
Received: from mail-ej1-f69.google.com ([209.85.218.69])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRVwm-000000007s7-0wDq
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:38:41 +0000
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c50547b4992so260998966b.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 06:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794494314; x=1795099114;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hmIEzwpVPZSicrLKtBd9SCjsMRd93+KAzG0uZsTPwwc=;
 b=L7sSlrGc8IBfM0nog/IR8xM0Zk1zFZGVPopXJSMSwVx/4JW4AgvhV6Hjp+xWYm0TWQ
 HDTjmIEaoWgcy+vBEpAkbTch5pGpj1c5apqPmFN7/iYisqwRgWpBmX0/v2PKg/mkVLeC
 ZL5Do40ySM2V5b/3higNS/T3KYldEwbHcwVoMcyoskXRVXoe143/jLNnAaJT3QkT8t42
 jT1IDwiC6hyAoGRJvtrsjv8pzTNqD6cPH3VF3Wr1XdQv9FgvCakXXqkY9lMe69eKLGVO
 m5coK1vGI9ZBmI2JX8E+xd/PVMzR+ePWAY4/MPyw6qRziskUYM7EufmfGcrAM8Ht35Ji
 8azQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794494314; x=1795099114;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hmIEzwpVPZSicrLKtBd9SCjsMRd93+KAzG0uZsTPwwc=;
 b=gLkF6/VRbLrh8wC45wahve6mMkhWTCXhAk3iR6+oX5VFNAyn1EvSljiiQhSOYsGfl9
 NzTzH6avxQfNEJ+SaiuEJUOSR2rQ6O2oaA/xMGXNiXmQLZOyo18FkPecOrYkRufRCqkD
 sViPYOgCy66+pNmpPwhwHMfOK1PpxwDqI7nymWALtScEYJHvM4P1a20AzzkGIjCnUx3n
 wRrH4jwSfLdmHET37Cl/LYmcKh+KRCA2pcwxeOLxFjnsKcaiMbthROwWa6MSC3szZfp5
 US1XEN6fu6lG+0Kj2HvX7ZnXs4PoIe7aqV0fPzqqDA9V90u88FRaR0nZh/zpeF0Pp/TL
 q/oA==
X-Gm-Message-State: APuU4Z8KX3DFZw6rowjdWLTYboa2yzi6kAPTdrS85uPDhwCXzn+HJLNX
 uFKog8TiFIaOi01PgnkbGd9TTn1AU5IC6jseeqWbItx4PVmoSrOOV9LovUtU05zjnadv80dl13C
 OL16i2GdOYcqjBmSCFQLmZPKQNKXIEQ==
X-Received: from ejdp25.prod.google.com ([2002:a17:906:28d9:b0:c31:64e2:a521])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:72c8:b0:c4c:fd37:bb0c with SMTP id
 a640c23a62f3a-c5066b47cc8mr471942566b.29.1794494313296; 
 Thu, 12 Nov 2026 06:38:33 -0800 (PST)
Date: Thu, 12 Nov 2026 14:33:54 +0000
In-Reply-To: <20261112143355.2923939-1-jprusakowski@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261112143355.2923939-1-jprusakowski@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112143355.2923939-9-jprusakowski@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xRVwm-000000007s7-0wDq
Subject: [f2fs-dev] [PATCH RESEND 8/9] f2fs: compress: fix cleanup when a
 cluster write fails to be submitted
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

When f2fs_write_compressed_pages() fails to submit a compressed page in
the middle of a cluster, it gives up and returns -EAGAIN, and
f2fs_write_multi_pages() writes the cluster with raw pages instead. But
it leaves two things behind:

- cc->cpages[i - 1] is set to NULL before the submission is checked, so
  the compressed page that was not submitted is not freed by the out_free
  loop, and leaks from the compress page pool.

- The dnode already points to the new blocks of the slots before i, and
  their old blocks were invalidated, while the slots from i on still
  point to the old blocks. The cluster then mixes new and old compressed
  data, and f2fs_write_raw_pages() sees it in that state.

Clear cc->cpages[i - 1] only after the page was submitted, and restore
the old block addresses of the slots before i, validating the old blocks
again. That's safe because they were invalidated in the same
f2fs_lock_op() section, unless they are not valid in the last checkpoint
(checkpoint=disable), where SSR may already have reused them; leave the
cluster as it is then. The old block addresses are kept on the stack for
clusters of up to 16 blocks, and in a __GFP_NOFAIL allocation of at most
1 KiB otherwise.

Also, when a raw page overwrites a compressed cluster, decrement
i_compr_blocks in f2fs_do_write_data_page() only if the page was
submitted, since the dnode keeps COMPRESS_ADDR otherwise.

Submission only fails when block allocation fails, which happens only
after the checkpoint was stopped, so all of this only keeps the
in-memory state consistent until unmount. Note that if the allocation
fails while opening a new segment, f2fs_allocate_data_block() has
already updated the SIT for the block it doesn't return, and that is
not undone here.

Fixes: 4c8ff7095bef ("f2fs: support data compression")
Assisted-by: LLM
Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 fs/f2fs/compress.c | 61 +++++++++++++++++++++++++++++++++++++++++++---
 fs/f2fs/data.c     |  6 ++---
 2 files changed, 61 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/compress.c b/fs/f2fs/compress.c
index c5758da7c621..0147a7e05022 100644
--- a/fs/f2fs/compress.c
+++ b/fs/f2fs/compress.c
@@ -1279,6 +1279,45 @@ int f2fs_truncate_partial_cluster(struct inode *inode, u64 from, bool lock)
 	return f2fs_do_truncate_blocks(inode, round_up(from, PAGE_SIZE), lock);
 }
 
+/*
+ * Undo the block address updates of the first @nr slots of a cluster, after a
+ * write of the cluster failed to be submitted in the middle. Submission only
+ * fails if block allocation fails, i.e. after the checkpoint was stopped, so
+ * this only keeps the in-memory state consistent until unmount.
+ *
+ * The old blocks were invalidated in the same f2fs_lock_op() section, so they
+ * can be validated again, unless SSR could have reused them because they are
+ * not valid in the last checkpoint (checkpoint=disable). Leave the cluster as
+ * it is then.
+ */
+static void f2fs_undo_cluster_update(struct dnode_of_data *dn,
+				     block_t *old_blkaddr, int nr)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
+	int i;
+
+	for (i = 0; i < nr; i++) {
+		if (!f2fs_is_checkpointed_data(sbi, old_blkaddr[i]))
+			return;
+	}
+
+	for (i = 0; i < nr; i++, dn->ofs_in_node++) {
+		block_t old_blk = old_blkaddr[i];
+		block_t new_blk = f2fs_data_blkaddr(dn);
+
+		if (new_blk == old_blk)
+			continue;
+		f2fs_update_data_blkaddr(dn, old_blk);
+		if (__is_valid_data_blkaddr(new_blk))
+			f2fs_invalidate_blocks(sbi, new_blk, 1);
+		if (__is_valid_data_blkaddr(old_blk))
+			f2fs_revalidate_blocks(sbi, old_blk, 1);
+	}
+}
+
+/* Old block addresses of clusters up to this size are kept on the stack. */
+#define F2FS_ONSTACK_CLUSTER_SIZE	16
+
 static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 					int *submitted,
 					struct writeback_control *wbc,
@@ -1306,6 +1345,8 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	struct node_info ni;
 	struct compress_io_ctx *cic;
 	struct f2fs_lock_context lc;
+	block_t old_blkaddr_onstack[F2FS_ONSTACK_CLUSTER_SIZE];
+	block_t *old_blkaddr = old_blkaddr_onstack;
 	pgoff_t start_idx = start_idx_of_cluster(cc);
 	unsigned int last_index = cc->cluster_size - 1;
 	loff_t psize;
@@ -1363,6 +1404,12 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 
 	cic->nr_rpages = cc->cluster_size;
 
+	if (cc->cluster_size > ARRAY_SIZE(old_blkaddr_onstack)) {
+		/* At most 1 KiB, don't fail the write for it. */
+		old_blkaddr = kmalloc_array(cc->cluster_size, sizeof(block_t),
+					    GFP_NOFS | __GFP_NOFAIL);
+	}
+
 	for (i = 0; i < cc->valid_nr_cpages; i++) {
 		f2fs_set_compressed_page(cc->cpages[i], inode,
 				page_folio(cc->rpages[i + 1])->index, cic);
@@ -1386,6 +1433,7 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 		blkaddr = f2fs_data_blkaddr(&dn);
 		fio.folio = page_folio(cc->rpages[i]);
 		fio.old_blkaddr = blkaddr;
+		old_blkaddr[i] = blkaddr;
 
 		/* cluster header */
 		if (i == 0) {
@@ -1412,14 +1460,16 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 
 		fio.compressed_page = cc->cpages[i - 1];
 
-		cc->cpages[i - 1] = NULL;
 		fio.submitted = 0;
 		f2fs_outplace_write_data(&dn, &fio);
 		if (unlikely(!fio.submitted)) {
 			cancel_cluster_writeback(cc, cic, i);
 			*submitted = 0;
-			goto out_free_page_array;
+			dn.ofs_in_node -= i;
+			f2fs_undo_cluster_update(&dn, old_blkaddr, i);
+			goto out_submit_err;
 		}
+		cc->cpages[i - 1] = NULL;
 		(*submitted)++;
 unlock_continue:
 		inode_dec_dirty_block(cc->inode);
@@ -1431,6 +1481,9 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	f2fs_i_compr_blocks_update(inode, cc->valid_nr_cpages, true);
 	add_compr_block_stat(inode, cc->valid_nr_cpages);
 
+	if (old_blkaddr != old_blkaddr_onstack)
+		kfree(old_blkaddr);
+
 	set_inode_flag(cc->inode, FI_APPEND_WRITE);
 
 	f2fs_put_dnode(&dn);
@@ -1450,7 +1503,9 @@ static int f2fs_write_compressed_pages(struct compress_ctx *cc,
 	f2fs_destroy_compress_ctx(cc, false);
 	return 0;
 
-out_free_page_array:
+out_submit_err:
+	if (old_blkaddr != old_blkaddr_onstack)
+		kfree(old_blkaddr);
 	page_array_free(sbi, cic->rpages, cc->cluster_size);
 out_put_cic:
 	kmem_cache_free(cic_entry_slab, cic);
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4d7731fbf5a4..016aa347880e 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4018,11 +4018,11 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 		pending_added = true;
 	}
 
-	if (fio->compr_blocks && fio->old_blkaddr == COMPRESS_ADDR)
-		f2fs_i_compr_blocks_update(inode, fio->compr_blocks - 1, false);
-
 	/* LFS mode write path */
 	f2fs_outplace_write_data(&dn, fio);
+	if (fio->compr_blocks && fio->old_blkaddr == COMPRESS_ADDR &&
+	    likely(fio->submitted))
+		f2fs_i_compr_blocks_update(inode, fio->compr_blocks - 1, false);
 	if (unlikely(opu_entry)) {
 		opu_entry->new_blkaddr[0] = fio->new_blkaddr;
 		f2fs_end_dio_opu_track(inode, opu_entry, fio->submitted, false);
-- 
2.56.0.567.gdb80ae8cd5-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
