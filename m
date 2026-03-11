Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 941DDFD88C6
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Mar 2026 11:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:In-Reply-To:Date:MIME-Version:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=Wg9RN246IoPwRAMMA2uJDzkYZobnHRUBk3AZVyok64A=; b=SK4JLl3sk1ykf31zBL345xMhnM
	hpcnV4r07wupwSFYbdbTZPzpxNXmSdxs5ludPGSAQ5jBNT7WmC7AgwMCF6lxS2FXEAMnT4RVrKDei
	1lhUkhdFcLcx1Hf68o21Y3w7SE+PJdpPQCAiSF0PwfyntUoug5U9hKXhQktAqGg7qs4o=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w0HLa-000093-Qo;
	Wed, 11 Mar 2026 11:03:26 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <36UuxaQkbAJoMSTE4FF8L4JJC7.AIIAF8OM8L6IHN8HN.6IG@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1w0HLR-00008j-CL for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Mar 2026 11:03:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=00o6g65oUdrN243+trpF7SWGsKEiuTr8VPwUn01kWqM=; b=WgKl3Wxs54itlTZC5tEJovohH2
 C70yZpt+b6coZmx9/6gV1lvvKvjl4i1NF0r37gAtzMKp+UrgqmCzTD3e4HL8uJTKFkTseGQgPElYK
 9qipZNCOG8TZvRgaXuGhw0Or00YB3PVNu1c5HeaVAGVq/pTbxdwXVbf+czkr+kpE7Hs0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=00o6g65oUdrN243+trpF7SWGsKEiuTr8VPwUn01kWqM=; b=e
 VzPGAp9HvdGQrLdqkPZNWEfV1EV1fudXfTTrf380oLJ2jJHrI59JSa9/L59ujRER7SXhMefKJGJPO
 xn3e/pOj75C7T646hCDCNzavKuTBDM4a+mTlaHD24ZQhDjLN7Q6zGkbYyMqqeM6m9OMvCLfEA4QBY
 9STk3LEIbjlDYUfg=;
Received: from mail-oo1-f70.google.com ([209.85.161.70])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1w0HLQ-0006Vc-HC for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Mar 2026 11:03:17 +0000
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-67a1e063795so8825259eaf.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Mar 2026 04:03:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773226986; x=1773831786;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=00o6g65oUdrN243+trpF7SWGsKEiuTr8VPwUn01kWqM=;
 b=utsnsrtjdysqI+3Ej8zt2g3iJxa6r3rPsPKmQIaC6JnEdwtCNizVbQUt5yxCXXRTKb
 rFUG9bZgQYmQAIEuWkGbCIHNmtjDL1WC7pRftQHJOd/AlflGEeRvYd6kEzyUhCDBC/gV
 cCBrlnFBI/Csbs1zAt5esL5eVK5c3NNy9ed5F7w4D6k/0gwYP3lr9RMfBdG9tpbi/PqA
 TL3oPKDBRQdZiajIvteuI3XHPKoeQ0qVUr2Th/S1Aydv+INS2S3n8sFsfuWlbFDCsG8p
 ICUSjMJEe384c+oTNP18yquDiWIpmq8zzOCADfT2Gbr8jq+yvPRq8lTyOiG+/wKmwiKd
 L9eA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAXn0GGSQbb9xS0gBaFnD9sqzi6zE1+LvBiD/P4zhnuBdhKqedYUnZ0FzGYv7BAXAoWMnQoi+rK3d8FQd4RNRD@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxniMi44yc9NWyL07CSeNSERDvxxKacFLo4/ZS0tIF72IK7t5yM
 1/PB3ei1SfXtoG3s+joZkAwBBYpoWJbgK1eNZ4UK0lbJSqW65jRavOTBHOuOf7ZrVhBIlXKP3Ga
 EH5zuuSIWSrgWO+NRIonUfUMI5btd93kRN4b4jNELZD8OXieY7ebh2qdos3g=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c9e:b0:67b:b63b:6fe4 with SMTP id
 006d021491bc7-67bbc7330d5mr4435697eaf.19.1773226985864; Wed, 11 Mar 2026
 04:03:05 -0700 (PDT)
Date: Wed, 11 Mar 2026 04:03:05 -0700
In-Reply-To: <20260311104855.102050-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b14be9.050a0220.209d0e.0001.GAE@google.com>
From: syzbot <syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chao@kernel.org, jaegeuk@kernel.org, 
 jannh@google.com, liam.howlett@oracle.com, linkinjeon@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
 pfalcato@suse.de, sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
 vbabka@suse.cz, wangqing7171@gmail.com
X-Headers-End: 1w0HLQ-0006Vc-HC
Subject: Re: [f2fs-dev] [syzbot] [mm?] [f2fs?] [exfat?] memory leak in
 __kfree_rcu_sheaf
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
memory leak in __pcs_replace_empty_main

BUG: memory leak
unreferenced object 0xffff88810005f800 (size 512):
  comm "swapper/0", pid 0, jiffies 4294937296
  hex dump (first 32 bytes):
    18 ca 17 2e 81 88 ff ff 00 b6 ad 81 ff ff ff ff  ................
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 9b7d1e76):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4550 [inline]
    slab_alloc_node mm/slub.c:4873 [inline]
    __do_kmalloc_node mm/slub.c:5266 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5279
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    alloc_full_sheaf mm/slub.c:2836 [inline]
    __pcs_replace_empty_main+0x1e0/0x2f0 mm/slub.c:4633
    alloc_from_pcs mm/slub.c:4724 [inline]
    slab_alloc_node mm/slub.c:4858 [inline]
    __kmalloc_cache_noprof+0x3ac/0x480 mm/slub.c:5382
    kmalloc_noprof include/linux/slab.h:950 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __irq_domain_alloc_fwnode+0x37/0x140 kernel/irq/irqdomain.c:95
    irq_domain_alloc_named_fwnode include/linux/irqdomain.h:271 [inline]
    arch_early_irq_init+0x1c/0x70 arch/x86/kernel/apic/vector.c:803
    start_kernel+0x931/0xb80 init/main.c:1114
    x86_64_start_reservations+0x24/0x30 arch/x86/kernel/head64.c:310
    x86_64_start_kernel+0xce/0xd0 arch/x86/kernel/head64.c:291
    common_startup_64+0x13e/0x148

BUG: memory leak
unreferenced object 0xffff8881008f6c00 (size 512):
  comm "kthreadd", pid 2, jiffies 4294937344
  hex dump (first 32 bytes):
    08 5e e1 28 81 88 ff ff 00 b6 ad 81 ff ff ff ff  .^.(............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 89324f2):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4550 [inline]
    slab_alloc_node mm/slub.c:4873 [inline]
    __do_kmalloc_node mm/slub.c:5266 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5279
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    alloc_full_sheaf mm/slub.c:2836 [inline]
    __pcs_replace_empty_main+0x1e0/0x2f0 mm/slub.c:4633
    alloc_from_pcs mm/slub.c:4724 [inline]
    slab_alloc_node mm/slub.c:4858 [inline]
    __kmalloc_cache_node_noprof+0x3ef/0x4e0 mm/slub.c:5395
    kmalloc_node_noprof include/linux/slab.h:1077 [inline]
    __get_vm_area_node+0xc6/0x1d0 mm/vmalloc.c:3221
    __vmalloc_node_range_noprof+0x1d3/0xe50 mm/vmalloc.c:4024
    __vmalloc_node_noprof+0x71/0x90 mm/vmalloc.c:4124
    alloc_thread_stack_node kernel/fork.c:355 [inline]
    dup_task_struct kernel/fork.c:924 [inline]
    copy_process+0x3e5/0x28c0 kernel/fork.c:2050
    kernel_clone+0xac/0x6e0 kernel/fork.c:2654
    kernel_thread+0x80/0xb0 kernel/fork.c:2715
    create_kthread kernel/kthread.c:459 [inline]
    kthreadd+0x186/0x250 kernel/kthread.c:817
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff8881023c6800 (size 512):
  comm "kworker/u8:3", pid 829, jiffies 4294937473
  hex dump (first 32 bytes):
    00 56 0a 2b 81 88 ff ff 00 fe 03 2b 81 88 ff ff  .V.+.......+....
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 175b82b9):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4550 [inline]
    slab_alloc_node mm/slub.c:4873 [inline]
    __do_kmalloc_node mm/slub.c:5266 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5279
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5729
    free_to_pcs mm/slub.c:5782 [inline]
    slab_free mm/slub.c:6177 [inline]
    kfree+0x352/0x390 mm/slub.c:6490
    call_usermodehelper_freeinfo kernel/umh.c:43 [inline]
    umh_complete kernel/umh.c:57 [inline]
    call_usermodehelper_exec_async+0x1c7/0x1f0 kernel/umh.c:119
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff8881023e9000 (size 512):
  comm "kworker/0:1", pid 10, jiffies 4294937519
  hex dump (first 32 bytes):
    e0 52 f6 28 81 88 ff ff 00 b6 ad 81 ff ff ff ff  .R.(............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc d8ec9e0d):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4550 [inline]
    slab_alloc_node mm/slub.c:4873 [inline]
    __do_kmalloc_node mm/slub.c:5266 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5279
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5729
    free_to_pcs mm/slub.c:5782 [inline]
    slab_free mm/slub.c:6177 [inline]
    kfree+0x352/0x390 mm/slub.c:6490
    blk_free_flush_queue+0x28/0x40 block/blk-flush.c:514
    srcu_invoke_callbacks+0x11a/0x1c0 kernel/rcu/srcutree.c:1941
    process_one_work+0x26c/0x5d0 kernel/workqueue.c:3275
    process_scheduled_works kernel/workqueue.c:3358 [inline]
    worker_thread+0x243/0x490 kernel/workqueue.c:3439
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888104850a00 (size 512):
  comm "kworker/0:1", pid 10, jiffies 4294937528
  hex dump (first 32 bytes):
    00 6c 8f 00 81 88 ff ff 00 10 0a 2b 81 88 ff ff  .l.........+....
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc c75772dc):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4550 [inline]
    slab_alloc_node mm/slub.c:4873 [inline]
    __do_kmalloc_node mm/slub.c:5266 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5279
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5729
    free_to_pcs mm/slub.c:5782 [inline]
    slab_free mm/slub.c:6177 [inline]
    kfree+0x352/0x390 mm/slub.c:6490
    blk_free_flush_queue+0x28/0x40 block/blk-flush.c:514
    srcu_invoke_callbacks+0x11a/0x1c0 kernel/rcu/srcutree.c:1941
    process_one_work+0x26c/0x5d0 kernel/workqueue.c:3275
    process_scheduled_works kernel/workqueue.c:3358 [inline]
    worker_thread+0x243/0x490 kernel/workqueue.c:3439
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888104850800 (size 512):
  comm "kworker/0:1", pid 10, jiffies 4294937528
  hex dump (first 32 bytes):
    18 6a 89 26 81 88 ff ff 00 b6 ad 81 ff ff ff ff  .j.&............
    00 12 04 00 81 88 ff ff 3c 00 00 00 00 00 00 00  ........<.......
  backtrace (crc 1ece07b3):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4550 [inline]
    slab_alloc_node mm/slub.c:4873 [inline]
    __do_kmalloc_node mm/slub.c:5266 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5279
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    __alloc_empty_sheaf+0x35/0x50 mm/slub.c:2771
    alloc_empty_sheaf mm/slub.c:2786 [inline]
    __pcs_replace_full_main+0xe8/0x300 mm/slub.c:5729
    free_to_pcs mm/slub.c:5782 [inline]
    slab_free mm/slub.c:6177 [inline]
    kfree+0x352/0x390 mm/slub.c:6490
    vfree.part.0+0x1d5/0x4d0 mm/vmalloc.c:3485
    vfree mm/vmalloc.c:3456 [inline]
    delayed_vfree_work+0x5b/0x90 mm/vmalloc.c:3398
    process_one_work+0x26c/0x5d0 kernel/workqueue.c:3275
    process_scheduled_works kernel/workqueue.c:3358 [inline]
    worker_thread+0x243/0x490 kernel/workqueue.c:3439
    kthread+0x14e/0x1a0 kernel/kthread.c:436
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


Tested on:

commit:         b29fb882 Merge tag 'v7.0-rc3-ksmbd-server-fixes' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13fb694a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c6ad6fefffa76b1
dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14023016580000



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
