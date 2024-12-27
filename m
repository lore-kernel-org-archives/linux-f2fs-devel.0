Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D96AE7718B
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 27 Dec 2024 09:50:28 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tR6zD-0007ee-I7;
	Fri, 27 Dec 2024 09:50:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chenzhangqi79@163.com>) id 1tR6zC-0007eY-DG
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Dec 2024 09:50:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WaGp55VFeVfQ+CP2av31VMxXyNUuax0zO9FIBMwzu+4=; b=YPH7muZpXgpuqJKDFGmQyhTMzL
 D+eWTam3oVBRpwFsoku2pj/Pbc9QIGQMiH2FDjjW+vBD7tapdKpnbCAoKvGiGQ2/oUUX5vPqnxeQ9
 bATVrmrl4bx4/77pmJUo06BdQRtGfoOd34J7Iv8rMcjnO2JQVwyF/ERWMSxMP7RpyvfE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WaGp55VFeVfQ+CP2av31VMxXyNUuax0zO9FIBMwzu+4=; b=S
 SztNE/PH9IfQxsdSkXmsEKxrWHarQNiuuCZSWA5I6f0lCZmf5rd2jnlTM9u5lw1sfEUjruqLjcKjH
 8UQhoGJGHd6bLsytkpJyakN0kFvg52ao0HBZ4I/hb4lCrmbCy19drJ0wlO8JamMg9GLoCPK4kHimZ
 RTJ9u283RXgRXnnU=;
Received: from m16.mail.163.com ([220.197.31.4])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtp (Exim 4.95)
 id 1tR6z9-0006eH-BQ for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 27 Dec 2024 09:50:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
 s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=WaGp5
 5VFeVfQ+CP2av31VMxXyNUuax0zO9FIBMwzu+4=; b=RSZwtFakV0aJ9BeMOj4SF
 /rt4z8XZElcs0RNIoxZHU1u7T0z4FSbppqUN3OKpwticWqbGR+v4aMpwlotDeyDd
 O9vR8nWTjr2XhcsXA+zf9qmHJuTYZJ3+hno5s/I+ZyW6JdFvAFWxUyzTajT0GkU4
 mHk0vgtM4gqUzJ1RnFPwZQ=
Received: from czq-PC.mioffice.cn (unknown [1.202.162.71])
 by gzsmtp5 (Coremail) with SMTP id QCgvCgC3ROWWdG5nTLAEIg--.63118S2;
 Fri, 27 Dec 2024 17:34:15 +0800 (CST)
From: chenzhangqi79@163.com
To: chao@kernel.org
Date: Fri, 27 Dec 2024 17:32:51 +0800
Message-Id: <20241227093251.344503-1-chenzhangqi79@163.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-CM-TRANSID: QCgvCgC3ROWWdG5nTLAEIg--.63118S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7WrWrZw4rAw4kZF4rCw1Utrb_yoW8XFWUpa
 4Y9F18GFn5uF4Uu39FqF1kWanY93ykKrZYkayruw1qvr13Jr9YkFn8Ka4vqF1xKF4kCF15
 tr1SkryfGF4UAFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07j7YFAUUUUU=
X-Originating-IP: [1.202.162.71]
X-CM-SenderInfo: hfkh065kdqw1rlxzqiywtou0bp/1tbi7gXCnWdubFVAwQABsE
X-Headers-End: 1tR6z9-0006eH-BQ
Subject: [f2fs-dev] [PATCH] f2fs: fix error map extent flag while block not
 allocated
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
