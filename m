Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B245E7716D
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Dec 2024 06:10:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tIiar-0007L4-Qr;
	Wed, 04 Dec 2024 06:10:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dmantipov@yandex.ru>) id 1tIiap-0007Ky-Od
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Dec 2024 06:10:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8hWD62IZYAeUJp3Omrw96qmRw3cdYlrJesm7kt67svE=; b=JAls2qSnfVsR/zoaxiVLCdjIZz
 oHmG2rPjpA78huwc3R881Ov+fQNg4CsFyQ/iVWM7orX9EYL8I/QTkNQL3vLUY/oy8atinhkbqFhTu
 0PxG0XQQ9443O3eyZNf6FyrcQkE16tL1EnF6/8NIKhqt1pbTAYUxlIYbHSIr2Uw4VRrc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8hWD62IZYAeUJp3Omrw96qmRw3cdYlrJesm7kt67svE=; b=G
 RZB9eSOs27Jn1886bjgwbm5CEh/81JcoGNXRQpWRqfPjwXKwEu8Mza/DKs/ovhg5sEo8A9mKjQD4J
 gVP3uPAQo36OXhN/g9v1OEfB3uocmDYB+6b21c8whq226DaL3LyVs8DJG92shmaBMXugj3UypwWkm
 sxrAeonvADIBFpMc=;
Received: from forward100b.mail.yandex.net ([178.154.239.147])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tIiao-0001xH-AS for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Dec 2024 06:10:36 +0000
Received: from mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net
 (mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net
 [IPv6:2a02:6b8:c10:2222:0:640:c513:0])
 by forward100b.mail.yandex.net (Yandex) with ESMTPS id E2BD760ED4;
 Wed,  4 Dec 2024 09:10:21 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net
 (smtp/Yandex) with ESMTPSA id KAZlHoFMpGk0-YLjjREcj; 
 Wed, 04 Dec 2024 09:10:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
 t=1733292621; bh=8hWD62IZYAeUJp3Omrw96qmRw3cdYlrJesm7kt67svE=;
 h=Message-ID:Date:Cc:Subject:To:From;
 b=CevgJG41h6uhOkpV4S6cGZPaFg/E5FdGAWpifLyvo4zJfbzc6MO8iBjmvkF2givGO
 rF4R2r8McfJ613AFen+XweWbGYy/nJVC0SjhBZKbLesimUlfjBI9lIS35p7NHoqj+3
 RgA5fdk+nSejL4E+79s+k3dp86NYk5mt6nxeiazA=
Authentication-Results: mail-nwsmtp-smtp-production-main-10.sas.yp-c.yandex.net;
 dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <chao@kernel.org>
Date: Wed,  4 Dec 2024 09:09:34 +0300
Message-ID: <20241204060934.697070-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
X-Headers-End: 1tIiao-0001xH-AS
Subject: [f2fs-dev] [PATCH] f2fs: ensure that node info flags are always
 initialized
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
Cc: linux-fsdevel@vger.kernel.org,
 syzbot+5141f6db57a2f7614352@syzkaller.appspotmail.com,
 Dmitry Antipov <dmantipov@yandex.ru>, lvc-project@linuxtesting.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Syzbot has reported the following KMSAN splat:

BUG: KMSAN: uninit-value in f2fs_new_node_page+0x1494/0x1630
 f2fs_new_node_page+0x1494/0x1630
 f2fs_new_inode_page+0xb9/0x100
 f2fs_init_inode_metadata+0x176/0x1e90
 f2fs_add_inline_entry+0x723/0xc90
 f2fs_do_add_link+0x48f/0xa70
 f2fs_symlink+0x6af/0xfc0
 vfs_symlink+0x1f1/0x470
 do_symlinkat+0x471/0xbc0
 __x64_sys_symlink+0xcf/0x140
 x64_sys_call+0x2fcc/0x3d90
 do_syscall_64+0xd9/0x1b0
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Local variable new_ni created at:
 f2fs_new_node_page+0x9d/0x1630
 f2fs_new_inode_page+0xb9/0x100

So adjust 'f2fs_new_node_page()' to ensure that 'flag' field of on-stack
'struct node_info' is always zeroed just like if it was allocated within
'struct nat_entry' via 'f2fs_kmem_cache_alloc(..., GFP_F2FS_ZERO, ...)'
in '__alloc_nat_entry()'.

Reported-by: syzbot+5141f6db57a2f7614352@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=5141f6db57a2f7614352
Fixes: e05df3b115e7 ("f2fs: add node operations")
Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 0b900a7a48e5..5103cc0d95c4 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1314,7 +1314,7 @@ struct page *f2fs_new_inode_page(struct inode *inode)
 struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
-	struct node_info new_ni;
+	struct node_info new_ni = { .flag = 0 };
 	struct page *page;
 	int err;
 
-- 
2.47.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
