Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29EE7CAC587
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 12 Sep 2025 02:30:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0RKOABLpL9xl/e5QyklFLfsg3RGnfwMWDMCHElI/A4g=; b=ZFhemSHCTtMJl8Pa2k4rnVphxW
	In9wwBvf8Lyr3QnqO7qiq74gQhFQabbXj5DlpU92/G5gY0OOJ0ENxpOJcaVOnSBuR4TfcyCFW37V6
	W/pRoEaEctLlrAj8lWghD6HtZb2vOpFNKIZ8LNX05rK3/9hnkqLYzJvTIH+qkoDh0Suk=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uwtYw-0004x6-1A;
	Fri, 12 Sep 2025 02:30:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uwtYt-0004ww-W7
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Sep 2025 02:30:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=92alcn1QgF3cfs6BcoQ02Oze3GF+BdfDgIzT4XHbYTM=; b=EhyZXUorgUd4TvVKs7QTgDyhAH
 3ITeS0AsLTQowixPajLAcgKvmlU06utsviTrLtCLu00vFds8Joi+l/bMVsTYJ/w97kFY9tOfsY8fa
 9xf6HYKv3lN5W3UHm2nXf73u7bE/SVWGttQ3CvnToRVBxm7KNp7PIGuPH8UoycUqKaxE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=92alcn1QgF3cfs6BcoQ02Oze3GF+BdfDgIzT4XHbYTM=; b=i
 MRoY4v23wDGqV5cuPfNcpDpye4AkEoBZsbTaRcJM7IsANEzTBa+w2miae7t2ZhVdwlo/9BjQnxQee
 RKyR7A21mdBMA2VZs9cR46F8l/VwxA+mA9iACQ4tv7DP7RUBYRmCbupwygGq4ptbBjT2a9jcKR5EN
 omqcJXRD+IGu0nUI=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uwtYt-0005F4-Fi for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 12 Sep 2025 02:30:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id C1E56601AF
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 12 Sep 2025 02:30:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2157C4CEF0;
 Fri, 12 Sep 2025 02:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1757644244;
 bh=C+wNWmDXpY+mqph3f3/pewOaqICR6pNRFqoYooFy4qU=;
 h=From:To:Cc:Subject:Date:From;
 b=Jp183D52hb3Fg+eQA/Q8cKVt3Zg2IoKO3k4ZEUZxBn8ebXAEnjksfbJDvv+sbemb1
 XvN4Wpwq1VMzvtVZOT6Jr2EwBbnZXlbGrq3JIfTmA7GbmEt926mjTmzVHjo6io6LyS
 BlaREY9jqUwC7VCizg0hWHLcQZbgFC1+UOTBOvASEgU7xBrkSYXCk5Z6eJifojiSsp
 49enosMPW7zilJWOSpaBT6R0x5rpOeW6Jnpj7ewpPDrEs8XeC08kxZeXi0vZps1fhA
 AlzTLpC5Ak4XhOj3U/F2WejEeem99OtctI8bwkpy6xLcLtH8KjjkSg6K6P85vHmWtA
 ub+0ukBXndACQ==
To: jaegeuk@kernel.org
Date: Fri, 12 Sep 2025 10:30:27 +0800
Message-ID: <20250912023027.2526939-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.384.g4c02a37b29-goog
MIME-Version: 1.0
X-Headers-End: 1uwtYt-0005F4-Fi
Subject: [f2fs-dev] [PATCH] f2fs: fix to update map->m_next_extent correctly
 in f2fs_map_blocks()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

mkfs.f2fs -O extra_attr,compression /dev/vdb -f
mount /dev/vdb /mnt/f2fs -o mode=lfs,noextent_cache
cd /mnt/f2fs
f2fs_io write 1 0 1024 rand dsync testfile
xfs_io testfile -c "fsync"
f2fs_io write 1 0 512 rand dsync testfile
xfs_io testfile -c "fsync"
cd /
umount /mnt/f2fs
mount /dev/vdb /mnt/f2fs
f2fs_io precache_extents /mnt/f2fs/testfile
umount /mnt/f2fs

         f2fs_io-760     [028] .....   407.418603: f2fs_update_read_extent_tree_range: dev = (253,16), ino = 4, pgofs = 0, len = 512, blkaddr = 1055744, c_len = 0
         f2fs_io-760     [028] .....   407.418613: f2fs_update_read_extent_tree_range: dev = (253,16), ino = 4, pgofs = 513, len = 351, blkaddr = 17921, c_len = 0
         f2fs_io-760     [028] .....   407.418770: f2fs_update_read_extent_tree_range: dev = (253,16), ino = 4, pgofs = 864, len = 160, blkaddr = 18272, c_len = 0

During precache_extents, there is off-by-one issue, we should update
map->m_next_extent to pgofs rather than pgofs + 1, if last blkaddr is
valid and not contiguous to previous extent.

Fixes: c4020b2da4c9 ("f2fs: support F2FS_IOC_PRECACHE_EXTENTS")
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/data.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index c4d80bffb559..35408f8c3d1c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1788,8 +1788,11 @@ int f2fs_map_blocks(struct inode *inode, struct f2fs_map_blocks *map, int flag)
 				start_pgofs, map->m_pblk + ofs,
 				map->m_len - ofs);
 		}
-		if (map->m_next_extent)
-			*map->m_next_extent = pgofs + 1;
+		if (map->m_next_extent) {
+			*map->m_next_extent = pgofs;
+			if (!__is_valid_data_blkaddr(blkaddr))
+				*map->m_next_extent += 1;
+		}
 	}
 	f2fs_put_dnode(&dn);
 unlock_out:
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
