Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90C17CC6B03
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 13 Oct 2026 11:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6bhT2TW/uV/D5qGZyj6/JqNxNhuVDXSv0Bf73yEzqVA=; b=LytR1YfL9GRNWirWrekoCnY49V
	yUAoApdzvWxp8eE4QtJ3OFpJZVGEYeVpt5Nw4dUCBgFbxkaPn2XdA8xj3TBxylvfAPFtk0rnfr8xY
	bKK338kNWHFkk9JD/rTJDcoBJ2bjA5RtZhV8qjvuI3n8MMheZKgVybU6J0ILkBPA1bp4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGb8L-0000lS-Qf;
	Tue, 13 Oct 2026 11:57:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1xGb8K-0000l6-BI
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:57:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=senjnjxqBDGx5hk2ld0D1T89Rh9/oU3kWKubbK2Ik0Y=; b=k39ZUv2i0HlMlkCHNDrjugihTe
 ooQx3L24ScM38KJsnpqwE5O7xX1SIbCX9ZEDY3B7VS8vVqOiWLcBPwgftVA8iW3S57lL46VxzbwEz
 bdok4UMHozOqaa9e01ni7Qa4tWYFAhAzXxGZloNcNMxscZs9zfzTThDavKiWDpwqhxck=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=senjnjxqBDGx5hk2ld0D1T89Rh9/oU3kWKubbK2Ik0Y=; b=dPT1UMV+U4SrFk7ZsEe/qlTD+C
 /08fxIe+sr7w4yAJjgTZLtYp6NDiGLOItK/bXu/qei30GyWnBQ0HeY7pRYehOOOoGfCuA9/3tea/i
 hZpyKczb8BhlbqdBZ/ICAsYelDx48WF9dSSCoOGfnUyI7ieS1zFdcMFPRRe4D1wuYX4A=;
Received: from mail-pj2-f6.google.com ([74.125.227.134])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGb8J-0001Up-Nm for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 13 Oct 2026 11:57:29 +0000
Received: by mail-pj2-f6.google.com with SMTP id
 98e67ed59e1d1-3964e7720afso1376505a91.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Oct 2026 04:57:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791892642; x=1792497442; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=senjnjxqBDGx5hk2ld0D1T89Rh9/oU3kWKubbK2Ik0Y=;
 b=nrVu3E0rR5ZZBxmgTsTTgtrItnAuge71dZAt3Nq5SPQ8pHJ8lbpXY9XQ/ZGKZV7T/G
 ysEa1W2bdsfv7ynNJN8WdnDqH2QYq00UYzfI1S0ppu7y8CIPdnf8OYBbrwAQI4z1S3g8
 d/u8aX1WeajVy7wS4yVICCO5T2KU6PEO/cwEBUKbtoV8wozxdvHuUx3lssEyeSl+otN8
 uxvqcFYxYwFgtS+yEgKvN03ey+GAqvo4XyPnhEaQELumI5DXwrv6KN2BZ3eZ9dNrJY8j
 DIU3Gpiz8BLOMoZj/X8iHxOWAK88VD4Kis0gnSPzHLZdkxg0J9WtuTDIRdjohKmlSEFm
 RYMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791892642; x=1792497442;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=senjnjxqBDGx5hk2ld0D1T89Rh9/oU3kWKubbK2Ik0Y=;
 b=nsk5FNc/Q4ihLqTojtn6s1dQjsH+JGBOnctYuXWRtTQdQFlmUST+GO/FFNYf9CNqvo
 a7FTqNZ1c9JQJJmVz31cDqbsGUnpPj5dm4Za15XdNFSB8kPetjfrgiu/ZymfiwNVHgUv
 BTRVgPW1UtCrojpf6qGPZI4KKrWkAwUyikRHNX51/l8kYr7lJiV1eMH6AJ2xkKO2BBwG
 30dJfh3BNRc7ygqcOR4EtVoFHJ1FCEeZ17n5n8OKFUsNQcvMJAFi0YUqKoplPvOZ/8me
 1pUuFDeuB0STahL+OnPMuOUzvUTKgcNcXExATQUAmgRtXbY71+mXhFocwR+RxQXMW3hE
 blJg==
X-Gm-Message-State: AFq9FYJCDKUY8f4MnXeCGi05V0gT2clU5MQG8EIITia2VY3mw7b3rIKU
 EdLoGI2jiA1xDwWX7bypxLRLD9Xu8onJ3REp7YtEjnddoNFffB4lTMDABcTmFnxSEdk=
X-Gm-Gg: AYBFou18C1EG8HdYzNJwWVBhxtO8B9QR4dYcfJJ3ncsJP0ezC02UQ2/EgxSIuwoeMgV
 QtFiUrTcj3FcKXdYhI7UVQfwFJrwdT3BhUqucxMF/B9Msa4A3j9GoqE57IOSWZUylmd/xw7YrCP
 T0/8jVY+fOtB6NTl4avCzXgrdOF6l94KDxQMyAo5JejPEdXpoqFC31bmLg7dOC0JJfr2JPakO6f
 VkvBGCFTAYgNkn6mHeDqL3z/1DbOpGyJOe0FmKAJWnZPp/VlwOPm8SGuZs9eVDR1nmKhoYaBTaV
 7XLMKUqwx1asv0cAqX00OFxblKa96AFYoqSfzqVQC5PCq8qYFLv1pl4PN4gqO2AIx0/TCNmQs3b
 1PM50hhtM8TlmBhoPCsf55gwn0VB0H1orE2Gq5IGYDHnLpE2Ucr7eoy989l0qkr0KfDeGPe00ES
 SOVdBXBh+nvP+KnLZvOJwmb1J3NwgcG6QQhaGkzFX98H11gKqafGprfHhpDfKCRNbUx4ctO3/wg
 /1JgDFBrYdKODU6bZUFGS1ocqLwTGvPDajD
X-Received: by 2002:a17:90b:1c08:b0:3a7:ab31:2f4f with SMTP id
 98e67ed59e1d1-3ab3a778481mr10559692a91.28.1791892641866; 
 Tue, 13 Oct 2026 04:57:21 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab37139b59sm21248516a91.13.2026.10.13.04.57.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Oct 2026 04:57:21 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
To: linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>,
 Chao Yu <chao@kernel.org>
Date: Tue, 13 Oct 2026 19:56:14 +0800
Message-ID: <20261013115621.968742-12-nzzhao.sigma@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
References: <20261013115621.968742-1-nzzhao.sigma@gmail.com>
MIME-Version: 1.0
X-Headers-End: 1xGb8J-0001Up-Nm
Subject: [f2fs-dev] [PATCH v4 11/18] f2fs: optimize small block size large
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

From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

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
index 4484f65fd..8b9a4788c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -158,7 +158,7 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 			continue;
 		}
 
-		if (folio_test_large(folio)) {
+		if (f2fs_folio_has_ffs(folio)) {
 			struct f2fs_folio_state *ffs =
 				(struct f2fs_folio_state *)folio->private;
 
@@ -3119,7 +3119,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 	pgoff_t index, offset, next_pgofs = 0;
 	unsigned max_nr_pages = rac ? readahead_count(rac) :
 				folio_nr_pages(folio);
-	unsigned nrpages;
+	unsigned nrpages, len_blks;
 	struct f2fs_folio_state *ffs;
 	int ret = 0;
 	bool folio_in_bio = false;
@@ -3143,11 +3143,16 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
@@ -3176,13 +3181,23 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
@@ -3202,9 +3217,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 			}
 
 			/* set the bitmap to wait */
-			spin_lock_irq(&ffs->state_lock);
-			ffs->read_pages_pending++;
-			spin_unlock_irq(&ffs->state_lock);
+			f2fs_update_read_folio_pending(folio, len_blks);
 		}
 
 		/*
@@ -3228,17 +3241,19 @@ static int f2fs_read_data_large_folio(struct inode *inode,
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
