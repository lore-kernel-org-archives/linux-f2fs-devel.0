Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A883C25B06
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 14 Aug 2022 16:29:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oNGUJ-0001DY-IB;
	Sun, 14 Aug 2022 16:29:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <sashal@kernel.org>) id 1oNGUI-0001DN-Mx
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 14 Aug 2022 16:29:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=31S8Yar2OivN3DYF/EJTKJi8PlWdrIlTAHIItGiTkm0=; b=mZ6Ptp4/ag2+qbdxLj9NoyklFW
 StQa6wpjKh06Rocb3ua3ymGrf5V9ZvINUY1dvC8qUK9afb/t3weaonFUMQxdEJPQvA9HW1fb5Lqn7
 2ZSwvz4KXt4YAbu1A9P5TCgBjmGtpOH8Waq00+sI0thwMxmY5iRAT31h34sPdRmfSsnM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=31S8Yar2OivN3DYF/EJTKJi8PlWdrIlTAHIItGiTkm0=; b=TbGPYC/XBYJby6Qp9L0i3zcgyJ
 nPnQukafdZ/QYuItzpZABwsuEhqFimPX5LromZdRdgp/4OV9oHHL943R0cMvQh98E4G83X/BZPhPw
 34p0XIpeMrP51dh+MdUMdYddsvBnbIJB1JttAoIB3c8DKoxCsRqOzvIagzAz5+BrLZVA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oNGUE-0000B3-SA for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 14 Aug 2022 16:29:18 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 7FB7460F97;
 Sun, 14 Aug 2022 16:29:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2EE7C433D6;
 Sun, 14 Aug 2022 16:29:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1660494548;
 bh=Qz4ncXoPoM7vugOgfR+vbf/bthx4RLKEb397z+CrCds=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=mCVZADOc6fY94QafbVw+3/9mwP8AmlJTs2W59dZ42orSc3nDPTgD/07PL9XP07sjZ
 F4NrWqriF4DH0GnLW34b5kQmDugzaLMEigBfczv/x3f5NsVRaKI7BRHa5VDKfkt6r8
 w1ylxccFD66EOA7N3ae0K5tEdVfQO/h/BmI4j/nPuSn35vMrQVcLODvTeXQiRkgwl+
 gqhsFe8HrcEYO2+rCOmtNII7wkfUPH0DvjRYXSaWzxaL0UIotsKt0qkWs1Nr6Lr9Sm
 8+J/CdMblYscesJGl2yoHbwZkcVHSNpL0Mp9wUGmi1oE4p+ih7h3IrNuwVHJXSiJL5
 VHrp57Ojxho4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Date: Sun, 14 Aug 2022 12:28:27 -0400
Message-Id: <20220814162833.2398478-12-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220814162833.2398478-1-sashal@kernel.org>
References: <20220814162833.2398478-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-Headers-End: 1oNGUE-0000B3-SA
Subject: [f2fs-dev] [PATCH AUTOSEL 5.4 12/16] f2fs: fix to avoid use
 f2fs_bug_on() in f2fs_new_node_page()
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
Cc: Sasha Levin <sashal@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Dipanjan Das <mail.dipanjan.das@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

From: Chao Yu <chao.yu@oppo.com>

[ Upstream commit 141170b759e03958f296033bb7001be62d1d363b ]

As Dipanjan Das <mail.dipanjan.das@gmail.com> reported, syzkaller
found a f2fs bug as below:

RIP: 0010:f2fs_new_node_page+0x19ac/0x1fc0 fs/f2fs/node.c:1295
Call Trace:
 write_all_xattrs fs/f2fs/xattr.c:487 [inline]
 __f2fs_setxattr+0xe76/0x2e10 fs/f2fs/xattr.c:743
 f2fs_setxattr+0x233/0xab0 fs/f2fs/xattr.c:790
 f2fs_xattr_generic_set+0x133/0x170 fs/f2fs/xattr.c:86
 __vfs_setxattr+0x115/0x180 fs/xattr.c:182
 __vfs_setxattr_noperm+0x125/0x5f0 fs/xattr.c:216
 __vfs_setxattr_locked+0x1cf/0x260 fs/xattr.c:277
 vfs_setxattr+0x13f/0x330 fs/xattr.c:303
 setxattr+0x146/0x160 fs/xattr.c:611
 path_setxattr+0x1a7/0x1d0 fs/xattr.c:630
 __do_sys_lsetxattr fs/xattr.c:653 [inline]
 __se_sys_lsetxattr fs/xattr.c:649 [inline]
 __x64_sys_lsetxattr+0xbd/0x150 fs/xattr.c:649
 do_syscall_x64 arch/x86/entry/common.c:50 [inline]
 do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
 entry_SYSCALL_64_after_hwframe+0x46/0xb0

NAT entry and nat bitmap can be inconsistent, e.g. one nid is free
in nat bitmap, and blkaddr in its NAT entry is not NULL_ADDR, it
may trigger BUG_ON() in f2fs_new_node_page(), fix it.

Reported-by: Dipanjan Das <mail.dipanjan.das@gmail.com>
Signed-off-by: Chao Yu <chao.yu@oppo.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 3dc7cc3d6ac6..b080d5c58f6c 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1240,7 +1240,11 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 		dec_valid_node_count(sbi, dn->inode, !ofs);
 		goto fail;
 	}
-	f2fs_bug_on(sbi, new_ni.blk_addr != NULL_ADDR);
+	if (unlikely(new_ni.blk_addr != NULL_ADDR)) {
+		err = -EFSCORRUPTED;
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		goto fail;
+	}
 #endif
 	new_ni.nid = dn->nid;
 	new_ni.ino = dn->inode->i_ino;
-- 
2.35.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
