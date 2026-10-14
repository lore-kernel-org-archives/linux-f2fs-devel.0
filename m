Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6555FCC6B19
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:46:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cywO+jqjQauoaODqhKiSjx/iuv+q4lyBfsa8+vU8dI0=; b=Wnomy4OA3nMzEGlzy3rdrEpdpu
	i3fHLxVzwplvrPXjNjYr/FvhE9zbJQGRWaJcKQeMG8uWcqtTdryDlRQigiM36qO9Ml8Xk0jGQ399s
	94ZrVmrcV3Alxu83s/yimDW4rdXepYioumshmTH8amgaRPZVohmc4UzHTiIuftQ9b02A=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGskY-0006nE-8s;
	Wed, 14 Oct 2026 06:46:07 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGskX-0006n7-1P
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:46:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SHO71UYjeP5xAAFO6D76VUy+VSDBc+W35bKfH/3Qvbs=; b=V8l8fwCwGL1rj/2uO4Aydxs4Kx
 fyXWx1A1sk0EeLQcg1maoj+ys6YPbDp8vZsd2LNy1+ujM2kF8u4HyfuZmW9NFJBrWtAnaX8/ShTkP
 8B6psYoeM9J1eUEJgsZblEXQ7oZ7NwENLKuUoM/43438qXy56oOYBAdwYJ5nXOxLtpOM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=SHO71UYjeP5xAAFO6D76VUy+VSDBc+W35bKfH/3Qvbs=; b=LSi3gjlZlbd7dv3AfEUNN3nDS9
 0OklZBbvrwTxNqFGb8ffnZkPJPxIDcAXhe/PTdtujQxzYAl3+Ed6++pL3xno77kpkZEQ/mS1y/FXc
 pDlNGJzUe1P+Vw2waa5IkjmF/uvGDpvsGcTQfeZHNAiCIkPx37eAQVA9Ii7asV90EaLQ=;
Received: from mail-pj2-f6.google.com ([74.125.227.134])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGskX-0004MQ-7f for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:46:05 +0000
Received: by mail-pj2-f6.google.com with SMTP id
 98e67ed59e1d1-3964e7720afso1847007a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 23:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791960359; x=1792565159; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=SHO71UYjeP5xAAFO6D76VUy+VSDBc+W35bKfH/3Qvbs=;
 b=G675st4qO3KnnD1Wiz/kTRIPBj83iohMz+pxMZRqVCV/v7ibBxKtc9QQ/zV8UcNeWJ
 kiFn3hiU+2dNGw7PatSOLzI0IS8tM2xj3nUh5dmaJuIxC9KnQZTbD0tn33O6/q1C7ESD
 iUM+iNWBEu1P4O92gFhbrR++gQUsV/W9Ho8Ei1Kp3F4ndn7pUEYJXNuwz4o2R6aKwslN
 6TqmtvYyr1ecgiwM2/s1UjsWR08g1KSuLeL294NggRkw794OX04HLmh9/gXfeG9At7rq
 54c85qFKtg2INrTKB2BLlxYFZOk5HuT4nHZIsNJ7GRgfrF+3zY4S7sF4PcvkZbPXCnt4
 61BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791960359; x=1792565159;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=SHO71UYjeP5xAAFO6D76VUy+VSDBc+W35bKfH/3Qvbs=;
 b=CzoM7T18tbKTpKjCWe8Pop6Kh1tItSYfLYEvu7I0zQpI3RNRrNh3v7XYptJ1I/yN3k
 PWtBZeLK1ZsMsWkIpE7w4NoiXjIxtnr4ZZC+fwN9AK1zpm9SzpXDaPwe5Y1IPTQb9OoG
 fKqk+WyuIpU6OKUPoeZixh9kwtTxWwVdnxg+9KQQpzCASasRAMcyxYKgupw1lZ2xergN
 6cK7uNNdwNW5tAhOLQsLFS/4/IOAcVoyqVFrqzJ5xJflZhNJ5RcB/+HI1DVvc9KpUmwR
 f3tIEQCQbwrx5twsda5rJnD7vwEzs+WF9jzuIoDsnkQNUuI5ZXq/v+egXe3g7z80wdBW
 tgeg==
X-Gm-Message-State: AFq9FYLhuC0g40ZlC1YQ/1yMAQphfH/eEA8qA7M4wucg5toG3XNxC0rr
 /TQSSOdk+Zrx8Ure+E8OzEMSvK8hu1YEDdBKjzGKSbeIgAw48fd2vnPEdYiVI/Ck4gY=
X-Gm-Gg: AYBFou2Y62jkmTrjPLXsTKbiPZlHfnU0CNA99A4qSNdphN4+4qQgz3VKDxiiI1kb93k
 OqYcI7oCxYb5o1y32CJcRbb7lN0uTeJ7CuI8YAdQE/3fFJORn8kmdM0jRiQfi08kiDUrmCx22RY
 gUfBzLMRc5gLP5SU8oD9tRk+cBxxYCY+BPCHGaN2YGxCS/zm7CQ/NVcabzlNCVpy5Uhia29RnQn
 oo21PAojF0wtSA3MHjuVCheiWh1NRZ/JlKOOd9OhVrnhi4EJ8+F6y8p/YGogZNS+plToDtx8LF9
 prQ7+9IbEJBUJi0Tu3onq4eShn2X60guPA9sTvHWsmUMo8jP0pVM5J4s6PPTXNfgAErc1X6+4bL
 +FjRYlWmjUnfXy1Jkk0nmVJNww+cUVKgKLA3kdkChM5UZoew3PEsIfh0A5CQIB27wqbbrPg3YTy
 UwtYqvxMrdPniv/1qDLPxOP0YThfVkxyzGFsYy4l7QmjGD9sgtY0M5T8q9jorbkPymPw0a23d6t
 jQg8IE1lGR5SgYfxejcHXgPcdecUXqP0Kmjew==
X-Received: by 2002:a17:90a:d007:b0:3ac:3588:b548 with SMTP id
 98e67ed59e1d1-3ac3588b5edmr4808888a91.13.1791960358294; 
 Tue, 13 Oct 2026 23:45:58 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f04e324sm3236371a91.2.2026.10.13.23.45.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 23:45:57 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 14 Oct 2026 14:44:39 +0800
Message-ID: <20261014064445.2835813-11-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xGskX-0004MQ-7f
Subject: [f2fs-dev] [PATCH v5 10/16] f2fs: support partial uptodate large
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, Pengfei Li <lipengfei28@xiaomi.com>,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-kernel@vger.kernel.org, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Buffered write can have write bytes smaller than folio
size for cases when folio minimum order is not zero.
This can left partially uptodate folio in page cache.
So we skip uptodate subpage read in read_data_large_folio.
Also mark hole subpage uptodate in uptodate bitmap.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 88 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 59346b61615b..b9f2054f514f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -148,6 +148,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 		struct folio *folio = fi.folio;
 		unsigned nr_pages = fi.length >> PAGE_SHIFT;
 		bool finished = true;
+		bool uptodate = bio->bi_status == BLK_STS_OK;
 
 		if (!folio_test_large(folio) &&
 		    f2fs_is_compressed_page(folio)) {
@@ -163,6 +164,9 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 				(struct f2fs_folio_state *)folio->private;
 
 			spin_lock_irqsave(&ffs->state_lock, flags);
+			if (bio->bi_status == BLK_STS_OK)
+				uptodate = __ffs_mark_subrange_uptodate(folio, ffs,
+						fi.offset, fi.length);
 			ffs->read_pages_pending -= nr_pages;
 			finished = !ffs->read_pages_pending;
 			spin_unlock_irqrestore(&ffs->state_lock, flags);
@@ -172,7 +176,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 			dec_cache_count(F2FS_F_SB(folio), F2FS_RD_DATA);
 
 		if (finished)
-			folio_end_read(folio, bio->bi_status == BLK_STS_OK);
+			folio_end_read(folio, uptodate);
 	}
 
 	if (ctx)
@@ -3095,6 +3099,70 @@ static bool find_next_valid_block(const struct folio *folio,
 	return false;
 }
 
+static unsigned int ffs_next_uptodate_subpage(struct f2fs_folio_state *ffs,
+			unsigned int start, unsigned int end)
+{
+	return find_next_bit(ffs->state, end + 1, start);
+}
+
+static unsigned int ffs_next_nonuptodate_subpage(struct f2fs_folio_state *ffs,
+			unsigned int start, unsigned int end)
+{
+	return find_next_zero_bit(ffs->state, end + 1, start);
+}
+
+static void f2fs_skip_fully_uptodate_front(struct folio *folio,
+			pgoff_t *index, pgoff_t *offset, unsigned int *nrpages,
+			unsigned int *max_nr_pages)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned int next, skipped;
+
+	if (!f2fs_folio_has_ffs(folio) || !*nrpages)
+		return;
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	next = ffs_next_nonuptodate_subpage(ffs, *offset,
+					    *offset + *nrpages - 1);
+	skipped = next - *offset;
+	if (!skipped)
+		return;
+
+	*index += skipped;
+	*offset += skipped;
+	*nrpages -= skipped;
+	*max_nr_pages -= skipped;
+}
+
+static void f2fs_truncate_read_extent(struct inode *inode, struct folio *folio,
+				      pgoff_t offset, block_t block_nr,
+				      unsigned int *len_blks)
+{
+	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
+	struct f2fs_folio_state *ffs;
+	unsigned int next, end;
+
+	if (!f2fs_folio_has_ffs(folio) || *len_blks <= 1)
+		return;
+
+	if (f2fs_is_multi_device(sbi)) {
+		int bidx = f2fs_target_device_index(sbi, block_nr);
+
+		*len_blks = min_t(unsigned int, *len_blks,
+				  FDEV(bidx).end_blk + 1 - block_nr);
+	}
+	*len_blks = min_t(unsigned int, *len_blks,
+			  (unsigned int)fscrypt_limit_io_blocks(inode,
+							folio->index + offset,
+							*len_blks));
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	end = offset + *len_blks - 1;
+	next = ffs_next_uptodate_subpage(ffs, offset + 1, end);
+	if (next <= end)
+		*len_blks = next - offset;
+}
+
 static int f2fs_read_data_large_folio(struct inode *inode,
 		struct fsverity_info *vi,
 		struct readahead_control *rac, struct folio *folio)
@@ -3139,6 +3207,11 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 
 		len_blks = 1;
 
+		f2fs_skip_fully_uptodate_front(folio, &index, &offset,
+					       &nrpages, &max_nr_pages);
+		if (!nrpages)
+			break;
+
 		/*
 		 * Map blocks using the previous result first.
 		 */
@@ -3171,6 +3244,8 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 			len_blks = min_t(unsigned int, nrpages, max_nr_pages);
 			len_blks = min_t(unsigned int, len_blks,
 					(unsigned int)(map.m_lblk + map.m_len - index));
+			f2fs_truncate_read_extent(inode, folio, offset,
+						  block_nr, &len_blks);
 
 			for (i = 0; i < len_blks; i++) {
 				if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
@@ -3189,6 +3264,17 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 				ret = -EIO;
 				goto err_out;
 			}
+			if (folio_test_large(folio)) {
+				ffs = f2fs_ffs_find_or_alloc(folio);
+				if (!ffs) {
+					ret = -ENOMEM;
+					goto err_out;
+				}
+				spin_lock_irq(&ffs->state_lock);
+				__ffs_mark_subrange_uptodate(folio, ffs,
+						page_offset, PAGE_SIZE);
+				spin_unlock_irq(&ffs->state_lock);
+			}
 			continue;
 		}
 
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
