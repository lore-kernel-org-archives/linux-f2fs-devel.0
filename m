Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC121C54E66
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 14 Mar 2024 02:06:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rkaTm-0001Pf-BX;
	Thu, 14 Mar 2024 02:05:58 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1rkaTl-0001PX-7o
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 14 Mar 2024 02:05:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=tFUUtBp9n+ynKjcHPbLuOsVf4oOV8yFY+mkgp47oTao=; b=Vh7vEyeTFCg55uOOx38Sr3y0y3
 GvwuxosGuUVfca+2ptccf5f9b6JPo4qLWBLDzIOJg0EDkS0zjkxK4tnnfFZXnt2o/e8SLWDb8yY/i
 qVNZk9cazccVzDLKlzYTV/AhdxGmAiw3/I/2Xt55YJZ3WM1vmKY218NWmK2kUZvwflhw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=tFUUtBp9n+ynKjcHPbLuOsVf4oOV8yFY+mkgp47oTao=; b=R
 85+6CVA843j6Jrv59CRCOzc7G21CX+xU822URL980XtH5duymSAol6j3svdY5RlBSS7Ne8Ciu7oTH
 537ZQH6gybANpHXIo4ciKd90GagRQEm09T2OYSZEjssy6bXzcKRAyT3Qz52KodJ22oz23gDP7L1jJ
 l2gi4u0cLKAZo6jQ=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rkaTY-0006se-VH for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 14 Mar 2024 02:05:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id A0F8A615C3;
 Thu, 14 Mar 2024 02:05:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 966EDC433C7;
 Thu, 14 Mar 2024 02:05:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1710381940;
 bh=U7PYq18bfRAU5ibN6PAzHt9sq4pbBVTYfvTtQlSUZlw=;
 h=From:To:Cc:Subject:Date:From;
 b=tG8OoOuQWZabqbTq5kUgMK1AS0e1VYZ40UHH/2aY9rWy9ExRjXLLG8eAcaL4joGxa
 IepwJt7C4afXJY9ALttZn4h+YFUNvsz3dDtiy4vhtTc4efMpZj52r42ExvGA9ON8iA
 QJ5Q/5A3omSFYi4tJKAPflQOh97EOcp/Nb9z52HaXyvqWDYeXNFDtM/Mg+ELdySrEF
 rI74jCaA+29INrSgvSffGgque6QaE5JGzJtzJJs6tbKJl+SyAj/QJKhOpyRGkbDXTQ
 zAC8H8fpUoRki5d/jCK0uKAvTxM2FEhR7r2L8rLk0FgGNuD6psx92Jko55f9oeAxaH
 +RcAlbJoMQSRA==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Date: Thu, 14 Mar 2024 10:05:28 +0800
Message-Id: <20240314020528.3051533-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
X-Headers-End: 1rkaTY-0006se-VH
Subject: [f2fs-dev] [PATCH] f2fs: fix to avoid use-after-free issue in
 f2fs_filemap_fault
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
Cc: Hillf Danton <hdanton@sina.com>, linux-kernel@vger.kernel.org,
 Ed Tsai <Ed.Tsai@mediatek.com>, linux-f2fs-devel@lists.sourceforge.net,
 syzbot+763afad57075d3f862f2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

syzbot reports a f2fs bug as below:

BUG: KASAN: slab-use-after-free in f2fs_filemap_fault+0xd1/0x2c0 fs/f2fs/file.c:49
Read of size 8 at addr ffff88807bb22680 by task syz-executor184/5058

CPU: 0 PID: 5058 Comm: syz-executor184 Not tainted 6.7.0-syzkaller-09928-g052d534373b7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_address_description mm/kasan/report.c:377 [inline]
 print_report+0x163/0x540 mm/kasan/report.c:488
 kasan_report+0x142/0x170 mm/kasan/report.c:601
 f2fs_filemap_fault+0xd1/0x2c0 fs/f2fs/file.c:49
 __do_fault+0x131/0x450 mm/memory.c:4376
 do_shared_fault mm/memory.c:4798 [inline]
 do_fault mm/memory.c:4872 [inline]
 do_pte_missing mm/memory.c:3745 [inline]
 handle_pte_fault mm/memory.c:5144 [inline]
 __handle_mm_fault+0x23b7/0x72b0 mm/memory.c:5285
 handle_mm_fault+0x27e/0x770 mm/memory.c:5450
 do_user_addr_fault arch/x86/mm/fault.c:1364 [inline]
 handle_page_fault arch/x86/mm/fault.c:1507 [inline]
 exc_page_fault+0x456/0x870 arch/x86/mm/fault.c:1563
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:570

The root cause is: in f2fs_filemap_fault(), vmf->vma may be not alive after
filemap_fault(), so it may cause use-after-free issue when accessing
vmf->vma->vm_flags in trace_f2fs_filemap_fault(). So it needs to keep vm_flags
in separated temporary variable for tracepoint use.

Fixes: 87f3afd366f7 ("f2fs: add tracepoint for f2fs_vm_page_mkwrite()")
Reported-and-tested-by: syzbot+763afad57075d3f862f2@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/lkml/000000000000e8222b060f00db3b@google.com
Cc: Ed Tsai <Ed.Tsai@mediatek.com>
Cc: Hillf Danton <hdanton@sina.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index a47c57e813bb..c19e55a3e50e 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -39,6 +39,7 @@
 static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 {
 	struct inode *inode = file_inode(vmf->vma->vm_file);
+	vm_flags_t flags = vmf->vma->vm_flags;
 	vm_fault_t ret;
 
 	ret = filemap_fault(vmf);
@@ -46,7 +47,7 @@ static vm_fault_t f2fs_filemap_fault(struct vm_fault *vmf)
 		f2fs_update_iostat(F2FS_I_SB(inode), inode,
 					APP_MAPPED_READ_IO, F2FS_BLKSIZE);
 
-	trace_f2fs_filemap_fault(inode, vmf->pgoff, vmf->vma->vm_flags, ret);
+	trace_f2fs_filemap_fault(inode, vmf->pgoff, flags, ret);
 
 	return ret;
 }
-- 
2.40.1



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
