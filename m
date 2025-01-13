Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64504E7719E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 13 Jan 2025 06:13:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tXDhK-0007bi-Je;
	Mon, 13 Jan 2025 06:13:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chenzhangqi79@163.com>) id 1tXDhD-0007bY-Kr
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jan 2025 06:13:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WaGp55VFeVfQ+CP2av31VMxXyNUuax0zO9FIBMwzu+4=; b=EqPAdI71dE8IX+Ei6f9lsjeWr6
 IQxflAfOdRjUSkO0fbw+bUmB/Fm1Rpc3Kr4D9JOANKo4sFwUwqi/h5uIQR89R+6jVJSy2izy5zCDK
 7xElEUw6EQ7NxMBKbyRoWXEDQLrTDEaZ5uYUpD/dP8UHL4hTtURVomdM1BwgpCfdhuMU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WaGp55VFeVfQ+CP2av31VMxXyNUuax0zO9FIBMwzu+4=; b=I
 AjBNS7VoWd8K5QCJg/xUDE8TnqSaIL/3njcdUpeveTcxZJp3WIHBIVtZ2k7T8/Wz8jfamB7rNrf1q
 OguqQyZQSjhFlENyzkpi53uNH7R68w9TXFp1rMYUdj2msy02cvIDIZViJIoI7KWnaZ33dC3sdvbfr
 VQsQt5UfmMjD3F84=;
Received: from m16.mail.163.com ([117.135.210.2])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtp (Exim 4.95)
 id 1tXDhA-0004oA-Nb for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 13 Jan 2025 06:13:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=WaGp5
 5VFeVfQ+CP2av31VMxXyNUuax0zO9FIBMwzu+4=; b=JZqIIy9Bew8z8gIlqqUtW
 yyT/fXmQoZP8gFioRGzTqCHIaEMLAYjv+B3dzbqGn0JLXxkGQD9JkUv2nL/LAOLu
 FT8Bv+jD3D3MRNOYLYWfhKyq0zdXNcppcjbzndzXuGhPIMwHXXaSowpSAQp10XPL
 AfkJi0d7sPQ4aDIZaWDzeE=
Received: from czq-PC.mioffice.cn (unknown [])
 by gzga-smtp-mtada-g1-3 (Coremail) with SMTP id
 _____wAXaz4xq4RnZFVJFw--.52282S2; 
 Mon, 13 Jan 2025 13:57:05 +0800 (CST)
From: chenzhangqi79@163.com
To: jaegeuk@kernel.org,
	chao@kernel.org
Date: Mon, 13 Jan 2025 13:57:02 +0800
Message-Id: <20250113055702.1347172-1-chenzhangqi79@163.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CM-TRANSID: _____wAXaz4xq4RnZFVJFw--.52282S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWrZw4rAw4kZF4rCw1Utrb_yoW8XFWUpa
 4Y9F18GFn5uF4Uu39FqF1kWanY93ykKrZYkayruw1qvr13Jr9YkFn8Ka4vqF1xKF4kCF15
 tr1SkryfGF4UAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j5NVgUUUUU=
X-Originating-IP: [1.202.162.71]
X-CM-SenderInfo: hfkh065kdqw1rlxzqiywtou0bp/1tbi7gDSnWeDJQE98wABsu
X-Headers-End: 1tXDhA-0004oA-Nb
Subject: [f2fs-dev] [PATCH V0 RESEND] f2fs: fix error map extent flag while
 block not allocated
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
Cc: Zhijun Li <lizhijun3@xiaomi.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Zhangqi Chen <chenzhangqi@xiaomi.com>

In the function f2fs_fiemap, when returning the file
map extent flag, the flag of the delayed allocation
block is set to FIEMAP_EXTENT_UNWRITTEN . At the same
time, the phy address of the file map extent reassigned
to 0 because it is not a valid address.

In this way, the file map extent with address 0 and
FIEMAP_EXTENT_UNWRITTEN flag returned by ioctl, and
may be used for writing by userspace programs, thereby
destroying the superblock of the file system.

As mentioned in /Documentation/filesystems/fiemap.txt,
FIEMAP_EXTENT_UNWRITTEN should mean that the block has
been allocated but not filled with data. However, the
actual situation in f2fs is that there is no allocated
block, so it should be changed to FIEMAP_EXTENT_UNKNOWN
and FIEMAP_EXTENT_DELALLOC.

Co-developed-by: Zhijun Li <lizhijun3@xiaomi.com>
Signed-off-by: Zhijun Li <lizhijun3@xiaomi.com>
Signed-off-by: Zhangqi Chen <chenzhangqi@xiaomi.com>
---
 fs/f2fs/data.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2ec0cfb41260..a945d1f1d40c 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2023,7 +2023,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 				size += F2FS_BLKSIZE;
 			}
 		} else if (map.m_flags & F2FS_MAP_DELALLOC) {
-			flags = FIEMAP_EXTENT_UNWRITTEN;
+			flags = FIEMAP_EXTENT_UNKNOWN | FIEMAP_EXTENT_DELALLOC;
 		}
 
 		start_blk += F2FS_BYTES_TO_BLK(size);
-- 
2.20.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
