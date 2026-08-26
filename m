Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8311C5DF97
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 15:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6h48uZ4uENdf43aZh8nMTnVdsw7O+kB1cgkIcIkKE2A=; b=f+tIs48WfYqkHXlByB8mJ/xL/Y
	iVzAqdaMQVpk+CXr/kaSqfrmWS5Sx6EpLXoqSjU2sP+rY7LxgUeG7mBjeSaRrm8a+0XZ6+K2u+Rpy
	uf9M363KOnkAVLPIFiaZRXKGP/2wGe0voA+SrEtmkALATbV8ZB3S7AugNcNHQsWptnVU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wzF9Q-0006sC-Rl;
	Wed, 26 Aug 2026 15:02:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wzF97-0006rt-I4
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:02:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XsBIZC7IR9A7r1RXPLN8NZNQ5js4QQye/w5nXDK3zng=; b=lO4DS12yN+nGmqru0KrtLq/rSZ
 LSgqvq3DrehSbrZU8Gv8dBtlmZ0cMoVNgLs33/1d1S4w3twltizSJRFoPEfK1iIXjPrOHx70ZybRY
 fgIuebLI+nCmVkGfpeNyoyzP6oQJPizasaUM36zE6PojeUgAvumWH4zRAUUd19zwT7Wk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XsBIZC7IR9A7r1RXPLN8NZNQ5js4QQye/w5nXDK3zng=; b=OMdazVxW0jsbrSZpTFGD8mwe9z
 M7oxMReskAfbCM5Mr4nCONchBc8ulhMVrp0Jq3BkQobj/fHkTVr0/2B+sEsX4izqtvbb+VIWoSBfh
 wJvcECNKTjG9c6fMIbcSDh9OyPl4tJfdRf8oKRibmIro53CVzI1ReA8WZ13KHoL1ZLAk=;
Received: from m16.mail.126.com ([220.197.31.9])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wzF91-0006UL-Le for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 15:02:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=Xs
 BIZC7IR9A7r1RXPLN8NZNQ5js4QQye/w5nXDK3zng=; b=lPIzxeKD1l8InKp8ad
 tYXOp5UU7idKQ6+qk5VKhBcLPJ7VwxbCCMk52rmHG72sI+20v+2hugj0CWKWgeVh
 1fq8+FMsklwqy5A2/CSYzWEyU/UlRvGM4xQ1TSI07OOkGfaPlYWXUsaDWDA0ZgaR
 lC7wnusgqHJUEr+grSwaifYx4=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-4 (Coremail) with SMTP id
 _____wB3P5N85Y5qx4G3Gg--.15517S2; 
 Wed, 26 Aug 2026 21:09:17 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 26 Aug 2026 21:09:12 +0800
Message-ID: <20260826130916.2231342-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
References: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wB3P5N85Y5qx4G3Gg--.15517S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxWF4DKF1xAFy7Gr15CFW7Jwb_yoW7Jr45pF
 W5GasrGrs5Gr48ur1xXF1DZw1rK3s3Wr4UCFWxGasIya4Yq3s5KF18t34j9Fs8tr48Arna
 q3W8KFyrWF1UJF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UCQ6JUUUUU=
X-Originating-IP: [114.247.175.250]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsB3WpmqO5X1ULQAA3Y
X-Headers-End: 1wzF91-0006UL-Le
Subject: [f2fs-dev] [PATCH 11/14] f2fs: fix zeroing paths for large folios
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Several f2fs zeroing paths still use PAGE_SIZE based offsets after
a file mapping can contain large folios.  This is fine for order-0
folios, but it zeros the wrong range once the target block is not at
offset 0 in a large folio.

Use offset_in_folio() to translate the file block index to the folio
offset before zeroing data in truncate_partial_data_page(), fill_zero(),
and f2fs_get_new_data_folio().

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 13 ++++++++++---
 fs/f2fs/f2fs.h |  1 +
 fs/f2fs/file.c | 27 ++++++++++++++++++++++-----
 3 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 15774e8e8795..0b167b14a9a5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1582,9 +1582,16 @@ struct folio *f2fs_get_new_data_folio(struct inode *inode,
 		goto got_it;
 
 	if (dn.data_blkaddr == NEW_ADDR) {
-		folio_zero_segment(folio, 0, folio_size(folio));
-		if (!folio_test_uptodate(folio))
+		size_t off = offset_in_folio(folio,
+					(loff_t)index << PAGE_SHIFT);
+
+		folio_zero_segment(folio, off, off + PAGE_SIZE);
+		if (folio_test_large(folio)) {
+			f2fs_ffs_find_or_alloc(folio);
+			f2fs_ffs_mark_subrange_uptodate(folio, off, PAGE_SIZE);
+		} else if (!folio_test_uptodate(folio)) {
 			folio_mark_uptodate(folio);
+		}
 	} else {
 		f2fs_folio_put(folio, true);
 
@@ -2670,7 +2677,7 @@ static bool __ffs_mark_subrange_uptodate(struct folio *folio,
 	return bitmap_full(ffs->state, nr_subpages);
 }
 
-static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
+void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
 				       size_t len)
 {
 	struct f2fs_folio_state *ffs;
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 0ffbe2bd04c8..6ae249bf9aa1 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -4330,6 +4330,7 @@ struct folio *f2fs_get_lock_data_folio(struct inode *inode, pgoff_t index,
 			bool for_write);
 struct folio *f2fs_get_new_data_folio(struct inode *inode,
 			struct folio *ifolio, pgoff_t index, bool new_i_size);
+void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset, size_t len);
 int f2fs_do_write_data_page(struct f2fs_io_info *fio);
 int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag);
 int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 02d687527241..4272013dbe38 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -811,12 +811,12 @@ void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
 static int truncate_partial_data_page(struct inode *inode, u64 from,
 								bool cache_only)
 {
-	loff_t offset = from & (PAGE_SIZE - 1);
 	pgoff_t index = from >> PAGE_SHIFT;
 	struct address_space *mapping = inode->i_mapping;
 	struct folio *folio;
+	size_t folio_off;
 
-	if (!offset && !cache_only)
+	if (!(from & (PAGE_SIZE - 1)) && !cache_only)
 		return 0;
 
 	if (cache_only) {
@@ -834,12 +834,21 @@ static int truncate_partial_data_page(struct inode *inode, u64 from,
 		return PTR_ERR(folio) == -ENOENT ? 0 : PTR_ERR(folio);
 truncate_out:
 	f2fs_folio_wait_writeback(folio, DATA, true, true);
-	folio_zero_segment(folio, offset, folio_size(folio));
+	folio_off = offset_in_folio(folio, from);
+	folio_zero_segment(folio, folio_off, folio_size(folio));
 
 	/* An encrypted inode should have a key and truncate the last page. */
 	f2fs_bug_on(F2FS_I_SB(inode), cache_only && IS_ENCRYPTED(inode));
-	if (!cache_only)
+	if (!cache_only) {
+		if (folio_test_large(folio)) {
+			f2fs_ffs_find_or_alloc(folio);
+			f2fs_ffs_mark_subrange_uptodate(folio, folio_off,
+					folio_size(folio) - folio_off);
+			f2fs_ffs_mark_subrange_dirty(folio, folio_off,
+					folio_size(folio) - folio_off);
+		}
 		folio_mark_dirty(folio);
+	}
 	f2fs_folio_put(folio, true);
 	return 0;
 }
@@ -1310,6 +1319,7 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	struct folio *folio;
 	struct f2fs_lock_context lc;
+	size_t folio_off;
 
 	if (!len)
 		return 0;
@@ -1324,7 +1334,14 @@ static int fill_zero(struct inode *inode, pgoff_t index,
 		return PTR_ERR(folio);
 
 	f2fs_folio_wait_writeback(folio, DATA, true, true);
-	folio_zero_range(folio, start, len);
+	folio_off = offset_in_folio(folio,
+				   (loff_t)index << PAGE_SHIFT) + start;
+	folio_zero_range(folio, folio_off, len);
+	if (folio_test_large(folio)) {
+		f2fs_ffs_find_or_alloc(folio);
+		f2fs_ffs_mark_subrange_uptodate(folio, folio_off, len);
+		f2fs_ffs_mark_subrange_dirty(folio, folio_off, len);
+	}
 	folio_mark_dirty(folio);
 	f2fs_folio_put(folio, true);
 	return 0;
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
