Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23DB606A32C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 22 Oct 2026 07:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jUuyQFfI;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MY0FvkGH;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=G/8LaC5P;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=T4tJwKEe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=Iw+fep3ZEf938ilTIB4BU2jfIWVcxk5EqIIcwE09SVA=; b=jUuyQFfIu6+4/oYNZ6wLAn0id5
	22Ncri8A4EFVPfmwePRY4tCxYZ32bT6TifvWT4Vv2/brnD23Sp7/s5XaVGc60zitcmH/i2yNpnV1R
	GEb2ibziF7zS76jkNVjUG7q/nAUknzuYBvbK5VUKkZ47UOC+vTxAu7tsdgr5Nj3ZfHJ4=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xJndH-000000000mD-1bU1;
	Thu, 22 Oct 2026 07:54:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xJndG-000000000jR-0TsB
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tc/c8341kdGrljrmpl+zI2/ClvSJfK/p7gQKezk4jH4=; b=MY0FvkGHr7kE93kSDEXgCMDwZz
 D6RrKKqTIhazEicPlrGh8/BJMR+dwIYSFDREbpTMFEvqJWh/FPgIrLumsvKSOuduOKXbtxKcvP48L
 FSL3CWuSoBIV2ORbUyY/IkDVdBWxYV7rhr2jqDzkOVX0mjUjIejDgQ6RWOc9k2eMvygk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tc/c8341kdGrljrmpl+zI2/ClvSJfK/p7gQKezk4jH4=; b=G/8LaC5PPBTHexfh1pYruyxKC4
 ANerShWwrU+TvBlb+n2lH2xZaNO2AsVxklJaqLhL9Nq7+ofaSPRsep9t0hTnf86UXq6pO2kjsvZ4i
 kYIt3PfuSOEtWVqG+erYYwMw5KZVqQRA0K0GStSzxbnLJvDq6yUooeJbOYL4uwKIA4zw=;
Received: from mail-pj2-f6.google.com ([74.125.227.134])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xJndB-0000000050k-3OSK
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 22 Oct 2026 07:54:35 +0000
Received: by mail-pj2-f6.google.com with SMTP id
 98e67ed59e1d1-3acc610014eso914745a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 22 Oct 2026 00:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792655668; x=1793260468; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tc/c8341kdGrljrmpl+zI2/ClvSJfK/p7gQKezk4jH4=;
 b=T4tJwKEeTO8zT6PMZ7yfr3chHOVvoa/mSs2UWSW09D85NW7hOi3nRjbLxJ6iKTlYXb
 swA9Jv/PWNNMqRNpyg9D/t8OMRakWpmf22YBp8QMcy9EKuCqxgM4LLpUKqRa9cJtNu38
 WscPYkL6dQlrLov6s7E3leKqMGHrNzWAfN38Ixf/HYR5p0ijLszDYQNHk9DFa0L3PNAZ
 q2bUEHUTtE3pTMy9GDvWedSFqKebuG/6jTlQFL8R/PwDLfzHvZrfpY2uSsSoM8cjyXIP
 Y1LEkRAk1D3ni01JNJEPD2J8vDYLSA3f8GPlpGglqUxKEMFhzzlkoZIPmsEbcVlkVOm0
 h2wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792655668; x=1793260468;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=tc/c8341kdGrljrmpl+zI2/ClvSJfK/p7gQKezk4jH4=;
 b=ixudTXNSn4XVbNE3EXSlt4re+z74YTtkbiP8w+v3hKeOgJfdSHLkCnUSqwEpmL0AQx
 lRwSGfqnl8HFgNGn501FDihQmqx1swSECbuaN4+Rd1b2Hv1rAIMDHRqCojcYRTLXCPEm
 stsTI3XpJdNG4tDNfaNt4o2MOOuWxdSqi78vC4pITdNh6zeJoSsebigQYoJ2MmJCzvR0
 mu7oxPtznCY3UiScj9qhWWQ2UO+9RdovXS9B84aU0RC74/jEzJDclAoNVa3vINH7eTRi
 LSaCrgDv0cfT3k7zkYHnWkojoUYPhyJiE8GzBeVQfTtDrzOK6twLrVu7qphay/4lCh07
 REBQ==
X-Gm-Message-State: AFq9FYJox21cnpT/oJmkkAtnjhxz4Wi/RUyV2I+enIHUG+Wk4SKGUlK/
 QVJzTbqQC2BzxLFcdn1AoXjIZMMi0V0CDZa6x5UCG/pYU5nVUhaRRY2GsNKh0Ba1ezo=
X-Gm-Gg: AYBFou2Z/6PJIuHtbGpBAz7SXNZyOG/m0W9YTAvEPKbpbuL++Ab6gl6BRGwlwFdig4r
 VCG+GqsOmRJECulqW5ZdH+Hd4lJyDjhdgGTgH+vNYgN5Ynu6FC67QLAhgKvSqTSnQbcTxHOpIzT
 amWgBWxBEAZTs5qLxfNmk/9tTHSkU1+f5MlBAPNX2WEVcsooqERN1GSaOmR2JvcZY6Z+fFHI7Er
 b5m+9xpRCBHVtBj8n1AoTKYrWIRb+OKJQ7vQ4YHbRgsIcRpzgbKwD0eFmw0n1eQWnOSAmhoLtsh
 onyO0fcDVr5rKRyM7qIevp6fIjAycCuZOQxYhFniicJexIG1JmSyuyPsNPzsQ/0ZYTVABdD8LO2
 pQAhNGwoqclgQTauC7vdIMpeVsgPZ56KlVTNSoblXpFY6WrjpoDCZs70X/ca89rqkhWgZhvIMZF
 9XRduVTvdr5HyNSMt0+rQu+C6AT0apFlIzcEEZSwDoKT1uFpV9ciyxUMUacLoCnOFrLy3q+NO/0
 /oA1ZhvSidH2tkcIc8acKqApwursV0lRUujt2sqN0BQa94xQ7Aw054epdWuby7ltANgjJti5s/d
 7CiecB6pPo9dHMbeXg==
X-Received: by 2002:a17:90b:28c5:b0:39e:6c68:c77a with SMTP id
 98e67ed59e1d1-3ad86f4b49fmr3660454a91.48.1792655668108; 
 Thu, 22 Oct 2026 00:54:28 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ada4896c71sm3202562a91.6.2026.10.22.00.54.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 00:54:27 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Thu, 22 Oct 2026 15:53:36 +0800
Message-ID: <20261022075343.3043003-10-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
References: <20261022075343.3043003-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xJndB-0000000050k-3OSK
Subject: [f2fs-dev] [PATCH v6 09/15] f2fs: optimize small block size large
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

The original f2fs_read_data_large_folio() implementation has limited
benefit with a 4KB block size, mainly because updating
read_pages_pending greatly increases the number of spinlock
operations.

Use len_blks to batch read_pages_pending and iostat updates for
contiguous mapped blocks.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 46 +++++++++++++++++++++++++++++++---------------
 1 file changed, 31 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 5671395130b2..bc1bffbb15ca 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -158,7 +158,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 			continue;
 		}
 
-		if (folio_test_large(folio)) {
+		if (f2fs_folio_has_ffs(folio)) {
 			struct f2fs_folio_state *ffs =
 				(struct f2fs_folio_state *)folio->private;
 
@@ -3151,7 +3151,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	pgoff_t index, offset, next_pgofs = 0;
 	unsigned max_nr_pages = rac ? readahead_count(rac) :
 				folio_nr_pages(folio);
-	unsigned nrpages;
+	unsigned nrpages, len_blks;
 	struct f2fs_folio_state *ffs;
 	int ret = 0;
 	bool folio_in_bio = false;
@@ -3175,11 +3175,16 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	folio_in_bio = false;
 	index = folio->index;
 	offset = 0;
-	ffs = NULL;
 	nrpages = folio_nr_pages(folio);
 
-	for (; nrpages; nrpages--, max_nr_pages--, index++, offset++) {
+	for (; nrpages;
+	     nrpages -= len_blks, max_nr_pages -= len_blks,
+	     index += len_blks, offset += len_blks) {
 		sector_t block_nr;
+		unsigned int i;
+
+		len_blks = 1;
+
 		/*
 		 * Map blocks using the previous result first.
 		 */
@@ -3208,13 +3213,23 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
 		} else {
 			size_t page_offset = offset << PAGE_SHIFT;
+
 			folio_zero_range(folio, page_offset, PAGE_SIZE);
 			if (vi && !fsverity_verify_blocks(vi, folio, PAGE_SIZE, page_offset)) {
 				ret = -EIO;
@@ -3234,9 +3249,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 			}
 
 			/* set the bitmap to wait */
-			spin_lock_irq(&ffs->state_lock);
-			ffs->read_pages_pending++;
-			spin_unlock_irq(&ffs->state_lock);
+			f2fs_update_read_folio_pending(folio, len_blks);
 		}
 
 		/*
@@ -3260,17 +3273,20 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 		 * If the page is under writeback, we need to wait for
 		 * its completion to see the correct decrypted data.
 		 */
-		f2fs_wait_on_block_writeback(inode, block_nr);
+		for (i = 0; i < len_blks; i++)
+			f2fs_wait_on_block_writeback(inode, block_nr + i);
 
-		if (!bio_add_folio(bio, folio, F2FS_BLKSIZE(F2FS_I_SB(inode)),
+		if (!bio_add_folio(bio, folio,
+				len_blks * F2FS_BLKSIZE(F2FS_I_SB(inode)),
 				offset << PAGE_SHIFT))
 			goto submit_and_realloc;
 
 		folio_in_bio = true;
-		inc_cache_count(F2FS_I_SB(inode), F2FS_RD_DATA);
+		for (i = 0; i < len_blks; i++)
+			inc_cache_count(F2FS_I_SB(inode), F2FS_RD_DATA);
 		f2fs_update_iostat(F2FS_I_SB(inode), NULL, FS_DATA_READ_IO,
-				F2FS_BLKSIZE(F2FS_I_SB(inode)));
-		last_block_in_bio = block_nr;
+				len_blks * F2FS_BLKSIZE(F2FS_I_SB(inode)));
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
