Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3846E606A32C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Nov 2026 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=YieVS2Wi;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=gwI1PIGk;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=ccNNvsuE
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=rwoI3bLKgwdO6/iKjxwW9+pSEcsRWm1QoWyKeDGHT6U=; b=YieVS2WiyI6hOoYEZH1jae7PS3
	HbuxyjYwpm2rjwLsrDcOk0f3zwVL2qrljGOE9UjW2jw1/tSo6qHucCgOtJiw3WhLTRnrF/8SA0tjb
	/Ulr5jmc15lucXl6NDRH4i+BLXhB3/86mghF+yRuPGTHA0ZvJOkwiEyVx8tNw67BHhXs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xOvMs-000000002ec-2cEH;
	Thu, 05 Nov 2026 11:10:54 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3M2TsagkbAAw4ABwmxxq3m11up.s00sxq64q3o0z5qz5.o0y@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1xOvMq-000000002eW-47DX
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 11:10:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QOIwjIRpeVDqlXAgbw2FLrO0KLt63dq5HpsWbh7v4l4=; b=gwI1PIGk1MMkKFLUNQ+E1fjiEO
 vmXG0iYrk8FtsKZDCvuP5ESmNQIIouItrYbUZ6woUZ+mZPHLiec90z6fxCQdb8HlG/TFfDjq6buvn
 UEmkSnN1AFeyc3/sVj3L1kEm1qGqTkRm0aJ8zkwVrAM+HdCvumPjQb6gfmDEM/Ugc2jg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QOIwjIRpeVDqlXAgbw2FLrO0KLt63dq5HpsWbh7v4l4=; b=ccNNvsuElGq185JFCDEQTLAZMc
 18wGwwMqY/vkwElfplJ9G5vDn7wvbxm+FfQ5mQsXRMiAkg85dcpRnX88vm61YZzxUP20xb1+98QcT
 UVyhBNE5sqA6kqlCIjcnR63q3d/EM95n8Gfrs1xYe4DKfvyxNW+pABHxEPu9UnvIGXXs=;
Received: from mail-ot1-f69.google.com ([209.85.210.69])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xOvMn-000000006PZ-0Rf6
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Nov 2026 11:10:52 +0000
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-823d73ffca1so2607715a34.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 05 Nov 2026 03:10:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793877043; x=1794481843;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=QOIwjIRpeVDqlXAgbw2FLrO0KLt63dq5HpsWbh7v4l4=;
 b=yeJN2NcvNdgTQrC1xzKx5vmNrq7FtuZbGteXAhnRtMHkrXD0hpkqN3zeEPV7in7b3O
 hlPt0fovAUbMEznHoxKiM7Uv105MO6tP4nvj6XGfLaGpx9FsUOcdxtrrpM1eL5q0oLzC
 RVGpXY/Y1j+FWz0taW8vxUlCy6dqzjzY0d/yFPPSi3N5u+OVMFlozELKCnjquw4yRlI8
 28ccNBkFRpGFaErY5/N2ceoDBA62LkSLO/De7jTitDWWKVtArge6kXYGQt57TEZK/AfS
 qZqac0RESY++m+tMPo+pFnpqBpGz51INfaPd9hLvYBy81bymWD10lMxvORy1k74XhLmt
 W3cg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzJ5adi8OJQp9SZRVeOsY16v8Uwcwo+Ak2CYYbMhmZZXmtPdJTXQ76TI1ceVNvDQD8QgjaOzixx1kE5zOfeHMXT@lists.sourceforge.net
X-Gm-Message-State: APuU4Z9dMR9S4IOhg3PmGOVGY1q0Qv64TyNRH8Kz41fd3wvlvc75wbQD
 cJMuQsZpZgpCDy+Vr8kC2WX9FVzoreL5LIimbhoUsGWKWaZK+cozLFrmnWk0XufWe8M29bd13Z7
 b10CfPEJRCezh1AQBJls38Yf88+OfcZ+OxlWnELw0IdNqlfWVXZqaI5Ymbd8=
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1783:b0:4fb:ac9b:b06a with SMTP id
 5614622812f47-5640de0fc9emr14499827b6e.48.1793877043501; Thu, 05 Nov 2026
 03:10:43 -0800 (PST)
Date: Thu, 05 Nov 2026 03:10:43 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6aec6433.0ce67c00.35143.0002.GAE@google.com>
From: syzbot <syzbot+d60be66dd00b4490fa96@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, jgg@ziepe.ca, leon@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 linux-rdma@vger.kernel.org, syzkaller-bugs@googlegroups.com
X-Spam-Score: 3.1 (+++)
X-Headers-End: 1xOvMn-000000006PZ-0Rf6
Subject: [f2fs-dev] [syzbot] [rdma?] [f2fs?] memory leak in
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

Hello,

syzbot found the following issue on:

HEAD commit:    6628e7d4c6b2 Linux 7.4-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=149fc6b1580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=441b6cc593d83cc4
dashboard link: https://syzkaller.appspot.com/bug?extid=d60be66dd00b4490fa96
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1613be2d580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bd1857dac9bc/disk-6628e7d4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0750834263ca/vmlinux-6628e7d4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ef4090776a72/bzImage-6628e7d4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/b8af1c9e7f1c/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=16e69cdd580000)

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
unreferenced object 0xffff88810d78f488 (size 576):
  comm "syz.1.32", pid 7505, jiffies 4294948085
  hex dump (first 32 bytes):
    0c 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    40 e5 f3 11 81 88 ff ff a0 f4 78 0d 81 88 ff ff  @.........x.....
  backtrace (crc d8883653):
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
unreferenced object 0xffff88810d792920 (size 576):
  comm "syz.1.32", pid 7505, jiffies 4294948085
  hex dump (first 32 bytes):
    06 09 00 00 00 00 00 00 88 f4 78 0d 81 88 ff ff  ..........x.....
    40 e5 f3 11 81 88 ff ff 38 29 79 0d 81 88 ff ff  @.......8)y.....
  backtrace (crc 415aa5b6):
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
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
