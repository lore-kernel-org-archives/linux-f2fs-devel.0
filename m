Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5ED7D606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 14:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QLaXrnj3;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=JswRy/uq;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=O+7Ni7+o;
	dkim=neutral header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=GbroEdSn
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:To:Message-ID:References:Mime-Version:
	In-Reply-To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Unsubscribe-Post:List-Owner;
	bh=TLdrPSayDu9GeXjuCOTipFYna8IwltHig0dRO367HaU=; b=QLaXrnj3LmClBu/OvAhWIC8NQN
	glEMzlMcZiEFzc4upBv4BSZs7J8xg1xerre6oRhOXrouAuuJWajZZ/ivY+EO6myDAe0wcnCEPWju3
	Bog+3ysCDH7UIbd4vvd3UhJLqdC/5RXiJfnGJsCEvFI+Ple7D7Hsc0QTAvwap9sl0C5Q=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRVxE-000000008Gq-0OJo;
	Thu, 12 Nov 2026 14:39:08 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3aM_1agwKAD0ioqtrZjnvrjhfnnfkd.bnl@flex--jprusakowski.bounces.google.com>)
 id 1xRVwv-000000008FH-3cs6
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:38:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 References:Mime-Version:In-Reply-To:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
 List-Help:List-Unsubscribe:List-Unsubscribe-Post:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Xjpz5UXR1Tg5X+gvoBXRXVWFNQdDmg7mBJrHjAU2AwI=; b=J
 swRy/uqwDyDc4g4Zf14lw8iyJCDfs4kyIKJxkjWcL4HUA0dB1T43/sHdKraBn7v3bJ6xHvTMS+HIo
 3ISu7y/RevEaa6grfxaM2o3Ei2dbHCeKY/MeATmKcRlOp7l39hFsaEHDEvywhD5frt+GiVCTw6zsR
 FYviGq7SzxCT4LjU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:References:Mime-Version:
 In-Reply-To:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Xjpz5UXR1Tg5X+gvoBXRXVWFNQdDmg7mBJrHjAU2AwI=; b=O+7Ni7+o3IxDvF88NGV2VdkPAy
 1ateS+VCXb0Fws/iS08ywxLSdwhjSPd9UeFBTdMgi9s38CYfRh4210LhTkG9mrqUoKhNcUMHoewoc
 fRCw5KpB4FcIJqnjMDFTRTGW6eWXbTwUMdJHueA9gVBYhzvArFDeZtfnXIEE9SkDqz1E=;
Received: from mail-ej1-f70.google.com ([209.85.218.70])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRVwl-000000003QU-1F2E
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 14:38:40 +0000
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-c504b52eed3so222758566b.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 06:38:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20260707; t=1794494313; x=1795099113;
 darn=lists.sourceforge.net; 
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Xjpz5UXR1Tg5X+gvoBXRXVWFNQdDmg7mBJrHjAU2AwI=;
 b=GbroEdSna3/AQsa2iIpd/CV9np73QD+jdfT+/jR+RHAsbd5u2FoER1u3A0lNO+6b4R
 5HR9lreMya00XSKwdlqierZauiF/kTnoQS428CToemGxviv4eRRvXlYe681d1vH4kjxg
 +1NQNxn5/x/zycemwkDhbOUF660AS19krqwAp4IVU8HsnoZZdNmWIJ607ZIbLdFa0FNf
 5QnZ/XsIRdYRlnvzSO8i0B7BUz5UY1Ac1uCMfbE/0j1faqmRdui96E5XPh9Yn8SsiHGZ
 FiAVmr2RntbyfZRDoMif3RCIHEavi+clfQGSzy/iSt1tT5hSHp275LqAze35DDweWOr/
 G62Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794494313; x=1795099113;
 h=content-type:cc:to:from:subject:message-id:references:mime-version
 :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xjpz5UXR1Tg5X+gvoBXRXVWFNQdDmg7mBJrHjAU2AwI=;
 b=nb/8wy1xQ/h1lHz+oEoea9sJ9JkJFvTPtmj68dwUPlpD1JDarSURwiBMtaoBRAJR6W
 +862H80WrJNL5TJqHeN8m33tchOmdOuE6516ibKf7v8uMrlHDv/lE3iofUS2SV8aLivA
 EzwbvQC4nkwgDjw4Xjbq5KDLO5ykik4zWP4pOs3I0vxR29CwDYkB5wFvsgGqttdlCpeb
 7GyHiNGKtjd/JbN0QH2k1L03T2sgMgE4/QxSyIgb0od/ew4vqx5VQ0jGl8/4lox30zO0
 9sfyxWolJdq3lijYq/4hjpDU05yOMFKyswH8a2dacL/iGSlb7IkgImy5BQ2PidzgHEEV
 XUYA==
X-Gm-Message-State: APuU4Z9aTFwpXzWLK30o6EjpyauIKXGbQKULR63996bEB3zJZB29RgdO
 NCt+/KTVP1Q0TzynKbgXxIWG+oyWx8jW0IvqoUveFsQrywJbRqXvzQqkfp4ZShMiRRHB0Iigd6j
 +oIeYDLnRJYqBnbBg08yMGEdX0g+zqQ==
X-Received: from ejbwn20.prod.google.com ([2002:a17:907:694:b0:c4d:a2a:2b71])
 (user=jprusakowski job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:906:844b:b0:c50:6718:67ff with SMTP id
 a640c23a62f3a-c50671871admr414144566b.35.1794494312379; 
 Thu, 12 Nov 2026 06:38:32 -0800 (PST)
Date: Thu, 12 Nov 2026 14:33:53 +0000
In-Reply-To: <20261112143355.2923939-1-jprusakowski@google.com>
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
References: <20261112143355.2923939-1-jprusakowski@google.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112143355.2923939-8-jprusakowski@google.com>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Spam-Score: -7.6 (-------)
X-Headers-End: 1xRVwl-000000003QU-1F2E
Subject: [f2fs-dev] [PATCH RESEND 7/9] f2fs: roll back failed block updates
 of direct writes
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

Direct writes to holes (NULL_ADDR), blocks reserved by fallocate()
(NEW_ADDR), or existing blocks in LFS mode allocate new physical blocks
in f2fs_preallocate_blocks() or f2fs_map_blocks(F2FS_GET_BLOCK_DIO) and
map them in the dnode and read extent cache before the bio is submitted.
If the direct write fails (e.g. with dm-error in generic/250 and
generic/252) or stops short, blocks inside i_size or on KEEP_SIZE files
are not truncated by f2fs_file_write_iter(), leaving the dnode and read
extent cache pointing to blocks that were never written and exposing
stale on-disk data.

Fix this while keeping direct writes on the native direct I/O path:

- Record contiguous runs of blocks allocated during a native O_DIRECT
  write per kiocb in f2fs_record_dio_block(), along with their previous
  block address (NULL_ADDR, NEW_ADDR, or old block in LFS mode) and the
  checkpoint version. Skip F2FS_GET_BLOCK_PRE_DIO on KEEP_SIZE files so
  post-EOF truncation on error does not drop blocks reserved by
  fallocate().

- Ensure IOMAP_F_NEW is set whenever a direct write allocated blocks so
  completions run in process context.

- In f2fs_dio_write_end_io() (and error paths where the bio is not
  submitted), free the recorded entries when the full range was written,
  or roll back any unwritten blocks: restore NULL_ADDR (and decrement
  valid block count), restore NEW_ADDR, or restore and revalidate the
  old block in LFS mode if no checkpoint ran since and the old block was
  checkpointed (falling back to NEW_ADDR otherwise).

- In f2fs_file_read_iter(), f2fs_file_splice_read() and
  f2fs_file_write_iter(), wait for any overlapping in-flight allocating
  direct write to finish (or return -EAGAIN for non-blocking I/O) so
  concurrent reads do not see unwritten blocks and concurrent writes do
  not race with rollback, while keeping non-overlapping async direct
  writes parallel.

The tracking state is allocated on the first native O_DIRECT write of an
inode and freed with the inode, so f2fs_inode_info only grows by one
pointer, and extent entries are allocated lazily with __GFP_NOFAIL only
when blocks are actually allocated.

Fixes: d4dd19ec1ea0 ("f2fs: do not expose unwritten blocks to user by DIO")
Fixes: a1e09b03e6f5 ("f2fs: use iomap for direct I/O")
Fixes: f847c699cff3 ("f2fs: allow out-place-update for direct IO in LFS mode")
Assisted-by: LLM
Signed-off-by: Jan Prusakowski <jprusakowski@google.com>
---
 fs/f2fs/data.c  |   6 +-
 fs/f2fs/f2fs.h  |  44 ++++++
 fs/f2fs/file.c  | 392 +++++++++++++++++++++++++++++++++++++++++++++++-
 fs/f2fs/super.c |   5 +
 4 files changed, 438 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 83c414cac252..4d7731fbf5a4 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2087,6 +2087,7 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
 		f2fs_invalidate_internal_cache(sbi, old_blkaddr, 1);
 
+	f2fs_record_dio_block(dn, old_blkaddr);
 	f2fs_update_data_blkaddr(dn, dn->data_blkaddr);
 	return 0;
 }
@@ -2339,7 +2340,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		}
 
 		blkaddr = dn.data_blkaddr;
-		if (is_hole)
+		if (is_hole || flag == F2FS_GET_BLOCK_DIO)
 			map->m_flags |= F2FS_MAP_NEW;
 	} else if (is_hole) {
 		if (f2fs_compressed_file(inode) &&
@@ -6273,7 +6274,8 @@ static int f2fs_iomap_begin(struct inode *inode, loff_t offset, loff_t length,
 		iomap->addr = IOMAP_NULL_ADDR;
 	}
 
-	if (map.m_flags & F2FS_MAP_NEW)
+	if ((map.m_flags & F2FS_MAP_NEW) ||
+	    ((flags & IOMAP_WRITE) && f2fs_dio_has_cur(inode)))
 		iomap->flags |= IOMAP_F_NEW;
 	if ((inode_state_read_once(inode) & I_DIRTY_DATASYNC) ||
 	    offset + length > i_size_read(inode))
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7c36b996a09c..f9bdf681f29e 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -970,6 +970,38 @@ struct f2fs_dio_bufio {
 	bool active;			/* record write failures */
 };
 
+/*
+ * Contiguous run of blocks allocated by a native O_DIRECT write, recorded so
+ * that unwritten blocks can be rolled back if the write fails or stops short.
+ */
+struct f2fs_dio_ext {
+	struct list_head list;		/* in f2fs_dio_write->extents */
+	unsigned long long cp_ver;	/* checkpoint version of the update */
+	pgoff_t fofs;			/* first file block offset */
+	unsigned int len;		/* number of blocks */
+	block_t old_blkaddr;		/* NULL_ADDR, NEW_ADDR, or first old block */
+	block_t new_blkaddr;		/* first allocated block */
+};
+
+struct f2fs_dio_write {
+	struct list_head list;		/* in f2fs_dio_track->inflight */
+	struct kiocb *iocb;		/* owning kiocb */
+	loff_t pos;			/* starting byte offset of the write */
+	pgoff_t min_fofs;		/* first block offset in extents */
+	pgoff_t max_end;		/* end block offset in extents */
+	bool completing;		/* completion in progress */
+	struct list_head extents;	/* f2fs_dio_ext entries, in fofs order */
+};
+
+struct f2fs_dio_track {
+	spinlock_t lock;		/* protects active_*, cur and inflight */
+	atomic_t nr_inflight;		/* number of entries in inflight */
+	struct kiocb *active_iocb;	/* kiocb mapping blocks under inode_lock */
+	loff_t active_pos;		/* starting offset of active_iocb */
+	struct f2fs_dio_write *cur;	/* entry of active_iocb, if any */
+	struct list_head inflight;	/* in-flight DIO writes with allocations */
+};
+
 struct f2fs_inode_info {
 	struct inode vfs_inode;		/* serve a vfs inode */
 	unsigned long i_flags;		/* keep an inode flags for ioctl */
@@ -1040,6 +1072,8 @@ struct f2fs_inode_info {
 
 	/* allocated by the first O_DIRECT write falling back to buffered I/O */
 	struct f2fs_dio_bufio *dio_bufio;
+	/* allocated by the first native O_DIRECT write */
+	struct f2fs_dio_track *dio_track;
 
 	unsigned int atomic_write_cnt;
 	loff_t original_i_size;		/* original i_size before atomic write */
@@ -3912,6 +3946,14 @@ static inline bool f2fs_should_track_dio_opu(struct inode *inode,
 	       start_idx <= READ_ONCE(b->end);
 }
 
+static inline bool f2fs_has_dio_alloc(struct inode *inode)
+{
+	/* Pairs with smp_store_release() in f2fs_start_dio_write(). */
+	struct f2fs_dio_track *t = smp_load_acquire(&F2FS_I(inode)->dio_track);
+
+	return t && atomic_read(&t->nr_inflight) > 0;
+}
+
 static inline int is_file(struct inode *inode, int type)
 {
 	return F2FS_I(inode)->i_advise & type;
@@ -4527,6 +4569,8 @@ void f2fs_end_dio_opu_track(struct inode *inode,
 			    bool submitted, bool failed);
 void f2fs_mark_dio_opu_failed(struct inode *inode, pgoff_t index);
 void f2fs_mark_dio_opu_superseded(struct inode *inode, pgoff_t index);
+void f2fs_record_dio_block(struct dnode_of_data *dn, block_t old_blkaddr);
+bool f2fs_dio_has_cur(struct inode *inode);
 int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			u64 start, u64 len);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 70ba3f535211..36a9aeabf23e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -25,6 +25,7 @@
 #include <linux/fileattr.h>
 #include <linux/fadvise.h>
 #include <linux/iomap.h>
+#include <linux/overflow.h>
 
 #include "f2fs.h"
 #include "node.h"
@@ -5403,6 +5404,75 @@ static void f2fs_trace_rw_file_path(struct file *file, loff_t pos, size_t count,
 	f2fs_putname(buf);
 }
 
+static bool f2fs_dio_alloc_overlaps(struct inode *inode, pgoff_t start,
+				    pgoff_t end)
+{
+	struct f2fs_dio_track *t = F2FS_I(inode)->dio_track;
+	struct f2fs_dio_write *dw;
+	unsigned long flags;
+	bool found = false;
+
+	if (likely(!t || !atomic_read(&t->nr_inflight)))
+		return false;
+
+	spin_lock_irqsave(&t->lock, flags);
+	list_for_each_entry(dw, &t->inflight, list) {
+		struct f2fs_dio_ext *ext;
+
+		if (end <= dw->min_fofs || start >= dw->max_end)
+			continue;
+		list_for_each_entry(ext, &dw->extents, list) {
+			if (end > ext->fofs && start < ext->fofs + ext->len) {
+				found = true;
+				goto out;
+			}
+		}
+	}
+out:
+	spin_unlock_irqrestore(&t->lock, flags);
+	return found;
+}
+
+/*
+ * Wait for any in-flight allocating O_DIRECT write overlapping [@pos, @pos +
+ * @count) to complete (and roll back if it failed), so reads do not see
+ * unwritten blocks and concurrent writes do not race with rollback.
+ */
+static int f2fs_wait_dio_alloc_range(struct inode *inode, loff_t pos,
+				     size_t count, bool nowait)
+{
+	struct f2fs_sb_info *sbi;
+	struct f2fs_dio_track *t;
+	u64 start_blk;
+	loff_t end_pos;
+	pgoff_t start, end;
+
+	if (likely(!f2fs_has_dio_alloc(inode)) || !count || pos < 0)
+		return 0;
+
+	sbi = F2FS_I_SB(inode);
+	start_blk = F2FS_BYTES_TO_BLK(sbi, pos);
+	if (start_blk >= ULONG_MAX)
+		return 0;
+	start = start_blk;
+	if (check_add_overflow(pos, (loff_t)count - 1, &end_pos))
+		end = ULONG_MAX;
+	else
+		end = min_t(u64, (u64)F2FS_BYTES_TO_BLK(sbi, end_pos) + 1,
+			    ULONG_MAX);
+
+	if (!f2fs_dio_alloc_overlaps(inode, start, end))
+		return 0;
+	if (nowait)
+		return -EAGAIN;
+
+	t = F2FS_I(inode)->dio_track;
+	/* Pairs with wake_up_var() in f2fs_finish_dio_write(). */
+	wait_var_event(&t->nr_inflight,
+		       !f2fs_dio_alloc_overlaps(inode, start, end));
+	return 0;
+}
+
 static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
@@ -5413,6 +5483,11 @@ static ssize_t f2fs_file_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	if (!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
 
+	ret = f2fs_wait_dio_alloc_range(inode, pos, iov_iter_count(to),
+					iocb->ki_flags & IOCB_NOWAIT);
+	if (ret)
+		return ret;
+
 	if (trace_f2fs_dataread_start_enabled())
 		f2fs_trace_rw_file_path(iocb->ki_filp, iocb->ki_pos,
 					iov_iter_count(to), READ);
@@ -5448,6 +5523,10 @@ static ssize_t f2fs_file_splice_read(struct file *in, loff_t *ppos,
 	if (!f2fs_is_compress_backend_ready(inode))
 		return -EOPNOTSUPP;
 
+	ret = f2fs_wait_dio_alloc_range(inode, pos, len, false);
+	if (ret)
+		return ret;
+
 	if (trace_f2fs_dataread_start_enabled())
 		f2fs_trace_rw_file_path(in, pos, len, READ);
 
@@ -5510,12 +5589,14 @@ static int f2fs_preallocate_blocks(struct kiocb *iocb, struct iov_iter *iter,
 	if (dio && f2fs_lfs_mode(sbi))
 		return 0;
 	/*
-	 * Don't preallocate holes aligned to DIO_SKIP_HOLES which turns into
-	 * buffered IO, if DIO meets any holes.
+	 * Don't preallocate holes inside i_size, nor past i_size of KEEP_SIZE
+	 * files where post-EOF truncation on error would also drop blocks
+	 * reserved by fallocate().
 	 */
-	if (dio && i_size_read(inode) &&
-		(F2FS_BYTES_TO_BLK(sbi, pos) <
-		 F2FS_BLK_ALIGN(sbi, i_size_read(inode))))
+	if (dio && (file_keep_isize(inode) ||
+		    (i_size_read(inode) &&
+		     (F2FS_BYTES_TO_BLK(sbi, pos) <
+		      F2FS_BLK_ALIGN(sbi, i_size_read(inode))))))
 		return 0;
 
 	/* No-wait I/O can't allocate blocks. */
@@ -5593,11 +5674,289 @@ static ssize_t f2fs_buffered_write_iter(struct kiocb *iocb,
 	return ret;
 }
 
+static void f2fs_start_dio_write(struct inode *inode, struct kiocb *iocb,
+				 loff_t pos)
+{
+	struct f2fs_inode_info *fi = F2FS_I(inode);
+	struct f2fs_dio_track *t = fi->dio_track;
+	unsigned long flags;
+
+	if (!t) {
+		t = kzalloc_obj(*t, GFP_NOFS | __GFP_NOFAIL);
+		spin_lock_init(&t->lock);
+		atomic_set(&t->nr_inflight, 0);
+		INIT_LIST_HEAD(&t->inflight);
+		/* Pairs with smp_load_acquire() in f2fs_has_dio_alloc(). */
+		smp_store_release(&fi->dio_track, t);
+	}
+
+	spin_lock_irqsave(&t->lock, flags);
+	t->active_iocb = iocb;
+	t->active_pos = pos;
+	t->cur = NULL;
+	spin_unlock_irqrestore(&t->lock, flags);
+}
+
+static void f2fs_end_dio_write(struct inode *inode)
+{
+	struct f2fs_dio_track *t = F2FS_I(inode)->dio_track;
+	unsigned long flags;
+
+	if (!t || !t->active_iocb)
+		return;
+
+	spin_lock_irqsave(&t->lock, flags);
+	t->active_iocb = NULL;
+	t->cur = NULL;
+	spin_unlock_irqrestore(&t->lock, flags);
+}
+
+bool f2fs_dio_has_cur(struct inode *inode)
+{
+	struct f2fs_dio_track *t = F2FS_I(inode)->dio_track;
+
+	return t && READ_ONCE(t->cur);
+}
+
+/*
+ * Record a block allocated by a native O_DIRECT write so it can be rolled back
+ * if the write fails or stops short. The caller holds inode_lock() and
+ * f2fs_lock_op().
+ */
+void f2fs_record_dio_block(struct dnode_of_data *dn, block_t old_blkaddr)
+{
+	struct inode *inode = dn->inode;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_dio_track *t = F2FS_I(inode)->dio_track;
+	struct f2fs_dio_write *dw;
+	struct f2fs_dio_ext *ext, *last;
+	unsigned long long cp_ver;
+	block_t new_blkaddr = dn->data_blkaddr;
+	pgoff_t fofs;
+	unsigned long flags;
+
+	if (!t || !t->active_iocb)
+		return;
+
+	fofs = f2fs_start_bidx_of_node(ofs_of_node(sbi, dn->node_entry),
+				       inode) + dn->ofs_in_node;
+	cp_ver = cur_cp_version(F2FS_CKPT(sbi));
+	dw = t->cur;
+	if (dw) {
+		bool can_merge;
+
+		last = list_last_entry(&dw->extents, struct f2fs_dio_ext, list);
+		can_merge = last->cp_ver == cp_ver &&
+			    last->fofs + last->len == fofs &&
+			    last->new_blkaddr + last->len == new_blkaddr &&
+			    (__is_valid_data_blkaddr(old_blkaddr) ?
+			     (__is_valid_data_blkaddr(last->old_blkaddr) &&
+			      last->old_blkaddr + last->len == old_blkaddr) :
+			     last->old_blkaddr == old_blkaddr);
+		if (can_merge) {
+			spin_lock_irqsave(&t->lock, flags);
+			last->len++;
+			if (fofs + 1 > dw->max_end)
+				dw->max_end = fofs + 1;
+			spin_unlock_irqrestore(&t->lock, flags);
+			return;
+		}
+	} else {
+		dw = kzalloc_obj(*dw, GFP_NOFS | __GFP_NOFAIL);
+		dw->iocb = t->active_iocb;
+		dw->pos = t->active_pos;
+		dw->min_fofs = fofs;
+		dw->max_end = fofs + 1;
+		INIT_LIST_HEAD(&dw->extents);
+	}
+
+	ext = kzalloc_obj(*ext, GFP_NOFS | __GFP_NOFAIL);
+	ext->cp_ver = cp_ver;
+	ext->fofs = fofs;
+	ext->len = 1;
+	ext->old_blkaddr = old_blkaddr;
+	ext->new_blkaddr = new_blkaddr;
+
+	spin_lock_irqsave(&t->lock, flags);
+	list_add_tail(&ext->list, &dw->extents);
+	if (fofs < dw->min_fofs)
+		dw->min_fofs = fofs;
+	if (fofs + 1 > dw->max_end)
+		dw->max_end = fofs + 1;
+	if (!t->cur) {
+		WRITE_ONCE(t->cur, dw);
+		list_add_tail(&dw->list, &t->inflight);
+		atomic_inc(&t->nr_inflight);
+	}
+	spin_unlock_irqrestore(&t->lock, flags);
+}
+
+static void f2fs_rollback_dio_ext(struct inode *inode, pgoff_t fofs,
+				  unsigned int len, block_t old_blk,
+				  block_t new_blk, unsigned long long cp_ver)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	bool old_valid = __is_valid_data_blkaddr(old_blk);
+	bool same_cp = cur_cp_version(F2FS_CKPT(sbi)) == cp_ver;
+
+	while (len) {
+		struct dnode_of_data dn;
+		unsigned int end_offset;
+		blkcnt_t freed = 0;
+		int err;
+
+		set_new_dnode(&dn, inode, NULL, NULL, 0);
+		err = f2fs_get_dnode_of_data(&dn, fofs, LOOKUP_NODE);
+		if (err == -ENOENT) {
+			pgoff_t next = f2fs_get_next_page_offset(&dn, fofs);
+			unsigned int step = min_t(pgoff_t, len,
+						  max_t(pgoff_t, 1,
+							next - fofs));
+
+			fofs += step;
+			new_blk += step;
+			if (old_valid)
+				old_blk += step;
+			len -= step;
+			continue;
+		}
+		if (err) {
+			f2fs_warn_ratelimited(sbi,
+				"%s: failed to roll back direct write, ino:%llu, index:%lu, err:%d",
+				__func__, inode->i_ino, fofs, err);
+			set_sbi_flag(sbi, SBI_NEED_FSCK);
+			return;
+		}
+
+		end_offset = ADDRS_PER_PAGE(dn.node_entry, inode);
+		for (; len && dn.ofs_in_node < end_offset;
+		     dn.ofs_in_node++, fofs++, new_blk++, len--) {
+			block_t cur_old = old_blk;
+
+			if (old_valid)
+				old_blk++;
+			if (f2fs_data_blkaddr(&dn) != new_blk)
+				continue;
+
+			if (cur_old == NULL_ADDR) {
+				f2fs_invalidate_blocks(sbi, new_blk, 1);
+				f2fs_update_data_blkaddr(&dn, NULL_ADDR);
+				freed++;
+			} else if (cur_old == NEW_ADDR) {
+				f2fs_invalidate_blocks(sbi, new_blk, 1);
+				f2fs_update_data_blkaddr(&dn, NEW_ADDR);
+			} else if (same_cp &&
+				   f2fs_is_checkpointed_data(sbi, cur_old)) {
+				f2fs_update_data_blkaddr(&dn, cur_old);
+				if (new_blk != cur_old) {
+					f2fs_invalidate_blocks(sbi, new_blk, 1);
+					f2fs_revalidate_blocks(sbi, cur_old, 1);
+				}
+			} else {
+				f2fs_invalidate_blocks(sbi, new_blk, 1);
+				f2fs_update_data_blkaddr(&dn, NEW_ADDR);
+			}
+		}
+		if (freed)
+			dec_valid_block_count(sbi, inode, freed);
+		f2fs_put_dnode(&dn);
+	}
+}
+
+static void f2fs_finish_dio_write(struct inode *inode, struct kiocb *iocb,
+				  ssize_t size, int error)
+{
+	struct f2fs_dio_track *t = F2FS_I(inode)->dio_track;
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_dio_write *cur, *dw = NULL;
+	struct f2fs_dio_ext *ext, *tmp, *last;
+	ssize_t written = error ? 0 : size;
+	pgoff_t end_fofs = 0;
+	unsigned long flags;
+	bool need_rollback;
+
+	if (likely(!t || !atomic_read(&t->nr_inflight)))
+		return;
+
+	spin_lock_irqsave(&t->lock, flags);
+	list_for_each_entry(cur, &t->inflight, list) {
+		if (cur->iocb == iocb && !cur->completing) {
+			dw = cur;
+			break;
+		}
+	}
+	if (!dw) {
+		spin_unlock_irqrestore(&t->lock, flags);
+		return;
+	}
+
+	if (t->cur == dw)
+		WRITE_ONCE(t->cur, NULL);
+	if (written > 0)
+		end_fofs = F2FS_BLK_ALIGN(sbi, dw->pos + written);
+	last = list_last_entry_or_null(&dw->extents, struct f2fs_dio_ext, list);
+	need_rollback = last &&
+			(written <= 0 || last->fofs + last->len > end_fofs);
+	if (need_rollback) {
+		dw->completing = true;
+	} else {
+		list_del_init(&dw->list);
+		atomic_dec(&t->nr_inflight);
+	}
+	spin_unlock_irqrestore(&t->lock, flags);
+
+	if (need_rollback) {
+		struct f2fs_lock_context lc;
+
+		clear_inode_flag(inode, FI_PREALLOCATED_ALL);
+		f2fs_lock_op(sbi, &lc);
+		list_for_each_entry(ext, &dw->extents, list) {
+			pgoff_t fofs = ext->fofs;
+			unsigned int len = ext->len;
+			block_t old_blk = ext->old_blkaddr;
+			block_t new_blk = ext->new_blkaddr;
+
+			if (written > 0) {
+				if (fofs + len <= end_fofs)
+					continue;
+				if (fofs < end_fofs) {
+					unsigned int done = end_fofs - fofs;
+
+					fofs += done;
+					new_blk += done;
+					if (__is_valid_data_blkaddr(old_blk))
+						old_blk += done;
+					len -= done;
+				}
+			}
+			f2fs_rollback_dio_ext(inode, fofs, len, old_blk,
+					      new_blk, ext->cp_ver);
+		}
+		f2fs_unlock_op(sbi, &lc);
+
+		spin_lock_irqsave(&t->lock, flags);
+		list_del_init(&dw->list);
+		atomic_dec(&t->nr_inflight);
+		spin_unlock_irqrestore(&t->lock, flags);
+	}
+
+	/* Pairs with wait_var_event() in f2fs_wait_dio_alloc_range(). */
+	wake_up_var(&t->nr_inflight);
+
+	list_for_each_entry_safe(ext, tmp, &dw->extents, list) {
+		list_del(&ext->list);
+		kfree(ext);
+	}
+	kfree(dw);
+}
+
 static int f2fs_dio_write_end_io(struct kiocb *iocb, ssize_t size, int error,
 				 unsigned int flags)
 {
-	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(iocb->ki_filp));
+	struct inode *inode = file_inode(iocb->ki_filp);
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
+	f2fs_finish_dio_write(inode, iocb, size, error);
 	dec_cache_count(sbi, F2FS_DIO_WRITE);
 	if (error)
 		return error;
@@ -5965,12 +6324,15 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		dio_flags |= IOMAP_DIO_FORCE_WAIT;
 	dio = __iomap_dio_rw(iocb, from, &f2fs_iomap_ops,
 			     &f2fs_iomap_dio_write_ops, dio_flags, iocb, 0);
+	f2fs_end_dio_write(inode);
 	if (IS_ERR_OR_NULL(dio)) {
 		ret = PTR_ERR_OR_ZERO(dio);
 		if (ret == -ENOTBLK)
 			ret = 0;
-		if (ret != -EIOCBQUEUED)
+		if (ret != -EIOCBQUEUED) {
+			f2fs_finish_dio_write(inode, iocb, 0, -ECANCELED);
 			dec_cache_count(sbi, F2FS_DIO_WRITE);
+		}
 	} else {
 		ret = iomap_dio_complete(dio);
 	}
@@ -6053,6 +6415,9 @@ static ssize_t f2fs_dio_write_iter(struct kiocb *iocb, struct iov_iter *from,
 		*may_need_sync = false;
 	}
 out:
+	f2fs_end_dio_write(inode);
+	if (ret != -EIOCBQUEUED)
+		f2fs_finish_dio_write(inode, iocb, 0, -ECANCELED);
 	trace_f2fs_direct_IO_exit(inode, pos, count, WRITE, ret);
 	return ret;
 }
@@ -6098,6 +6463,12 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out_unlock;
 	}
 
+	ret = f2fs_wait_dio_alloc_range(inode, iocb->ki_pos,
+					iov_iter_count(from),
+					iocb->ki_flags & IOCB_NOWAIT);
+	if (ret)
+		goto out_unlock;
+
 	bufio_start_pos = iocb->ki_pos;
 
 	/* Determine whether we will do a direct write or a buffered write. */
@@ -6109,10 +6480,17 @@ static ssize_t f2fs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		goto out_unlock;
 	}
 
+	if (dio)
+		f2fs_start_dio_write(inode, iocb, iocb->ki_pos);
+
 	/* Possibly preallocate the blocks for the write. */
 	target_size = iocb->ki_pos + iov_iter_count(from);
 	preallocated = f2fs_preallocate_blocks(iocb, from, dio);
 	if (preallocated < 0) {
+		if (dio) {
+			f2fs_end_dio_write(inode);
+			f2fs_finish_dio_write(inode, iocb, 0, preallocated);
+		}
 		ret = preallocated;
 	} else {
 		/* Buffered write fails right away for NOWAIT. */
diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index cce6bac1cda1..3bd9f2ab08b9 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1981,11 +1981,16 @@ static void f2fs_dirty_inode(struct inode *inode, int flags)
 static void f2fs_free_inode(struct inode *inode)
 {
 	struct f2fs_dio_bufio *b = F2FS_I(inode)->dio_bufio;
+	struct f2fs_dio_track *t = F2FS_I(inode)->dio_track;
 
 	if (b) {
 		xa_destroy(&b->entries);
 		kfree(b);
 	}
+	if (t) {
+		WARN_ON_ONCE(!list_empty(&t->inflight));
+		kfree(t);
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
