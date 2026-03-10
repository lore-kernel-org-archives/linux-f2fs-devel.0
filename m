Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8596BEFCD9F
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Mar 2026 09:40:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:In-Reply-To:Date:MIME-Version:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=Asohf4u3hCMhsmGYTqQoFu6PSiQ2WJc0DvkGaIM0kqk=; b=MzeETSTabrPg/YMwEUYAKC7Say
	aWVFh/BG9e3aGX++vnqCYvoDV7Fd7iNuEpg9obhsBAABqMNwXy7V4JOkURzW2CZyw4fKkF7o++zBn
	+40dPaYIABXD9MSYS6kujrstG3sPt9dBJ9OVtMX+28YJrpuivbq+VNKuVCSZVYuhcamo=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vztZX-0005lc-DI;
	Tue, 10 Mar 2026 09:40:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <38-avaQkbANQIOPA0BB4H0FF83.6EE6B4KI4H2EDJ4DJ.2EC@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1vztZW-0005lQ-Gk for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Mar 2026 09:40:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=i8Z0gVF0uPQ8qNSugfsMNVMLQ4iv7U/CKd+gpIjRAX8=; b=Dv4B277nnzeLD4HampBqshtyOb
 V7Zqmt/LdVv+r2lFMKCOjxAifWs/i/P2h7i24cGI0A2tMPM1ttCWWMaJBCQ0f8DsDTA6QilTW4Vuy
 Hs8J2iY+M5UYaaqBrZJ0sliLQ3jSGC9W/HcQY1be7bOwB63P9ceJ3uQ0lvJvD0DRRi6Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=i8Z0gVF0uPQ8qNSugfsMNVMLQ4iv7U/CKd+gpIjRAX8=; b=B
 NkvOeoIC1PlaYWEuOvcK0RyYnX/bDhsE25fx+3nk4qCDCnHbaDzhebJZ3PwwKiUSgKLiajUay8E/9
 W5CXCJKgbMGUz3sQO4cNKVJA/Xo20Y5NqlkoW1SBWidxPVSb7cEne4aJWP2BZ+Hv8JC5cElAzd59f
 gB6tKdV0xSbFY56Y=;
Received: from mail-ot1-f71.google.com ([209.85.210.71])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vztZW-0002uA-Jz for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Mar 2026 09:40:15 +0000
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-7d753cb3174so10387781a34.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 10 Mar 2026 02:40:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773135604; x=1773740404;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i8Z0gVF0uPQ8qNSugfsMNVMLQ4iv7U/CKd+gpIjRAX8=;
 b=HAzpgvzxEaAm7SqmUdITmW5GD3HFYnjkG4/DdKh+kSJkxvZd5/G/a+diIFN+EOuaqb
 rCAzcwnqgEsp7Zln1znbwkyKEzuIpoRJanVjQBwW64NA4VBoOQfx+pzWiPNuu0GDO3qb
 qlLEeRiTeklo7VeI3H6RzbO8E7aqvy9d7noYzbSpqwutvHD7Nde/5CtwFUeHvZwkJj7s
 /vIMLkiP/JhRdD90ai6hICMk7zQUP0JrIWE5+738dkoWf+2oWmW+gaJ1VGxHsp9Kol00
 M6hIpAOYIZbmx3Q/lzT7MF0bhHYOgfO3IJeIIkjgPQ/1nlNzknYDP6Whx0mf2cQJ8vD7
 wo3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXhBGP6uyBMmGoBZcca1P5WaFW54hA9FlrdmNHoKSznBtr5GIV7pVrE+Xyzt/ni3no6awSr9z7IOv1nWW50B/nU@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw9iN7z9H9lxQ1eg6XvRDtDbY89OOmYeqJ0CehCvhqJ0Yv6VwIW
 8TNzPY2qpxamftUUHx6s3m4b9mMLtUrS5kgTnLCY/izUKfgbRSvrT6cuVqS0cKUfEpI6DF82mDx
 5jw/fmjC08Prtt3cdebk0GY3yC8xp84tRlyzo9b78KHkZvU6SLVShGqXLLQQ=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3102:b0:66f:c72c:7c7 with SMTP id
 006d021491bc7-67b9bca8899mr9412099eaf.18.1773135603949; Tue, 10 Mar 2026
 02:40:03 -0700 (PDT)
Date: Tue, 10 Mar 2026 02:40:03 -0700
In-Reply-To: <aa_R-6SdHYBBkQX-@hyeyoo>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69afe6f3.050a0220.310d8.0038.GAE@google.com>
From: syzbot <syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, catalin.marinas@arm.com, chao@kernel.org, 
 hao.li@linux.dev, harry.yoo@oracle.com, jaegeuk@kernel.org, jannh@google.com, 
 liam.howlett@oracle.com, linkinjeon@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
 pfalcato@suse.de, sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
 vbabka@kernel.org, vbabka@suse.cz, wangqing7171@gmail.com
X-Headers-End: 1vztZW-0002uA-Jz
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
memory leak in __kthread_create_on_node

BUG: memory leak
unreferenced object 0xffff88811351d1b0 (size 16):
  comm "syz.0.38", pid 7021, jiffies 4294948268
  hex dump (first 16 bytes):
    66 32 66 73 5f 66 6c 75 73 68 2d 37 3a 30 00 00  f2fs_flush-7:0..
  backtrace (crc 73f9c04e):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4548 [inline]
    slab_alloc_node mm/slub.c:4870 [inline]
    __do_kmalloc_node mm/slub.c:5263 [inline]
    __kmalloc_node_track_caller_noprof+0x3e0/0x5d0 mm/slub.c:5372
    kvasprintf+0x6e/0xf0 lib/kasprintf.c:25
    __kthread_create_on_node+0x9e/0x1c0 kernel/kthread.c:491
    kthread_create_on_node+0x73/0xa0 kernel/kthread.c:559
    f2fs_create_flush_cmd_control+0x178/0x200 fs/f2fs/segment.c:707
    f2fs_build_segment_manager+0x212/0x3630 fs/f2fs/segment.c:5734
    f2fs_fill_super+0x14b1/0x3c20 fs/f2fs/super.c:5140
    get_tree_bdev_flags+0x1c0/0x290 fs/super.c:1694
    vfs_get_tree+0x30/0x120 fs/super.c:1754
    fc_mount fs/namespace.c:1193 [inline]
    do_new_mount_fc fs/namespace.c:3763 [inline]
    do_new_mount fs/namespace.c:3839 [inline]
    path_mount+0x5a9/0x1360 fs/namespace.c:4159
    do_mount fs/namespace.c:4172 [inline]
    __do_sys_mount fs/namespace.c:4361 [inline]
    __se_sys_mount fs/namespace.c:4338 [inline]
    __x64_sys_mount+0x1a3/0x1e0 fs/namespace.c:4338
    do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
    do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

BUG: memory leak
unreferenced object 0xffff88810b6a4700 (size 4544):
  comm "kthreadd", pid 2, jiffies 4294948268
  hex dump (first 32 bytes):
    04 00 08 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 01 00 00 00 80 00 00 00 00 00 00 00  ................
  backtrace (crc 71339aaa):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4548 [inline]
    slab_alloc_node mm/slub.c:4870 [inline]
    kmem_cache_alloc_node_noprof+0x373/0x4d0 mm/slub.c:4922
    alloc_task_struct_node kernel/fork.c:185 [inline]
    dup_task_struct kernel/fork.c:916 [inline]
    copy_process+0x286/0x28c0 kernel/fork.c:2050
    kernel_clone+0xac/0x6e0 kernel/fork.c:2654
    kernel_thread+0x80/0xb0 kernel/fork.c:2715
    create_kthread kernel/kthread.c:459 [inline]
    kthreadd+0x186/0x250 kernel/kthread.c:817
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888109f45f00 (size 184):
  comm "kthreadd", pid 2, jiffies 4294948268
  hex dump (first 32 bytes):
    02 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc 5ee6cb00):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4548 [inline]
    slab_alloc_node mm/slub.c:4870 [inline]
    kmem_cache_alloc_noprof+0x372/0x480 mm/slub.c:4877
    prepare_creds+0x22/0x600 kernel/cred.c:185
    copy_creds+0x44/0x290 kernel/cred.c:286
    copy_process+0x7a7/0x28c0 kernel/fork.c:2084
    kernel_clone+0xac/0x6e0 kernel/fork.c:2654
    kernel_thread+0x80/0xb0 kernel/fork.c:2715
    create_kthread kernel/kthread.c:459 [inline]
    kthreadd+0x186/0x250 kernel/kthread.c:817
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff8881096f8240 (size 32):
  comm "kthreadd", pid 2, jiffies 4294948268
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    f8 6e 0a 00 81 88 ff ff 00 00 00 00 00 00 00 00  .n..............
  backtrace (crc 13ba6aa5):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4548 [inline]
    slab_alloc_node mm/slub.c:4870 [inline]
    __do_kmalloc_node mm/slub.c:5263 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5276
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    lsm_blob_alloc+0x4d/0x80 security/security.c:192
    lsm_cred_alloc security/security.c:209 [inline]
    security_prepare_creds+0x2d/0x290 security/security.c:2763
    prepare_creds+0x395/0x600 kernel/cred.c:215
    copy_creds+0x44/0x290 kernel/cred.c:286
    copy_process+0x7a7/0x28c0 kernel/fork.c:2084
    kernel_clone+0xac/0x6e0 kernel/fork.c:2654
    kernel_thread+0x80/0xb0 kernel/fork.c:2715
    create_kthread kernel/kthread.c:459 [inline]
    kthreadd+0x186/0x250 kernel/kthread.c:817
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff888125626e40 (size 192):
  comm "kthreadd", pid 2, jiffies 4294948268
  hex dump (first 32 bytes):
    02 00 00 00 00 00 00 00 00 00 00 00 ff ff ff ff  ................
    01 00 00 00 00 00 00 00 60 4a 8a 82 ff ff ff ff  ........`J......
  backtrace (crc 3a1ec858):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4548 [inline]
    slab_alloc_node mm/slub.c:4870 [inline]
    __kmalloc_cache_noprof+0x377/0x480 mm/slub.c:5379
    kmalloc_noprof include/linux/slab.h:950 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    set_kthread_struct+0x58/0x150 kernel/kthread.c:107
    copy_process+0x15b8/0x28c0 kernel/fork.c:2152
    kernel_clone+0xac/0x6e0 kernel/fork.c:2654
    kernel_thread+0x80/0xb0 kernel/fork.c:2715
    create_kthread kernel/kthread.c:459 [inline]
    kthreadd+0x186/0x250 kernel/kthread.c:817
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88812cb53700 (size 64):
  comm "kthreadd", pid 2, jiffies 4294948268
  hex dump (first 32 bytes):
    20 09 d5 89 ff ff ff ff 00 00 00 00 00 00 00 00   ...............
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc e7a33bad):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4548 [inline]
    slab_alloc_node mm/slub.c:4870 [inline]
    __do_kmalloc_node mm/slub.c:5263 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5276
    kmalloc_noprof include/linux/slab.h:954 [inline]
    kzalloc_noprof include/linux/slab.h:1188 [inline]
    lsm_blob_alloc+0x4d/0x80 security/security.c:192
    lsm_task_alloc security/security.c:244 [inline]
    security_task_alloc+0x2a/0x260 security/security.c:2682
    copy_process+0xedf/0x28c0 kernel/fork.c:2205
    kernel_clone+0xac/0x6e0 kernel/fork.c:2654
    kernel_thread+0x80/0xb0 kernel/fork.c:2715
    create_kthread kernel/kthread.c:459 [inline]
    kthreadd+0x186/0x250 kernel/kthread.c:817
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88810b507180 (size 1152):
  comm "kthreadd", pid 2, jiffies 4294948268
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    90 71 50 0b 81 88 ff ff 90 71 50 0b 81 88 ff ff  .qP......qP.....
  backtrace (crc ef1916d7):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4548 [inline]
    slab_alloc_node mm/slub.c:4870 [inline]
    kmem_cache_alloc_noprof+0x372/0x480 mm/slub.c:4877
    copy_signal kernel/fork.c:1700 [inline]
    copy_process+0x10da/0x28c0 kernel/fork.c:2220
    kernel_clone+0xac/0x6e0 kernel/fork.c:2654
    kernel_thread+0x80/0xb0 kernel/fork.c:2715
    create_kthread kernel/kthread.c:459 [inline]
    kthreadd+0x186/0x250 kernel/kthread.c:817
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


Tested on:

commit:         1f318b96 Linux 7.0-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1751f8d6580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c6ad6fefffa76b1
dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=10def8d6580000



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
