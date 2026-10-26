Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E64F1606A31F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 Oct 2026 03:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=ESdCCbsX;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=iW5xs2RE;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=DrfvhSsW;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=SSdxhuRH
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=IV7qYDMJtLz3OXt4e8MIoINov4kxgL9mOncKy+5XKiw=; b=ESdCCbsXJ6wadqf/tfI4uSoLIh
	WXpI7Z+nlLoZCc9sK2t9WlUzdThibmGduCCfWLaRISWCyzazDTPDfjdbj795Ul2CBhwPnIHpeROuc
	iHnM/f4s6IRpK6cBJmgjSTiNAO/pb1NfuianHKzjxtKCFR+0RDWx3Q6oFbH4t5D7j/G8=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xLBXm-000000000OC-2mPL;
	Mon, 26 Oct 2026 03:38:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xLBXk-000000000O3-4Asb
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:38:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zIN4tTxZ+23tHq5qE7t7jNQ6CYYlYri1A9S1msEJiBc=; b=iW5xs2REk/ICzDdcrHp5DckIwI
 mZNIxzO8oowmYNWvIEmBqd7QAEta2bYaviMFecCNdnzbW/fsRWnBFilavpZRkk/6gV4h/jlpE4AWk
 NhrTGRnLCoxmtTNbv3Cyuh7s0vvB8u3DW92edMFAih1kFShO4psTUmc9OZFe4lgMrs5U=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zIN4tTxZ+23tHq5qE7t7jNQ6CYYlYri1A9S1msEJiBc=; b=DrfvhSsWXo650GMhTlk6j+NqlX
 hiEoSYNFxuq9DO5xgyVsP/LtXMGvoBoQchgZCCF+FV2K+1OC4bdzIpg08vr/ebgu1o949nwj6VBAU
 KTnpegN7kIdsONsi0gMI5wJRwdKyyu1ryV/NePQNdIehLNXwrI6LjPEq0765yM0wVrco=;
Received: from mail-pj2-f6.google.com ([74.125.227.134])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xLBXk-000000000fX-1RE2
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 Oct 2026 03:38:40 +0000
Received: by mail-pj2-f6.google.com with SMTP id
 98e67ed59e1d1-3ad41dad3faso1711373a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 25 Oct 2026 20:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792985915; x=1793590715; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zIN4tTxZ+23tHq5qE7t7jNQ6CYYlYri1A9S1msEJiBc=;
 b=SSdxhuRHALOdWkr1SGqJupDjppWSokAOpAOr+Bwnp2HE2skCcgoIycnzDmYoYK0hS9
 feIQwBDc5ytmdT/qFlXvAQGbCalyhF1HMjTVB+QL9lykXKcWnFfzlK6KyG4GtSetgZzM
 ScKMm3zLo2ZszBv7+0WAB3ebKL7M0C/Xm9/7G6vghyEzRtwhko47jl03k8p9iFwMpuUU
 5jyHsBETwHBbts6Bi0pCWJKPupkGsTvdFxBe1seSxawD74ZTZJdL3u/GxVvbZnc9hYhf
 R/g7HMjoel3ymbR45YTP8ySYh68CZIriAjeq/5YTVHKsUeqDTe0LLXjShI4C4b9boar/
 CZxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792985915; x=1793590715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zIN4tTxZ+23tHq5qE7t7jNQ6CYYlYri1A9S1msEJiBc=;
 b=ws6+n0fmn9oltvASp+tPEuPOvbebYLYMgpkc6GWya8HarBJKhpu73xbCP8L0Vs/7Xd
 +H/UvgL3/XKyegh/BB+HxR5c2emL2kJlIkpZRwu/7t1wRj1LfPVD9Xe5LxG0lpOCyx9A
 hn/sQZrVeizWJAdj/TSrWXHhXrKZhUa2zuZpiJI4UBbRMMPcSE8kKOxi57SBZ3JrhSjr
 hZ/BDzZf4aMA8oakp2dK6cVlErE/LFknXQEb0CCm5Oqcuv689GMmO1nrWjFEq3Kl9TxE
 gFkmnQzzY2vinS6rdTmDt8IYTf/H9M4aF7MwletFOwq4z7P7nj0ZtVclchDkswAsQdXB
 8QDg==
X-Gm-Message-State: AFq9FYLiNbzmGLSF79G8xlQ47wvAc1cuG5wKO+nzO0xr5qj0poVK3j/b
 LGle0ffSmbRRCTdPLSF3VsyJWVwqiaWDJjZPfKGGwQ2oGg5FZ2TC8AtXTqXYQd4vSTtm4Q==
X-Gm-Gg: AYBFou17JIEi9P49W/mFoKEL3cB98WV3eEd559VW3KUaREVHvEgkxGIfK68n1iSX9YQ
 CCOple4A8HF5DNunkGQkunqv78/n159lpFsC20jLy1YulGWWh4MHKKxAUwHIpLylheVKsfLgBa6
 dyw9t8tI1cSw3/f63hVbHesFGWAgzcfbDVjPGAh+ecJ4/IQv5SOeiM0MFgxpBaTraLeNQuZIo2S
 6JNzPoW5dnGTywcyHnbG3sxrsMqJ7VtWXSs9JKDXLUXdOuCDzrqRUQ8M5TtFXfVKHXD62ixRwOE
 itYyleAg9VhEKHe041A7DChCq+RO3xund/kOmQv9g0fUNvJJPK7ZPwE1+oMI5m+9/4xQBMDoo1+
 s/SyqLUzuM8AXJgKe0t1KddP5MTHPGqvTIoyt/RUQakbP2Bue2Wu4SgrOGmaTDOpnlURUbPrBTf
 MzAeDFkPzb5r78zv5f+GbfzImU9DqsHSPMaa9+Pg86Qcp1T6XWEnwMJ6JFzahNB5/WxVme6Hm70
 P3/cLFF2y41d75dLWJX6QAFovNGCLnXP5Wf9DRhEqsekGSkvpfJRTlZjztNKXQ13fQtX8RYhuNG
 90cLtqzmZSOmGCoi8eIQZcVdA4BsKHMBvR07uJdCyQrtyCz6w1Z4Qye2Qpza7chU+Ag=
X-Received: by 2002:a17:90b:4cc4:b0:3ab:2d46:1dd6 with SMTP id
 98e67ed59e1d1-3ade9b2eeeemr4528363a91.4.1792985914584; 
 Sun, 25 Oct 2026 20:38:34 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3adebe8f0b2sm6409823a91.8.2026.10.25.20.38.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Oct 2026 20:38:34 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Mon, 26 Oct 2026 11:37:39 +0800
Message-ID: <20261026033745.784107-10-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
References: <20261026033745.784107-1-nzzhao.sigma@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xLBXk-000000000fX-1RE2
Subject: [f2fs-dev] [PATCH v7 09/15] f2fs: optimize small block size large
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
index b3ada22cb0cb..b805dbe2c187 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -158,7 +158,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 			continue;
 		}
 
-		if (folio_test_large(folio)) {
+		if (f2fs_folio_has_ffs(folio)) {
 			struct f2fs_folio_state *ffs =
 				(struct f2fs_folio_state *)folio->private;
 
@@ -3167,7 +3167,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	pgoff_t index, offset, next_pgofs = 0;
 	unsigned max_nr_pages = rac ? readahead_count(rac) :
 				folio_nr_pages(folio);
-	unsigned nrpages;
+	unsigned nrpages, len_blks;
 	struct f2fs_folio_state *ffs;
 	int ret = 0;
 	bool folio_in_bio = false;
@@ -3191,11 +3191,16 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
@@ -3224,13 +3229,23 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
@@ -3250,9 +3265,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 			}
 
 			/* set the bitmap to wait */
-			spin_lock_irq(&ffs->state_lock);
-			ffs->read_pages_pending++;
-			spin_unlock_irq(&ffs->state_lock);
+			f2fs_update_read_folio_pending(folio, len_blks);
 		}
 
 		/*
@@ -3276,17 +3289,20 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
