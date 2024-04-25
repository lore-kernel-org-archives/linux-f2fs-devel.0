Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D2B4C4345F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Apr 2024 08:58:56 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rzuwP-0003Q1-AA;
	Thu, 25 Apr 2024 08:58:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rzuwN-0003Pb-Be
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Apr 2024 08:58:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8vj1jRxeWt3kht+ogkkZcalD7A9KTk/C0AZbc8LD+og=; b=h6X7e3HIeHCT2AM30t7X3FDxlV
 m0E88NlVpttXtt1mWS2285VBqqaLVbdijkEeCrtxlfCJZr7O9fbl/3UhLSxkfYqDRzHOhLH9VwYfT
 djhvpd0uUbU2lIzbts8tFUxdfz+YlQvA2wddIdCfWqgx9Scr3nsqjiQrcfBJjT3gNWJg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=8vj1jRxeWt3kht+ogkkZcalD7A9KTk/C0AZbc8LD+og=; b=O
 udcDI3dN0GjUlcmIQVs04sW+PXQkyvItgS24aQqor3NfJ/Dtz0eiOskjxVwlu6OS8Yv60Fy44gZu8
 +Zh2wVU1vDo2doe1vw615qGjsuIaxK70sfA+xezVGFNCOkVCnhIdGFfyhAo2OFK1reN1NDSFFZdob
 JFcj3Txf5ZZnE1KM=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rzuwM-00080I-Ij for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 25 Apr 2024 08:58:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A432C61DC9;
 Thu, 25 Apr 2024 08:58:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96D3C113CC;
 Thu, 25 Apr 2024 08:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1714035525;
 bh=EaBSbJOHv52HBKklQSKkdSNTrsJUV+9br8OituPzzVw=;
 h=From:To:Cc:Subject:Date:From;
 b=R3gJnOIyGb2+MfqBAwTRrvF9QeF7rcYlA/BSXv2f3bY/WLiVWw7MSI2mGD9mG6Ee6
 O4cTKwqXzpbHcTo8rcNg5B49anf2Fj/iQAmLFCWDtU7RpFdcU3kK6cvlfcW4DTMZol
 Ydnd2tRMU4iyYS7uwKqbo/YHBPt56gOT9GL7W3/YJlHtr27ZILxMMi4/iMkxIT9n0K
 bmWDk+MNhrNu2yKs5Xw2kFFv8Pm732p9fkowf/VN8hjbRoa/BF7tv5C7GP2doyuikU
 1kgP1UjotydpOrsga3F873E0rtWHr0rpYXI3TPTgH1Yo6mgMwHmcG5sB7zamw/IoLo
 ffwyMRBAv4OLA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Thu, 25 Apr 2024 16:58:38 +0800
Message-Id: <20240425085838.4032657-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1rzuwM-00080I-Ij
Subject: [f2fs-dev] [PATCH] f2fs: fix to do sanity check on i_xattr_nid in
 sanity_check_inode()
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
Cc: syzbot+3694e283cf5c40df6d14@syzkaller.appspotmail.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

syzbot reports a kernel bug as below:

F2FS-fs (loop0): Mounted with checkpoint version = 48b305e4
==================================================================
BUG: KASAN: slab-out-of-bounds in f2fs_test_bit fs/f2fs/f2fs.h:2933 [inline]
BUG: KASAN: slab-out-of-bounds in current_nat_addr fs/f2fs/node.h:213 [inline]
BUG: KASAN: slab-out-of-bounds in f2fs_get_node_info+0xece/0x1200 fs/f2fs/node.c:600
Read of size 1 at addr ffff88807a58c76c by task syz-executor280/5076

CPU: 1 PID: 5076 Comm: syz-executor280 Not tainted 6.9.0-rc5-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x169/0x550 mm/kasan/report.c:488
 kasan_report+0x143/0x180 mm/kasan/report.c:601
 f2fs_test_bit fs/f2fs/f2fs.h:2933 [inline]
 current_nat_addr fs/f2fs/node.h:213 [inline]
 f2fs_get_node_info+0xece/0x1200 fs/f2fs/node.c:600
 f2fs_xattr_fiemap fs/f2fs/data.c:1848 [inline]
 f2fs_fiemap+0x55d/0x1ee0 fs/f2fs/data.c:1925
 ioctl_fiemap fs/ioctl.c:220 [inline]
 do_vfs_ioctl+0x1c07/0x2e50 fs/ioctl.c:838
 __do_sys_ioctl fs/ioctl.c:902 [inline]
 __se_sys_ioctl+0x81/0x170 fs/ioctl.c:890
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The root cause is we missed to do sanity check on i_xattr_nid during
f2fs_iget(), so that in fiemap() path, current_nat_addr() will access
nat_bitmap w/ offset from invalid i_xattr_nid, result in triggering
kasan bug report, fix it.

Reported-by: syzbot+3694e283cf5c40df6d14@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/linux-f2fs-devel/00000000000094036c0616e72a1d@google.com
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/inode.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index d7a5a88a1a5e..7968b14d49f4 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -362,6 +362,12 @@ static bool sanity_check_inode(struct inode *inode, struct page *node_page)
 		return false;
 	}
 
+	if (fi->i_xattr_nid && f2fs_check_nid_range(sbi, fi->i_xattr_nid)) {
+		f2fs_warn(sbi, "%s: inode (ino=%lx) has corrupted i_xattr_nid: %u, run fsck to fix.",
+			  __func__, inode->i_ino, fi->i_xattr_nid);
+		return false;
+	}
+
 	return true;
 }
 
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
