Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C295606A31F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HM90Qi6Q;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=A2qfQ15Y;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NXYCsUkV;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kgF7xGZE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=eUJL/6nNbXbTgUtntHZaZaDXL2H93NQoYYIHVLNRr7M=; b=HM90Qi6Qgr+DuKZAU4+FP458Pm
	H1/W/49uyR6NkSoZTvjdgyrVV0JrhYHWABKGBEjfisylyljcWM62az6/KLzEXjNiAeFsRlLEqNbpl
	7nU7kJsl5DAvRwJlrQpYB+W4EtTyWUceJv0vSJ0qlchFipJuSljC8ANiwAPvRijc3DVQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJndJ-000000006zL-1Td2;
	Thu, 22 Oct 2026 07:54:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xJndG-000000006yS-3E1y
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EAwiE2TbtfpvHJ17XLmEC1Ibh6fiFrr0dXc3eg/92Ts=; b=A2qfQ15Yb/qWiDfFLACxxTXdV6
 /wZJNaKmvoYrxVNgX0KhhLwULt8t4bZWVzBSih3rqzC5sI+/MSM2hRBOLsKqoWlGsfUuh8P0LHd/f
 Zoqn8bseZbBKqWchW7GWPrzAr9C8nsbCkpeTHUNamjeZzF9LL+khxUaZWhf+e9xdJuyg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EAwiE2TbtfpvHJ17XLmEC1Ibh6fiFrr0dXc3eg/92Ts=; b=NXYCsUkVamoaRzf3rNY+KnPxr6
 /8algahnMcKuEDOpt10qSGo8YuMgwdBRRrwvinnbJpE6DarT4YHF+e28EB3L7nVNJJt2uy0Vt7wtf
 GSoTo1YXSxkEojYyOVaAxgijSl6OkKQ21Jkw26RZWFjsYsFa8W8MjsVavix+bfn0QbtQ=;
Received: from mail-pj2-f8.google.com ([74.125.227.136])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJndG-000000007p3-0JRq
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:38 +0000
Received: by mail-pj2-f8.google.com with SMTP id
 98e67ed59e1d1-3ac803d3bafso197558a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 00:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792655672; x=1793260472; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EAwiE2TbtfpvHJ17XLmEC1Ibh6fiFrr0dXc3eg/92Ts=;
 b=kgF7xGZETLaPoGaHFqmbZLLNsE6rXICdO7CtmoWL2a1FcI+PB2B/yh/VprpcxQCDDm
 rw39lygLmeswzChJJUKB+3exWtA4ENAnd3yOJtqoNaLUxRcX/RFURsTNaMuohjSFgwnN
 76w34ng0iMkv0JvDgeONd9f6PSMN70aJvI/r2LwrKIQBDXvW7MYDN6JnL96BGaUmdhKJ
 PdxaFfWToyRZcinCfUuGAJtb022OcZc73UXoh6RicK/0ylaaZteGhM3j57L02qlwtzXf
 fJpGjxQFr9ojgEkvte35RbH03dUtLoCweFhg8TfStQmh74iCbA3YUVJ8IThiYQkRRTMo
 K9Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655672; x=1793260472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=EAwiE2TbtfpvHJ17XLmEC1Ibh6fiFrr0dXc3eg/92Ts=;
 b=o4QsRO4f1jNcg+2aJO/r2H4Wwus+Trbe0ecnre5vyiWzFCf2oXcvhY8wDlmjNc6zg6
 +14uvRoGCP2I6QcPKRT/KA6SdrPT08HvnuIY20nuaACXHwkDmN8720+0UtCr59eSF7Ai
 xfy2MW/yabxRXoggQ6pgv2ikzP8TCGcrQv6e+S48+RE3jTwiIEg4Zjvoq20IDqqrIHnJ
 YQX00HqUlLPy7yWsBGCZTECfaZswRSqauEdxsmB9dLCFX880ce05GxbfHcH92Xk16mJj
 G0mLGwGUSZnMPU7tHGyEraODFeK49ssfhfdkc5gtxWm+4FRiRfUEEx3BkYOX8A0pK03q
 GbBA==
X-Gm-Message-State: AFq9FYJaQUndHjQSWYDRI6BxcgmzFXCc3VoFi92SZHjWBXunFuRvJty/
 rJgq+gjp9beVzuIkupSs/ULMIJBUM0P3Pz/wdvlzPp9OgwuIBskwTw3u+efFYYCJ
X-Gm-Gg: AYBFou3LvGgHNcBmm583sgtpD3hUCsGs6+/9KEGH4bVKbYDRm0c1AwalDtvtKNmic26
 bK5p7dOEfHA/jscgywHg0Vh7rYLxtIcdam2LOhM+AciyiLC1xwEzEPJzXga9n9mcWjRPNHvJqo/
 wEPM4LwwaRWSqz4GkhuvbgsdfvZxCXmJdS6appxQJV8ND+NooRl1USdBVA+IBTQPtEVDC4bmLZM
 AggjFZskuGb6pGrMJxOtCvhS36h1VI87r8YSQ0bmCAqAMnhjrBLcke17ym9FAzgp0mC63XsMb/L
 cCN6n3xunNakE0GksMHkVEC4k0ZoIfOlFt4/uWiIG8IrNU5Vi6wOi4Wxf9y8SznQPSBa/z/Jirv
 lpljuJAt14sDK4zmcFYBmcr1Ho+vLpIl2J0Sjql3YT4B1op8lQJZsPW6NtL2AgTNuPMhss/ioLO
 e06nbGubQnI8H+rKagj+HidV6rxJNiJAO5s6t9VrV+3ouHk5AU/M5goasTmNikNaNzgFzMmrXYf
 gO0GvnlQ+8bWJVODWP4aJT5G2nRvkGwiUDtbVwz8V+BJJhobmNeCB5hOQz62X2/SiaygNU03i0y
 P2VyGuPCdR0v9vF0EA==
X-Received: by 2002:a17:90b:2c85:b0:3a0:d82b:237b with SMTP id
 98e67ed59e1d1-3ada6c8df7amr920112a91.25.1792655672357; 
 Thu, 22 Oct 2026 00:54:32 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada4896c71sm3202562a91.6.2026.10.22.00.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:54:31 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Thu, 22 Oct 2026 15:53:37 +0800
Message-ID: <20261022075343.3043003-11-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
References: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJndG-000000007p3-0JRq
Subject: [f2fs-dev] [PATCH v6 10/15] f2fs: support partial uptodate large
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
index bc1bffbb15ca..e718ed01fe7c 100644
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
@@ -3141,6 +3145,70 @@ static bool find_next_valid_block(const struct folio *folio,
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
@@ -3173,6 +3241,19 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
@@ -3185,6 +3266,11 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 
 		len_blks = 1;
 
+		f2fs_skip_fully_uptodate_front(folio, &index, &offset,
+					       &nrpages, &max_nr_pages);
+		if (!nrpages)
+			break;
+
 		/*
 		 * Map blocks using the previous result first.
 		 */
@@ -3217,6 +3303,8 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 			len_blks = min_t(unsigned int, nrpages, max_nr_pages);
 			len_blks = min_t(unsigned int, len_blks,
 					(unsigned int)(map.m_lblk + map.m_len - index));
+			f2fs_truncate_read_extent(inode, folio, offset,
+						  block_nr, &len_blks);
 
 			for (i = 0; i < len_blks; i++) {
 				if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode),
@@ -3235,6 +3323,12 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
 
@@ -3242,12 +3336,6 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
