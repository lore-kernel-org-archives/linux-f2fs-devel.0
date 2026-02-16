Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81A07E7BDA4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 16 Feb 2026 11:29:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-ID:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=T3CDl8wezHBBw1KzMtqLIKY21UHi9BLPGWEUy+F0/Fw=; b=OXSjwkT4Au+Jic1t88qOHogzui
	JXbqyh9xt5YOrNUWi1mQmzchuTNnDtsHm7lGee+WpRNS4npGqSx8PGAJRFEfAG2n5P6oSSfaCbhqd
	mZkMRxGe3i7wt4j019oKzujahvGEm3ojc6ptkOqzXsLw+X9HCheCbRk/minGl3+bJOkI=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vrwmy-0004vW-53;
	Mon, 16 Feb 2026 11:29:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <monty_pavel@sina.com>) id 1vrwmw-0004vN-9Y
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Feb 2026 11:29:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CfvARkWSTO3N5ItJgj3aYFloorVfKdr+764UxnXWz4g=; b=DyF4dXavEN6APjKrD/NRMKK2E5
 iEaO2Ok0UgUPXaPz5GcjtptBXsiqRHJlUiOhpvnYCYHrrqwfoJ6WqNdDdMahAp/9vd/tVynJOPG5V
 lmYr5MRQcbPXBAD39pqsR2mic72Ftzf0Uvjehhl33D3j8rgaBFM2J7zLrOJQCJRircrs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CfvARkWSTO3N5ItJgj3aYFloorVfKdr+764UxnXWz4g=; b=Y
 6hik6cdNT5ktRRks0yDK6lMaDbtAqXoSRHXvns0/mYc0B7gBSqPAxCNZguAHx8wuZ6N4z4bBvU9ic
 vM/g3IjmBWfAM8msKg1ccLv/mqenv8RgwN/ifIcLH4tpB28T9GXaclvOloopUIi/awNypnJG7j6Cn
 /BNHwNrfK7mCcJtk=;
Received: from smtp153-163.sina.com.cn ([61.135.153.163])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vrwmu-0005iG-Vo for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 16 Feb 2026 11:29:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sina.com; s=201208;
 t=1771241353; bh=CfvARkWSTO3N5ItJgj3aYFloorVfKdr+764UxnXWz4g=;
 h=From:Subject:Date:Message-ID;
 b=XTc02bglUkGSx7hMYM5QXqSqYseZIzCmmBaV9Rd0Ss88xM587wIA/Xka5VP1pvBD5
 g+5aiBgDCHcQnJwJgoZJLZzDeVuPcCiAH80FwYS/eKoIZaD4irbXpV4UIMK606hqdx
 hRp2sk1deABOJzJbLUQihBj+18kfzw5402kfo9NY=
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([111.18.125.202])
 by sina.com (10.54.253.32) with ESMTP
 id 6992FF7D00003C1B; Mon, 16 Feb 2026 19:29:03 +0800 (CST)
X-Sender: monty_pavel@sina.com
X-Auth-ID: monty_pavel@sina.com
Authentication-Results: sina.com; spf=none smtp.mailfrom=monty_pavel@sina.com;
 dkim=none header.i=none;
 dmarc=none action=none header.from=monty_pavel@sina.com
X-SMAIL-MID: 6562494456614
X-SMAIL-UIID: 36BBCD939F794668BFB33F00E07EAFE8-20260216-192903-1
From: Yongpeng Yang <monty_pavel@sina.com>
To: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>
Date: Mon, 16 Feb 2026 19:28:42 +0800
Message-ID: <20260216112841.67508-2-monty_pavel@sina.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
X-Headers-End: 1vrwmu-0005iG-Vo
Subject: [f2fs-dev] [PATCH] f2fs-tools: invalidate block device page cache
 before reading metadata
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
Cc: Yongpeng Yang <yangyongpeng@xiaomi.com>,
 Yongpeng Yang <monty_pavel@sina.com>, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

After the device is mounted, f2fs updates on-disk metadata without
updating the block device page cache. As a result, f2fs-tools may read
stale metadata from the page cache.

For example:
mount /dev/vdb /mnt/f2fs
touch mx // ino = 4
sync
dump.f2fs -i 4 /dev/vdb
touch mx2 // ino = 5
sync
dump.f2fs -i 5 /dev/vdb // block addr is 0

Since `dump.f2fs -i 4 /dev/vdb` has already populated the metadata area
into the block device page cache, the cached pages remain resident in
memory. After creating mx2, the page cache is not updated accordingly.
Therefore, `dump.f2fs -i 5 /dev/vdb` reads stale metadata, and the
physical block address of inode 5 is incorrectly reported as 0.

This patch issues a BLKFLSBUF ioctl to the block device before reading
metadata. The kernel then invalidates the block device page cache,
ensuring that subsequent reads fetch uptodate metadata from disk.

Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 lib/libf2fs.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/libf2fs.c b/lib/libf2fs.c
index 1a496b7..31b5924 100644
--- a/lib/libf2fs.c
+++ b/lib/libf2fs.c
@@ -1027,6 +1027,7 @@ int get_device_info(int i)
 	}
 
 	dev->fd = fd;
+	ioctl(fd, BLKFLSBUF);
 
 	if (c.sparse_mode && i == 0) {
 		if (f2fs_init_sparse_file()) {
-- 
2.52.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
