Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C78606A325
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 03:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jEFJa+nC;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=T8SBFjUj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CBTSa2Hg;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Lk4QEv4f
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=uTljZ+yYxWNnqlIUnxvCtOxoC3ed2X2Nfo3Hk+41NcE=; b=jEFJa+nCTYZpnVBkNlPt5t8t7n
	MaIf4lOKFi7LOSWFo7W3lWiDadKgctalYUurNtbXzxphl2+DhZIXUwZ33w29exwfwxISVCV/+lzHF
	45xp45v6JcnCZf4nbIo6eMLMOw/CcKtu8d2URSOMzgN/1gwU/cq2tfg/6o9JTo4DMVxs=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLBXy-000000007LO-2sGS;
	Mon, 26 Oct 2026 03:38:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xLBXw-000000007LH-3qe9
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:38:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gRXMIt1xZlGHxLGBAD5XVRfeBcwnFPnW7+Pvj+Pw9YI=; b=T8SBFjUjxo41sv+uSmisayIuVN
 SGqC/C9UfMHg1O2QigwYBhdYMuAVwJrteYbVyp0U62rFxtOqhGP/5a02PCNB6GU1G8Z8Bia4YbtEs
 L56saLl5FMz7pqGfrO2tpGNNUaKBfE4NavLWztjvtLtEnBGloHuI3fLmx6B3pTZ3ceGQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=gRXMIt1xZlGHxLGBAD5XVRfeBcwnFPnW7+Pvj+Pw9YI=; b=CBTSa2HgLG6aPeyOzBXRg6D8WH
 qdu4GXcfwsw9qzrJYdHiNeQ1bGNhbm3ZNrHKfIqCPfzm5ZgQEVJIJzf5qMXmcAQ4nj9HqQSDQ1f9r
 5owqOo3bSmF8EwQmV8qcZzH7NX/C9MUfzeO6p38gs/sKJXX3+rUAVwvUS5d//uCTWaEU=;
Received: from mail-pj2-f9.google.com ([74.125.227.137])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLBXt-000000002b3-1vVJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:38:52 +0000
Received: by mail-pj2-f9.google.com with SMTP id
 d9443c01a7336-2e97ddaf3c4so11484305ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 20:38:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792985924; x=1793590724; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gRXMIt1xZlGHxLGBAD5XVRfeBcwnFPnW7+Pvj+Pw9YI=;
 b=Lk4QEv4fI06vvD0ESmZ3Ra6HcbiBwYecDIswxbrtEOX3McMJyTg80laxgDtWNMQu4Z
 So/Riu86rx4+37xVdUsRHJhLexkjyChgyNicONaBTmUbOEgGisMj7ZQz0LtKcs0G9Xj3
 tToycKH7xB7jKOm+rMdUkHpqBXBgI/WeRxvtJwO1UFSh4RcxZcgTEvbqd9WqYaFu5fWT
 UMLEVODWWmxlLRfoSu5EKQiwhgbuxvtKJSF2htt8MuOTsLK2f3gsi/Cy2OMFFJv7iQgD
 4C4Mvg47xliFBJ9JGwbVxG35ATrhPr+a7L8g61L+de01Y4WoVIs1SPMgA+X8pLsoSBLI
 L/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792985924; x=1793590724;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=gRXMIt1xZlGHxLGBAD5XVRfeBcwnFPnW7+Pvj+Pw9YI=;
 b=LjjBkIuNxuWH+mxBspGiM9wKimcH2YbeqlrEOqNlCSgsHcXNeE5i58aselXL/O4v1/
 JoDpqYx7TPx2vklng0p+q1Q226rYBR4fOMT3fUGIsulH2L/GqbeSdJCJLROrrDFNhImP
 sF1tdnGB7KkQKUjxF6FRf+i+QtJZlPVHumn5dyQ+iW0bj6BbrxY1za2GIaMV/nI2j7f6
 qw6u+DQ9d1SiTJ6+cUHqyM6CxpuNu3teL+hOW4qTf3v4WMQGBsN1mZpC7DMrG7+M14zY
 6cq/kLLoyxP4+xUpUy8dkxPTX8HFe9ebK+7MW/l3YTgymJr9qWvP+6r3nkqLZHu8G3Ee
 PoWw==
X-Gm-Message-State: AFq9FYJQTqglnm+dXuGTpzrDtuMiLDo4EEUrQH4UEoSUfmJ02Nr6Qef6
 2BQCqF5kY0yMA78rCeaz6uMl1ECATHLfkqVvqv555QswfZ7IKliF0mowkP4/ca6T
X-Gm-Gg: AYBFou2qLeVu0F0L0ElHsnC1nm0P89l2WvUeARsotjInGy5ON663Bdq98JpjknLVRo/
 y85+rjgKOCTiYu8efXV11+A03CkyK7iV0q3LxORdZvR+ExTSYwAQ0ei/Dh+l0PrPuy0DNVe+J2/
 Z/ECgZywtOqBoUBCQW2COL9HlV+tSvd5Vdj8V3vOdJTE6mdFxSJh+LxuRxF11YOr+CUQRvYbZej
 hmv3GRakmjAvlt+UDfh0h+EzIITuh/KFR8Uf9iUsIkE4TJj/9Q6TuJ9vnoruR8wVrsM4/x2cUBy
 jXhUb4zwzer9tsReqWIYRosWfqupgYe6+5L2uZfJwSb0VHqIpo8ildcGp2Y8FmftBkTkAnHsZK8
 O+8rwEiRKxbF5zputwnXBaOrdnGlVRyYFmNFokSjidcUUZC83eribxfJpSjbfhnsYLe6Ys/5Jre
 p7p2D/pb7xUYGxiauhfaQGRiqQUCNVCZPrvYDCegnH4eiPsc84ZAUl32r+q6kuXsFAAUlfJfAGk
 bOHNxijWJd6ENUUUmy85Sy+kEUlHODdto7JDjA1eVub90/Vpa97GS7hrf0uXLxtQtdI0pI1yD7N
 8BH47KffWyy7Stru+Q==
X-Received: by 2002:a17:90b:4a12:b0:3a4:fe48:d410 with SMTP id
 98e67ed59e1d1-3adeaae86a1mr5173447a91.30.1792985923731; 
 Sun, 25 Oct 2026 20:38:43 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebe8f0b2sm6409823a91.8.2026.10.25.20.38.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 20:38:43 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 11:37:41 +0800
Message-ID: <20261026033745.784107-12-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
References: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLBXt-000000002b3-1vVJ
Subject: [f2fs-dev] [PATCH v7 11/15] f2fs: handle partial truncate of large
 folio dirty subpages
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

A large folio can be partial truncated and stays in folio mapping, we
need to clear the subrange dirty bits and uptodate bits that the partial
truncate covers. If this partial truncate happens to clear the last
subrange dirty bits, then cancel the whole folio dirty state.

Also add a guard in f2fs_write_folio_dirty_range() so a large folio
subpage whose disk block was already truncated (NULL_ADDR) is skipped

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 89 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2dacc9211cc2..33750ebf31cb 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -404,7 +404,6 @@ static void f2fs_ffs_put_write_pending(struct folio *folio, unsigned int nr)
 	if (folio_test_writeback(folio))
 		folio_end_writeback(folio);
 }
-
 static void f2fs_write_end_bio(struct bio *bio)
 {
 	struct f2fs_sb_info *sbi = bio->bi_private;
@@ -2971,6 +2970,41 @@ static void f2fs_ffs_mark_subrange_uptodate(struct folio *folio, size_t offset,
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
+		folio_clear_uptodate(folio);
+	} else {
+		folio_clear_uptodate(folio);
+		folio_clear_f2fs_gcing(folio);
+	}
+}
+
 bool f2fs_ffs_test_blk_dirty(const struct folio *folio, pgoff_t index)
 {
 	struct f2fs_folio_state *ffs;
@@ -3751,7 +3785,7 @@ int f2fs_do_write_data_page(struct f2fs_io_info *fio)
 
 	/* This page is already truncated */
 	if (fio->old_blkaddr == NULL_ADDR) {
-		folio_clear_uptodate(folio);
+		f2fs_clear_truncated_page_state(folio, fio->folio_offset);
 		goto out_writepage;
 	}
 got_it:
@@ -3901,12 +3935,31 @@ static int f2fs_write_folio_dirty_range(struct folio *folio, int *submitted,
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
@@ -5455,10 +5508,41 @@ void f2fs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
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
