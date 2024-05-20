Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 710ECC25B75
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 May 2024 01:23:57 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1s8rkr-0004AH-Io;
	Mon, 20 May 2024 01:23:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1s8rkr-0004A8-53
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 May 2024 01:23:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dsgb6SdsB4OWQ6oRMx+elb4zClhPDCkMqYb9gnkPMjg=; b=O1/P1rC9dqqizFSnj1oEdEUocm
 WS/xN1C+PyX7HNzLK6AGsrFp9MF9R3JhTu3JCk7kHBpQOcnOxL7y5Qux8JAVzhKRavztPbES1qL1l
 dG0vTLPce+Fhfj6vfzFP7kbCYejr3eTbxWSwtiTEqY+osh+XDdWO7UH3VVs9owSzZJzg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=dsgb6SdsB4OWQ6oRMx+elb4zClhPDCkMqYb9gnkPMjg=; b=N
 dO/D0+boVXWPObxaobhBCgJ1eMjfAA4+lAUa68hR7A8rpl+FZJKuQnr7GnM3F+FrmulS7/DuP9SyM
 9X3/HRvkofEK6j+aunKdjINCq6Gg3/YxZA2a+TULgXn0lotcAK0pEFr3C4BbIcydHKfW1OAze7xxH
 MsVVK7gc0raF+uz0=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1s8rkq-00070Q-6g for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 May 2024 01:23:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id AEFC8CE0A64;
 Mon, 20 May 2024 01:23:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 558AEC32781;
 Mon, 20 May 2024 01:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1716168222;
 bh=nJaAnZlV7G8UIvdkeNqKnHhMgwTeD6WOS4VGzx9vc6M=;
 h=From:To:Cc:Subject:Date:From;
 b=F4N21gwSvfnMb1MUqEs20LDkdi0yS+zdHZ6Y2E9zbVjQ6eTkzu5BcGN7aHc3qdEef
 xoRx5mGcPJLR/kgOkG1Jb8remTckQ5PdLpJdRviKSOj5ZZf7FxLKJNvvGo1lq8unwo
 dL4mrg1tYe+UByHpqWZxVJIuxO/a23NV1jxP84Dveay5WhUSdHKf0jGpEhrPpaOHdB
 HTc7HAofECmzxIPIdxtFsiS78wa2ZpNGDTgytAFNJ1K3xejo+ct8bNvIsijtLtf7jJ
 NAf+UauI3olZTguf9r7COsWto4eXNyXOj8Hwv3FssdlMiHamoug4JbsqZLb5VTg8S1
 ti0U+Y4uH+TcA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Mon, 20 May 2024 09:23:28 +0800
Message-Id: <20240520012328.516836-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1s8rkq-00070Q-6g
Subject: [f2fs-dev] [PATCH] f2fs: fix to truncate preallocated blocks in
 f2fs_file_open()
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
Cc: chenyuwen <yuwen.chen@xjmz.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

chenyuwen reports a f2fs bug as below:

Unable to handle kernel NULL pointer dereference at virtual address 0000000000000011
 fscrypt_set_bio_crypt_ctx+0x78/0x1e8
 f2fs_grab_read_bio+0x78/0x208
 f2fs_submit_page_read+0x44/0x154
 f2fs_get_read_data_page+0x288/0x5f4
 f2fs_get_lock_data_page+0x60/0x190
 truncate_partial_data_page+0x108/0x4fc
 f2fs_do_truncate_blocks+0x344/0x5f0
 f2fs_truncate_blocks+0x6c/0x134
 f2fs_truncate+0xd8/0x200
 f2fs_iget+0x20c/0x5ac
 do_garbage_collect+0x5d0/0xf6c
 f2fs_gc+0x22c/0x6a4
 f2fs_disable_checkpoint+0xc8/0x310
 f2fs_fill_super+0x14bc/0x1764
 mount_bdev+0x1b4/0x21c
 f2fs_mount+0x20/0x30
 legacy_get_tree+0x50/0xbc
 vfs_get_tree+0x5c/0x1b0
 do_new_mount+0x298/0x4cc
 path_mount+0x33c/0x5fc
 __arm64_sys_mount+0xcc/0x15c
 invoke_syscall+0x60/0x150
 el0_svc_common+0xb8/0xf8
 do_el0_svc+0x28/0xa0
 el0_svc+0x24/0x84
 el0t_64_sync_handler+0x88/0xec

It is because inode.i_crypt_info is not initialized during below path:
- mount
 - f2fs_fill_super
  - f2fs_disable_checkpoint
   - f2fs_gc
    - f2fs_iget
     - f2fs_truncate

So, let's relocate truncation of preallocated blocks to f2fs_file_open(),
after fscrypt_file_open().

Fixes: d4dd19ec1ea0 ("f2fs: do not expose unwritten blocks to user by DIO")
Reported-by: chenyuwen <yuwen.chen@xjmz.com>
Closes: https://lore.kernel.org/linux-kernel/20240517085327.1188515-1-yuwen.chen@xjmz.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c  | 28 +++++++++++++++++++++++++++-
 fs/f2fs/inode.c |  8 --------
 2 files changed, 27 insertions(+), 9 deletions(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index ef4cfb4436ef..058fcc83a2fc 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -554,6 +554,28 @@ static int f2fs_file_mmap(struct file *file, struct vm_area_struct *vma)
 	return 0;
 }
 
+static int finish_preallocate_blocks(struct inode *inode)
+{
+	int ret;
+
+	if (is_sbi_flag_set(F2FS_I_SB(inode), SBI_POR_DOING))
+		return 0;
+
+	inode_lock(inode);
+	if (!file_should_truncate(inode)) {
+		inode_unlock(inode);
+		return 0;
+	}
+
+	ret = f2fs_truncate(inode);
+	inode_unlock(inode);
+	if (ret)
+		return ret;
+
+	file_dont_truncate(inode);
+	return 0;
+}
+
 static int f2fs_file_open(struct inode *inode, struct file *filp)
 {
 	int err = fscrypt_file_open(inode, filp);
@@ -571,7 +593,11 @@ static int f2fs_file_open(struct inode *inode, struct file *filp)
 	filp->f_mode |= FMODE_NOWAIT | FMODE_BUF_RASYNC;
 	filp->f_mode |= FMODE_CAN_ODIRECT;
 
-	return dquot_file_open(inode, filp);
+	err = dquot_file_open(inode, filp);
+	if (err)
+		return err;
+
+	return finish_preallocate_blocks(inode);
 }
 
 void f2fs_truncate_data_blocks_range(struct dnode_of_data *dn, int count)
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 005dde72aff3..791c06e159fd 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -610,14 +610,6 @@ struct inode *f2fs_iget(struct super_block *sb, unsigned long ino)
 	}
 	f2fs_set_inode_flags(inode);
 
-	if (file_should_truncate(inode) &&
-			!is_sbi_flag_set(sbi, SBI_POR_DOING)) {
-		ret = f2fs_truncate(inode);
-		if (ret)
-			goto bad_inode;
-		file_dont_truncate(inode);
-	}
-
 	unlock_new_inode(inode);
 	trace_f2fs_iget(inode);
 	return inode;
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
