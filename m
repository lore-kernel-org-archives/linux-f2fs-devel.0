Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE47606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Ystss95i;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=HXHcAsGM;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=aKlpGbyp;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=fIaIwxaU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=r1r2ybXbTfeKBiNeKuJvA5fsaztb/0NygL1RorqQr9M=; b=Ystss95iesONAxRnu/cJMjuz+u
	vpI47HAHJJVD36nNBWwv801WcVoes5mdG5uUTb8vwTED0FlApXB01N9wM8BHzQmtbh6buDBbW6lH3
	9zQPaBr4MS2X7QWwrU7vsaXsNqocWpPdkGJimfvyQlVlr6Erj8c1ufQQaJLtA9Omn1YU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRVxF-000000007Wi-1IOR;
	Thu, 12 Nov 2026 14:39:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3Z8_1agwKADwhnpsqYimuqigemmejc.amk@flex--jprusakowski.bounces.google.com>)
 id 1xRVxB-000000007Tz-3rpC
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:39:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=E9/JoVy0vnxXu0StCIAGckIk3K88Xeri6wjZkZqG7/I=; b=H
 XHcAsGMlPyU8YWw0TtbyCKngEi2BJmOtyj7Ko76Sh6a1qpIpjOS0/CNSGNqDiT5a6aeHBphkdQ+gY
 TcEw33pTKg8tjseEQoFDFNVfwGF7t4gxbZj5rks4KgY9lKI8+YTzEYNWjyL8O4nuxArJV9VRsWACy
 szPXGd5UkCsU23yQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=E9/JoVy0vnxXu0StCIAGckIk3K88Xeri6wjZkZqG7/I=; b=aKlpGbyp1lIQqQ2tQWVd3jqqXt
 vv7JM3rUPYZ6dYa39FqtaPyVqG4p5AttxyPd+MH6lplpJfY1YWp857H9AtJySwgWBhyz1rQyDjDrz
 8IhKMPK71CwIQ6fJG2m24DPkRByMAvAe5cHxlUeIGLxOnPtJhmiJ384KsmiMq59RGO/s=;
Received: from mail-ej1-f69.google.com ([209.85.218.69])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRVwk-000000007s2-2nxt
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:38:41 +0000
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-c465c4c8da0so506522066b.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 06:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794494312; x=1795099112;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E9/JoVy0vnxXu0StCIAGckIk3K88Xeri6wjZkZqG7/I=;
 b=fIaIwxaURBJC0Kr6Tuseks99pBkopla8Tf3XY0ls4zvFdV88wia2C4PodmL7MaNCFf
 vFvlARSZFhyMGeh7TwDm51hNK+kH1R6JRsRyGu66QiV+9DUMdoDRaAVPLH7jR9ezwwQx
 ebMWp5mIddLhAxhSEXJGVjYbxqY7dBFEAam94vqYVG0NfxRoMiQr5cKTCcol90GEGVxB
 8RiLASt12OZy4yAsTRsDDjcn2uIoxFr071zaCsbHnGj5IoP+ANkziAShHXvVERU0PfWv
 i2aGg6oZURVZwZCDIGiNBn7Mmm5ZR+vlHn5bqECIJ8NqArPZ8JIqEVshxQPQUONVdWWc
 aegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794494312; x=1795099112;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=E9/JoVy0vnxXu0StCIAGckIk3K88Xeri6wjZkZqG7/I=;
 b=zuWiEmRu7VN53uTliaARY727loIAw+rCxtyKTIx1B67PsPWtfDP1rme6RkNM4/RaeJ
 8V84SMYWHAYhWtN8cuLYfFOAOzdb5+rLdvxGrTjwTdf+6+ud60Q9Oar9ERi/hybRNjC2
 G9gZlL3y9mP0o5Y/QoTwqWTJpDXr+aIS9SqywcESuVc5nXW10zXKIsXXIKiskJadAxoV
 5xw6OeWryb8vIFoZQy0c1Py2JzRJ2qEDYv1XFo6tlYiWUIclPLjnE16dO5/u04YWq5xU
 WuMWXJubMryRyPQCsvQSZWPNsapHW1SUKGbAxtAcwtjLJdyV+c60zV4zE/pCZTlKmf10
 4W5g==
X-Gm-Message-State: APuU4Z9n5k+4BaKgEJrGn6DhOXQ5Nrk3aEVpRDnTYp9CVkKeEs5vkufG
 7eIgKgkFX9bkw7I5al6bcRTswwzhP0XGaFmFJQmghtWkI26IOQOEqmHRtMtuvpfAD1ru6BoUH94
 Q4qe1PTP8236yylqMQvBc/93bf6dDfw==
X-Received: from ejbkt19.prod.google.com ([2002:a17:906:aad3:b0:c50:7646:a856])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:907:2da9:b0:c46:9ee5:eeee with SMTP id
 a640c23a62f3a-c5066863922mr509416066b.6.1794494311448; 
 Thu, 12 Nov 2026 06:38:31 -0800 (PST)
Date: Thu, 12 Nov 2026 14:33:52 +0000
In-Reply-To: <20261112143355.2923939-1-jprusakowski@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261112143355.2923939-1-jprusakowski@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112143355.2923939-7-jprusakowski@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xRVwk-000000007s2-2nxt
Subject: [f2fs-dev] [PATCH RESEND 6/9] f2fs: roll back failed block updates
 of O_DIRECT buffered fallback
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

When an O_DIRECT write falls back to buffered I/O, the data is written
back by f2fs_flush_buffered_write() before the write returns. Writeback
does out-of-place updates: f2fs_outplace_write_data() allocates a new
block, points the dnode at it and invalidates the old block before the
bio completes. If the bio then fails (e.g. with dm-error when O_DIRECT
is forced to buffered I/O), the error is returned to the user, but the
dnode keeps pointing to a block that was never written, and reads return
whatever the disk contained before, possibly data of a deleted file.

Track out-of-place updates of the written range while the fallback is in
progress, and roll back the ones whose write failed:

- f2fs_start_dio_bufio() records the page range of the write. It is
  called with the inode lock held, before the buffered write.

- f2fs_do_write_data_page() records the old and new block address of
  each out-of-place update in that range with f2fs_start_dio_opu_track()
  and f2fs_end_dio_opu_track(), and f2fs_write_end_bio() marks the
  entries of the pages of a failed bio segment with
  f2fs_mark_dio_opu_failed(). Entries are looked up by page index in an
  xarray, so bio completion doesn't walk a list.
  A page rewritten in place after a failed update holds newer data, so
  its entry is marked superseded and not rolled back.

- f2fs_finish_dio_bufio() stops tracking, waits until the tracked
  updates have reached the dnode and until their I/O has completed, and
  then rolls back each failed update whose blocks were not changed again
  since. If no checkpoint was done since the update and the old blocks
  are valid in the last checkpoint, the old blocks can't have been
  reused, so the dnode points back to them and they are validated again
  with the new f2fs_revalidate_blocks(). Otherwise the blocks are reset
  to NEW_ADDR, so that they read as zeroes. Page cache of rolled back
  updates is dropped. If the write failed, its page cache is dropped and
  i_size is restored, keeping blocks reserved by
  fallocate(FALLOC_FL_KEEP_SIZE).

The state is allocated on the first fallback of an inode and freed with
the inode, so f2fs_inode_info only grows by one pointer. Entries are
allocated with __GFP_NOFAIL, so the tracking can't fail writeback.

Writeback of the range by other tasks in the meantime (e.g. of mmap
writes, or GC moving pages with f2fs_do_write_data_page()) is tracked
and rolled back on failure as well, but only failures of the bytes
written by this write, and of the flush, make it fail.

Fixes: a1e09b03e6f5 ("f2fs: use iomap for direct I/O")
Assisted-by: LLM
Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 fs/f2fs/data.c    | 163 ++++++++++++++++++++++++
 fs/f2fs/f2fs.h    |  55 +++++++++
 fs/f2fs/file.c    | 306 +++++++++++++++++++++++++++++++++++++++++++---
 fs/f2fs/segment.c |  42 ++++++-
 fs/f2fs/super.c   |   6 +
 5 files changed, 550 insertions(+), 22 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e978b6b18c26..83c414cac252 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -410,6 +410,149 @@ static void f2fs_ffs_put_write_pending(struct folio *folio, unsigned int nr)
 	if (folio_test_writeback(folio))
 		folio_end_writeback(folio);
 }
+
+/*
+ * Out-of-place updates done while an O_DIRECT write falls back to buffered
+ * I/O are tracked, so that they can be rolled back by f2fs_finish_dio_bufio()
+ * if the write fails. Otherwise the dnode would keep pointing to new blocks
+ * that were never written and expose their old contents.
+ */
+struct f2fs_dio_opu_entry *f2fs_start_dio_opu_track(struct inode *inode,
+						    pgoff_t start_idx,
+						    unsigned int nr_pages)
+{
+	/* Pairs with smp_store_release() in f2fs_start_dio_bufio(). */
+	struct f2fs_dio_bufio *b = smp_load_acquire(&F2FS_I(inode)->dio_bufio);
+	struct f2fs_dio_opu_entry *entry;
+	unsigned long flags;
+	unsigned int i;
+
+	if (!b)
+		return NULL;
+
+	/* Failing here would fail writeback, so don't. */
+	entry = kzalloc(struct_size(entry, blkaddr, 2 * nr_pages),
+			GFP_NOFS | __GFP_NOFAIL);
+	entry->old_blkaddr = entry->blkaddr;
+	entry->new_blkaddr = entry->blkaddr + nr_pages;
+	entry->start_idx = start_idx;
+	entry->nr_pages = nr_pages;
+	/* The caller holds f2fs_lock_op(), so this can't change under us. */
+	entry->cp_ver = cur_cp_version(F2FS_CKPT(F2FS_I_SB(inode)));
+
+	/* Reserve the slots, so that storing the entry below won't allocate. */
+	for (i = 0; i < nr_pages; i++)
+		if (xa_reserve_irq(&b->entries, start_idx + i,
+				   GFP_NOFS | __GFP_NOFAIL))
+			break;
+
+	xa_lock_irqsave(&b->entries, flags);
+	if (unlikely(i < nr_pages) || !b->tracking ||
+	    start_idx + nr_pages - 1 < b->start || start_idx > b->end) {
+		for (i = 0; i < nr_pages; i++)
+			__xa_cmpxchg(&b->entries, start_idx + i,
+				     XA_ZERO_ENTRY, NULL, 0);
+		xa_unlock_irqrestore(&b->entries, flags);
+		kfree(entry);
+		return NULL;
+	}
+	for (i = 0; i < nr_pages; i++) {
+		void *old = __xa_store(&b->entries, start_idx + i, entry,
+				       GFP_ATOMIC);
+
+		/* The slots are reserved, so this can't fail. */
+		if (WARN_ON_ONCE(xa_is_err(old)))
+			break;
+	}
+	if (unlikely(i < nr_pages)) {
+		while (i--)
+			__xa_cmpxchg(&b->entries, start_idx + i, entry, NULL, 0);
+		for (i = 0; i < nr_pages; i++)
+			__xa_cmpxchg(&b->entries, start_idx + i,
+				     XA_ZERO_ENTRY, NULL, 0);
+		xa_unlock_irqrestore(&b->entries, flags);
+		kfree(entry);
+		return NULL;
+	}
+	list_add_tail(&entry->list, &b->list);
+	atomic_inc(&b->pending);
+	xa_unlock_irqrestore(&b->entries, flags);
+
+	return entry;
+}
+
+/*
+ * Called after the block addresses of @entry were updated. If the folios were
+ * not submitted, the dnode was not changed and the entry is dropped.
+ */
+void f2fs_end_dio_opu_track(struct inode *inode,
+			    struct f2fs_dio_opu_entry *entry,
+			    bool submitted, bool failed)
+{
+	struct f2fs_dio_bufio *b = F2FS_I(inode)->dio_bufio;
+	unsigned long flags;
+	unsigned int i;
+
+	xa_lock_irqsave(&b->entries, flags);
+	if (unlikely(!submitted)) {
+		for (i = 0; i < entry->nr_pages; i++)
+			__xa_cmpxchg(&b->entries, entry->start_idx + i,
+				     entry, NULL, 0);
+		list_del(&entry->list);
+	} else if (unlikely(failed)) {
+		entry->failed = true;
+	}
+	xa_unlock_irqrestore(&b->entries, flags);
+
+	if (unlikely(!submitted))
+		kfree(entry);
+
+	/* Pairs with wait_var_event() in f2fs_finish_dio_bufio(). */
+	if (atomic_dec_and_test(&b->pending))
+		wake_up_var(&b->pending);
+}
+
+static void f2fs_mark_dio_opu(struct inode *inode, pgoff_t index,
+			      bool failed)
+{
+	struct f2fs_dio_bufio *b;
+	struct f2fs_dio_opu_entry *entry;
+	unsigned long flags;
+
+	if (!inode)
+		return;
+
+	/* Pairs with smp_store_release() in f2fs_start_dio_bufio(). */
+	b = smp_load_acquire(&F2FS_I(inode)->dio_bufio);
+	if (likely(!b) || !READ_ONCE(b->active))
+		return;
+
+	xa_lock_irqsave(&b->entries, flags);
+	if (b->active) {
+		entry = xa_load(&b->entries, index);
+		if (entry && failed)
+			entry->failed = true;
+		else if (entry)
+			entry->superseded = true;
+	}
+	xa_unlock_irqrestore(&b->entries, flags);
+}
+
+/* Called on write I/O failure of the folio at @index, may run in IRQ context. */
+void f2fs_mark_dio_opu_failed(struct inode *inode, pgoff_t index)
+{
+	f2fs_mark_dio_opu(inode, index, true);
+}
+
+/*
+ * Called before the folio at @index is rewritten in place: the block now holds
+ * newer data, so a failed out-of-place update to it must not be rolled back.
+ */
+void f2fs_mark_dio_opu_superseded(struct inode *inode, pgoff_t index)
+{
+	f2fs_mark_dio_opu(inode, index, false);
+}
+
 static void f2fs_write_end_bio(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = bio->bi_private;
@@ -439,7 +582,13 @@ static void f2fs_write_end_bio(struct bio *bio)
 		type = WB_DATA_TYPE(folio, false);
 
 		if (unlikely(bio->bi_status != BLK_STS_OK)) {
+			pgoff_t idx = folio->index + (fi.offset >> PAGE_SHIFT);
+			unsigned int j;
+
 			mapping_set_error(folio->mapping, -EIO);
+			for (j = 0; j < npages; j++)
+				f2fs_mark_dio_opu_failed(folio->mapping->host,
+							 idx + j);
 			if (type == F2FS_WB_CP_DATA) {
 				f2fs_stop_checkpoint(sbi, true,
 						STOP_CP_REASON_WRITE_FAIL);
@@ -3756,6 +3905,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	struct node_info ni;
 	struct f2fs_lock_context lc;
 	struct f2fs_folio_state *ffs;
+	struct f2fs_dio_opu_entry *opu_entry = NULL;
 	bool ipu_force = false;
 	bool atomic_commit;
 	bool pending_added = false;
@@ -3824,6 +3974,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 	if (ipu_force ||
 		(__is_valid_data_blkaddr(fio->old_blkaddr) &&
 					need_inplace_update(fio))) {
+		f2fs_mark_dio_opu_superseded(inode, F2FS_FIO_LBLK(fio));
 		__folio_start_writeback(folio, folio_test_dirty(folio));
 		f2fs_put_dnode(&dn);
 		if (fio->need_lock == LOCK_REQ)
@@ -3851,6 +4002,14 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 
 	fio->version = ni.version;
 
+	if (!atomic_commit && !fio->compr_blocks &&
+	    unlikely(f2fs_should_track_dio_opu(inode, F2FS_FIO_LBLK(fio), 1))) {
+		opu_entry = f2fs_start_dio_opu_track(inode, F2FS_FIO_LBLK(fio),
+						     1);
+		if (opu_entry)
+			opu_entry->old_blkaddr[0] = fio->old_blkaddr;
+	}
+
 	__folio_start_writeback(folio, folio_test_dirty(folio));
 	if (f2fs_folio_has_ffs(folio)) {
 		ffs = (struct f2fs_folio_state *)folio->private;
@@ -3863,6 +4022,10 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 
 	/* LFS mode write path */
 	f2fs_outplace_write_data(&dn, fio);
+	if (unlikely(opu_entry)) {
+		opu_entry->new_blkaddr[0] = fio->new_blkaddr;
+		f2fs_end_dio_opu_track(inode, opu_entry, fio->submitted, false);
+	}
 	trace_f2fs_do_write_data_page(folio, OPU);
 	/*
 	 * The outplace write path failed to submit this block.
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 4fa4d8042f70..7c36b996a09c 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -941,6 +941,35 @@ enum {
 	FI_MAX,			/* max flag, never be used */
 };
 
+/*
+ * Out-of-place block update done while an O_DIRECT write falls back to
+ * buffered I/O, recorded so that it can be rolled back if the write fails.
+ */
+struct f2fs_dio_opu_entry {
+	struct list_head list;		/* in f2fs_dio_bufio->list */
+	unsigned long long cp_ver;	/* checkpoint version of the update */
+	pgoff_t start_idx;		/* first page index */
+	unsigned int nr_pages;		/* number of pages */
+	unsigned int old_compr_blocks;	/* compressed blocks before update */
+	unsigned int new_compr_blocks;	/* compressed blocks after update */
+	bool failed;			/* write I/O failed */
+	bool superseded;		/* rewritten in place since */
+	block_t *old_blkaddr;		/* block addresses before update */
+	block_t *new_blkaddr;		/* block addresses after update */
+	block_t blkaddr[];		/* storage of old_blkaddr/new_blkaddr */
+};
+
+/* State of an O_DIRECT write falling back to buffered I/O */
+struct f2fs_dio_bufio {
+	struct xarray entries;		/* page index -> latest entry */
+	struct list_head list;		/* all entries, oldest first */
+	atomic_t pending;		/* entries with block update in progress */
+	pgoff_t start;			/* first page index of the write */
+	pgoff_t end;			/* last page index of the write */
+	bool tracking;			/* record new block updates */
+	bool active;			/* record write failures */
+};
+
 struct f2fs_inode_info {
 	struct inode vfs_inode;		/* serve a vfs inode */
 	unsigned long i_flags;		/* keep an inode flags for ioctl */
@@ -1009,6 +1038,9 @@ struct f2fs_inode_info {
 	unsigned int i_cluster_size;		/* cluster size */
 	atomic_t writeback;			/* count # of writeback thread */
 
+	/* allocated by the first O_DIRECT write falling back to buffered I/O */
+	struct f2fs_dio_bufio *dio_bufio;
+
 	unsigned int atomic_write_cnt;
 	loff_t original_i_size;		/* original i_size before atomic write */
 #ifdef CONFIG_FS_ENCRYPTION
@@ -3867,6 +3899,19 @@ static inline int f2fs_has_inline_dentry(struct inode *inode)
 	return is_inode_flag_set(inode, FI_INLINE_DENTRY);
 }
 
+static inline bool f2fs_should_track_dio_opu(struct inode *inode,
+					     pgoff_t start_idx,
+					     unsigned int nr_pages)
+{
+	/* Pairs with smp_store_release() in f2fs_start_dio_bufio(). */
+	struct f2fs_dio_bufio *b = smp_load_acquire(&F2FS_I(inode)->dio_bufio);
+
+	if (likely(!b) || !READ_ONCE(b->tracking))
+		return false;
+	return start_idx + nr_pages - 1 >= READ_ONCE(b->start) &&
+	       start_idx <= READ_ONCE(b->end);
+}
+
 static inline int is_file(struct inode *inode, int type)
 {
 	return F2FS_I(inode)->i_advise & type;
@@ -4258,6 +4303,8 @@ int f2fs_flush_device_cache(struct f2fs_sb_info *sbi);
 void f2fs_destroy_flush_cmd_control(struct f2fs_sb_info *sbi, bool free);
 void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr,
 						unsigned int len);
+void f2fs_revalidate_blocks(struct f2fs_sb_info *sbi, block_t addr,
+			    unsigned int len);
 void f2fs_reserve_device_alias(struct f2fs_sb_info *sbi, block_t addr,
 						unsigned int len);
 bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr);
@@ -4472,6 +4519,14 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
 			struct f2fs_cached_block *ientry, pgoff_t index, bool new_i_size);
 void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset, size_t len);
 int f2fs_do_write_data_page(struct f2fs_io_info *fio);
+struct f2fs_dio_opu_entry *f2fs_start_dio_opu_track(struct inode *inode,
+						    pgoff_t start_idx,
+						    unsigned int nr_pages);
+void f2fs_end_dio_opu_track(struct inode *inode,
+			    struct f2fs_dio_opu_entry *entry,
+			    bool submitted, bool failed);
+void f2fs_mark_dio_opu_failed(struct inode *inode, pgoff_t index);
+void f2fs_mark_dio_opu_superseded(struct inode *inode, pgoff_t index);
 int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			u64 start, u64 len);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 3fcea85c36a2..70ba3f535211 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -5644,23 +5644,30 @@ static const struct iomap_dio_ops f2fs_iomap_dio_write_ops = {
 };
 
 /*
- * Write back and drop the page cache of a buffered fallback of an O_DIRECT
- * write.  Writing a part of a compressed cluster dirties the whole cluster,
- * so extend the range to cluster boundaries for compressed files.
+ * Writing a part of a compressed cluster dirties the whole cluster, so the
+ * page cache of a buffered fallback of an O_DIRECT write must be handled in
+ * whole clusters for compressed files.
  */
+static void f2fs_dio_bufio_range(struct inode *inode, loff_t *start_pos,
+				 loff_t *end_pos)
+{
+	loff_t cluster_bytes;
+
+	if (!f2fs_compressed_file(inode))
+		return;
+
+	cluster_bytes = (loff_t)F2FS_I(inode)->i_cluster_size << PAGE_SHIFT;
+	*start_pos = round_down(*start_pos, cluster_bytes);
+	*end_pos = round_up(*end_pos + 1, cluster_bytes) - 1;
+}
+
+/* Write back and drop the page cache of a buffered fallback of O_DIRECT. */
 static int f2fs_flush_buffered_write(struct address_space *mapping,
 				     loff_t start_pos, loff_t end_pos)
 {
-	struct inode *inode = mapping->host;
 	int ret;
 
-	if (f2fs_compressed_file(inode)) {
-		loff_t cluster_bytes =
-			(loff_t)F2FS_I(inode)->i_cluster_size << PAGE_SHIFT;
-
-		start_pos = round_down(start_pos, cluster_bytes);
-		end_pos = round_up(end_pos + 1, cluster_bytes) - 1;
-	}
+	f2fs_dio_bufio_range(mapping->host, &start_pos, &end_pos);
 
 	ret = filemap_write_and_wait_range(mapping, start_pos, end_pos);
 	if (ret < 0)
@@ -5671,6 +5678,234 @@ static int f2fs_flush_buffered_write(struct address_space *mapping,
 	return 0;
 }
 
+/*
+ * Start tracking out-of-place block updates of the buffered fallback of an
+ * O_DIRECT write of @count bytes at @pos. Called with the inode lock held.
+ */
+static void f2fs_start_dio_bufio(struct inode *inode, loff_t pos, size_t count)
+{
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct f2fs_dio_bufio *b = fi->dio_bufio;
+	loff_t start_pos = pos, end_pos = pos + count - 1;
+	unsigned long flags;
+
+	if (!count)
+		return;
+
+	if (!b) {
+		b = kzalloc_obj(*b, GFP_NOFS | __GFP_NOFAIL);
+		xa_init_flags(&b->entries, XA_FLAGS_LOCK_IRQ);
+		INIT_LIST_HEAD(&b->list);
+		atomic_set(&b->pending, 0);
+		/* Pairs with smp_load_acquire() in the writeback paths. */
+		smp_store_release(&fi->dio_bufio, b);
+	}
+
+	f2fs_dio_bufio_range(inode, &start_pos, &end_pos);
+
+	xa_lock_irqsave(&b->entries, flags);
+	WRITE_ONCE(b->start, start_pos >> PAGE_SHIFT);
+	WRITE_ONCE(b->end, end_pos >> PAGE_SHIFT);
+	WRITE_ONCE(b->active, true);
+	WRITE_ONCE(b->tracking, true);
+	xa_unlock_irqrestore(&b->entries, flags);
+}
+
+/* Roll back the out-of-place update of @entry, whose write failed. */
+static void f2fs_rollback_dio_opu_entry(struct inode *inode,
+					struct f2fs_dio_opu_entry *entry)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct dnode_of_data dn;
+	bool can_revalidate;
+	unsigned int i;
+	int err;
+
+	set_new_dnode(&dn, inode, NULL, NULL, 0);
+	err = f2fs_get_dnode_of_data(&dn, entry->start_idx, LOOKUP_NODE);
+	if (err == -ENOENT)	/* truncated, nothing to roll back */
+		return;
+	if (err) {
+		f2fs_warn_ratelimited(sbi,
+				      "%s: failed to roll back write, ino:%llu, index:%lu, err:%d",
+				      __func__, inode->i_ino, entry->start_idx,
+				      err);
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		return;
+	}
+
+	/* Leave the blocks alone if they were updated again since. */
+	for (i = 0; i < entry->nr_pages; i++) {
+		if (data_blkaddr(dn.inode, dn.node_entry,
+				 dn.ofs_in_node + i) != entry->new_blkaddr[i])
+			goto put_dnode;
+	}
+
+	/*
+	 * The update invalidated the old blocks. They can be validated again
+	 * only if they can't have been reused since: no checkpoint was done,
+	 * and they are valid in the last checkpoint (otherwise SSR may reuse
+	 * them, e.g. with checkpoint=disable). If they can't, reset the
+	 * blocks to NEW_ADDR, which reads as zeroes, so the failed write at
+	 * least doesn't expose stale data.
+	 */
+	can_revalidate = cur_cp_version(F2FS_CKPT(sbi)) == entry->cp_ver;
+	for (i = 0; can_revalidate && i < entry->nr_pages; i++) {
+		if (!f2fs_is_checkpointed_data(sbi, entry->old_blkaddr[i]))
+			can_revalidate = false;
+	}
+
+	for (i = 0; i < entry->nr_pages; i++, dn.ofs_in_node++) {
+		block_t old_blk = entry->old_blkaddr[i];
+		block_t new_blk = entry->new_blkaddr[i];
+
+		if (can_revalidate) {
+			f2fs_update_data_blkaddr(&dn, old_blk);
+			if (new_blk == old_blk)
+				continue;
+			if (__is_valid_data_blkaddr(new_blk))
+				f2fs_invalidate_blocks(sbi, new_blk, 1);
+			if (__is_valid_data_blkaddr(old_blk))
+				f2fs_revalidate_blocks(sbi, old_blk, 1);
+		} else {
+			if (__is_valid_data_blkaddr(new_blk))
+				f2fs_invalidate_blocks(sbi, new_blk, 1);
+			f2fs_update_data_blkaddr(&dn, NEW_ADDR);
+		}
+	}
+
+	if (entry->new_compr_blocks)
+		f2fs_i_compr_blocks_update(inode, entry->new_compr_blocks - 1,
+					   false);
+	if (can_revalidate && entry->old_compr_blocks)
+		f2fs_i_compr_blocks_update(inode, entry->old_compr_blocks - 1,
+					   true);
+put_dnode:
+	f2fs_put_dnode(&dn);
+}
+
+/*
+ * Finish the buffered fallback of an O_DIRECT write started by
+ * f2fs_start_dio_bufio(). @len bytes were written at @start_pos to the page
+ * cache, and @err is the result of writing them back. Failed block updates
+ * in the range are rolled back. If the write failed, its page cache is
+ * dropped and i_size is restored. Returns @err, or -EIO if a block update of
+ * the written bytes failed.
+ */
+static int f2fs_finish_dio_bufio(struct inode *inode, loff_t start_pos,
+				 loff_t len, loff_t orig_i_size,
+				 bool keep_isize, int err)
+{
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct address_space *mapping = inode->i_mapping;
+	struct f2fs_dio_bufio *b = fi->dio_bufio;
+	struct f2fs_dio_opu_entry *entry, *tmp;
+	LIST_HEAD(entries);
+	unsigned long flags;
+	loff_t end_pos = start_pos + len - 1;
+	pgoff_t first, last;
+	bool failed = false;
+
+	if (!b || !b->active)
+		return err;
+
+	/* Stop tracking new block updates, ... */
+	xa_lock_irqsave(&b->entries, flags);
+	WRITE_ONCE(b->tracking, false);
+	xa_unlock_irqrestore(&b->entries, flags);
+
+	/* ... wait for the tracked ones to finish updating the dnode, ... */
+	wait_var_event(&b->pending, !atomic_read_acquire(&b->pending));
+
+	/*
+	 * ... and for their I/O to complete, so that failures are recorded.
+	 * Leave errors in the mapping for others to see.
+	 */
+	filemap_fdatawait_range_keep_errors(mapping,
+					    (loff_t)b->start << PAGE_SHIFT,
+					    (loff_t)b->end << PAGE_SHIFT |
+					    (PAGE_SIZE - 1));
+
+	xa_lock_irqsave(&b->entries, flags);
+	WRITE_ONCE(b->active, false);
+	list_splice_init(&b->list, &entries);
+	xa_unlock_irqrestore(&b->entries, flags);
+
+	/*
+	 * Remove the entries from the xarray one by one rather than with
+	 * xa_destroy(), which would also drop slots just reserved by a writer
+	 * of the next fallback.
+	 */
+	f2fs_dio_bufio_range(inode, &start_pos, &end_pos);
+	first = start_pos >> PAGE_SHIFT;
+	last = end_pos >> PAGE_SHIFT;
+	list_for_each_entry(entry, &entries, list) {
+		unsigned int i;
+
+		for (i = 0; i < entry->nr_pages; i++)
+			xa_cmpxchg_irq(&b->entries, entry->start_idx + i,
+				       entry, NULL, 0);
+		if (entry->failed && !entry->superseded) {
+			/* Only failures of the written bytes fail the write. */
+			if (len > 0 && entry->start_idx <= last &&
+			    entry->start_idx + entry->nr_pages - 1 >= first &&
+			    !err)
+				err = -EIO;
+			failed = true;
+		}
+	}
+
+	if (failed || (err && len > 0)) {
+		f2fs_down_write(&fi->i_gc_rwsem[WRITE]);
+		filemap_invalidate_lock(mapping);
+
+		if (failed) {
+			struct f2fs_lock_context lc;
+
+			f2fs_lock_op(sbi, &lc);
+			list_for_each_entry_reverse(entry, &entries, list) {
+				if (entry->failed && !entry->superseded)
+					f2fs_rollback_dio_opu_entry(inode,
+								    entry);
+			}
+			f2fs_unlock_op(sbi, &lc);
+
+			/* Cached data no longer matches the blocks on disk. */
+			list_for_each_entry(entry, &entries, list) {
+				pgoff_t idx = entry->start_idx;
+				pgoff_t end = idx + entry->nr_pages - 1;
+
+				if (!entry->failed || entry->superseded)
+					continue;
+				invalidate_inode_pages2_range(mapping, idx,
+							      end);
+			}
+		}
+
+		/* Drop the page cache of the failed write, as for O_DIRECT. */
+		if (err && len > 0)
+			invalidate_inode_pages2_range(mapping, first, last);
+
+		if (err && i_size_read(inode) > orig_i_size) {
+			truncate_pagecache(inode, orig_i_size);
+			f2fs_i_size_write(inode, orig_i_size);
+			if (!keep_isize)
+				f2fs_truncate_blocks(inode, orig_i_size, true);
+		}
+
+		filemap_invalidate_unlock(mapping);
+		f2fs_up_write(&fi->i_gc_rwsem[WRITE]);
+	}
+
+	list_for_each_entry_safe(entry, tmp, &entries, list) {
+		list_del(&entry->list);
+		kfree(entry);
+	}
+
+	return err;
+}
+
 static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 				   bool *may_need_sync)
 {
@@ -5755,6 +5990,9 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		ssize_t ret2;
 		loff_t bufio_start_pos = iocb->ki_pos;
 
+		loff_t bufio_orig_size = i_size_read(inode);
+		bool keep_isize = file_keep_isize(inode);
+
 		/* A buffered write can block, so don't fall back for NOWAIT. */
 		if (iocb->ki_flags & IOCB_NOWAIT) {
 			if (!ret)
@@ -5766,16 +6004,22 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		 * The direct write was partial, so we need to fall back to a
 		 * buffered write for the remainder.
 		 */
-
+		f2fs_start_dio_bufio(inode, bufio_start_pos,
+				     iov_iter_count(from));
 		ret2 = f2fs_buffered_write_iter(iocb, from);
 		if (iov_iter_count(from))
 			f2fs_write_failed(inode, iocb->ki_pos);
 		/*
 		 * Return the number of bytes written by direct I/O, or the
 		 * error if there were none, same as direct_write_fallback().
+		 * Failures of other writes in the range are rolled back, but
+		 * not reported here.
 		 */
-		if (ret2 < 0) {
-			if (!ret)
+		if (ret2 <= 0) {
+			f2fs_finish_dio_bufio(inode, bufio_start_pos, 0,
+					      bufio_orig_size, keep_isize,
+					      ret2);
+			if (ret2 < 0 && !ret)
 				ret = ret2;
 			goto out;
 		}
@@ -5791,6 +6035,9 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 			err = f2fs_flush_buffered_write(file->f_mapping,
 							bufio_start_pos,
 							bufio_end_pos);
+			err = f2fs_finish_dio_bufio(inode, bufio_start_pos,
+						    ret2, bufio_orig_size,
+						    keep_isize, err);
 			if (err) {
 				/* We don't know how much of it was written. */
 				iocb->ki_pos = bufio_start_pos;
@@ -5868,10 +6115,20 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (preallocated < 0) {
 		ret = preallocated;
 	} else {
+		/* Buffered write fails right away for NOWAIT. */
+		bool forced_bufio = !dio && (iocb->ki_flags & IOCB_DIRECT) &&
+				    !(iocb->ki_flags & IOCB_NOWAIT);
+		loff_t orig_i_size = i_size_read(inode);
+		bool keep_isize = file_keep_isize(inode);
+
 		if (trace_f2fs_datawrite_start_enabled())
 			f2fs_trace_rw_file_path(iocb->ki_filp, iocb->ki_pos,
 						orig_count, WRITE);
 
+		if (forced_bufio)
+			f2fs_start_dio_bufio(inode, bufio_start_pos,
+					     iov_iter_count(from));
+
 		/* Do the actual write. */
 		ret = dio ?
 			f2fs_dio_write_iter(iocb, from, &may_need_sync) :
@@ -5883,13 +6140,22 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		 * If buffered IO was forced, flush and drop the data from
 		 * the page cache to preserve O_DIRECT semantics.
 		 */
-		if (ret > 0 && !dio && (iocb->ki_flags & IOCB_DIRECT)) {
-			int err;
+		if (forced_bufio) {
+			struct address_space *mapping = iocb->ki_filp->f_mapping;
+			int err = 0;
 
-			err = f2fs_flush_buffered_write(iocb->ki_filp->f_mapping,
-							bufio_start_pos,
-							bufio_start_pos + ret - 1);
-			if (err) {
+			if (ret > 0) {
+				loff_t bufio_end_pos = bufio_start_pos + ret - 1;
+
+				err = f2fs_flush_buffered_write(mapping,
+								bufio_start_pos,
+								bufio_end_pos);
+			}
+			err = f2fs_finish_dio_bufio(inode, bufio_start_pos,
+						    ret > 0 ? ret : 0,
+						    orig_i_size, keep_isize,
+						    ret < 0 ? ret : err);
+			if (ret > 0 && err) {
 				iocb->ki_pos = bufio_start_pos;
 				ret = err;
 			}
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index a26cde2dc60e..0cc37788efb8 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -2733,8 +2733,9 @@ void f2fs_invalidate_blocks(struct f2fs_sb_info *sbi, block_t addr,
 	up_write(&sit_i->sentry_lock);
 }
 
-void f2fs_reserve_device_alias(struct f2fs_sb_info *sbi, block_t addr,
-				unsigned int len)
+/* Mark @len blocks starting at @addr as valid in the SIT. */
+static void __validate_blocks(struct f2fs_sb_info *sbi, block_t addr,
+			      unsigned int len)
 {
 	unsigned int segno = GET_SEGNO(sbi, addr);
 	struct sit_info *sit_i = SIT_I(sbi);
@@ -2779,6 +2780,43 @@ void f2fs_reserve_device_alias(struct f2fs_sb_info *sbi, block_t addr,
 	up_write(&sit_i->sentry_lock);
 }
 
+void f2fs_reserve_device_alias(struct f2fs_sb_info *sbi, block_t addr,
+			       unsigned int len)
+{
+	__validate_blocks(sbi, addr, len);
+}
+
+/*
+ * Validate again blocks invalidated by an out-of-place update in the current
+ * checkpoint, when rolling the update back. The caller must make sure the
+ * blocks have not been reused since, see f2fs_is_checkpointed_data().
+ */
+void f2fs_revalidate_blocks(struct f2fs_sb_info *sbi, block_t addr,
+			    unsigned int len)
+{
+	if (len == 0)
+		return;
+
+	f2fs_bug_on(sbi, addr == NULL_ADDR);
+	if (addr == NEW_ADDR || addr == COMPRESS_ADDR)
+		return;
+
+	/* Undo the unusable block accounting done on invalidation. */
+	if (unlikely(is_sbi_flag_set(sbi, SBI_CP_DISABLED))) {
+		unsigned int i;
+
+		for (i = 0; i < len; i++) {
+			if (f2fs_is_checkpointed_data(sbi, addr + i)) {
+				spin_lock(&sbi->stat_lock);
+				sbi->unusable_block_count--;
+				spin_unlock(&sbi->stat_lock);
+			}
+		}
+	}
+
+	__validate_blocks(sbi, addr, len);
+}
+
 bool f2fs_is_checkpointed_data(struct f2fs_sb_info *sbi, block_t blkaddr)
 {
 	struct sit_info *sit_i = SIT_I(sbi);
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 78dbf1e92285..cce6bac1cda1 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1980,6 +1980,12 @@ static void f2fs_dirty_inode(struct inode *inode, int flags)
 
 static void f2fs_free_inode(struct inode *inode)
 {
+	struct f2fs_dio_bufio *b = F2FS_I(inode)->dio_bufio;
+
+	if (b) {
+		xa_destroy(&b->entries);
+		kfree(b);
+	}
 	fscrypt_free_inode(inode);
 	kmem_cache_free(f2fs_inode_cachep, F2FS_I(inode));
 }
-- 
2.56.0.567.gdb80ae8cd5-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
