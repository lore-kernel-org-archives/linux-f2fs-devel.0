Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B91BF606A326
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  6 Nov 2026 08:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=jw3VmeW4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kg1dQxag;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=TcH3io+v
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:In-Reply-To:Date:MIME-Version:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Unsubscribe-Post:
	List-Owner; bh=IUfQX6IrAJQY+R/3SznOoUQbxdyjsb7riP23FmmJYK0=; b=jw3VmeW4C58eJd
	K/l5NPNE8th+aPaN3OwUM08rLeHAofyHOE7/Dut2G/P5W2Y891Sxl8c0ZHFlgo0URRAfgT5PtOQ4d
	BgYmEyNbzfJQV6FhEOGGsO5Fvr1/Mn36dSbGKG5h6yzwqoDOA9s1DqLp2f/EYgUphhb6ePO4dsuv5
	IZQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xPFX5-00000000097-0nsz;
	Fri, 06 Nov 2026 08:42:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3_5LtagkbADoouvgWhhanWlleZ.ckkchaqoanYkjpajp.Yki@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1xPFX4-00000000091-1CGk
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 08:42:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M8yDQ/yIYjf1yjkinMkq3f1GifKllueCDz6yFTcJFC8=; b=kg1dQxag7uMlmrUPktXIu9T7iy
 kzyr1IVfXzMeDJT+IJvpV6CaI3uCmGdfyu10JO4Aak55V6WPuCkBOs9AVtNncxVbEGYXCPu0iGElc
 /++7hJAL4xOaq3GiON3XwhxRmdYl413sfPHBTday5Kw0+ntzEKvkSHKu5UIfqXmOTAxc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M8yDQ/yIYjf1yjkinMkq3f1GifKllueCDz6yFTcJFC8=; b=TcH3io+vH23Hg6gAyh3Gza4Dom
 66tN9ucCMvLIuhZ2M2RkwuAz75iYPz9MYYbCrWdmWivAWt+TlPjfklp5vliPZEj3vWub1K5wDOL2i
 tpCtHixcAymC5q8nBL7zd8dKUc6gs5Z3SviBmz/xzc1BYKl5IcOezyF7lYdp+AyNGnqo=;
Received: from mail-oi1-f198.google.com ([209.85.167.198])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xPFX3-0000000038A-2LKn
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 06 Nov 2026 08:42:46 +0000
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-4db3db8687fso589750b6e.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 06 Nov 2026 00:42:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793954560; x=1794559360;
 h=content-type:to:from:subject:message-id:in-reply-to:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=M8yDQ/yIYjf1yjkinMkq3f1GifKllueCDz6yFTcJFC8=;
 b=vKIKd6ibkci5zG+8TISYMc+9RweQC3gfr2fEW0i7SJ/7/POizbk71/2KUDlis/9Gyw
 Q2ZPGp3O98U513MfeP9oSKqv2OUaWgiyAFx2ogoBR6S0TDI208X6Kn7PtQVmT7MLUb1J
 60KSkmNhk2u0Ef9osoKMMZ0TJSzZtVdpW0FjZ/gjNQD5BkwwNj5Mvikk8yzAUKlXUWSv
 kjvWoqyCNz8d07KhHNzKDtwaZdPn0gsytnEW1qHl+1Q1NKjY2gm37qEsaNEs3gLTlSOA
 2zupjr6HMdFkUgn9ZIYA0fC8yhw0QYWyP5L1u/ctXJj9GA/KLoktmmV+HVlvqMIOdTOp
 H4kA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxpBQ5sXY9XUdOF3SpGDoKs8YJAYOuWm3Xt58oKLT128cMe4P5A33GK97ocEH+94vk6p5+Gdr/OZBjSBRkwj5Wa@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+vQGhMHx/c1iDFL6RIkKw2nh3cqTVyHL4NcxYfulvAAevZQhcI
 yFdM8Pj0NJHpG3pl1IYOevQsr9/On6NZVrKjvHc2skjtN9pm3oLCRsU6wvH9CxLaZCS9u9HV2wB
 BJb+oW5V81OrqIWchCOVI0D+6UV3m+Dd4J62/mkInQ72yRThJ9MyYKySc9K0=
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:3097:b0:4b3:7b31:8df7 with SMTP id
 5614622812f47-567e0faab32mr1577450b6e.14.1793954559883; Fri, 06 Nov 2026
 00:42:39 -0800 (PST)
Date: Fri, 06 Nov 2026 00:42:39 -0800
In-Reply-To: <6aec6433.0ce67c00.35143.0002.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aed92ff.a716b02e.a4a62.0000.GAE@google.com>
From: syzbot <syzbot+d60be66dd00b4490fa96@syzkaller.appspotmail.com>
To: chao@kernel.org, edwards@nvidia.com, hemanth.selam@gmail.com, 
 jaegeuk@kernel.org, jgg@ziepe.ca, kartikey406@gmail.com, leon@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 linux-rdma@vger.kernel.org, michael.j.ruhl@intel.com, mrgolin@amazon.com, 
 syzkaller-bugs@googlegroups.com, yishaih@nvidia.com
X-Spam-Score: 3.1 (+++)
X-Headers-End: 1xPFX3-0000000038A-2LKn
Subject: Re: [f2fs-dev] [syzbot] [rdma?] [f2fs?] memory leak in
 radix_tree_insert (3)
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FROM_LOCAL_HEX,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

syzbot has found a reproducer for the following issue on:

HEAD commit:    d68ce4e71248 Merge tag 'mm-core-7.4-rc2' of git://git.kern..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
console output: https://syzkaller.appspot.com/x/log.txt?x=1781772d580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4361b1bb937ae1c4
dashboard link: https://syzkaller.appspot.com/bug?extid=d60be66dd00b4490fa96
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=169572fd580000

AI-generated root cause summary:
In lib/radix-tree.c:__radix_tree_create(), intermediate radix_tree_node
(xa_node) structures are allocated and linked into parent slots as the function
descends through tree levels (shift -= RADIX_TREE_MAP_SHIFT). If a subsequent
node allocation fails with -ENOMEM before reaching the leaf slot,
__radix_tree_create() returns the error immediately without unwinding or
deleting the newly allocated empty intermediate nodes. Consequently, slot-based
iterators such as radix_tree_for_each_slot() used during cleanup (e.g. in
uverbs_destroy_api() -> uapi_remove_range()) never encounter the empty nodes
(which have count == 0), causing those radix_tree_node objects to leak when the
containing object is destroyed.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=d60be66dd00b4490fa96

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d60be66dd00b4490fa96@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff8881102cb918 (size 576):
  comm "syz.1.20", pid 6842, jiffies 4294945826
  hex dump (first 32 bytes):
    0c 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 ef c5 11 81 88 ff ff 30 b9 2c 10 81 88 ff ff  ........0.,.....
  backtrace (crc c4ea6eb8):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4733 [inline]
    slab_alloc_node mm/slub.c:5033 [inline]
    kmem_cache_alloc_noprof+0x35b/0x3e0 mm/slub.c:5047
    radix_tree_node_alloc.constprop.0+0x81/0x1a0 lib/radix-tree.c:276
    __radix_tree_create lib/radix-tree.c:624 [inline]
    radix_tree_insert+0x140/0x390 lib/radix-tree.c:712
    uapi_add_elm drivers/infiniband/core/uverbs_uapi.c:27 [inline]
    uapi_add_elm drivers/infiniband/core/uverbs_uapi.c:16 [inline]
    uapi_add_get_elm+0x61/0x140 drivers/infiniband/core/uverbs_uapi.c:41
    uapi_merge_obj_tree drivers/infiniband/core/uverbs_uapi.c:178 [inline]
    uapi_merge_def+0x4c4/0xb60 drivers/infiniband/core/uverbs_uapi.c:297
    uapi_merge_def+0xf0/0xb60 drivers/infiniband/core/uverbs_uapi.c:286
    uverbs_alloc_api+0x85/0xc50 drivers/infiniband/core/uverbs_uapi.c:659
    ib_uverbs_create_uapi drivers/infiniband/core/uverbs_main.c:1140 [inline]
    ib_uverbs_add_one+0x1b1/0x350 drivers/infiniband/core/uverbs_main.c:1196
    add_client_context+0x290/0x480 drivers/infiniband/core/device.c:755
    enable_device_and_get+0x106/0x250 drivers/infiniband/core/device.c:1375
    ib_register_device drivers/infiniband/core/device.c:1503 [inline]
    ib_register_device+0x4fe/0x7f0 drivers/infiniband/core/device.c:1441
    siw_device_register drivers/infiniband/sw/siw/siw_main.c:71 [inline]
    siw_newlink drivers/infiniband/sw/siw/siw_main.c:433 [inline]
    siw_newlink+0x36a/0x3f0 drivers/infiniband/sw/siw/siw_main.c:415
    nldev_newlink+0x26f/0x3e0 drivers/infiniband/core/nldev.c:1859
    rdma_nl_rcv_msg+0x1ad/0x2d0 drivers/infiniband/core/netlink.c:195
    rdma_nl_rcv_skb.constprop.0.isra.0+0x175/0x1f0 drivers/infiniband/core/netlink.c:239
    netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
    netlink_unicast+0x3e0/0x530 net/netlink/af_netlink.c:1361

BUG: memory leak
unreferenced object 0xffff88811021f488 (size 576):
  comm "syz.1.20", pid 6842, jiffies 4294945826
  hex dump (first 32 bytes):
    06 09 00 00 00 00 00 00 18 b9 2c 10 81 88 ff ff  ..........,.....
    00 ef c5 11 81 88 ff ff a0 f4 21 10 81 88 ff ff  ..........!.....
  backtrace (crc 8219f7d7):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4733 [inline]
    slab_alloc_node mm/slub.c:5033 [inline]
    kmem_cache_alloc_noprof+0x35b/0x3e0 mm/slub.c:5047
    radix_tree_node_alloc.constprop.0+0x81/0x1a0 lib/radix-tree.c:276
    __radix_tree_create lib/radix-tree.c:624 [inline]
    radix_tree_insert+0x140/0x390 lib/radix-tree.c:712
    uapi_add_elm drivers/infiniband/core/uverbs_uapi.c:27 [inline]
    uapi_add_elm drivers/infiniband/core/uverbs_uapi.c:16 [inline]
    uapi_add_get_elm+0x61/0x140 drivers/infiniband/core/uverbs_uapi.c:41
    uapi_merge_obj_tree drivers/infiniband/core/uverbs_uapi.c:178 [inline]
    uapi_merge_def+0x4c4/0xb60 drivers/infiniband/core/uverbs_uapi.c:297
    uapi_merge_def+0xf0/0xb60 drivers/infiniband/core/uverbs_uapi.c:286
    uverbs_alloc_api+0x85/0xc50 drivers/infiniband/core/uverbs_uapi.c:659
    ib_uverbs_create_uapi drivers/infiniband/core/uverbs_main.c:1140 [inline]
    ib_uverbs_add_one+0x1b1/0x350 drivers/infiniband/core/uverbs_main.c:1196
    add_client_context+0x290/0x480 drivers/infiniband/core/device.c:755
    enable_device_and_get+0x106/0x250 drivers/infiniband/core/device.c:1375
    ib_register_device drivers/infiniband/core/device.c:1503 [inline]
    ib_register_device+0x4fe/0x7f0 drivers/infiniband/core/device.c:1441
    siw_device_register drivers/infiniband/sw/siw/siw_main.c:71 [inline]
    siw_newlink drivers/infiniband/sw/siw/siw_main.c:433 [inline]
    siw_newlink+0x36a/0x3f0 drivers/infiniband/sw/siw/siw_main.c:415
    nldev_newlink+0x26f/0x3e0 drivers/infiniband/core/nldev.c:1859
    rdma_nl_rcv_msg+0x1ad/0x2d0 drivers/infiniband/core/netlink.c:195
    rdma_nl_rcv_skb.constprop.0.isra.0+0x175/0x1f0 drivers/infiniband/core/netlink.c:239
    netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
    netlink_unicast+0x3e0/0x530 net/netlink/af_netlink.c:1361

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
