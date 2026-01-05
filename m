Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93214C79F9E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Jan 2026 15:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NJpDCgOR9KlZj3JPTvQzYAYIozKGmqSVhq6lldLSr6M=; b=W/2H3ESiNXWTwdq7X4qHsaLTHo
	b54tkwF2W9ZNrSVTALfxB3ztgUHmAQ0ScDrKX2LiS4ROHWIdOm2ZaLbSs9KMb5QKCZGdQ90u12O0D
	EXTAZq3TkiFk99TvIzqPZYcb45Py2H/krbZUVFgIJPZ6Xoadq1IzikAs515znRmazrMg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vcmYa-0004to-9J;
	Mon, 05 Jan 2026 15:31:44 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1vcmYV-0004te-NW
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Jan 2026 15:31:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tiYLZz94d9LLQaDgoW6RxRSXj1GY6myv0dr2n31N658=; b=EDqkE1ooy/yLt7RncJ+3oHYmV1
 z6ky151ZoJw7xPfxBOcaj0STaWCBFz/DLP4OMxcndAg6gu+2/lPHzCgpXQPIRpQnEihGmSN1PNhKb
 EYoTqVbpVaFL2xd/dgHf6THZ+vthZ2JB3lnXjHbEGg8DmEeXN2oXHP66kbStt0+bGEyk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=tiYLZz94d9LLQaDgoW6RxRSXj1GY6myv0dr2n31N658=; b=FzV5zcIz9hmCZsigUzV7ktrAV/
 r4RFKrtQnDzl0zQGJ1tMZBEIM0FYQ5nbvkVR6pdP+OuDMKSyP57hUBHLxodh0SS1D8wHp1ZsQ9+3u
 BVB14UJHkkGlex81V8C5/JH0I8pC9UysRu9IKFveRq0U7+FNQ0sC38+zwCWBT2O5jEmI=;
Received: from m16.mail.126.com ([117.135.210.7])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vcmYU-0006EH-TX for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Jan 2026 15:31:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=ti
 YLZz94d9LLQaDgoW6RxRSXj1GY6myv0dr2n31N658=; b=S3lbzwazwBjl+OviT0
 x/cOP0ZvC3s0wO1wMtTQNLxCS3xwTfRLbgUhs8qgfZydNanRjVCOou6DhoUkKN02
 SSwUq8Ub1gc1nunuxtht6BbLluROa1JiZ4bQ+h0+jRI40yAg1VmKl2oCMLn6lRWr
 3qjSL4WheQMiP+Tygi/tjcNVw=
Received: from YLLaptop.. (unknown [])
 by gzga-smtp-mtada-g0-1 (Coremail) with SMTP id _____wD3t6092Vtp4nHABA--.665S5;
 Mon, 05 Jan 2026 23:31:12 +0800 (CST)
From: Nanzhe Zhao <nzzhao@126.com>
To: Kim Jaegeuk <jaegeuk@kernel.org>
Date: Mon,  5 Jan 2026 23:30:59 +0800
Message-Id: <20260105153101.152892-4-nzzhao@126.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260105153101.152892-1-nzzhao@126.com>
References: <20260105153101.152892-1-nzzhao@126.com>
MIME-Version: 1.0
X-CM-TRANSID: _____wD3t6092Vtp4nHABA--.665S5
X-Coremail-Antispam: 1Uf129KBjvJXoW7WF1fWw1xZw4DWFy3CryDJrb_yoW5Jr1DpF
 y7Gr15Grs3GF4IgF4xJ3Z8uFn09348Kw4UuFZ3A34fWayYqr9agFnYya45uF1Y9rZ7XFn2
 qF48K34kCa45taDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07U2NtxUUUUU=
X-Originating-IP: [2409:8a20:4df7:2871:d124:26e2:5013:1aa3]
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsQC3h2lb2UBIxwAA3l
X-Headers-End: 1vcmYU-0006EH-TX
Subject: [f2fs-dev] [PATCH v1 3/5] f2fs: add f2fs_block_needs_zeroing() to
 handle hole blocks
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
Cc: Nanzhe Zhao <nzzhao@126.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

f2fs_read_data_large_folio() relies on f2fs_map_blocks() to decide whether
a subpage should be zero-filled or queued to a read bio.

However, f2fs_map_blocks() can set F2FS_MAP_MAPPED for NULL_ADDR and
NEW_ADDR in the non-DIO, no-create path. The large folio read code then
treats such hole blocks as mapped blocks, and may account them
in read_pages_pending and attempt to build bios for them, which can
leave tasks stuck in readahead for heavily fragmented files.

Add a helper, f2fs_block_needs_zeroing(), which detects NULL_ADDR and
NEW_ADDR from struct f2fs_map_blocks. Use it to prioritize the zeroing
path by checking f2fs_block_needs_zeroing() before
(map.m_flags & F2FS_MAP_MAPPED) under got_it: label.

Signed-off-by: Nanzhe Zhao <nzzhao@126.com>
---
 fs/f2fs/data.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 4bef04560924..66ab7a43a56f 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2413,6 +2413,11 @@ static void ffs_detach_free(struct folio *folio)
 	kmem_cache_free(ffs_entry_slab, ffs);
 }

+static inline bool f2fs_block_needs_zeroing(const struct f2fs_map_blocks *map)
+{
+	return map->m_pblk == NULL_ADDR || map->m_pblk == NEW_ADDR;
+}
+
 static int f2fs_read_data_large_folio(struct inode *inode,
 		struct readahead_control *rac, struct folio *folio)
 {
@@ -2468,14 +2473,7 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 		if (ret)
 			goto err_out;
 got_it:
-		if ((map.m_flags & F2FS_MAP_MAPPED)) {
-			block_nr = map.m_pblk + index - map.m_lblk;
-			if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
-						DATA_GENERIC_ENHANCE_READ)) {
-				ret = -EFSCORRUPTED;
-				goto err_out;
-			}
-		} else {
+		if ((f2fs_block_needs_zeroing(&map))) {
 			folio_zero_range(folio, offset << PAGE_SHIFT, PAGE_SIZE);
 			if (f2fs_need_verity(inode, index) &&
 			    !fsverity_verify_page(folio_file_page(folio,
@@ -2484,6 +2482,13 @@ static int f2fs_read_data_large_folio(struct inode *inode,
 				goto err_out;
 			}
 			continue;
+		} else if((map.m_flags & F2FS_MAP_MAPPED)) {
+			block_nr = map.m_pblk + index - map.m_lblk;
+			if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
+						DATA_GENERIC_ENHANCE_READ)) {
+				ret = -EFSCORRUPTED;
+				goto err_out;
+			}
 		}

 		/* We must increment read_pages_pending before possible BIOs submitting
--
2.34.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
