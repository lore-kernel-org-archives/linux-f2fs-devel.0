Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DCFC61DCB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 08:27:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=m82yVa3nauL+Fm/5Mi6VJDciCCKdXEdFPpJ3YrtQlKU=; b=cAJXhY0T4AI2goh/cXQXXU0v03
	ptjd5L2vAZBrFvGoNepiCC/ILhRDJ+h237+rRzF7YMlWJG+xRQuWKCotxsQ2nnnTLDOaYoc2quErH
	QsT0IfYcZ9fShAV7dnLBq8RaCoOrVqUUOefx71BDX6qQUTtpEuKtf+p015asTL0Fl+IY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wz8yj-00024h-8j;
	Wed, 26 Aug 2026 08:27:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wz8yg-000244-KY
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 08:27:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/qtpC58izgX6U/rQqVoA/r5hSEzSCHQCTdPAveMHdn8=; b=OscQBJ11+yx+BgXVfahfiXt4wB
 ZYXxV49zpWxi3270CmlFSXHzJmd+n6dyFdt8ja/isKLunAywMAN1OdUS28jw80qVBB51bC8FlSC9R
 l7n2evCQKgoLnMsgnZCKJZljvbEzvBwB43BtcAU9QbuV/BNuysomGc1GFLoQqKGqdABA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/qtpC58izgX6U/rQqVoA/r5hSEzSCHQCTdPAveMHdn8=; b=P72HS3x4EYj57Pq2zIUmE3Lo7G
 WllEQYS8p7bMNmH9+CFOq5t25OUuabF8aapu9onr8U5Jva9u5zTPXzb+x52RS1OzgftDBzZvy/R0+
 sCrHTyJXJLHW6NtHGfUEF6otuFGh+ytkeK90MjzYMmefJjrjt1sp4+Tu4a3iKN4dfvbY=;
Received: from m16.mail.126.com ([220.197.31.9])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wz8ye-0002cS-AZ for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 08:27:23 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/q
 tpC58izgX6U/rQqVoA/r5hSEzSCHQCTdPAveMHdn8=; b=lhJ6ohbM7YbQBEdKN3
 zCEQlqjrRijAd5ePXn0f2pMc/PCMhIxwWXVMLN6h4fEZTCwZY2TswjYDFDZc/C/P
 DzmXlWWgwq9RTP5NJ6FeughLHoLdL21pmqHH7NPVyqZL0xYRV95yiRZf6H9Q7MBD
 Dq5GnL1EyQuh4SSnFqhQUG1XI=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id
 _____wD3F29Bo45qLzIoGQ--.14929S10; 
 Wed, 26 Aug 2026 16:26:49 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 26 Aug 2026 16:26:35 +0800
Message-ID: <20260826082641.2007658-9-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
References: <20260826082641.2007658-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3F29Bo45qLzIoGQ--.14929S10
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFW7urWUGF4UWw48uFWfXwb_yoW7Gr18pF
 WUKrn5KrZ8WFW7Xr1SqF1DZr1Sg348Ww4UGFZ7G34fJF1Yq3sakF1vk34YgF4rtr1kuFn7
 XF48GryDWF4UXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jUZ2-UUUUU=
X-Originating-IP: [114.247.175.250]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBogk5CWqOo0lSzQAA3K
X-Headers-End: 1wz8ye-0002cS-AZ
Subject: [f2fs-dev] [PATCH 08/14] f2fs: optimize small block size large
 folio read
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

The original f2fs_read_data_large_folio() implementation has limited
benefit with a 4KB block size, mainly because updating
read_pages_pending greatly increases the number of spinlock
operations.

Use len_blks to batch read_pages_pending and iostat updates for
contiguous mapped blocks. If the contiguous mapping covers the whole
folio, skip f2fs_folio_state allocation for that folio.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 62 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0e54b1e25893..48c1bb6c02e3 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -153,6 +153,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 		struct folio *folio = fi.folio;
 		unsigned int nr_pages = fi.length >> PAGE_SHIFT;
 		bool finished = true;
+		bool uptodate = bio->bi_status == BLK_STS_OK;
 
 		if (!folio_test_large(folio) &&
 		    f2fs_is_compressed_page(folio)) {
@@ -163,10 +164,14 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 			continue;
 		}
 
-		if (folio_test_large(folio)) {
-			struct f2fs_folio_state *ffs = folio->private;
+		if (f2fs_folio_has_ffs(folio)) {
+			struct f2fs_folio_state *ffs =
+				(struct f2fs_folio_state *)folio->private;
 
 			spin_lock_irqsave(&ffs->state_lock, flags);
+			if (bio->bi_status == BLK_STS_OK)
+				uptodate = __ffs_mark_subrange_uptodate(folio, ffs,
+						fi.offset, fi.length);
 			ffs->read_pages_pending -= nr_pages;
 			finished = !ffs->read_pages_pending;
 			spin_unlock_irqrestore(&ffs->state_lock, flags);
@@ -182,7 +187,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 			bio->bi_status = BLK_STS_IOERR;
 
 		if (finished)
-			folio_end_read(folio, bio->bi_status == BLK_STS_OK);
+			folio_end_read(folio, uptodate);
 	}
 
 	if (ctx)
@@ -2887,8 +2892,15 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	ffs = NULL;
 	nrpages = folio_nr_pages(folio);
 
-	for (; nrpages; nrpages--, max_nr_pages--, index++, offset++) {
+	for (; nrpages;
+	     nrpages -= len_blks, max_nr_pages -= len_blks,
+	     index += len_blks, offset += len_blks) {
 		sector_t block_nr;
+		bool whole_folio_in_bio;
+		unsigned int i;
+
+		len_blks = 1;
+
 		/*
 		 * Map blocks using the previous result first.
 		 */
@@ -2917,13 +2929,31 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 got_it:
 		if ((map.m_flags & F2FS_MAP_MAPPED)) {
 			block_nr = map.m_pblk + index - map.m_lblk;
-			if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
+
+			len_blks = min_t(unsigned int, nrpages, max_nr_pages);
+			len_blks = min_t(unsigned int, len_blks,
+					(unsigned int)(map.m_lblk + map.m_len - index));
+
+			for (i = 0; i < len_blks; i++) {
+				if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
+						block_nr + i,
 						DATA_GENERIC_ENHANCE_READ)) {
-				ret = -EFSCORRUPTED;
-				goto err_out;
+					ret = -EFSCORRUPTED;
+					goto err_out;
+				}
 			}
+
+			/*
+			 * If an entire folio is added to one bio,
+			 * folio_end_read() can complete the folio read status
+			 * without relying on f2fs_folio_state.
+			 */
+			whole_folio_in_bio = offset == 0 &&
+					len_blks == folio_nr_pages(folio);
+
 		} else {
 			size_t page_offset = offset << PAGE_SHIFT;
+
 			folio_zero_range(folio, page_offset, PAGE_SIZE);
 			if (vi && !fsverity_verify_blocks(vi, folio, PAGE_SIZE, page_offset)) {
 				ret = -EIO;
@@ -2933,14 +2963,14 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 		}
 
 		/* We must increment read_pages_pending before possible BIOs submitting
-		 * to prevent from premature folio_end_read() call on folio
+		 * to prevent from premature folio_end_read() call on folio.
 		 */
-		if (folio_test_large(folio)) {
+		if (folio_test_large(folio) && !whole_folio_in_bio) {
 			ffs = f2fs_ffs_find_or_alloc(folio);
 
 			/* set the bitmap to wait */
 			spin_lock_irq(&ffs->state_lock);
-			ffs->read_pages_pending++;
+			ffs->read_pages_pending += len_blks;
 			spin_unlock_irq(&ffs->state_lock);
 		}
 
@@ -2965,17 +2995,19 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 		 * If the page is under writeback, we need to wait for
 		 * its completion to see the correct decrypted data.
 		 */
-		f2fs_wait_on_block_writeback(inode, block_nr);
+		for (i = 0; i < len_blks; i++)
+			f2fs_wait_on_block_writeback(inode, block_nr + i);
 
-		if (!bio_add_folio(bio, folio, F2FS_BLKSIZE,
+		if (!bio_add_folio(bio, folio, len_blks * F2FS_BLKSIZE,
 					offset << PAGE_SHIFT))
 			goto submit_and_realloc;
 
 		folio_in_bio = true;
-		inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
+		for (i = 0; i < len_blks; i++)
+			inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
 		f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
-				F2FS_BLKSIZE);
-		last_block_in_bio = block_nr;
+				len_blks * F2FS_BLKSIZE);
+		last_block_in_bio = block_nr + len_blks - 1;
 	}
 	trace_f2fs_read_folio(folio, DATA);
 err_out:
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
