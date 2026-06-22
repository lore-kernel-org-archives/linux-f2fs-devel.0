Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C05D4CD98F2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WhueItDRwF9n5xXPXy5Vnlcxe7DY+6vW5mNA5iegv3c=; b=bCqUk7uMTuUD7AgRji7x32wxAu
	sOOPQLz9w8iM+UtmgiKRRP+jlAQoy9bFz70vrBfRwhBRoe5yjOFQD6/nOpv9VAJTkI8M/h3Poo8bw
	jFGy6ZRy8RkpzoI6E4VG9m03tYOShkNci4V11hHkAzbpJRiOb+ZZtG98mzppubjWo+LA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wbhD2-00072H-0l;
	Mon, 22 Jun 2026 16:09:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wbhCy-000723-Tl
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 16:09:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G5C8DROU1AhdPxsE+NvVCRUTbhNULvYAuOQ7B9jpgmY=; b=c1oKynS/bA0Leh1UbcL7yQiya/
 xCFNnRj1adAnSPxRbabpVnElZywIR2/szRQgzeSsFfblO5aZIzzr0muyd3JEGjru1Xo699bilFJMU
 Dg3D6CiFNvjGd1RYAKK9N7KEJ2kSUPTkNlWs1tmPiu2TjgB4cvF0XYBsu+WaNdgi8sgc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=G5C8DROU1AhdPxsE+NvVCRUTbhNULvYAuOQ7B9jpgmY=; b=WGg7eQIoIrN9QiF8EzD9cgpi8O
 N26GlBzxyWdC+kt26W0EA6Nu9u7x+1rRkLukEXKJaJBHF9YQ4677CmXclTFzkA9xJv31OorzOE8jk
 A4UNE7EkMvO35GZdnni6dfQXmZJXQx/8b4vrARs4pSDssccBv9ASEGl7i+sy6X0ZhCdk=;
Received: from m16.mail.126.com ([220.197.31.8])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbhCx-0001AD-Ew for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 16:09:12 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=G5
 C8DROU1AhdPxsE+NvVCRUTbhNULvYAuOQ7B9jpgmY=; b=ErDYdWIbF/71eLQiH6
 DN6KrFXqUca11TxwberYzxWHJJNXgtqu/HZKj7AYYLc1MG9cA0mxBwlhDwEptd+b
 CZwPnZTsKrSeY1TCGQGbjpr0ZFFsYAz+2k6Tfmcat3uHLS9xxNezVFoNOwy+5mFs
 L9HS1fIb0WGXw0gBlG4whNI9E=
Received: from YLLaptop.. (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wAXfIP+XTlqz32SBw--.54996S6; 
 Tue, 23 Jun 2026 00:08:38 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 23 Jun 2026 00:08:24 +0800
Message-Id: <20260622160830.324455-5-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622160830.324455-1-zhaonanzhe@xiaomi.com>
References: <20260622160830.324455-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wAXfIP+XTlqz32SBw--.54996S6
X-Coremail-Antispam: 1Uf129KBjvJXoWxKF1fuFyDJF18JFy7trWfGrg_yoW7ZrykpF
 WUKwn8KrWrJ3yfuwn3XFn8Zr1F934Iqw4xGayfGw1fZ3W5X3s8K3Wvyr1YkF1YqrZ7AF18
 Xa17tFWrW3WkJrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j15l8UUUUU=
X-Originating-IP: [39.144.78.181]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBogaBUWo5XgbaAAAA3l
X-Headers-End: 1wbhCx-0001AD-Ew
Subject: [f2fs-dev] [RFC PATCH v2 04/10] f2fs: support atomic file large
 folios buffered write
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
Cc: Barry Song <baohua@kernel.org>, Nanzhe Zhao <zhaonanzhe@xiaomi.com>,
 Juan Yescas <jyescas@google.com>, Dev Jain <Dev.Jain@arm.com>,
 linux-kernel@vger.kernel.org, David Hildenbrand <David.Hildenbrand@arm.com>,
 Bo Zhang <zhangbo56@xiaomi.com>, Kalesh Singh <kaleshsingh@google.com>,
 Ryan Roberts <Ryan.Roberts@arm.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Pengfei Li <lipengfei28@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

ioctl can convert an inode with large folio support into an atomic
file. Support large folio buffered writes for atomic files as well.

Add a large folio atomic write_begin helper that reserves COW mappings
for the write range. For partial head and tail subpages, read the
existing data from either the COW inode or the original inode before
marking the subpage uptodate.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 145 ++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 143 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index ad24a0e2da5f..0acd0a147831 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4198,6 +4198,139 @@ static int prepare_large_folio_write_begin(struct inode *inode,
 	return 0;
 }
 
+static int prepare_large_folio_atomic_write_begin(struct inode *inode,
+		struct address_space *mapping, struct folio *folio, loff_t pos,
+		unsigned int len)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct inode *cow_inode = F2FS_I(inode)->cow_inode;
+	size_t ori_off = offset_in_folio(folio, pos);
+	size_t need_off = ori_off;
+	pgoff_t index;
+	int err = 0;
+	sector_t sector;
+	struct block_device *bdev;
+	struct bio *bio;
+	unsigned int orig_order;
+	bool need_balance = false;
+
+	len = min_t(unsigned int, len, folio_size(folio) - ori_off);
+
+	ffs_find_or_alloc(folio);
+
+	/* Inline data must have been converted before reaching here. */
+	if (WARN_ON_ONCE(f2fs_has_inline_data(inode)))
+		return -EINVAL;
+
+	/* 1) Reserve COW blocks for all covered 4K subpages first. */
+	{
+		pgoff_t start_index = folio->index + (ori_off >> PAGE_SHIFT);
+		pgoff_t end_index = folio->index +
+			((ori_off + len - 1) >> PAGE_SHIFT);
+
+		for (index = start_index; index <= end_index; index++) {
+			block_t cow_blkaddr = NULL_ADDR;
+			bool node_changed = false;
+			int ret;
+
+			ret = __find_data_block(cow_inode, index, &cow_blkaddr);
+			if (ret)
+				return ret;
+			if (cow_blkaddr != NULL_ADDR)
+				continue;
+
+			ret = __reserve_data_block(cow_inode, index, &cow_blkaddr,
+						   &node_changed);
+			if (ret)
+				return ret;
+
+			inc_atomic_write_cnt(inode);
+			need_balance |= node_changed;
+		}
+	}
+
+	if (need_balance && !IS_NOQUOTA(inode) &&
+			has_not_enough_free_secs(sbi, 0, 0)) {
+		orig_order = folio_order(folio);
+		folio_unlock(folio);
+		f2fs_balance_fs(sbi, true);
+		folio_lock(folio);
+		if (unlikely(folio->mapping != mapping ||
+			     folio_order(folio) != orig_order))
+			return -EAGAIN;
+	}
+
+	if (folio_test_uptodate(folio) || len == folio_size(folio))
+		return 0;
+
+	/* Then read partial 4K subpages. */
+	while (f2fs_find_next_need_read_block(folio, ori_off, &need_off, len)) {
+		size_t off;
+		block_t cow_blkaddr = NULL_ADDR;
+		block_t ori_blkaddr = NULL_ADDR;
+		struct inode *read_inode = NULL;
+		block_t read_blkaddr = NULL_ADDR;
+
+		index = folio->index + (need_off >> PAGE_SHIFT);
+		off = offset_in_folio(folio, index << PAGE_SHIFT);
+
+		err = __find_data_block(cow_inode, index, &cow_blkaddr);
+		if (err)
+			return err;
+
+		if (__is_valid_data_blkaddr(cow_blkaddr)) {
+			if (!f2fs_is_valid_blkaddr(sbi, cow_blkaddr,
+					DATA_GENERIC_ENHANCE_READ))
+				return -EFSCORRUPTED;
+			read_inode = cow_inode;
+			read_blkaddr = cow_blkaddr;
+		} else if (is_inode_flag_set(inode, FI_ATOMIC_REPLACE)) {
+			folio_zero_segment(folio, off, off + PAGE_SIZE);
+			ffs_mark_subrange_uptodate(folio, off, PAGE_SIZE);
+			continue;
+		} else {
+			err = __find_data_block(inode, index, &ori_blkaddr);
+			if (err)
+				return err;
+
+			if (!__is_valid_data_blkaddr(ori_blkaddr)) {
+				folio_zero_segment(folio, off, off + PAGE_SIZE);
+				ffs_mark_subrange_uptodate(folio, off, PAGE_SIZE);
+				continue;
+			}
+
+			if (!f2fs_is_valid_blkaddr(sbi, ori_blkaddr,
+					DATA_GENERIC_ENHANCE_READ))
+				return -EFSCORRUPTED;
+			read_inode = inode;
+			read_blkaddr = ori_blkaddr;
+		}
+
+		/* Submit a synchronous read for this 4K subpage. */
+		f2fs_wait_on_block_writeback(read_inode, read_blkaddr);
+		bdev = f2fs_target_device(sbi, read_blkaddr, &sector);
+
+		bio = bio_alloc_bioset(bdev, 1, REQ_OP_READ | REQ_SYNC,
+				       GFP_NOIO, &f2fs_bioset);
+		bio->bi_iter.bi_sector = sector;
+		f2fs_set_bio_crypt_ctx(bio, read_inode, index, NULL, GFP_NOFS);
+
+		if (!bio_add_folio(bio, folio, PAGE_SIZE, off)) {
+			bio_put(bio);
+			return -EIO;
+		}
+
+		err = submit_bio_wait(bio);
+		bio_put(bio);
+		if (err)
+			return err;
+
+		ffs_mark_subrange_uptodate(folio, off, PAGE_SIZE);
+	}
+
+	return 0;
+}
+
 static int f2fs_write_begin(const struct kiocb *iocb,
 			    struct address_space *mapping,
 			    loff_t pos, unsigned len, struct folio **foliop,
@@ -4269,7 +4402,7 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 
 	*foliop = folio;
 
-	if (f2fs_is_atomic_file(inode))
+	if (f2fs_is_atomic_file(inode) && !folio_test_large(folio))
 		err = prepare_atomic_write_begin(sbi, folio, pos, len,
 					&blkaddr, &need_balance);
 	else if (!folio_test_large(folio))
@@ -4294,10 +4427,18 @@ static int f2fs_write_begin(const struct kiocb *iocb,
 	f2fs_folio_wait_writeback(folio, DATA, false, true);
 
 	if (folio_test_large(folio)) {
-		err = prepare_large_folio_write_begin(inode,
+		if (f2fs_is_atomic_file(inode))
+			err = prepare_large_folio_atomic_write_begin(inode,
+					mapping, folio, pos, len);
+		else
+			err = prepare_large_folio_write_begin(inode,
 					folio, pos, len);
 		if (!err)
 			return 0;
+		if (err == -EAGAIN) {
+			f2fs_folio_put(folio, true);
+			goto repeat;
+		}
 		goto put_folio;
 	}
 
-- 
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
