Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BABE8CD98CF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 12 Jun 2026 08:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-Id:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Yvo0R3z3dZdwM/6V5sVc9MupG4J8j+JMv/GAAxf2rVU=; b=B68zsMzQQ7FcqN0TcBA3RSKfuQ
	6Pi0+xaBc/caToLwkLeG0W/mE3hsSRZoqrGx9c4FtgmjH6lVwnDIN6cU+qGpz9CRwCUQnonzZm57d
	0ZaCgIydxynYjqH7m6B9cyclp+fx93Mk70lu0VceD0LQojhzslfQvjhsFooaP2xnMhI4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wXwsQ-0000Bg-LQ;
	Fri, 12 Jun 2026 08:04:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1wXwsO-0000BQ-P5
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 08:04:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cG3h88ZXl2chCJLapwKzMiuBmbcw61vyaWoxfUwYFiE=; b=bwD1NmJr92hwlSIQIfBjxfp3Rc
 oM0qhYgtTwWjU2oit7TEcNhxCayru1sxLf2WxAl7QKtx/wbcSfKl/5eq3FS942e784udxig6fzM2V
 m9n9TdUuRlAf2Pjf2UvbNSBtnhehZkf+n3vbgJdfKvG99So0jruqA4mzakdJF0RYcs0E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cG3h88ZXl2chCJLapwKzMiuBmbcw61vyaWoxfUwYFiE=; b=VEWvta+OBzAp1eCgeexiZsOA3c
 a4AfeKNYU6Bjy4qlhVniEU20VXk8uEh5Ld9Z2C9LfNaKpRh0zo4Yw/+3BQlp6fP4fRUilGatuzoO7
 kb8gMegy5IfJQeh/bFXKQ6Flw1U69N4zmjiRk+HWs5N1GeU/j42lTdArnSIKnrFzUvdg=;
Received: from m16.mail.126.com ([117.135.210.9])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wXwsL-0004JY-L6 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Jun 2026 08:04:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=cG
 3h88ZXl2chCJLapwKzMiuBmbcw61vyaWoxfUwYFiE=; b=EprClj0bpbo5IAzryM
 HNcs74kEU/9wjEScTFoG/x6C8DZU0D1xCwh/FDdGuw57ZMkxZKi0gFFrTgpcUZbp
 aqzjilBDC/r5apDyXb50KSt0g0mdjJixuhB4emz3qRJlj2mcyFRTHnxBCLgxLjOF
 wO86osIyGAmvTEaQyH68tXRVE=
Received: from YLLaptop.. (unknown [])
 by gzga-smtp-mtada-g0-0 (Coremail) with SMTP id
 _____wDX_ytWvStqyXqrBQ--.43664S11; 
 Fri, 12 Jun 2026 16:03:48 +0800 (CST)
To: linux-f2fs-devel@lists.sourceforge.net
Date: Fri, 12 Jun 2026 16:03:34 +0800
Message-Id: <20260612080334.70657-10-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260612080334.70657-1-zhaonanzhe@xiaomi.com>
References: <20260612080334.70657-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wDX_ytWvStqyXqrBQ--.43664S11
X-Coremail-Antispam: 1Uf129KBjvJXoWxJFW7urWUGF4UWr1ktF4fXwb_yoWrZF17pF
 yUKrn5KrZ5WFWIgF4IvF1DZr1Sq34kWw4UGFZ3G34fX3Wjq3sIkF1vy34Y9F15trykXFs2
 qF45GryDWF15XaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jbcTQUUUUU=
X-Originating-IP: [223.104.43.40]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBowTtvWorvWSt0AAA3S
X-Headers-End: 1wXwsL-0004JY-L6
Subject: [f2fs-dev] [RFC PATCH 9/9] f2fs: optimize small block size large
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
Cc: Barry Song <baohua@kernel.org>, Ryan Roberts <Ryan.Roberts@arm.com>,
 Juan Yescas <jyescas@google.com>, Dev Jain <Dev.Jain@arm.com>,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Nanzhe <zhaonanzhe@xiaomi.com>

The original f2fs_read_data_large_folio() implementation has limited
benefit with a 4KB block size, mainly because updating
read_pages_pending greatly increases the number of spinlock
operations.

Use len_blks to batch read_pages_pending and iostat updates for
contiguous mapped blocks. If the contiguous mapping covers the whole
folio, skip f2fs_folio_state allocation for that folio.

Signed-off-by: Nanzhe <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 55 +++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 033b28be2ae7..f02637e3f420 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -156,7 +156,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 			continue;
 		}
 
-		if (folio_test_large(folio)) {
+		if (folio_has_ffs(folio)) {
 			struct f2fs_folio_state *ffs = folio->private;
 
 			spin_lock_irqsave(&ffs->state_lock, flags);
@@ -3012,7 +3012,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	pgoff_t index, offset, next_pgofs = 0;
 	unsigned max_nr_pages = rac ? readahead_count(rac) :
 				folio_nr_pages(folio);
-	unsigned nrpages;
+	unsigned int nrpages, len_blks;
 	struct f2fs_folio_state *ffs;
 	int ret = 0;
 	bool folio_in_bio = false;
@@ -3039,8 +3039,15 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
@@ -3069,13 +3076,31 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
@@ -3085,14 +3110,14 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
 
@@ -3117,17 +3142,19 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
