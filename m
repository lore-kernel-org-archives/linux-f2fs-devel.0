Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5900ECAAD2
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 29 Aug 2022 21:52:26 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1oSmgB-0003hK-6b;
	Mon, 29 Aug 2022 21:52:23 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1oSmg9-0003hE-6A
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Aug 2022 21:52:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sipA4Bl6qZCNqNt7HIBeH1q0sfD0CXnhVp7xO476/uw=; b=Pvaoty48VR0OTbcLlyWKmOIjbu
 HjwpuxU6NiX/wR8kBQ8Pc5OpnfD6gXNu6HjTcoLeuu78RrS3nRh3NYUW6KrodnHqoxwY1blMrwRJI
 sgzt7i1ZOVPaPLWbT/gVaqb+b+f1ZxXCYzOCWtD0XPheTfnYPoXRFMRpVXiInN2CD9qA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sipA4Bl6qZCNqNt7HIBeH1q0sfD0CXnhVp7xO476/uw=; b=f
 OThrffuxxuM4EkkVNFYlnESoNsNZefSS/NmPRPv9LS73zZVBuf7/xh8xqws9rYCspIKhP91FoVX92
 A5++lSxZzoTq+iyr4jKKthIHEvUYReBvF+wemSeOfF61rnjDi5yKNoJTJKYmp861XLog/gNCmVGyf
 elFhVlv2O12VKZvQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1oSmg7-00073m-Fa for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 29 Aug 2022 21:52:20 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 452D4612A4;
 Mon, 29 Aug 2022 21:52:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031F3C433D7;
 Mon, 29 Aug 2022 21:52:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1661809929;
 bh=7Jc9lfPSa/RKCHMNGaoGKZTxV4IfoIxki5b/Q03tyDQ=;
 h=From:To:Cc:Subject:Date:From;
 b=SBNcYUJCWANaShZsh03IOumNVt1m4+Oo46saZ+khMm3JsraoWL8gGyWo5X8JzfRDB
 d8zeBvX4xqy65EX/AkiqwhQNjaC7E6i2aki4h51ll8ahHjzsaJ0JsQ5SF9CFm6Tb1K
 OFS+E+bQlebrJ72yPfWdBlR5l0hoKbPaIle8GrvQT96lcYWkfrp9strViU+yWHb8MX
 D1rTO5n25wRZr4mqabXFyYdc9iC1TdjKNVdBfHaBTl6T1UBxpFfLx4B/rp7oCj13bK
 DPXO5AV8VXi6OTuSOBJ41rzZQYftVdpyzNSgEXT3PlQlPE8ixfoiqF/NWjOMxuxzlY
 FQDlek4I0o54A==
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net
Date: Mon, 29 Aug 2022 14:52:06 -0700
Message-Id: <20220829215206.3082124-1-jaegeuk@kernel.org>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
MIME-Version: 1.0
X-Headers-End: 1oSmg7-00073m-Fa
Subject: [f2fs-dev] [PATCH] f2fs: fix missing mapping caused by the
 mount/umount race
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
 syzbot+775a3440817f74fddb8c@syzkaller.appspotmail.com, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Sometimes we can get a cached meta_inode which has no aops yet. Let's set it
all the time to fix the below panic.

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000000
Mem abort info:
  ESR = 0x0000000086000004
  EC = 0x21: IABT (current EL), IL = 32 bits
  SET = 0, FnV = 0
  EA = 0, S1PTW = 0
  FSC = 0x04: level 0 translation fault
user pgtable: 4k pages, 48-bit VAs, pgdp=0000000109ee4000
[0000000000000000] pgd=0000000000000000, p4d=0000000000000000
Internal error: Oops: 86000004 [#1] PREEMPT SMP
Modules linked in:
CPU: 1 PID: 3045 Comm: syz-executor330 Not tainted 6.0.0-rc2-syzkaller-16455-ga41a877bc12d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/22/2022
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : 0x0
lr : folio_mark_dirty+0xbc/0x208 mm/page-writeback.c:2748
sp : ffff800012783970
x29: ffff800012783970 x28: 0000000000000000 x27: ffff800012783b08
x26: 0000000000000001 x25: 0000000000000400 x24: 0000000000000001
x23: ffff0000c736e000 x22: 0000000000000045 x21: 05ffc00000000015
x20: ffff0000ca7403b8 x19: fffffc00032ec600 x18: 0000000000000181
x17: ffff80000c04d6bc x16: ffff80000dbb8658 x15: 0000000000000000
x14: 0000000000000000 x13: 0000000000000000 x12: 0000000000000000
x11: ff808000083e9814 x10: 0000000000000000 x9 : ffff8000083e9814
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff0000cbb19000 x4 : ffff0000cb3d2000 x3 : ffff0000cbb18f80
x2 : fffffffffffffff0 x1 : fffffc00032ec600 x0 : ffff0000ca7403b8
Call trace:
 0x0
 set_page_dirty+0x38/0xbc mm/folio-compat.c:62
 f2fs_update_meta_page+0x80/0xa8 fs/f2fs/segment.c:2369
 do_checkpoint+0x794/0xea8 fs/f2fs/checkpoint.c:1522
 f2fs_write_checkpoint+0x3b8/0x568 fs/f2fs/checkpoint.c:1679

Cc: stable@vger.kernel.org
Reported-by: syzbot+775a3440817f74fddb8c@syzkaller.appspotmail.com
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/inode.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 6d11c365d7b4..1feb0a8a699e 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -490,10 +490,7 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	if (!inode)
 		return ERR_PTR(-ENOMEM);
 
-	if (!(inode->i_state & I_NEW)) {
-		trace_f2fs_iget(inode);
-		return inode;
-	}
+	/* We can see an old cached inode. Let's set the aops all the time. */
 	if (ino == F2FS_NODE_INO(sbi) || ino == F2FS_META_INO(sbi))
 		goto make_now;
 
@@ -502,6 +499,11 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 		goto make_now;
 #endif
 
+	if (!(inode->i_state & I_NEW)) {
+		trace_f2fs_iget(inode);
+		return inode;
+	}
+
 	ret = do_read_inode(inode);
 	if (ret)
 		goto bad_inode;
@@ -557,7 +559,8 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 		file_dont_truncate(inode);
 	}
 
-	unlock_new_inode(inode);
+	if (inode->i_state & I_NEW)
+		unlock_new_inode(inode);
 	trace_f2fs_iget(inode);
 	return inode;
 
-- 
2.37.2.672.g94769d06f0-goog



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
