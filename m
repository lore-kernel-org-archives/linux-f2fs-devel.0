Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22C81CCA46C
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 17 Oct 2026 02:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=RkTiBqAOn1CcjUozWx14TidBkokfqA/k8N+kgpxt9KA=; b=RI6wKzkwkIQlXJlCuEyUK83E3F
	boLWSlLX7BaqnwD7kx41+wilGKObF9MAXJkZx/E5gfmDIu/6z2yFkLBJ/OCYCLslfE6nxGl15MQ84
	SS/pGxF8WpaaU7S9+oaeiCyiHPUV7e1eNKpjyE6JHYyjFnaiFmByYmam4VVszxKpzapQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xHtmR-0000Zg-4v;
	Sat, 17 Oct 2026 02:04:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xHtmQ-0000ZT-03
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 02:04:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qIfzl9+QXGyHxNn9noq+ro3ckc6FSDaXOAYGm2ZzYik=; b=D5SKdZTIwcv+sLesb/ekGDNLrL
 6uNdlcSBc2idawS2eMFM94DrZ4PFfkQDj0soS6SfbPtmYODvQWwgyHSFvkFURyob1MiHy0wAIk87Q
 51ad7A+16Qu/stEayFUV32VO7ctCSLArQKYiBWl802Qu/WTniKSjMq0YhPKDw6P50GWQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=qIfzl9+QXGyHxNn9noq+ro3ckc6FSDaXOAYGm2ZzYik=; b=d
 4YnzDcNmcjFBIMU4HQHedAIpc/+PindEP+Jkd2ZroT36294drlpE2mH8oe9hNm7kzerfz7olpv+L0
 WvqBaYQ8ZguoMnqoy+VGzHWXJhcnnUDZgbz2oLNxernNBgQP/k1UdKjftDmHTCwB0unac1oRacVC5
 joKr2yaymw9cobXI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xHtmQ-0005bZ-2n for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 17 Oct 2026 02:04:14 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B7034434DC
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 17 Oct 2026 02:04:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C28B71F000C4;
 Sat, 17 Oct 2026 02:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792202648;
 bh=qIfzl9+QXGyHxNn9noq+ro3ckc6FSDaXOAYGm2ZzYik=;
 h=From:To:Cc:Subject:Date;
 b=M/QhGHF+aSMVtmJMxXsNf0QCeNWKFhLYRIDQs90crrEDJXZCEvcwajlPj7OI8I8L+
 W2l/1tQNeraVP/yXtcBQx+/S/TqQCxuoFpEvs5CUyzT79/oHPt8A4bruogfyeSJwQ0
 g+4NPwotant0IsnhP1abmCtTInjP22Bt/Q7LawTK9nTXA2ismg0DU/QI33oN1ns7Qh
 lxW82125OEYZQ2loY238IpZNDxIzoG2KBdi0VaK8bBLEkhD6nsvVlsnOTQdyrxXdnR
 lnJ8HV8/qXMtBh5BYbdtzwdj14RxMK4Fh89HxSv/EbSbe7P6t3mHjliddok8ejh5I8
 SMl0H4KE7HNRQ==
To: jaegeuk@kernel.org
Date: Sat, 17 Oct 2026 02:03:57 +0000
Message-ID: <20261017020358.305503-1-chao@kernel.org>
X-Mailer: git-send-email 2.56.0.176.g3575e65682-goog
MIME-Version: 1.0
X-Headers-End: 1xHtmQ-0005bZ-2n
Subject: [f2fs-dev] [PATCH 1/2] f2fs: introduce max_write_bio_{folio,
 entry}_cnt module parameters
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

Commit 3de6b8094115 ("f2fs: Run f2fs_write_end_io() asynchronously")
introduced max_atc_write_bio_size to offload write bio completion to a
workqueue when f2fs_write_end_io() is called in atomic context.

However, relying on bio->bi_iter.bi_size as the threshold has two main
issues:

1. bio->bi_iter.bi_size is not reliable at bio completion time, as its
   value depends on the underlying storage stack:
   - On a direct blk-mq path (e.g. SCSI or UFS), blk_update_request()
     consumes the bio iterator via bio_advance() before calling
     bio_endio(), so bi_size is already 0 when f2fs_write_end_io() is
     called, and the threshold check is never triggered:
     scsi_end_request() / blk_mq_end_request()
      -> blk_update_request()
        -> bio_advance()          /* bio->bi_iter.bi_size becomes 0 */
        -> bio_endio()
          -> f2fs_write_end_io()  /* sees bi_size == 0 */
   - On a device-mapper / zoned device path (e.g. dm-linear / dm-crypt),
     DM allocates a clone bio and sets clone->bi_iter.bi_size, while the
     original bio's bi_size remains intact when completed:
     dm_submit_bio()
      -> dm_split_and_process_bio()
        -> __split_and_process_bio()
          -> alloc_tio()          /* sets clone->bi_iter.bi_size */
          -> __map_bio()
            -> dm_submit_bio_remap()
              -> submit_bio_noacct(clone)
     blk_update_request()         /* advances clone->bi_iter.bi_size to 0 */
      -> bio_endio(clone)
        -> clone_endio()
          -> dm_io_dec_pending()
            -> dm_io_complete()
              -> __dm_io_complete()
                -> bio_endio(orig_bio)
                  -> f2fs_zone_write_end_io()
                    -> f2fs_write_end_io() /* orig_bio->bi_iter.bi_size intact */

2. With large folios or multi-page bvecs, bi_size (and bi_vcnt) does not
   reflect the actual completion latency:
   - In f2fs_write_end_bio() and f2fs_cache_write_end_bio(), execution
     time is dominated by the completion loop (bio_for_each_folio_all()
     for pagecache folios, or while(entry) for cached metadata blocks).
     The CPU latency in atomic context scales with the number of entries
     in the bio, not its byte size.
   - For large folios, a large bio (e.g. 1MB comprised of a few large
     folios) only iterates a few times in the loop. Throttling by
     bi_size unnecessarily offloads such low-latency bios to the
     workqueue, adding context-switch overhead.
   - Relying on bio->bi_vcnt is also insufficient because the block
     layer (bvec_try_merge_page()) merges physically contiguous
     pages/folios into the same bio_vec segment, so a bio with
     bi_vcnt == 1 can still contain multiple entries.

Furthermore:
- The limit is used to bound the CPU latency of f2fs_write_end_io() in
  atomic context, which is a property of the platform (CPU and storage
  completion path) rather than of each f2fs instance, so a global knob
  set once at boot fits better than a per-superblock sysfs entry.
- Pagecache folios and cached metadata blocks are completed in different
  loops with different per-entry costs, i.e. f2fs_write_end_bio() and
  f2fs_cache_write_end_bio(), so it's better to tune them separately
  rather than sharing a single threshold.

To address this, track the exact number of entries (folios or cached
blocks) queued to a write bio via entry_cnt in struct f2fs_bio, and
introduce two module parameters:

- max_write_bio_folio_cnt: for write bios of pagecache folios, which
  are completed in f2fs_write_end_bio().
- max_write_bio_entry_cnt: for write bios of cached metadata blocks,
  which are completed in f2fs_cache_write_end_bio().

Both parameters are read-only at runtime, they can be set via
f2fs.max_write_bio_{folio,entry}_cnt=<n> in the kernel command line, or
via modprobe, and apply to all f2fs instances. The default value is
UINT_MAX, which means this functionality is disabled by default.

Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 28 +++++++++++++++++++++++++++-
 fs/f2fs/f2fs.h |  1 +
 2 files changed, 28 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 1b0395b45fb7..3caadb30496a 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -36,6 +36,16 @@ static struct kmem_cache *ffs_entry_slab;
 static mempool_t *bio_post_read_ctx_pool;
 static struct bio_set f2fs_bioset;
 
+static unsigned int max_write_bio_folio_cnt = UINT_MAX;
+module_param(max_write_bio_folio_cnt, uint, 0444);
+MODULE_PARM_DESC(max_write_bio_folio_cnt,
+		"Maximum number of folios in a write bio completed in atomic context");
+
+static unsigned int max_write_bio_entry_cnt = UINT_MAX;
+module_param(max_write_bio_entry_cnt, uint, 0444);
+MODULE_PARM_DESC(max_write_bio_entry_cnt,
+		"Maximum number of cache entries in a write bio completed in atomic context");
+
 struct f2fs_folio_state {
 	spinlock_t		state_lock;
 	unsigned int		read_pages_pending;
@@ -390,6 +400,12 @@ static void f2fs_write_end_io_work(struct work_struct *work)
 	f2fs_write_end_bio(bio);
 }
 
+static unsigned int f2fs_max_write_bio_cnt(struct bio *bio)
+{
+	return f2fs_is_cache_bio(bio) ? max_write_bio_entry_cnt :
+					max_write_bio_folio_cnt;
+}
+
 static void f2fs_write_end_io(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi;
@@ -398,7 +414,8 @@ static void f2fs_write_end_io(struct bio *bio)
 
 	sbi = bio->bi_private;
 
-	if (in_atomic() && bio->bi_iter.bi_size > sbi->max_atc_write_bio_size) {
+	if (in_atomic() && (bio->bi_iter.bi_size > sbi->max_atc_write_bio_size ||
+		F2FS_BIO(bio)->entry_cnt > f2fs_max_write_bio_cnt(bio))) {
 		struct work_struct *w;
 
 		w = &container_of(bio, struct f2fs_bio, bio)->work;
@@ -555,6 +572,7 @@ static struct bio *__bio_alloc(struct f2fs_io_info *fio, int npages)
 						fio->type, fio->temp);
 		bio->bi_write_stream = f2fs_io_type_to_write_stream(bdev, fio->type,
 								    fio->temp);
+		F2FS_BIO(bio)->entry_cnt = 0;
 	}
 	iostat_alloc_and_bind_ctx(sbi, bio, NULL);
 
@@ -867,6 +885,9 @@ int f2fs_submit_page_bio(struct f2fs_io_info *fio)
 			fio_folio->index, fio, GFP_NOIO);
 	bio_add_folio_nofail(bio, data_folio, folio_size(data_folio), 0);
 
+	if (!is_read_io(fio->op))
+		F2FS_BIO(bio)->entry_cnt++;
+
 	if (fio->io_wbc && !is_read_io(fio->op))
 		wbc_account_cgroup_owner(fio->io_wbc, fio_folio, PAGE_SIZE);
 
@@ -937,6 +958,7 @@ static void add_bio_entry(struct f2fs_sb_info *sbi, struct bio *bio,
 	bio_get(bio);
 
 	bio_add_folio_nofail(bio, folio, folio_size(folio), 0);
+	F2FS_BIO(bio)->entry_cnt++;
 
 	f2fs_down_write(&io->bio_list_lock);
 	list_add_tail(&be->list, &io->bio_list);
@@ -977,6 +999,7 @@ static int add_ipu_page(struct f2fs_io_info *fio, struct bio **bio,
 					fio_folio->mapping->host,
 					fio_folio->index, fio) &&
 			    bio_add_folio(*bio, folio, folio_size(folio), 0)) {
+				F2FS_BIO(*bio)->entry_cnt++;
 				ret = 0;
 				break;
 			}
@@ -1234,6 +1257,8 @@ void f2fs_submit_page_write(struct f2fs_io_info *fio)
 		goto alloc_new;
 	}
 
+	F2FS_BIO(io->bio)->entry_cnt++;
+
 	if (fio->io_wbc)
 		wbc_account_cgroup_owner(fio->io_wbc, fio->folio,
 				folio_size(fio->folio));
@@ -1340,6 +1365,7 @@ void f2fs_submit_cache_write(struct f2fs_io_info *fio)
 	}
 
 	f2fs_bio_add_cache(fio, io->bio);
+	F2FS_BIO(io->bio)->entry_cnt++;
 
 	io->last_block_in_bio = fio->new_blkaddr;
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 362f06cb398d..4333d88cf076 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1778,6 +1778,7 @@ struct f2fs_gc_kthread {
 struct f2fs_bio {
 	struct work_struct work;
 	struct f2fs_cached_block *entry;
+	unsigned int entry_cnt;
 	struct bio bio;
 };
 
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
