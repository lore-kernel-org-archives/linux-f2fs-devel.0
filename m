Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31CDFC79FB7
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 10 Sep 2026 02:20:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WEdlp3Ua4D65mVcDMic/pNj8YfLvAJxT0s4WSeHkxwU=; b=MULUigml2BWNC2umS2nAHeXNec
	I1zTvn9KOgrY0G7hlbDQHs3Fy3Nw/jHqMcn2uvBvyp1ca17PqSAWtDcZJF47ZOQg2Zaoc7PrWw39S
	laOQSVJyM433m3uEsGuy74qINi4/88rujANrx6T55o9KcOGeOI4Wc0nOPRbsWa+mgnR0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x4UP7-0003AV-PA;
	Thu, 10 Sep 2026 02:20:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x4UP6-0003AN-MC
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 02:20:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V8GXsSYTyWAtgr1wiQcgVRZK6oARMhydaZHAC1b1Ebw=; b=G24MaEdHu2/mPV9e2IE6tF77OL
 7I8zF2iAcVIhXMF8c5heSx09l9DQXld6N/Yb9DhzSsJeFnzIez8W46lCRjpyPKGd9c9LVkKcfheN3
 7yRR6/Eb7uAuWxbpNrdLQ95rJkxPy0sCVaIw58aPi7SCd4yxGLQft56E9uyyvMSEsR80=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=V8GXsSYTyWAtgr1wiQcgVRZK6oARMhydaZHAC1b1Ebw=; b=A
 ejwhjj+rSnZ4ojAwh075QZMdrjO8uOpaB9np9qnJhjHul5JHzbM+Pg0NoRBIFhdn6OgvRForEP8Ii
 5UBIT8M+1g/9FCLxRrdwQR4jtkoPvMmgVw17bQCUlVXqvM1lK2FBOgZmOC2WIsqoLyubczhXpLL42
 fykBconyCJEqpagI=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x4UP3-0007ZM-4I for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 10 Sep 2026 02:20:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 52EF4600CB;
 Thu, 10 Sep 2026 02:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0881F000FF;
 Thu, 10 Sep 2026 02:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789006835;
 bh=V8GXsSYTyWAtgr1wiQcgVRZK6oARMhydaZHAC1b1Ebw=;
 h=From:To:Cc:Subject:Date;
 b=P9WVVEkXkInKMtIIv3FRPraAECYvqmFS8+J3uXvBmz7SnH5U6MsicP4uORL1xe7ep
 LG7vqSryciy7G+lZgwZnDPDLY3L8q8F6Gtv0+vnzaRP5CI166IpFTEe2Ti0aFcDKuE
 Yfw11IAzd0JyW+1bw8YkmjJd+2Q7jhe1YZXHoOVKOaW+NW7v12eX/2Kdh1HwQI8o7o
 XuI0YxUi21p2Bkh3zoPe6AFgMRIteyyxmmsXGq+qXE+P+mUcrqWs2KZqtPOZiSZRCb
 fF+gZBR8eINuWZpSnTkxuXq9+fQR1eJLT/uqRAqSKW6h/oJV76GGjXa37VsMQ3RoNc
 HgWiY0XIbnO+w==
To: jaegeuk@kernel.org
Date: Thu, 10 Sep 2026 02:20:26 +0000
Message-ID: <20260910022026.3301257-1-chao@kernel.org>
X-Mailer: git-send-email 2.55.0.1003.g10538fe699-goog
MIME-Version: 1.0
X-Headers-End: 1x4UP3-0007ZM-4I
Subject: [f2fs-dev] [PATCH] f2fs: fix to avoid folio->mapping dereference in
 is_{meta, node}_folio()
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
Cc: Zhiguo Niu <zhiguo.niu@unisoc.com>, stable@kernel.org,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao@kernel.org>

Otherwise, it may cause NULL pointer dereference in race condition:

Thread A			Thread B
				- f2fs_setattr
				 - f2fs_truncate
				  - f2fs_truncate_blocks
			    	   - f2fs_do_truncate_blocks
				    - f2fs_truncate_inode_blocks
				     - truncate_dnode
				      - truncate_node
				       - invalidate_mapping_pages
				        - folio->mapping = NULL
- folio_lock
- is_node_folio
 - F2FS_F_SB(folio): dereference on folio->mapping

Cc: stable@kernel.org
Fixes: 019a8912425e ("f2fs: introduce is_{meta,node}_folio")
Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Closes: https://lore.kernel.org/linux-f2fs-devel/c5d29b31-e764-4782-9639-be84b1b2bfc2@kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/checkpoint.c |  4 ++--
 fs/f2fs/data.c       |  7 ++++---
 fs/f2fs/f2fs.h       | 10 +++++-----
 fs/f2fs/gc.c         |  2 +-
 fs/f2fs/node.c       | 22 +++++++++++-----------
 fs/f2fs/segment.c    |  2 +-
 6 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index 712c4508f38c..dfbfe42086f2 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -291,7 +291,7 @@ static struct folio *__get_meta_folio(struct f2fs_sb_info *sbi, pgoff_t index,
 	f2fs_update_iostat(sbi, NULL, FS_META_READ_IO, F2FS_BLKSIZE(sbi));
 
 	folio_lock(folio);
-	if (unlikely(!is_meta_folio(folio))) {
+	if (unlikely(!is_meta_folio(sbi, folio))) {
 		f2fs_folio_put(folio, true);
 		goto repeat;
 	}
@@ -638,7 +638,7 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, long nr_to_write,
 
 			folio_lock(folio);
 
-			if (unlikely(!is_meta_folio(folio))) {
+			if (unlikely(!is_meta_folio(sbi, folio))) {
 continue_unlock:
 				folio_unlock(folio);
 				continue;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 93ed8416a289..0da78bf05ac0 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -172,7 +172,8 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 			dec_page_count(F2FS_F_SB(folio), __read_io_type(folio));
 
 		if (bio->bi_status == BLK_STS_OK &&
-			F2FS_F_SB(folio)->node_inode && is_node_folio(folio) &&
+			F2FS_F_SB(folio)->node_inode &&
+			is_node_folio(F2FS_F_SB(folio), folio) &&
 			f2fs_sanity_check_node_footer(F2FS_F_SB(folio),
 				folio, folio->index, NODE_TYPE_REGULAR, true))
 			bio->bi_status = BLK_STS_IOERR;
@@ -359,12 +360,12 @@ static void f2fs_write_end_bio(struct bio *bio)
 			}
 		}
 
-		if (is_node_folio(folio)) {
+		if (is_node_folio(sbi, folio)) {
 			f2fs_sanity_check_node_footer(sbi, folio,
 				folio->index, NODE_TYPE_REGULAR, true);
 			f2fs_bug_on(sbi, folio->index != nid_of_node(sbi, folio));
 		}
-		if (f2fs_in_warm_node_list(folio))
+		if (f2fs_in_warm_node_list(sbi, folio))
 			f2fs_del_fsync_node_entry(sbi, folio);
 
 		dec_page_count(sbi, type);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 693153cbd8a0..ebc621f302e1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2371,14 +2371,14 @@ static inline struct address_space *NODE_MAPPING(struct f2fs_sb_info *sbi)
 	return sbi->node_inode->i_mapping;
 }
 
-static inline bool is_meta_folio(struct folio *folio)
+static inline bool is_meta_folio(struct f2fs_sb_info *sbi, struct folio *folio)
 {
-	return folio->mapping == META_MAPPING(F2FS_F_SB(folio));
+	return folio->mapping == META_MAPPING(sbi);
 }
 
-static inline bool is_node_folio(struct folio *folio)
+static inline bool is_node_folio(struct f2fs_sb_info *sbi, struct folio *folio)
 {
-	return folio->mapping == NODE_MAPPING(F2FS_F_SB(folio));
+	return folio->mapping == NODE_MAPPING(sbi);
 }
 
 static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
@@ -4063,7 +4063,7 @@ enum node_type;
 
 int f2fs_check_nid_range(struct f2fs_sb_info *sbi, nid_t nid);
 bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type);
-bool f2fs_in_warm_node_list(struct folio *folio);
+bool f2fs_in_warm_node_list(struct f2fs_sb_info *sbi, struct folio *folio);
 void f2fs_init_fsync_node_info(struct f2fs_sb_info *sbi);
 void f2fs_del_fsync_node_entry(struct f2fs_sb_info *sbi, struct folio *folio);
 void f2fs_reset_fsync_node_info(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index aedb45c8ee4a..c70deac9f1a3 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1431,7 +1431,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 						F2FS_BLKSIZE(fio.sbi));
 
 		folio_lock(mfolio);
-		if (unlikely(!is_meta_folio(mfolio) ||
+		if (unlikely(!is_meta_folio(fio.sbi, mfolio) ||
 			     !folio_test_uptodate(mfolio))) {
 			err = -EIO;
 			f2fs_folio_put(mfolio, true);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8c150d4966e5..f16144b75d11 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -332,10 +332,10 @@ static unsigned int __gang_lookup_nat_set(struct f2fs_nm_info *nm_i,
 							start, nr);
 }
 
-bool f2fs_in_warm_node_list(struct folio *folio)
+bool f2fs_in_warm_node_list(struct f2fs_sb_info *sbi, struct folio *folio)
 {
-	return is_node_folio(folio) && IS_DNODE(F2FS_F_SB(folio), folio) &&
-					is_cold_node(F2FS_F_SB(folio), folio);
+	return is_node_folio(sbi, folio) && IS_DNODE(sbi, folio) &&
+					is_cold_node(sbi, folio);
 }
 
 void f2fs_init_fsync_node_info(struct f2fs_sb_info *sbi)
@@ -1296,7 +1296,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 			goto fail;
 		if (offset[1] == 0 && get_nid(sbi, folio, offset[0], true)) {
 			folio_lock(folio);
-			BUG_ON(!is_node_folio(folio));
+			BUG_ON(!is_node_folio(sbi, folio));
 			set_nid(sbi, folio, offset[0], 0, true);
 			folio_unlock(folio);
 		}
@@ -1612,7 +1612,7 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 
 	folio_lock(folio);
 
-	if (unlikely(!is_node_folio(folio))) {
+	if (unlikely(!is_node_folio(sbi, folio))) {
 		f2fs_folio_put(folio, true);
 		goto repeat;
 	}
@@ -1731,7 +1731,7 @@ static struct folio *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 
 			folio_lock(folio);
 
-			if (unlikely(!is_node_folio(folio))) {
+			if (unlikely(!is_node_folio(sbi, folio))) {
 continue_unlock:
 				folio_unlock(folio);
 				continue;
@@ -1841,7 +1841,7 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool do_fsync,
 				f2fs_need_dentry_mark(sbi, ino_of_node(sbi, folio)));
 
 	/* should add to global list before clearing PAGECACHE status */
-	if (f2fs_in_warm_node_list(folio)) {
+	if (f2fs_in_warm_node_list(sbi, folio)) {
 		seq = f2fs_add_fsync_node_entry(sbi, folio);
 		if (seq_id)
 			*seq_id = seq;
@@ -1965,7 +1965,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 
 			folio_lock(folio);
 
-			if (unlikely(!is_node_folio(folio))) {
+			if (unlikely(!is_node_folio(sbi, folio))) {
 continue_unlock:
 				folio_unlock(folio);
 				continue;
@@ -2023,7 +2023,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 		f2fs_debug(sbi, "Retry to write fsync mark: ino=%u, idx=%lx",
 			   ino, last_folio->index);
 		folio_lock(last_folio);
-		if (unlikely(!is_node_folio(last_folio))) {
+		if (unlikely(!is_node_folio(sbi, last_folio))) {
 			f2fs_folio_put(last_folio, true);
 			ret = -EAGAIN;
 			goto out;
@@ -2101,7 +2101,7 @@ void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
 
 			folio_lock(folio);
 
-			if (unlikely(!is_node_folio(folio)))
+			if (unlikely(!is_node_folio(sbi, folio)))
 				goto unlock;
 			if (!folio_test_dirty(folio))
 				goto unlock;
@@ -2173,7 +2173,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			else if (!folio_trylock(folio))
 				continue;
 
-			if (unlikely(!is_node_folio(folio))) {
+			if (unlikely(!is_node_folio(sbi, folio))) {
 continue_unlock:
 				folio_unlock(folio);
 				continue;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0b6267d0354e..ffdd2c510b3c 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4161,7 +4161,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 			__func__, fio->ino, folio->index, type,
 			fio->old_blkaddr, fio->new_blkaddr, err);
 		folio_end_writeback(folio);
-		if (f2fs_in_warm_node_list(folio))
+		if (f2fs_in_warm_node_list(fio->sbi, folio))
 			f2fs_del_fsync_node_entry(fio->sbi, folio);
 		f2fs_bug_on(fio->sbi, !is_set_ckpt_flags(fio->sbi,
 							CP_ERROR_FLAG));
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
