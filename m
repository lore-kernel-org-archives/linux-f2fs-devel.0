Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04323606A75D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 28 Oct 2026 15:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Pk+19G84;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=RsuU57r6;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ahct0baI;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=SPf74Z0p
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=kBzgBjigDbSDhlB+10SaRvjI2vFL2J1FTHcALikvbMk=; b=Pk+19G84LPV0BZJHNczqT/N9Pj
	7b5TKpuRDc4wHFwOtN0XU2Pq2I5M9aQMFYEE0bZM4Xt1K75O2H0B1h7NlmhMoclZQgLctMqoeNGFZ
	/Hm4S0t82BbLebYikz0sJVdtsvCOT+Giq2UTWRVlcVhCx8Jxcgp0ypMhCcMtrWe44XdE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xM5py-000000006qk-36nV;
	Wed, 28 Oct 2026 15:45:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xM5px-000000006qd-3AEG
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:45:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IfQzdJuUF11P/NB71UB6Mk1gbvRuSZ4EX8Cfo5SAjks=; b=RsuU57r6Dr3Cvrpxla2FfpdmoX
 GcPXnX4xAXKV6MLVD+5PPD1Fu42xxVFhlv/lAzPDd+SF77ZeAiWyNJ5i+dmQke5x8Fg0lhxCTuxQ8
 Q6BvQgUmIzK3h5ZHinHeWQcpEd88VvY+8Uxr27x7X1LLiSd0F30ba7dIA2oVuKywLa0A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IfQzdJuUF11P/NB71UB6Mk1gbvRuSZ4EX8Cfo5SAjks=; b=ahct0baIT4aE608KQx4zOlRGEX
 +xwm3ZE14twzKCxuWs1WpdTlfIVwYKLMoGrGvGp9xGbtMLyFCRufanCT79tLm8UrRIBF4fdkp2njx
 z3k+T6mMObMXveH9gLYHIIUz/Qres/MYKvN7Bq5LnHm/V9Y8tyngZk+7+jJwHWUiqP1s=;
Received: from mail-pj2-f3.google.com ([74.125.227.131])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xM5px-000000003aQ-0EuL
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 28 Oct 2026 15:45:13 +0000
Received: by mail-pj2-f3.google.com with SMTP id
 d9443c01a7336-2e831901331so8739135ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 28 Oct 2026 08:45:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793202307; x=1793807107; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IfQzdJuUF11P/NB71UB6Mk1gbvRuSZ4EX8Cfo5SAjks=;
 b=SPf74Z0pObs5FeaStFtoy4LjUJWTw/qGP/4wJA43eKsVULyMrCaf/MUPKMtG3vJcD9
 TbHsNUwuc2+kdhsTz5XITTxbuvMqz3buKtIXhmVShi6OJYkSv8FWVTzaNsgGZgN7bnXs
 vpplrAKuIyJqYcS5JfAKQH2rYHl2kESlpLVsineHYMneqYXh8L5pgI/QDpAyroe+7svw
 trzUllYBDUGGFM8q5qDz49l4HUcJjMmxPqCVcr+X4O5c0GuyrOdq04ktFCdvHHzn0Kgw
 pDngYoVAdIcqRoZ+0+SzqR9FTuGrWeFCyJ4IIGQuKpfRf/OozKwZLbEyIhaOHL3Zkc8S
 GwnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793202307; x=1793807107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=IfQzdJuUF11P/NB71UB6Mk1gbvRuSZ4EX8Cfo5SAjks=;
 b=KaaJmzViCyeC/PC86KMuP38YbJbKUhB7IUXaUZer9TrEVii6DtIr6QCcPxgJDDJZAe
 /ASQJPanfS3R5YvvV5DtoNp1/zYcuKmKHDg+JWwPEKwHF1yG0xHM08s3VAjiTcp+0M3Z
 gXRB9OtkolLKr5JeIVw+E+ExPisd4MdAtKrgWBEjfgpPcNMUL+03vGZcXWwm+yflh3Ce
 uld7EclDPVxDBkuP3c4vrkfn4fKyNx/TqWr5ZP9y/6Nxz7kyD9/JXEAOA2URlfFuAJz8
 0/1V+/UwHb+hVLiaH4q3X1RdwxXxgf/lUrjzJ0mdgTpLmyrhgUV5IORvOdbTn8IjiLwd
 U+vw==
X-Gm-Message-State: AFq9FYKEStvjXvONfSDKqURq08QX78FAUZwIg1OPa1uN03oTRUdRPweT
 YZjN1ud2GicocZS7VM19YhnMmzgnnKn1vlyH8/En91nrE/SQ1Ju+ZLen4zPd46MOIxI=
X-Gm-Gg: AYBFou1678/qjbcP4HrjWl8gDG8sa6Nj3cAdpKS45uWujW7jVbmyTWYVlOYTLtm8uNu
 4GLPwIhZAgHk3b2m3wOU/2vwBrX2/KQe4ael/jOQWOM3I0jIIyF+gbQtnGtm22u0cUtUlEOKPCM
 1GI6RYWHTda/JXKed74K/ppoimWl168v3itoYBLkI5Bg+fJpN0h7YSDPEBu5DB38fwzERHb7gMP
 5Q3FwgAGeiWaS4dGGufIYNlMVqGTnm1015Qr8XBG5fWid5bERCVAzA+RRcHAqsLUY9jnW9SKPya
 FaUqD5on+lIpqwvQEbFjD0hV30wGtmUHdrrCM6Ch0TuCvbbftEmOVHqUW3lqQDvxylxRfZsEV8k
 auVheh+WV/pMQ17QyXkuYN2Us0q6KlpaEIpZqNOfaTiySrOcESzt/4BRx+rDMYbTXVbvUA81l5V
 Fuae6oPgQ2Vph2QlhoH30HdACjAmwjUxyun/L46OONcl1hfU3TzL8bgw2yP1f5hurerIHTHc83+
 7LFnNtwASkPnvCX0zp/QuagLg6z/DQ5823TGdcSNZeijhfRYfH4meFjN+TRbnTRXh1eH/p2H6Lc
 xoeBHMf8eGOKdSDwWA5aRBin9r7b5M0hMosfpBOqACdhMaq3+cPkPI6A8H3jG2DJ6Ns=
X-Received: by 2002:a17:903:120f:b0:2ea:1b9b:b946 with SMTP id
 d9443c01a7336-2eb004888b6mr26038415ad.14.1793202307198; 
 Wed, 28 Oct 2026 08:45:07 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2eae6be5105sm24111655ad.37.2026.10.28.08.45.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 08:45:06 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 28 Oct 2026 23:44:01 +0800
Message-ID: <20261028154407.1601430-11-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xM5px-000000003aQ-0EuL
Subject: [f2fs-dev] [PATCH v8 10/15] f2fs: support partial uptodate large
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
index d2c9e9d2eb9c..d76038d82e16 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -154,6 +154,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 		struct f2fs_sb_info *sbi = F2FS_F_SB(folio);
 		unsigned nr_pages = fi.length >> PAGE_SHIFT;
 		bool finished = true;
+		bool uptodate = bio->bi_status == BLK_STS_OK;
 
 		if (!folio_test_large(folio) &&
 		    f2fs_is_compressed_page(folio)) {
@@ -169,6 +170,9 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 				(struct f2fs_folio_state *)folio->private;
 
 			spin_lock_irqsave(&ffs->state_lock, flags);
+			if (uptodate)
+				uptodate = __ffs_mark_subrange_uptodate(folio, ffs,
+						fi.offset, fi.length);
 			ffs->read_pages_pending -= nr_pages;
 			finished = !ffs->read_pages_pending;
 			spin_unlock_irqrestore(&ffs->state_lock, flags);
@@ -178,7 +182,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 			dec_cache_count(sbi, F2FS_RD_DATA);
 
 		if (finished)
-			folio_end_read(folio, bio->bi_status == BLK_STS_OK);
+			folio_end_read(folio, uptodate);
 	}
 
 	if (ctx)
@@ -3163,6 +3167,70 @@ static bool find_next_valid_block(const struct folio *folio,
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
@@ -3195,6 +3263,19 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
@@ -3207,6 +3288,11 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 
 		len_blks = 1;
 
+		f2fs_skip_fully_uptodate_front(folio, &index, &offset,
+					       &nrpages, &max_nr_pages);
+		if (!nrpages)
+			break;
+
 		/*
 		 * Map blocks using the previous result first.
 		 */
@@ -3239,6 +3325,8 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 			len_blks = min_t(unsigned int, nrpages, max_nr_pages);
 			len_blks = min_t(unsigned int, len_blks,
 					(unsigned int)(map.m_lblk + map.m_len - index));
+			f2fs_truncate_read_extent(inode, folio, offset,
+						  block_nr, &len_blks);
 
 			for (i = 0; i < len_blks; i++) {
 				if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
@@ -3257,6 +3345,12 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
 
@@ -3264,12 +3358,6 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
