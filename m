Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD430CA101F
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 15 Sep 2025 03:53:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5lB6khOlkeAKxynHed/AEqjJwX3PJyzCVBXnBceWNDA=; b=WZzoYLiVIoRZZmilu7W7WyJe4p
	QjC0McrG4A/qsdDrsgbs+r2At36WtnHOddQDKly4I/G/JwDfE3PnpKZWEbtZDozNMGloFrbZTNIL7
	u6PCjKzktKFC/ksMi7+hnhjvJw4/aQ4uhu3bDYYoDkRs43dFmaTRtBY+/QFKB+Fzsgzk=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uy0H0-0001u5-5t;
	Mon, 15 Sep 2025 03:53:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <wangzijie1@honor.com>) id 1uy0Gy-0001tq-On
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Sep 2025 03:53:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Content-Transfer-Encoding:MIME-Version
 :Message-ID:Date:Subject:CC:To:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SlsJjX3HgnTSH+HImyl5M3CiKG/sy4lS3Xt2uFdRqlE=; b=PuAa3orDesJ1SPJ6d9qhnZb9gR
 0pzzfwHt8pYm2G0qHOkVa3Vjv3nINtP7DPNva33Llj9clLnsWlUho+gaolzObYu4Q+HyOJ4JjJolp
 uEImN1xXyyULtrnXg6W/dDcNn2zigJ2zo66NwOsWy6+asWqeXwJmvIEeXdxXgdC9j/ng=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
 Subject:CC:To:From:Sender:Reply-To:Content-ID:Content-Description:Resent-Date
 :Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SlsJjX3HgnTSH+HImyl5M3CiKG/sy4lS3Xt2uFdRqlE=; b=G
 SKAgmPJ1M2x7oE43L0nI/JwyrEIrbXi51SNpL7XPECPCA+LCOKT+GlH6oyd0fkAHY98n8Qax+wrUj
 5jlGPnJ/pAd0G2OoQ+Xqxf+o6/FQriUKAlQ+M2rQG2sq6WKrmA4pqFx4izGNEQJWTEMtQhFsxHp2p
 DyK/Gt/7urKCc/Bc=;
Received: from mta22.honor.com ([81.70.192.198] helo=mta22.hihonor.com)
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uy0Gx-0003lc-Lt for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 15 Sep 2025 03:53:00 +0000
dkim-signature: v=1; a=rsa-sha256; d=honor.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=To:From;
 bh=SlsJjX3HgnTSH+HImyl5M3CiKG/sy4lS3Xt2uFdRqlE=;
 b=FZC3dHfPSeduPtImkDOJKoA8ZymX3MMhhadsGqAgRF7TFSk/6vIOdgDcrZzTQNR6JMCw2cEzD
 WLaK9cbxoBfajLwXUMGhe4/4VU0Rz2bY2V7Zghjb3FieyP7MUCWR4s6/lkULwE5nMifC5ybiT99
 LKY/uaK7cUI4e66kqc8samE=
Received: from w011.hihonor.com (unknown [10.68.20.122])
 by mta22.hihonor.com (SkyGuard) with ESMTPS id 4cQB1r5dmfzYmM3s;
 Mon, 15 Sep 2025 11:52:32 +0800 (CST)
Received: from a011.hihonor.com (10.68.31.243) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 15 Sep
 2025 11:52:51 +0800
Received: from localhost.localdomain (10.144.23.14) by a011.hihonor.com
 (10.68.31.243) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 15 Sep
 2025 11:52:51 +0800
From: wangzijie <wangzijie1@honor.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
Date: Mon, 15 Sep 2025 11:52:45 +0800
Message-ID: <20250915035246.98055-1-wangzijie1@honor.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Originating-IP: [10.144.23.14]
X-ClientProxiedBy: w001.hihonor.com (10.68.25.235) To a011.hihonor.com
 (10.68.31.243)
X-Headers-End: 1uy0Gx-0003lc-Lt
Subject: [f2fs-dev] [PATCH v2 1/2] f2fs: fix zero-sized extent for precache
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
map->m_flags & F2FS_MAP_MAPPED == true, and we make zero-sized extent.

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
v1:
https://lore.kernel.org/linux-f2fs-devel/20250912103915.3597413-1-wangzijie1@honor.com
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
