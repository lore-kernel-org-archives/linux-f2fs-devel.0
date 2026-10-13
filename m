Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B99FCC6B03
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:57:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ur2/4J5vZ1i827CsrETwtYCJz4Wnl11EnHPytn4CeTU=; b=b459DWFErfnDfANapwBw4NpgHC
	VhdrfXMkFN4sNMBOXhmUOPSRxDJSrgRUbU9uEg0HfJk8gRxTfF1UeLvXBcS+EB/3ddRICTBAm/0y9
	+2vg1ioRlqcL0vsszxtXVbwqKW3Tl4SpZP9zhpHs9nAKrmxiYZfxFSwV4wrCyhy6dzPc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGb8V-0002H4-7X;
	Tue, 13 Oct 2026 11:57:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGb8U-0002Gq-7X
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:57:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=PCytcjZSgMUY384rNP4MPOBmVD1ndl+qrXFK7w2nFwg=; b=SMgRLCwI26DCvnbPtT9pjNzp42
 dw2xWixUFSzRvJYalkEcpA5YBSGRS3l6/zyplV9WX8FGoRaTL+yf1YQvZNTHPpTdojNkAYq3aLAFk
 0KIfBDNgDognI7GHb5aCW+RA8TzILQRf5PSyIYibruSvBTxcsQoGhWR4wHZ9KPP1qwBI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=PCytcjZSgMUY384rNP4MPOBmVD1ndl+qrXFK7w2nFwg=; b=YgZdUcwRAn5Hs/bbR0RxDcKwd8
 w6LCEUCnm/zUm1r6dzCByyf8vOdE0DoGsTLtqHvjpb2PN5HOzko91fD8Wc+0S1djzPOGYL77Fr0e3
 86TZ5gFnhJs3vQWKn2yg2e7aXt+0+Fq0qn4m5TadfT//fnaUEBjvMeb0RLbIOGh7ZcOg=;
Received: from mail-pj2-f6.google.com ([74.125.227.134])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGb8S-0005S2-LS for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:57:38 +0000
Received: by mail-pj2-f6.google.com with SMTP id
 98e67ed59e1d1-3964e7720afso1376569a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 04:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791892651; x=1792497451; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PCytcjZSgMUY384rNP4MPOBmVD1ndl+qrXFK7w2nFwg=;
 b=oi91l4Yp1kav3V1h5W0UR3JkkaoVlZ0mXC9OcsWMiuWXe8HJ3p3ohL5vbOdqMoxIeD
 wPz87HOZ2xIllYSzOcN7Pjs2E5MwhRqiIT+1wo4zAG2lWnig7YpH08P1oUcv19UNmhBE
 gfZKaF2H3vRM3+I2eIYsDABHyFKu8SSCIg4/ZUG/dG1ocYhwYgCUrfpdqB/K13tAFJFw
 ARZSWkzjYDg+keP6wzN3VZp/4xV9aG34a0ielvnsTpgoQvBVq1mfJvx+l2sKp9iqs1rN
 qqoBRyCeBpHE7VlZJyCar4QdG5o8HQTo4ErDYdOZ/1OeYbzFad8w3EJ27Ux2g3GU20Jn
 h6nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892651; x=1792497451;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PCytcjZSgMUY384rNP4MPOBmVD1ndl+qrXFK7w2nFwg=;
 b=R691kLmzoF5ktVm0Fg2NHDphdzq6DLSZSt+uPL8he9AjeJYFVse/vZvSpW9VHTD/ET
 OuN+HaO+nkrIhjh88jopyIDys8C5elx6Mj6csTxDUXAKv6WqqNoiRlETJT1gxTavIAIo
 YC1YJFXYYeujiUbOri1TKY2l3WAIHh+SX7eMf6D1nz20/VuXPZlNf0SRt+AldzTJjySq
 PC6SeB/xs90SWSkBJRFJ9aZrvHlCmb0GH5U6EOdQRxv5AcUd2sRXUf+xnr4wq7tDB71m
 Wsyk+LPJxOkEFWHgAe+bBI8aI/8PLyHd/g2caY0EeJlBtTYFCbfilEQw1hAGv1xyJt6m
 p01w==
X-Gm-Message-State: AFq9FYLYXsgNNNd2hunQIGjG8Y5PfaY1lmQxc5/LgBDad8pxIMgEP4h2
 0ohv7nrugty/Rt1Ll7Z5TqBjV9LupNqGQZOyYHkdHy4ZAubPL1IvpRS8Gk0P9Bvu4bA=
X-Gm-Gg: AYBFou0Hek0JiWe9F7m89DKo/+dXHe62xHqbvk7iH9ZBFbZjtRr7+f7eXUkbLascQUL
 36vMrUrnwEY5Y+aPn/LZWp0UOaAhSSzV4+lhIFYRUuHwnRgYWVitRMdYrYeh29lAlnoZh9Sam/S
 9E1SVZOrS2M4C5LpgiVv+L2MkN9JkpbVXmxT5fnDNw0y7w7kw4kLrc9SUGWBMbSgIXOvI5Zb3V9
 DklRyDTQXjI63s0grjjWGSPmWw1Mb0kihKBgRPNDVDhsD1s/tvA9UaRvmLEiGC2EJOerh+bkZqC
 zE/+scYunwxUJ7rIqOY1hs0iXetSRL2+pBD0eG+yDU/YjXW8q1SEMmfxlRDBF6N3uGHbIqv6L2E
 E6qoz3E0o23V4DetTYRE+Autx8w9MydNR6ua7upJEv8e6i4Kr2bhDzjYJZHYSglwAk1acYN8ShO
 xuobkl7RcALhusj02WcYuSH1/o405zT5uKGJmuIv/GBvofNDMcvMHgridcvOUTvOLS0ouolh4Hc
 U2/xvfvkWwU8Tzbxy1u02L+b88kbhuiLEKx
X-Received: by 2002:a17:90b:2886:b0:39e:6c6a:6577 with SMTP id
 98e67ed59e1d1-3ab3a966524mr10308058a91.58.1791892650937; 
 Tue, 13 Oct 2026 04:57:30 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37139b59sm21248516a91.13.2026.10.13.04.57.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:57:30 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Tue, 13 Oct 2026 19:56:16 +0800
Message-ID: <20261013115621.968742-14-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
References: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1xGb8S-0005S2-LS
Subject: [f2fs-dev] [PATCH v4 13/18] f2fs: handle partial truncate of large
 folio dirty subpages
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

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

A large folio can be partial truncated and stays in folio mapping, we
need to clear the subrange dirty bits and uptodate bits that the partial
truncate covers. If this partial truncate happens to clear the last
subrange dirty bits, then cancel the whole folio dirty state.

Also add a guard in f2fs_write_folio_dirty_range() so a large folio
subpage whose disk block was already truncated (NULL_ADDR) is skipped

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 128 ++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 122 insertions(+), 6 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 0c4c41871..61fe4a0c5 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -328,6 +328,27 @@ static void f2fs_read_end_io(struct bio *bio)
 	f2fs_verify_and_finish_bio(bio, intask);
 }
 
+static bool f2fs_ffs_has_dirty_subpage(struct folio *folio)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned long flags;
+	unsigned int nr_subpages;
+	bool dirty;
+
+	if (!f2fs_folio_has_ffs(folio))
+		return false;
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	nr_subpages = folio_nr_pages(folio);
+
+	spin_lock_irqsave(&ffs->state_lock, flags);
+	dirty = find_next_bit(ffs->state, 2 * nr_subpages,
+				nr_subpages) < 2 * nr_subpages;
+	spin_unlock_irqrestore(&ffs->state_lock, flags);
+
+	return dirty;
+}
+
 static void f2fs_write_end_bio(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = bio->bi_private;
@@ -379,7 +400,8 @@ static void f2fs_write_end_bio(struct bio *bio)
 			wake_up(&sbi->cp_wait);
 
 		if (finished) {
-			folio_clear_f2fs_gcing(folio);
+			if (!f2fs_ffs_has_dirty_subpage(folio))
+				folio_clear_f2fs_gcing(folio);
 			folio_end_writeback(folio);
 		}
 	}
@@ -2923,6 +2945,40 @@ static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
 		folio_mark_uptodate(folio);
 }
 
+static void ffs_clear_subrange_uptodate(struct folio *folio,
+					size_t offset, size_t len)
+{
+	struct f2fs_folio_state *ffs;
+	unsigned int nr_subpages, start, end;
+	unsigned long flags;
+
+	f2fs_bug_on(F2FS_F_SB(folio), offset + len > folio_size(folio));
+
+	if (!f2fs_folio_has_ffs(folio))
+		return;
+
+	ffs = (struct f2fs_folio_state *)folio->private;
+	nr_subpages = folio_nr_pages(folio);
+	start = offset >> PAGE_SHIFT;
+	end = (offset + len + PAGE_SIZE - 1) >> PAGE_SHIFT;
+	end = min(end, nr_subpages);
+
+	spin_lock_irqsave(&ffs->state_lock, flags);
+	bitmap_clear(ffs->state, start, end - start);
+	spin_unlock_irqrestore(&ffs->state_lock, flags);
+}
+
+static void f2fs_clear_truncated_page_state(struct folio *folio, pgoff_t i)
+{
+	if (f2fs_folio_has_ffs(folio)) {
+		ffs_clear_subrange_uptodate(folio,
+				(loff_t)i << PAGE_SHIFT, PAGE_SIZE);
+	} else {
+		folio_clear_uptodate(folio);
+		folio_clear_f2fs_gcing(folio);
+	}
+}
+
 bool f2fs_ffs_test_blk_dirty(const struct folio *folio, pgoff_t index)
 {
 	struct f2fs_folio_state *ffs;
@@ -3807,12 +3863,31 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
 		}
 
 		err = f2fs_get_dnode_of_data(&dn, data_idx, LOOKUP_NODE);
-		if (err)
+		/*
+		 * If a subpage of folio for a cow file is dirtied but not
+		 * reserve a cow block, fallback to original inode to lookup
+		 * block address
+		 */
+		if (atomic_commit && (err == -ENOENT ||
+		    (!err && dn.data_blkaddr == NULL_ADDR))) {
+			f2fs_put_dnode(&dn);
+			set_new_dnode(&dn, inode, NULL, NULL, 0);
+			err = f2fs_get_dnode_of_data(&dn, data_idx,
+						     LOOKUP_NODE);
+		}
+		if (err && err != -ENOENT)
 			goto block_done;
 		dn_held = true;
 
 		fio.old_blkaddr = dn.data_blkaddr;
 
+		/* This page is already truncated */
+		if (err == -ENOENT || fio.old_blkaddr == NULL_ADDR) {
+			f2fs_clear_truncated_page_state(folio, i);
+			err = 0;
+			goto block_done;
+		}
+
 got_it:
 		if (__is_valid_data_blkaddr(fio.old_blkaddr) &&
 		    !f2fs_is_valid_blkaddr(sbi, fio.old_blkaddr,
@@ -4360,6 +4435,7 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		bool verity_in_progress;
 		int folio_submitted = 0;
 		bool bias_added = false;
+		bool dirty;
 
 		submitted = 0;
 		retry = false;
@@ -4481,8 +4557,9 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		 * partially written back), the folio must stay dirty so that
 		 * the remaining subranges are written back later.
 		 */
-		if (f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
-					(err ? pos : end_pos) - folio_pos(folio)))
+		dirty = f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
+					(err ? pos : end_pos) - folio_pos(folio));
+		if (dirty)
 			folio_redirty_for_writepage(wbc, folio);
 		else if (!f2fs_folio_has_ffs(folio))
 			inode_dec_dirty_block(inode);
@@ -4493,6 +4570,14 @@ static int f2fs_write_cache_folios(struct address_space *mapping,
 		 */
 		if (bias_added &&
 		    atomic_dec_and_test(&ffs->write_pages_pending)) {
+			/*
+			 * For a large folio we clear PAGE_PRIVATE_GCING only
+			 * when the last dirty bit is cleared, otherwise the
+			 * remaining subpages are no longer written back as
+			 * checkpoint-guaranteed data (f2fs_is_cp_guaranteed()).
+			 */
+			if (!dirty)
+				folio_clear_f2fs_gcing(folio);
 			folio_end_writeback(folio);
 		} else if (!folio_submitted && folio_test_writeback(folio)) {
 			/*
@@ -5310,10 +5395,41 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 
 	if (inode->i_ino >= F2FS_ROOT_INO(sbi) &&
-				(offset || length != folio_size(folio)))
+				(offset || length != folio_size(folio))) {
+		size_t clear_start = round_up(offset, PAGE_SIZE);
+		size_t clear_end = round_down(offset + length, PAGE_SIZE);
+		size_t clear_length;
+		bool dirty;
+
+		/*
+		 * If the truncated range falls within a single subpage, no
+		 * subpage state needs to be cleared.
+		 */
+		if (clear_start >= clear_end || !f2fs_folio_has_ffs(folio))
+			return;
+
+		clear_length = clear_end - clear_start;
+		dirty = f2fs_ffs_clear_subrange_dirty_and_test(folio,
+						clear_start, clear_length);
+		ffs_clear_subrange_uptodate(folio, clear_start, clear_length);
+		folio_clear_uptodate(folio);
+
+		/*
+		 * If the truncated subrange happens to clear the remaining
+		 * dirty bitmap of the whole folio, cancel the folio-level
+		 * dirty state.
+		 */
+		if (!dirty && folio_test_dirty(folio))
+			folio_cancel_dirty(folio);
+		if (!dirty && !folio_test_writeback(folio))
+			folio_clear_f2fs_gcing(folio);
 		return;
+	}
 
-	if (folio_test_dirty(folio)) {
+	if (f2fs_folio_has_ffs(folio)) {
+		f2fs_ffs_clear_subrange_dirty_and_test(folio, 0,
+							folio_size(folio));
+	} else if (folio_test_dirty(folio)) {
 		inode_dec_dirty_block(inode);
 		f2fs_remove_dirty_inode(inode);
 	}
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
