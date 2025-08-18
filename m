Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7011CA0EE4
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 18 Aug 2025 02:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:Message-ID:Date:To:Sender:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7mbLJ3vCY8BzUkoIyVeL7zNj6NR8pxMseoTgKkyZXoI=; b=asK61SA5DuNLLjdYBSflyuK2MQ
	ARsj5RHG/xTNV28uqQb1LJkJa07J2p8p0AM9yaEDMTuFKe0+7t8axDjIj8Tf1qSPUDGJeAqMubUXq
	0Y7Zbb/HJAIETLcPaR5hV3GFeozxfBe+3l8uxM6bvnJuEy+4zWmykxX6SJuKlVqR0g6A=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1unpJt-0002mY-GM;
	Mon, 18 Aug 2025 02:09:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1unpJr-0002mL-Qa
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 18 Aug 2025 02:09:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=oRaSYN2vyFUY4KxPSLuksWoL/j7890YdrKdpwpznFq8=; b=HrzE395AoM9DDqYyh79vr5bgaI
 z+aH6kmlSJFqBpClXLNbCUryL26nYB9+DsZDi8o2HlaHOWu2JGelYwx6jXQs43DwoSK5zcogjvqNx
 S3sDq/FMTa2VAE3w8bu2xefwFjQ5ZFIdVEVaSG97xXZS4o/PAc16X79oMcl8M/T+gVAQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=oRaSYN2vyFUY4KxPSLuksWoL/j7890YdrKdpwpznFq8=; b=m
 A8auUY0RrT8KpKH11FQWrhUc+mgst9ENZrHvNzOpzVmFEqMVMdBpfrVfTMgwc0bHlVvJY6AnVX+M3
 82A75tSlJ0WLWThP65mQJw2FY1mXBqEjrG3Fus8WhsUaDr5eZEMo5I91qcpAyFZM1l+IH+9WFRn/H
 0umpZKDNB/qHWD2Y=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1unpJr-0006Ek-9j for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 18 Aug 2025 02:09:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id D83EE5C53E2;
 Mon, 18 Aug 2025 02:09:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 243E8C4CEEB;
 Mon, 18 Aug 2025 02:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1755482984;
 bh=RZoPX6qoxbaE7E4S76HF9R2kVzcEwoopEK600mDDAeo=;
 h=From:To:Cc:Subject:Date:From;
 b=a6ElxozupGkH49ZesF/SDDHgg+UdIkv4eZSoMFFBVwogpBXnbu9NOM37hYrrEKIFt
 7njlMU/k4ITbOKzlMgguRKo73PFXmVdjH+SC5t22mGZgVx2Bv6riQh9gIKQ0nobJWT
 h5jrrn0yRDtA28tPeHQpHA6eBSIWu+btQlnnmQijzq2vASBTCpdVNHIB/wjPCYAH/W
 1l2WmMp81rFRp5W06BWpQz4Q5UwSmA739DgXBs3oJBNEEcPYjTsPsKsOCuldbI4axk
 WBFseR1RhSEN4aBUu4EvaXCElq5QK1npNo1GFXhr3LYBDtX3Z/7irgjPb1ycPBvySO
 Pwo+vbZ+P9wYg==
To: jaegeuk@kernel.org
Date: Mon, 18 Aug 2025 10:09:38 +0800
Message-ID: <20250818020939.3529802-1-chao@kernel.org>
X-Mailer: git-send-email 2.51.0.rc1.163.g2494970778-goog
MIME-Version: 1.0
X-Headers-End: 1unpJr-0006Ek-9j
Subject: [f2fs-dev] [PATCH 1/2] f2fs: fix to avoid NULL pointer dereference
 in f2fs_check_quota_consistency()
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: syzbot+d371efea57d5aeab877b@syzkaller.appspotmail.com,
 Hongbo Li <lihongbo22@huawei.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

syzbot reported a f2fs bug as below:

Oops: gen[  107.736417][ T5848] Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 UID: 0 PID: 5848 Comm: syz-executor263 Tainted: G        W           6.17.0-rc1-syzkaller-00014-g0e39a731820a #0 PREEMPT_{RT,(full)}
RIP: 0010:strcmp+0x3c/0xc0 lib/string.c:284
Call Trace:
 <TASK>
 f2fs_check_quota_consistency fs/f2fs/super.c:1188 [inline]
 f2fs_check_opt_consistency+0x1378/0x2c10 fs/f2fs/super.c:1436
 __f2fs_remount fs/f2fs/super.c:2653 [inline]
 f2fs_reconfigure+0x482/0x1770 fs/f2fs/super.c:5297
 reconfigure_super+0x224/0x890 fs/super.c:1077
 do_remount fs/namespace.c:3314 [inline]
 path_mount+0xd18/0xfe0 fs/namespace.c:4112
 do_mount fs/namespace.c:4133 [inline]
 __do_sys_mount fs/namespace.c:4344 [inline]
 __se_sys_mount+0x317/0x410 fs/namespace.c:4321
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

The direct reason is f2fs_check_quota_consistency() may suffer null-ptr-deref
issue in strcmp().

The bug can be reproduced w/ below scripts:
mkfs.f2fs -f /dev/vdb
mount -t f2fs -o usrquota /dev/vdb /mnt/f2fs
quotacheck -uc /mnt/f2fs/
umount /mnt/f2fs
mount -t f2fs -o usrjquota=aquota.user,jqfmt=vfsold /dev/vdb /mnt/f2fs
mount -t f2fs -o remount,usrjquota=,jqfmt=vfsold /dev/vdb /mnt/f2fs
umount /mnt/f2fs

So, before old_qname and new_qname comparison, we need to check whether
they are all valid pointers, fix it.

Reported-by: syzbot+d371efea57d5aeab877b@syzkaller.appspotmail.com
Fixes: d18535132523 ("f2fs: separate the options parsing and options checking")
Closes: https://lore.kernel.org/linux-f2fs-devel/689ff889.050a0220.e29e5.0037.GAE@google.com
Cc: Hongbo Li <lihongbo22@huawei.com>
Signed-off-by: Chao Yu <chao@kernel.org>
---
 fs/f2fs/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/super.c b/fs/f2fs/super.c
index 5aa9d650512d..465604fdc5dd 100644
--- a/fs/f2fs/super.c
+++ b/fs/f2fs/super.c
@@ -1219,7 +1219,8 @@ static int f2fs_check_quota_consistency(struct fs_context *fc,
 				goto err_jquota_change;
 
 			if (old_qname) {
-				if (strcmp(old_qname, new_qname) == 0) {
+				if (new_qname &&
+					strcmp(old_qname, new_qname) == 0) {
 					ctx->qname_mask &= ~(1 << i);
 					continue;
 				}
-- 
2.49.0



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
