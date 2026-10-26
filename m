Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 167D0606A323
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 03:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=X8kWx6xx;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kTGUd65C;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=azQsITX/;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mD4yd3Qr
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=zkG4+cdQ0b4GQY/QtxHFXMwDDdZ7/oLu/W6D7sRn6z0=; b=X8kWx6xxDElpOhT66xEPLWkV0K
	3zGLYFsFMzW8gEti9hEvM2XSCzWFDH4BQerMRnyMeMuAcGPUDrNvPc3jY0uIwR7Mcqqd/cCPVt9yv
	zMe2qE1UP6Gc1rIvcNf0RzCMAgOh7/kFtiACnyqpzOkZR7ff7k7ut9FlpvaixDQd4f8s=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLBY2-000000007MU-3QGM;
	Mon, 26 Oct 2026 03:38:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xLBY1-000000007MK-1qcz
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:38:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=diDzf0qPFinEe80dBTEZm6MKAA9079p+WnYDEu9PBSI=; b=kTGUd65C0ELuzFYGPH8T8uZQA+
 GjxrTfxptIC0t3h26koW+HFglaxYSp36hb5qUIzU6q1zahWesrR3tUDjHgTkhifi9nr8Z3YSNmKSK
 iDsHvkwZEH7F3I3vfsrqT1bh/hYIx/gV6HLYBkhH8vSr6DiG96o+1A43jnEsSLAJ8gF8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=diDzf0qPFinEe80dBTEZm6MKAA9079p+WnYDEu9PBSI=; b=azQsITX/xxOLU3lCpqQjTT3TbQ
 KMgmMNzsGzYhz5yTng4/FQ5i1R8w8suRaKO4PbxMD367gt3TLQBLaUmR9KA9IAlQlx65TmG/63cpf
 UfT0azNc8VdJucMhajBCCZrYKd2VR3kOxT3LA8qftQ4QgagGgyMSoPtaeX5aDrRioiKs=;
Received: from mail-pj2-f11.google.com ([74.125.227.139])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLBXo-000000000fl-38fE
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:38:57 +0000
Received: by mail-pj2-f11.google.com with SMTP id
 d9443c01a7336-2ea993271f2so7396995ad.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 20:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792985919; x=1793590719; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=diDzf0qPFinEe80dBTEZm6MKAA9079p+WnYDEu9PBSI=;
 b=mD4yd3Qr/bFq6l8zwjGdSbtvJh1XajIp/qO9cTbumWqMBddXaaASe4ARRnQsgqejcY
 2PCpbfcBwWL2bibLRJveCZhKC3xjKIvs3ro22UN6q9yR0KW/gV/3JqUip/FULwpwfYxY
 w+xdk7nLs5H/nITScz97PUYf3K9at2wfCc5QHB+0Jpv4VXCuyPbk15fBf/etd1DoWxrd
 xLKSQPRvMi38sN9ZznRhC59VRvUdtRm5f0IsfzY7oiYK3xh0o3qfkIdiiMXvIPjm2gYG
 9pcM2wv3NqaPJKFzJGy0OkLZF896F2+pDOkvU/eDPqCt+K9M/P7traE5lTPLHvIHHyb7
 LfsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792985919; x=1793590719;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=diDzf0qPFinEe80dBTEZm6MKAA9079p+WnYDEu9PBSI=;
 b=0eIUhjlbwTk3tcYEr3wbRGWe1Lsm+Dw+upfOSxKx9XpDbRlkn52otUGhyiz4hHESS4
 PsdTvnT6Q519BMZlKrDKCLJrm+sTuBUZxCnitJYVLsznGq7vHD+fuJaf4CdjwL86urZG
 PTISeqHajvLDkdpuqa8JPPnnSkJKPNOVO+cH7MDUfdtfxsca6eIpR21fnZjiDe/1sQyD
 RIjboMaB3+iG1wTrp7WME2tH/QXCuUSSLieCej4coXYFK5mONBTf4+qhW9c4+4hS77VK
 WUIOhvbTmnbkyYF5seUPku9aFGRGRQNRmP8Rn5i5dAiQtBarPAy6bmIPqwz1gkyU9Zpy
 CHSg==
X-Gm-Message-State: AFq9FYLg3DDC0E895LhDDxyJhxhcE5ZdBeL90DN9QxhRA8/9iFRpRWzK
 hXSorqIcemVOBAp4m47LaFWHG0rU3UpBimyNJmLgj0sYssEThFBCTkR0KH/9vO0dHucQHw==
X-Gm-Gg: AYBFou1fb9e/Njb8IfwpGTc7099kQnILS2B5Lqv800e4ID/sNZinxCi9TpOjOpj7QI1
 ZbsAlrJQAxaIMMvYCWK7fRD+HU5/0UhTTuJVjbTlepH5Gf0WcXUq06tE6nIguHXVV1r+s6ZKwaw
 sHsSdaCHMAzHWH61cXZRGCymppb6rZVh5K+v7Z4G0dWDmQcfcg9zAAPnjl37ZbBDL2Z03qSMYBV
 HdkA/MMjFFzSmaNI294LN4zqyiEy9FnOl0sQXvAWtJva3UkrHxrRlufnnaAWhGXwtjO3cqOapym
 BrGYvQg21k4gKds3BMabI5+Kw0s+dcS5Y9FN+1PibA0kXQGz1ZhBhYTxDj5F8yGRyMRsod5DilM
 yhGrJ7J5teFZMkYGjHDct11AMhdejKkFPixLk0Zja4V1XeTAXeNGu/OV8Jmj/VTxzSl9407MpLF
 qqPgEDY4NAXtqxGHeh0nQWo39r9hczYQLJy+Hk4APQVWkv0dMcxB6tNBSKUU51/xEpKKeCiPVal
 Anhw1RHd7w87oIFVdJyHdaBiz1oG3CQQHYzunyLi7QZ7lChJkk/Jk2NcOpP6DJ8VNY6vT/k9xxB
 EIoc/UNYmfW2BoBYYoq3n+OXFNgG+unFk1VeCrsXYxh95CFJEjj42l8w9RFJPisBnDRl
X-Received: by 2002:a17:90b:2f4c:b0:3a8:6045:5a24 with SMTP id
 98e67ed59e1d1-3adeb0fa979mr5362979a91.38.1792985919082; 
 Sun, 25 Oct 2026 20:38:39 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebe8f0b2sm6409823a91.8.2026.10.25.20.38.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 20:38:38 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 11:37:40 +0800
Message-ID: <20261026033745.784107-11-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
References: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLBXo-000000000fl-38fE
Subject: [f2fs-dev] [PATCH v7 10/15] f2fs: support partial uptodate large
 folio read
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

Buffered write can have write bytes smaller than folio
size for cases when folio minimum order is not zero.
This can left partially uptodate folio in page cache.
So we skip uptodate subpage read in read_data_large_folio.
Also mark hole subpage uptodate in uptodate bitmap.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 102 +++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 95 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b805dbe2c187..2dacc9211cc2 100644
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
+			if (uptodate)
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
@@ -3157,6 +3161,70 @@ static bool find_next_valid_block(const struct folio *folio,
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
@@ -3189,6 +3257,19 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	f2fs_update_read_folio_count(F2FS_I_SB(inode), folio);
 
 	folio_in_bio = false;
+	ffs = NULL;
+	if (folio_test_large(folio)) {
+		/*
+		 * Allocate the folio state before doing anything with the
+		 * folio, so that the block mapping helpers below can rely on
+		 * it, and fail early if memory is not available.
+		 */
+		ffs = f2fs_ffs_find_or_alloc(folio);
+		if (!ffs) {
+			ret = -ENOMEM;
+			goto err_out;
+		}
+	}
 	index = folio->index;
 	offset = 0;
 	nrpages = folio_nr_pages(folio);
@@ -3201,6 +3282,11 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 
 		len_blks = 1;
 
+		f2fs_skip_fully_uptodate_front(folio, &index, &offset,
+					       &nrpages, &max_nr_pages);
+		if (!nrpages)
+			break;
+
 		/*
 		 * Map blocks using the previous result first.
 		 */
@@ -3233,6 +3319,8 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 			len_blks = min_t(unsigned int, nrpages, max_nr_pages);
 			len_blks = min_t(unsigned int, len_blks,
 					(unsigned int)(map.m_lblk + map.m_len - index));
+			f2fs_truncate_read_extent(inode, folio, offset,
+						  block_nr, &len_blks);
 
 			for (i = 0; i < len_blks; i++) {
 				if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
@@ -3251,6 +3339,12 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 				ret = -EIO;
 				goto err_out;
 			}
+			if (folio_test_large(folio)) {
+				spin_lock_irq(&ffs->state_lock);
+				__ffs_mark_subrange_uptodate(folio, ffs,
+						page_offset, PAGE_SIZE);
+				spin_unlock_irq(&ffs->state_lock);
+			}
 			continue;
 		}
 
@@ -3258,12 +3352,6 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 		 * to prevent from premature folio_end_read() call on folio
 		 */
 		if (folio_test_large(folio)) {
-			ffs = f2fs_ffs_find_or_alloc(folio);
-			if (!ffs) {
-				ret = -ENOMEM;
-				goto err_out;
-			}
-
 			/* set the bitmap to wait */
 			f2fs_update_read_folio_pending(folio, len_blks);
 		}
-- 
2.43.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
