Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDD20606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 30 Oct 2026 02:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VQnXnRqe;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=BVpy6t3s;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=k3TRVvt1
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Unsubscribe-Post:List-Owner;
	bh=vsilqII6CHsfwnKBinUjWlGOJe9c340I8LMlfc0B9RQ=; b=VQnXnRqemzL+wSfV9tgeegqinT
	mymU4NRxx7LhKUUCIATY9YaAh3pz1a8tAfB9Ehx1wSnMUzroEVS7QgywSdzoPkuZMDgFK+z/MVWyz
	aQROcxVe1ih45zmBOMQnQVuU5QR+1bPVU0GrpI97uiaaExbxUM8HGABdQAEJG5FsZvMU=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMcU7-000000000jt-2aiH;
	Fri, 30 Oct 2026 02:36:51 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1) (envelope-from
 <3uwLkagkbAK4gmnYOZZSfOddWR.UccUZSigSfQcbhSbh.Qca@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1xMcU6-000000000jf-1Nrw
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 02:36:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LZpY3C/W3YVvnLmO3CF3zYjfsRgXkvzAHK5Myqx7bt8=; b=BVpy6t3smSkGuyXMDSk4JMISrj
 h3otwAXIwiMU0QrJtcdFtqHzTi3pPjKJUpc/q5IIrIMAXJ0Quis2JJBJM10xbg6DZKRBGhwSaizLF
 UFANR+pDX5syZjlyeBrqLxKf5kSlsDJpl/CQWpFeznv+qdc1jHv2oskQ07aBZvQoPmdg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LZpY3C/W3YVvnLmO3CF3zYjfsRgXkvzAHK5Myqx7bt8=; b=k3TRVvt1/zSf/Bb4gV21vVGgu8
 17hh+Lgxysp7oarQLWm7qjjCP8DnOuwG/sY6h5jz0xlaWod+iwu47sZuvAT55jnvblA5Fs2H+JufJ
 GhqkezUV2LRhtm4zsXOC91SXK97PmRa/dV7I3UaKHrjf1mumeSTfdxl5OQW/5TP0EtlY=;
Received: from mail-oi1-f198.google.com ([209.85.167.198])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xMcU4-000000001WC-3ukm
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 30 Oct 2026 02:36:50 +0000
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-547ae874949so375834b6e.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 29 Oct 2026 19:36:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793327803; x=1793932603;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=LZpY3C/W3YVvnLmO3CF3zYjfsRgXkvzAHK5Myqx7bt8=;
 b=rEvikcyUdeuxu7c9O93Z5akps/k3VOD5sn+wwEFS6H3umtjr2JhgJh4D8PDm9QZl10
 Pb9oELvWnk/6SG1nzoEMDZ93DtYvRja4QgBKsW+4mLr6YfOafqlVSoPSx5tdvmNleLG+
 VAYy5/iA2sPjpfqZjn1vmbigrstpi3ECRQYaUN+bO/CGWG6w0oQ5nRK27IyKkJcCvkRS
 bo4O3BmULfMc0tvgDU2FWzqC6u7D4P2gR79YP1O4yDwH6b9lhTwvOb1u5lMuBrYhEmaI
 tvQYCsTGF+bqiiqBV0YwKC3TBrLOi1IpZkfCw+LACGpvUyum4l+4LYhqE4RmbmJbJUvx
 cpwg==
X-Forwarded-Encrypted: i=1;
 AKwUvByFBYfy/jx03TQOsB9coL8Re7RktvN99/TPRetelRrrTm6eHpAAdURozg1vvS5NbfbJ+PWbT+PPJoEyZvv3cfU9@lists.sourceforge.net
X-Gm-Message-State: AFq9FYLcRl4c3agKhIgSgnr1ljwtzo1MGsAeSqOAISaVE8QCpoGV7Ho7
 IFc6682LkP49loHrps9B/oM2UpxgVw4lPsKYjim4xjbtbpzD/vnZ/L1C2nMWbW0Yh4O1tG7nOBL
 slAbg0L4iYsxb0RdfHORuGugIwy1ia4LTc2CSy6o2fqQ8BT6Vc5axnWVM5/U=
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:6508:b0:4f5:4780:582 with SMTP id
 5614622812f47-5640dfeff32mr678119b6e.50.1793327803370; Thu, 29 Oct 2026
 19:36:43 -0700 (PDT)
Date: Thu, 29 Oct 2026 19:36:43 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ae402bb.0c1d3ab6.e3d48.006c.GAE@google.com>
From: syzbot <syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Spam-Score: 0.6 (/)
X-Headers-End: 1xMcU4-000000001WC-3ukm
Subject: [f2fs-dev] [syzbot] [f2fs?] memory leak in f2fs_apply_options
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

HEAD commit:    c339f4010dea Merge tag 'platform-drivers-x86-v7.4-1' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15fbdd95580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=73ec643490576dec
dashboard link: https://syzkaller.appspot.com/bug?extid=6c000dea1a93b4f5905c
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c1448d580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/533212b95d17/disk-c339f401.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5cb62d3629c7/vmlinux-c339f401.xz
kernel image: https://storage.googleapis.com/syzbot-assets/12da5b4ca87c/bzImage-c339f401.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/546324936b23/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=17480929580000)

AI-generated root cause summary:
In F2FS, when remounting a filesystem with an empty journalled quota option
(such as 'usrjquota='), f2fs_apply_quota_options() overwrites
F2FS_OPTION(sbi).s_qf_names[i] with NULL without freeing the previously
allocated quota filename string. While __f2fs_remount() duplicates the existing
quota file names into org_mount_opt via kstrdup() at the start of remount and
frees them upon successful completion, this only frees the temporary backup
copy, leaving the original allocated string orphaned. This results in a kernel
heap memory leak on every remount that clears a journalled quota filename
option.

full analysis:  https://syzkaller.appspot.com/x/ai_root_cause?x=6c000dea1a93b4f5905c

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6c000dea1a93b4f5905c@syzkaller.appspotmail.com

BUG: memory leak
unreferenced object 0xffff888128b26a10 (size 8):
  comm "syz.0.17", pid 5977, jiffies 4294944034
  hex dump (first 8 bytes):
    66 32 66 73 00 00 00 00                          f2fs....
  backtrace (crc 49a76b1f):
    kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
    slab_post_alloc_hook mm/slub.c:4733 [inline]
    slab_alloc_node mm/slub.c:5033 [inline]
    __do_kmalloc_node mm/slub.c:5530 [inline]
    __kmalloc_node_track_caller_noprof+0x3e0/0x530 mm/slub.c:5662
    __kmemdup_nul mm/util.c:64 [inline]
    kstrdup+0x3c/0x80 mm/util.c:84
    f2fs_apply_quota_options fs/f2fs/super.c:1661 [inline]
    f2fs_apply_options+0x99c/0xb70 fs/f2fs/super.c:1804
    f2fs_fill_super+0xfc4/0x43f0 fs/f2fs/super.c:5288
    get_tree_bdev_flags+0x1c0/0x290 fs/super.c:1883
    vfs_get_tree+0x30/0x120 fs/super.c:1943
    fc_mount fs/namespace.c:1282 [inline]
    do_new_mount_fc fs/namespace.c:3910 [inline]
    do_new_mount fs/namespace.c:3986 [inline]
    path_mount+0x5a9/0x1580 fs/namespace.c:4337
    do_mount fs/namespace.c:4350 [inline]
    __do_sys_mount fs/namespace.c:4565 [inline]
    __se_sys_mount fs/namespace.c:4542 [inline]
    __x64_sys_mount+0x1a3/0x1e0 fs/namespace.c:4542
    do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
    do_syscall_64+0xe9/0x530 arch/x86/entry/syscall_64.c:84
    entry_SYSCALL_64_after_hwframe+0x77/0x7f

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
