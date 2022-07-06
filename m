Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2749C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  6 Jul 2022 06:30:45 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o8yYd-0006ZT-MA; Wed, 06 Jul 2022 06:30:43 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1o8yYc-0006ZF-1o
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Jul 2022 06:30:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Dns421vBMVBdKK5rIATWvC7h7IS2N6achgUTFfGjuaM=; b=TNVdZKFhBwqvQAGKLAH/o3tFWP
 J4nw0SQ+0P0kZfFyo5C++kJDG9lljY2S2i/mP4DyWAfKQ6dcgY42k/9RsO6aBhCH/7qDIm4rn31sU
 GzikG6LY/EtUhJO2EBuASku+gay1vYnEqSFCdpJvfsVuGzhYPdG0BbDc4CBk+l9lJYs0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Dns421vBMVBdKK5rIATWvC7h7IS2N6achgUTFfGjuaM=; b=Z
 eXcIWl/InP1EMx2827MJc0JYP2xZxndVDS3IjJm8ZB5zExCOFCqdrcJBQzONcnoUpu0xKuuotczGg
 eTKAE8QREbV58BPixE/DvbkAqrSZVQ03AvMOTLlkyu2K5Jeym6B+a5+4YbDM/NAsI5+dRcBXQYAcX
 1xBdKpRReYhLJNB8=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o8yYa-0003Qu-Na
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 06 Jul 2022 06:30:41 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 709CBB81A61;
 Wed,  6 Jul 2022 06:30:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4DAC3411C;
 Wed,  6 Jul 2022 06:30:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1657089025;
 bh=PTwnVLqCKTknxTFPAXpZG38/BbOEsnQ5HZjLPj6vgEs=;
 h=From:To:Cc:Subject:Date:From;
 b=gstNkweOe/7+xVYqNE9xStimSVujj9AmDdhf5JgNcY5MCoHU+lKImBc2a262m+QrI
 hEDZUnc4ayavXp2ngUY6KKKAdX7DnEROSBPN1e1YXy8dTLwJioeHX0uMQkHwodNRQV
 YEOXPjgIX1wBqEMsWUicf9kFm7esDf1ZlvdlvLYxVqyRP2HjUtEx8dPt0hNTnBtoHJ
 vZh3YWduf+didN2wppVq7rBH7GzYrJicp5xkUYbYoFdHw29KLPDmBSbJ/c/PdQh2WE
 xn/seLHvCSW3ZkCSAc4UtyWZVhjHRE8FleBkC+u6N6aTVGSVUpyBrmOxHV8+Sd66kc
 buJSafA3cxPIQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Wed,  6 Jul 2022 14:30:15 +0800
Message-Id: <20220706063015.29727-1-chao@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1o8yYa-0003Qu-Na
Subject: [f2fs-dev] [PATCH] f2fs: fix to invalidate META_MAPPING before DIO
 write
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
Cc: Hyeong-Jun Kim <hj514.kim@samsung.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Quoted from commit e3b49ea36802 ("f2fs: invalidate META_MAPPING before
IPU/DIO write")

"
Encrypted pages during GC are read and cached in META_MAPPING.
However, due to cached pages in META_MAPPING, there is an issue where
newly written pages are lost by IPU or DIO writes.

Thread A - f2fs_gc()            Thread B
/* phase 3 */
down_write(i_gc_rwsem)
ra_data_block()       ---- (a)
up_write(i_gc_rwsem)
                                f2fs_direct_IO() :
                                 - down_read(i_gc_rwsem)
                                 - __blockdev_direct_io()
                                 - get_data_block_dio_write()
                                 - f2fs_dio_submit_bio()  ---- (b)
                                 - up_read(i_gc_rwsem)
/* phase 4 */
down_write(i_gc_rwsem)
move_data_block()     ---- (c)
up_write(i_gc_rwsem)

(a) In phase 3 of f2fs_gc(), up-to-date page is read from storage and
    cached in META_MAPPING.
(b) In thread B, writing new data by IPU or DIO write on same blkaddr as
    read in (a). cached page in META_MAPPING become out-dated.
(c) In phase 4 of f2fs_gc(), out-dated page in META_MAPPING is copied to
    new blkaddr. In conclusion, the newly written data in (b) is lost.

To address this issue, invalidating pages in META_MAPPING before IPU or
DIO write.
"

In previous commit, we missed to cover extent cache hit case, and passed
wrong value for parameter @end of invalidate_mapping_pages(), fix both
issues.

Fixes: 6aa58d8ad20a ("f2fs: readahead encrypted block during GC")
Fixes: e3b49ea36802 ("f2fs: invalidate META_MAPPING before IPU/DIO write")
Cc: Hyeong-Jun Kim <hj514.kim@samsung.com>
Signed-off-by: Chao Yu <chao.yu@oppo.com>
---
 fs/f2fs/data.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c448c3ee7ac3..2d027505d5f6 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1479,9 +1479,12 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 			*map->m_next_extent = pgofs + map->m_len;
 
 		/* for hardware encryption, but to avoid potential issue in future */
-		if (flag == F2FS_GET_BLOCK_DIO)
+		if (flag == F2FS_GET_BLOCK_DIO) {
 			f2fs_wait_on_block_writeback_range(inode,
 						map->m_pblk, map->m_len);
+			invalidate_mapping_pages(META_MAPPING(sbi),
+				map->m_pblk, map->m_pblk + map->m_len - 1);
+		}
 
 		if (map->m_multidev_dio) {
 			block_t blk_addr = map->m_pblk;
@@ -1698,7 +1701,7 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map,
 		f2fs_wait_on_block_writeback_range(inode,
 						map->m_pblk, map->m_len);
 		invalidate_mapping_pages(META_MAPPING(sbi),
-						map->m_pblk, map->m_pblk);
+				map->m_pblk, map->m_pblk + map->m_len - 1);
 
 		if (map->m_multidev_dio) {
 			block_t blk_addr = map->m_pblk;
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
