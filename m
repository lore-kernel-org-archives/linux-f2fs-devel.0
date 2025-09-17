Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A4A2CAC598
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 17 Sep 2025 02:36:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uj4J2ZuPR6suCsfjxgGKVdNBMlVlpNJOETR08duNcJ0=; b=FtmO98MK13A6AYkxqHXRw89DKa
	HP0lcaD0IYvNcd6f1oYSQDmEqdIBNq2DwKBcwFOChu6rTS56Cd2EFx7bmtjEALCOWZUBAyCSuFbtF
	bJwmqmirOxgYrvw4gvdGoIcgYIiZVA6IwKobTZx7rA6y8PGvBq9ufjleBFc8NNfIKtsE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uyi2B-0002py-Cd;
	Wed, 17 Sep 2025 02:36:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <wangzijie1@honor.com>) id 1uyi29-0002pf-Ik
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Sep 2025 02:36:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=V8jRf/XdzOZu8DRuETfgfqD98J9cKAQM69d4lnejfFs=; b=AW2Zna3gkZ/8GSNB67kWxd4uFM
 cJKCE8aE4PD+gFG0yr4KrUeKXgM5hjafSlGVM8jPYIoxnpEwkbzMUfzWRv9THfBBs1DGLtmWLK/0R
 uHQ7lMn0dWVuB6DSNj6UYIpzK41lVzzpX8ao6dauV84iQVnMXpZ84TWSzdnlgNLDOm2s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=V8jRf/XdzOZu8DRuETfgfqD98J9cKAQM69d4lnejfFs=; b=Y
 sprEW+r5kXqr9JUXs/lse4EOidjd/Sjn2pjR85hBXWW4OkPxg1sYjneFThkVZUPnvS/l8ur7x1ZPT
 wONb1b5Hq7YLHVFSK16eCluJwxXXXYxqikjkqXSTiWebIgqOLI+ZagyNOHHNaMqIy10XKTgDIsXuF
 L5A6LoZMZNdAb1CU=;
Received: from mta22.honor.com ([81.70.192.198] helo=mta22.hihonor.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uyi29-0001jX-8s for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 17 Sep 2025 02:36:38 +0000
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=To:From;
 bh=V8jRf/XdzOZu8DRuETfgfqD98J9cKAQM69d4lnejfFs=;
 b=IUaW5o+7/875Ti9Fg/iLLZ6Ikhs2FXhAk4m6zwtOWvE8QtULP2OWF9hpyS9Gl2xodHOqz03A4
 gVYwu1BgChHy9G3U343ajZbOlwVRL/GuODDSdDxCK0eaazHe6BtMi6O95yS2Ot+HeIQ5RMGGJ1m
 VDmUoWERgF51PRJAOoauq0E=
Received: from w003.hihonor.com (unknown [10.68.17.88])
 by mta22.hihonor.com (SkyGuard) with ESMTPS id 4cRNDh5vbhzYl1N1;
 Wed, 17 Sep 2025 10:36:04 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w003.hihonor.com
 (10.68.17.88) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 17 Sep
 2025 10:36:24 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Wed, 17 Sep
 2025 10:36:24 +0800
From: wangzijie <wangzijie1@honor.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
Date: Wed, 17 Sep 2025 10:36:21 +0800
Message-ID: <20250917023622.516052-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.144.23.14]
X-ClientProxiedBy: w012.hihonor.com (10.68.27.189) To a011.hihonor.com
 (10.68.31.243)
X-Headers-End: 1uyi29-0001jX-8s
Subject: [f2fs-dev] [PATCH v3 1/2] f2fs: fix zero-sized extent for precache
 extents
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
Cc: wangzijie <wangzijie1@honor.com>, linux-kernel@vger.kernel.org,
 feng.han@honor.com, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Script to reproduce:
f2fs_io write 1 0 1881 rand dsync testfile
f2fs_io fallocate 0 7708672 4096 testfile
f2fs_io write 1 1881 1 rand buffered testfile
fsync testfile
umount
mount
f2fs_io precache_extents testfile

When the data layout is something like this:
dnode1:                     dnode2:
[0]      A                  [0]    NEW_ADDR
[1]      A+1                [1]    0x0
...
[1016]   A+1016
[1017]   B (B!=A+1017)      [1017] 0x0

During precache_extents, we map the last block(valid blkaddr) in dnode1:
map->m_flags |= F2FS_MAP_MAPPED;
map->m_pblk = blkaddr(valid blkaddr);
map->m_len = 1;
then we goto next_dnode, meet the first block in dnode2(hole), goto sync_out:
map->m_flags & F2FS_MAP_MAPPED == true, and we make zero-sized extent:

map->m_len = 1
ofs = start_pgofs - map->m_lblk = 1882 - 1881 = 1
ei.fofs = start_pgofs = 1882
ei.len = map->m_len - ofs = 1 - 1 = 0


Rebased on patch[1], this patch can cover these cases to avoid zero-sized extent:
A,B,C is valid blkaddr
case1:
dnode1:                     dnode2:
[0]      A                  [0]    NEW_ADDR
[1]      A+1                [1]    0x0
...                         ....
[1016]   A+1016
[1017]   B (B!=A+1017)      [1017] 0x0

case2:
dnode1:                     dnode2:
[0]      A                  [0]    C (C!=B+1)
[1]      A+1                [1]    C+1
...                         ....
[1016]   A+1016
[1017]   B (B!=A+1017)      [1017] 0x0

case3:
dnode1:                     dnode2:
[0]      A                  [0]    C (C!=B+2)
[1]      A+1                [1]    C+1
...                         ....
[1015]   A+1015
[1016]   B (B!=A+1016)
[1017]   B+1                [1017] 0x0

[1] https://lore.kernel.org/linux-f2fs-devel/20250912081250.44383-1-chao@kernel.org/

Fixes: c4020b2da4c9 ("f2fs: support F2FS_IOC_PRECACHE_EXTENTS")
Signed-off-by: wangzijie <wangzijie1@honor.com>
---
Rebased on:
https://lore.kernel.org/linux-f2fs-devel/20250912081250.44383-1-chao@kernel.org/
v2:
https://lore.kernel.org/linux-f2fs-devel/20250915035246.98055-1-wangzijie1@honor.com/
---
 fs/f2fs/data.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 838eae39d..7a5170b32 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1778,9 +1778,10 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 		if (map->m_flags & F2FS_MAP_MAPPED) {
 			unsigned int ofs = start_pgofs - map->m_lblk;
 
-			f2fs_update_read_extent_cache_range(&dn,
-				start_pgofs, map->m_pblk + ofs,
-				map->m_len - ofs);
+			if (map->m_len - ofs > 0)
+				f2fs_update_read_extent_cache_range(&dn,
+					start_pgofs, map->m_pblk + ofs,
+					map->m_len - ofs);
 		}
 		if (map->m_next_extent)
 			*map->m_next_extent = is_hole ? pgofs + 1 : pgofs;
-- 
2.25.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
