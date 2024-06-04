Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE23EC27C52
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Jun 2024 07:57:01 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sEP2Q-0006Ex-Qt;
	Tue, 04 Jun 2024 07:56:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sEP2P-0006Eh-Dp
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Jun 2024 07:56:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ITGrlqJRN+pElsMl1Ef+phFWmPYSyAJOia0KXho7Bv8=; b=eglAhvfbSeTws3+FG4kF6ovdrG
 Ua2R3BYUanZu6c6NzdQkIH6ee/jDt9qf9O1GXqkpbDMXfWkWHl0QgArQiuofFY3qwrXUSc3Jbe5cw
 R1GgozZtaPcdI6V/yvYPV4MTv+X6KitmwSYg8s6XaqKlNG9uP+ALcm1G4q2kdGgjrmrc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=ITGrlqJRN+pElsMl1Ef+phFWmPYSyAJOia0KXho7Bv8=; b=K
 PJ33xxCJ59/vc1dgFxjyK0cGv1Hf+oR329HA7Ocf1ZBK25/j+fvQNBHr925V1r1fZJvvxixHmeMeF
 sjdkvMf+K8HcrPVRvgeWiLpOvSBhQEmw46m9LUnPW7meASsFHg4h2vqw/+Ys5bKyqC0PAqwQI2ENz
 2/Ub3QPCl9cD/vTM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sEP2P-0004b7-QT for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Jun 2024 07:56:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id ADDAA60B2D;
 Tue,  4 Jun 2024 07:56:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BAC81C2BBFC;
 Tue,  4 Jun 2024 07:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1717487811;
 bh=Th/bB0ynCfO7mBhDp66CrCHTDuadKccCIQuJMOSIRY4=;
 h=From:To:Cc:Subject:Date:From;
 b=g3KvaiVU/xqeqaTzDV8nY3eNyEjqjPfyvo3F7DXRzSODsuzx86qp5/8vnI+vebXqQ
 sozoykN1o+zTbkD3/SesWFwXLoDP0bqMpq5JfYdktaOqDJ4e2MWR8mpPDJp8ebG+BZ
 ngh4SeIBlf74V3zietQIhQowVewvVur/WjpF8CdsmYkvYwV43o9KIhTzaY3kRIk/8F
 cP9Dt1RfX/0J3q0Y42XBkacg1udQUf3SqIpfOhdP4RPH1Q/ITOcowWNFzGpeKENaO+
 exDEEk575mK74TugEOeC7gy8hfR+NY9w1Cc0yGTxlRxHRWinTOWLOTyiW5ML+zryVh
 v1pl5X8bRZQCA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Tue,  4 Jun 2024 15:56:36 +0800
Message-Id: <20240604075636.3126389-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1sEP2P-0004b7-QT
Subject: [f2fs-dev] [PATCH] f2fs: fix to don't dirty inode for readonly
 filesystem
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
Cc: syzbot+31e4659a3fe953aec2f4@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

syzbot reports f2fs bug as below:

kernel BUG at fs/f2fs/inode.c:933!
RIP: 0010:f2fs_evict_inode+0x1576/0x1590 fs/f2fs/inode.c:933
Call Trace:
 evict+0x2a4/0x620 fs/inode.c:664
 dispose_list fs/inode.c:697 [inline]
 evict_inodes+0x5f8/0x690 fs/inode.c:747
 generic_shutdown_super+0x9d/0x2c0 fs/super.c:675
 kill_block_super+0x44/0x90 fs/super.c:1667
 kill_f2fs_super+0x303/0x3b0 fs/f2fs/super.c:4894
 deactivate_locked_super+0xc1/0x130 fs/super.c:484
 cleanup_mnt+0x426/0x4c0 fs/namespace.c:1256
 task_work_run+0x24a/0x300 kernel/task_work.c:180
 ptrace_notify+0x2cd/0x380 kernel/signal.c:2399
 ptrace_report_syscall include/linux/ptrace.h:411 [inline]
 ptrace_report_syscall_exit include/linux/ptrace.h:473 [inline]
 syscall_exit_work kernel/entry/common.c:251 [inline]
 syscall_exit_to_user_mode_prepare kernel/entry/common.c:278 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:283 [inline]
 syscall_exit_to_user_mode+0x15c/0x280 kernel/entry/common.c:296
 do_syscall_64+0x50/0x110 arch/x86/entry/common.c:88
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

The root cause is:
- do_sys_open
 - f2fs_lookup
  - __f2fs_find_entry
   - f2fs_i_depth_write
    - f2fs_mark_inode_dirty_sync
     - f2fs_dirty_inode
      - set_inode_flag(inode, FI_DIRTY_INODE)

- umount
 - kill_f2fs_super
  - kill_block_super
   - generic_shutdown_super
    - sync_filesystem
    : sb is readonly, skip sync_filesystem()
    - evict_inodes
     - iput
      - f2fs_evict_inode
       - f2fs_bug_on(sbi, is_inode_flag_set(inode, FI_DIRTY_INODE))
       : trigger kernel panic

When we try to repair i_current_depth in readonly filesystem, let's
skip dirty inode to avoid panic in later f2fs_evict_inode().

Cc: stable@vger.kernel.org
Reported-by: syzbot+31e4659a3fe953aec2f4@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/000000000000e890bc0609a55cff@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/inode.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 8f2b9f62ef73..64cda1d77fe5 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -29,6 +29,9 @@ void f2fs_mark_inode_dirty_sync(struct inode *inode, bool sync)
 	if (is_inode_flag_set(inode, FI_NEW_INODE))
 		return;
 
+	if (f2fs_readonly(F2FS_I_SB(inode)->sb))
+		return;
+
 	if (f2fs_inode_dirtied(inode, sync))
 		return;
 
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
