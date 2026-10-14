Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11AE2CC6B25
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Oct 2026 06:46:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q8cZHEKuVVQaVv1cFSYy4arkEhnj7K+LnH07p78YHsU=; b=S/BRFHuOn+LRA53OiFiM9SmN5j
	/q7TnA+jlXU4QsWJuZ2MW6XwKwouxMOwqgw6/YgQTvwLRFJp8dQBkCBv+CRAJdBRVDgRRE0n0ghGS
	80f1hOcC38ufdqC+761eiLKWgx9GzSR/l19niEb2KYqIOOXzeHIv5cUy6heb3vm73cQU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGskU-0000kz-0O;
	Wed, 14 Oct 2026 06:46:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGskS-0000kV-Bj
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:46:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=w4CSXXM+8AC2FdQHssbklEdRtPR/7CbkAxHC+roAb84=; b=hl5ieDvKpeF5ARkTz1Oj0VI0zq
 AnDhfuJ7eYO1G4uGzJ2glqekGCsihA30potWz9FbiJAc4dkDj/T3yoMqfmpjO848XALdQ9pE9Tmuz
 I8fNrfgu3yCz16sgnd2wEpK9I/qA3vIb+D2RvdLsUjCTXPfUpq5zrIJG8cwxUgDMNEmI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=w4CSXXM+8AC2FdQHssbklEdRtPR/7CbkAxHC+roAb84=; b=HPFnY5gYbSw7RD6vEUZHj2j6eK
 oVyrS50pWgnHmjugk5JthLY6L8C2hS0FlQUjmtfcq81QJJcdsqYkNY/ZNwwuNaiWPdSuclUl/fFr/
 hTGqmAKFuQSK66JEaUKp+9QjMgDRKRYD1EOh0fPXWDsNXuFz7cUmwnk9Y70KYXhkFCcM=;
Received: from mail-pj2-f10.google.com ([74.125.227.138])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGskR-0004La-Kv for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Oct 2026 06:46:00 +0000
Received: by mail-pj2-f10.google.com with SMTP id
 98e67ed59e1d1-3abe4821449so1451832a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 23:45:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791960354; x=1792565154; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=w4CSXXM+8AC2FdQHssbklEdRtPR/7CbkAxHC+roAb84=;
 b=CPM6Pzn+ZT7eU9YtS1RStlTnBrp8pcGNFxpKwybi9zrbyLIZ/ZSYWiS33JH9obIKCG
 bCkMK9HbLf0kDNddbdHy5uLruLE4fNLiHabN7LalTWy47DDUgEMGCQ6FhSx2Zn3ZCZN1
 diuvR/tySW4/rVbHiqEHa66iPShgUss7rXczOM5OryrZNW9gnb6WgoWXtfXlEQL0EkTv
 UL6FGCA/uCM3ODax/TC7cu/lrLmmkxeRnHawak0OjcwDWoDt+ydGUNQ2gQt7M+AVGMTJ
 GDgyiMdwxSS3lnaE5YxVZwwnOzoX9pw6N7POAPR4ic8al61fWDEebFy5Vj4ydWmWmgqF
 7Zhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791960354; x=1792565154;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=w4CSXXM+8AC2FdQHssbklEdRtPR/7CbkAxHC+roAb84=;
 b=OvE8bEDfr2zyValmzqiv2JPzlIFKj9PnMnf6K28+qH9Cbo1GItebucxMJWPh4K53R0
 taE2yqOq85C9IXX/dvP8A3wMh7P86lhcXGSh+Xg5LeNCTD0KfYL21xREJNeZpwTjmqqQ
 YSMksj2/IWKwWLrASTCBCZf3X+r5BW0Bize5LUNP/VQASTRa7WYJRvm/SEi9JwxilQwS
 hk70jwBd0iLEi8mbxqTVuxTBfqgYtQ0C9E8v7uFxTNw2HbGVapNIwb3qd0BNske003dQ
 VysPx9yHawXUfuDCO2O2iRDjW8Pogqsumr0OcIvP661Rb3OktjNUhL5ylIjsDsSEhsL6
 HA6Q==
X-Gm-Message-State: AFq9FYIKPLRwIg7hQJkT1xYFbhOvLVMOvlk88cVVwvecw2QT3CmkTTGN
 T7ERPOYcbGsJXOdS5HAUfqavAkxsgUxJiWhL/oGfwa5GOeoV/Hxqmn8wA3PJydwqV4Q=
X-Gm-Gg: AYBFou0AuVco5KCEfS1lmZCHI/mgUeL1MhLU+gg0tY9LlVovP9KdKxAtMLYxJUSvvHg
 zOe/2S59Yi86uESED6itugly3aEr9inE7eNVRKafHL4R8Fh/8v3QzKWhVu2NW/K2jYuyasDua7Y
 iETymmYQVerk1GeX3eDU/FrqxkUyP4o0BhqkOCUSLe/XrldYpEvERSEvhIg8I8cvmr2EBebV5tG
 QP7WZk9T3blx5JYwG2TbVhIfB0TUOBbTGG/z9d3p1xBDx1iPDqLcKYjQKjRVbetwTvqDD9Y+5wc
 N7IY44JaL9d/0kOuXzj28F4TwjL5tXuHMwNkoBSFlzNHMJB3MmnRpO8FKm0XyA06iHe27GJIPpv
 hTyEDEUF/AR7t6qfcGCpBufeB09D5+scIsR6EOXKY7thhDWubFuOYkMjqk6nn0UydW9T/wiPTtq
 QJjMxQ08R8PXwfi/H497GeE6AVEA2LzmmZGah30tBRY9JPjZDqKAmL4nKQP0R+hmPhbOpvJm4FJ
 eBZYySFtL60IKl4RGRiiPZj2AXrYV+nCPbF
X-Received: by 2002:a17:90b:224e:b0:3a8:9db2:a4f with SMTP id
 98e67ed59e1d1-3ab3af75ac1mr11361841a91.51.1791960353869; 
 Tue, 13 Oct 2026 23:45:53 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ac5f04e324sm3236371a91.2.2026.10.13.23.45.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 23:45:53 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Wed, 14 Oct 2026 14:44:38 +0800
Message-ID: <20261014064445.2835813-10-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
References: <20261014064445.2835813-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
X-Headers-End: 1xGskR-0004La-Kv
Subject: [f2fs-dev] [PATCH v5 09/16] f2fs: optimize small block size large
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

The original f2fs_read_data_large_folio() implementation has limited
benefit with a 4KB block size, mainly because updating
read_pages_pending greatly increases the number of spinlock
operations.

Use len_blks to batch read_pages_pending and iostat updates for
contiguous mapped blocks.

Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
---
 fs/f2fs/data.c | 45 ++++++++++++++++++++++++++++++---------------
 1 file changed, 30 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 710213fea7a6..59346b61615b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -158,7 +158,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 			continue;
 		}
 
-		if (folio_test_large(folio)) {
+		if (f2fs_folio_has_ffs(folio)) {
 			struct f2fs_folio_state *ffs =
 				(struct f2fs_folio_state *)folio->private;
 
@@ -3105,7 +3105,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	pgoff_t index, offset, next_pgofs = 0;
 	unsigned max_nr_pages = rac ? readahead_count(rac) :
 				folio_nr_pages(folio);
-	unsigned nrpages;
+	unsigned nrpages, len_blks;
 	struct f2fs_folio_state *ffs;
 	int ret = 0;
 	bool folio_in_bio = false;
@@ -3129,11 +3129,16 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
@@ -3162,13 +3167,23 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
@@ -3188,9 +3203,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 			}
 
 			/* set the bitmap to wait */
-			spin_lock_irq(&ffs->state_lock);
-			ffs->read_pages_pending++;
-			spin_unlock_irq(&ffs->state_lock);
+			f2fs_update_read_folio_pending(folio, len_blks);
 		}
 
 		/*
@@ -3214,17 +3227,19 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 		 * If the page is under writeback, we need to wait for
 		 * its completion to see the correct decrypted data.
 		 */
-		f2fs_wait_on_block_writeback(inode, block_nr);
+		f2fs_wait_on_block_writeback_range(inode, block_nr, len_blks);
 
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
