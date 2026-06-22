Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94F27CDB475
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 22 Jun 2026 16:09:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PvnKaWX+I3rcW6cjOxExv0h1a8KKi+F2tQk++vu5BfM=; b=L8vWtKkBwQOaP2ZwmtwWGZ7wXG
	I5z3N6OC9XJHY9fzaKMnYiLMnojN6lPRyFYR/2qZlKL464VZBFlRUxe5uf5wRZ9SCjxgT9sRnJo84
	HHTouMSzRycf0NvQvOPYNmqaBxh3tZjzqEFZydolQUXuaVAZv4EBjMH6lC3pEAjflkHY=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wbhD8-0000ED-KM;
	Mon, 22 Jun 2026 16:09:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wbhD7-0000Dq-7f
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 16:09:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0CYNA7h1lOzfFyX70QKpIJOI26u3lc0ZkMWq5JQfuRA=; b=NtTS/Lx6UKWHe9VsSGfBtEjMpx
 Qi7GTm469gUar1XegezQ+P3IEnBjD3MHhDFtN0hG+mGaVdWUwRZr5x/p7ZTlY3N8+m1OYdcQ3sBZu
 VP4E9N8wwKeJuVxxl/td/MjPiX98KR7jNaI/uqAEpZaCD+7H7pK14X3VVqGzsucoGAlI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0CYNA7h1lOzfFyX70QKpIJOI26u3lc0ZkMWq5JQfuRA=; b=ER41pLb9qbn+xM/ZvvpdIzuGfr
 6l25JFWyR5tNWWfUjiFF++PltUh1AUPFihmUw+OnZ5ww2IPRy1XYuQTtDhZayuFk+JHERzxdtjlF9
 AwiQbylYlvelsjjFCgeTI19MBB6d/43N3OpkMPIL6qTwmNT/XysLFTYqROUQUdkiNGLg=;
Received: from m16.mail.126.com ([117.135.210.7])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wbhD4-0001An-Ur for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 22 Jun 2026 16:09:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=0C
 YNA7h1lOzfFyX70QKpIJOI26u3lc0ZkMWq5JQfuRA=; b=Lm2D35+SYGTTakNEo2
 83Ukm78wg6P1KEwIZrW+2Ik9ik6pIH58LZLJSPc70zAUeBK0Nxt1+VI8HbiJhKZG
 ReorPCIwmv0tpIHXURqv6LBxt4jRs/s0SdV3MCITR+X+gvnkChDTU8lmruzCc2oM
 kb0YYNioBRgWprrZYQn2HhvBQ=
Received: from YLLaptop.. (unknown [])
 by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id
 _____wAXfIP+XTlqz32SBw--.54996S11; 
 Tue, 23 Jun 2026 00:08:45 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Tue, 23 Jun 2026 00:08:29 +0800
Message-Id: <20260622160830.324455-10-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260622160830.324455-1-zhaonanzhe@xiaomi.com>
References: <20260622160830.324455-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wAXfIP+XTlqz32SBw--.54996S11
X-Coremail-Antispam: 1Uf129KBjvJXoWxuw18WFy7Xr1rXw4fAr1DJrb_yoW7ZFy7pF
 WUKr98KrZ5WFWxWr4SqF1DZr1Sg348W3yUGFZ7G34fJF1Yq3sIkF4kC34YgF4rtrykGFn3
 XF48GryDWF4UXF7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j189NUUUUU=
X-Originating-IP: [39.144.78.181]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsQ2DU2o5Xg3bCwAA38
X-Headers-End: 1wbhD4-0001An-Ur
Subject: [f2fs-dev] [RFC PATCH v2 09/10] f2fs: optimize small block size
 large folio read
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

The original f2fs_read_data_large_folio() implementation has limited
benefit with a 4KB block size, mainly because updating
read_pages_pending greatly increases the number of spinlock
operations.

Use len_blks to batch read_pages_pending and iostat updates for
contiguous mapped blocks. If the contiguous mapping covers the whole
folio, skip f2fs_folio_state allocation for that folio.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 69 ++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 53 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index a53fe68640d9..c7c36dad0d46 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -126,6 +126,11 @@ struct bio_post_read_ctx {
 	block_t fs_blkaddr;
 };
 
+static bool __ffs_mark_subrange_uptodate(struct folio *folio,
+		struct f2fs_folio_state *ffs, size_t offset, size_t len);
+static void ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
+					size_t len);
+
 /*
  * Update and unlock a bio's pages, and free the bio.
  *
@@ -150,6 +155,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 		struct folio *folio = fi.folio;
 		unsigned nr_pages = fi.length >> PAGE_SHIFT;
 		bool finished = true;
+		bool uptodate = bio->bi_status == BLK_STS_OK;
 
 		if (!folio_test_large(folio) &&
 		    f2fs_is_compressed_page(folio)) {
@@ -160,10 +166,14 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 			continue;
 		}
 
-		if (folio_test_large(folio)) {
-			struct f2fs_folio_state *ffs = folio->private;
+		if (folio_has_ffs(folio)) {
+			struct f2fs_folio_state *ffs =
+				(struct f2fs_folio_state *)folio->private;
 
 			spin_lock_irqsave(&ffs->state_lock, flags);
+			if (bio->bi_status == BLK_STS_OK)
+				uptodate = __ffs_mark_subrange_uptodate(folio, ffs,
+						fi.offset, fi.length);
 			ffs->read_pages_pending -= nr_pages;
 			finished = !ffs->read_pages_pending;
 			spin_unlock_irqrestore(&ffs->state_lock, flags);
@@ -179,7 +189,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 			bio->bi_status = BLK_STS_IOERR;
 
 		if (finished)
-			folio_end_read(folio, bio->bi_status == BLK_STS_OK);
+			folio_end_read(folio, uptodate);
 	}
 
 	if (ctx)
@@ -2853,7 +2863,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	pgoff_t index, offset, next_pgofs = 0;
 	unsigned max_nr_pages = rac ? readahead_count(rac) :
 				folio_nr_pages(folio);
-	unsigned nrpages;
+	unsigned int nrpages, len_blks;
 	struct f2fs_folio_state *ffs;
 	int ret = 0;
 	bool folio_in_bio = false;
@@ -2880,8 +2890,15 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
@@ -2910,13 +2927,31 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
@@ -2926,14 +2961,14 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 		}
 
 		/* We must increment read_pages_pending before possible BIOs submitting
-		 * to prevent from premature folio_end_read() call on folio
+		 * to prevent from premature folio_end_read() call on folio.
 		 */
-		if (folio_test_large(folio)) {
+		if (folio_test_large(folio) && !whole_folio_in_bio) {
 			ffs = ffs_find_or_alloc(folio);
 
 			/* set the bitmap to wait */
 			spin_lock_irq(&ffs->state_lock);
-			ffs->read_pages_pending++;
+			ffs->read_pages_pending += len_blks;
 			spin_unlock_irq(&ffs->state_lock);
 		}
 
@@ -2958,17 +2993,19 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
