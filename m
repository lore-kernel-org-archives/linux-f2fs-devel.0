Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8B68CA5FC1
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Sep 2026 08:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ApY9qxtMmVpoF2YYoCaTf9e9Hyb021iy2MIZkczvkfk=; b=aLsYAHW7ADqp2PDA1Jsz+GiQo4
	06ytMbol7Cv/ltuPYwjij6Ivj0dfDgukr+mM4PUQ/vyZ02e1LWcs+5Lg1sdUYMNx+j3VuE8CFkqDy
	AjmcfgRUQUDvpTwR2IM5CtyqwGEevnufAelkIPnC9IF72EC5XbF2cis0uhSsFohA8EvM=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xBq6Z-0005HN-AW;
	Wed, 30 Sep 2026 08:56:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xBq6X-0005H8-Bw
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:55:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=smyXzlvSOyHCIwuaZy+2HZbtsR0hJx/vYNzEkKtyKYw=; b=LCPkbKJ8fBScj3cxL6nMWwzF9f
 cV4OxhfLkCPUPcC8aS3B0Oy3P8gXIZJP/sC8AAZ+l4tO7YomgTEomXjhOmPkFoHOo3zvsbEtRAuFd
 5DgBQAZ3jTZkeJqeGXz7st4c44Bd2PR7ektbouk06IYWbc4sazgVYOuYQCDgNH8tqW/k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=smyXzlvSOyHCIwuaZy+2HZbtsR0hJx/vYNzEkKtyKYw=; b=GuBMpuEAxlUiPA+aUpUWGticpc
 +g3RyKkop62T9Yl1m0wqn8pcA2LiUB4xZr7chnRKjDM488/fOJY3kL9v5Td+Do0lBxq+bObtKdv4u
 WIVTf433v3KrAjP1FlGFN2FgCZE1C/Cr3e2njPpbyw+7NG/WxgdY/LZ24dIqQg+X+ZB4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xBq6W-0008M8-VL for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 08:55:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 53B42600D4;
 Wed, 30 Sep 2026 08:55:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7B2D1F000FF;
 Wed, 30 Sep 2026 08:55:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790758551;
 bh=smyXzlvSOyHCIwuaZy+2HZbtsR0hJx/vYNzEkKtyKYw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=NA1dDU3ojJWFJcrRdYxLhF0yLwcL8O/7xCrUVLe1Tm1F/oVkTh7MtuZExpZo8D1NW
 zy63VZwY1H/PQzqRzPW0iyJj/mbZf/AROFDVYOJ7ZNPrBDrVrFjjfRRZnRovNZDkyn
 ykjdjTMkotJ/q4NNkoL3E+fSyOJlj1OJjv6AVfminFTB9G6/GBQE8U3Bmo4K1uzmGz
 X7Kgwv5U6SgnFlngK51oJObFu2ixY+eBOeNq0QlsOZxA/th6JqcRfK6PDtXuHg7IMh
 ZqEogR0u3VFB/aTLZxjgeCMjFFS1KYjo56bi0rQnQPhvEtFQ4RCqFqbPYzbErLxzMg
 BRyv69hsMekAQ==
Message-ID: <784ebcc3-2d37-4640-88fa-3385a646c2d5@kernel.org>
Date: Wed, 30 Sep 2026 16:55:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot <syzbot+dfcbc1741488709db4b2@syzkaller.appspotmail.com>,
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <6ab4ae74.80e1c6cc.1e8e5f.000c.GAE@google.com>
Content-Language: en-US
In-Reply-To: <6ab4ae74.80e1c6cc.1e8e5f.000c.GAE@google.com>
X-Headers-End: 1xBq6W-0008M8-VL
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] UBSAN: shift-out-of-bounds in
 __f2fs_commit_super
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/common

On 9/24/26 13:00, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    a8c591ed6b67 Add linux-next specific files for 20260922
> git tree:       linux-next
> console+strace: https://syzkaller.appspot.com/x/log.txt?x=16f98405580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=19be71c9d7429efd
> dashboard link: https://syzkaller.appspot.com/bug?extid=dfcbc1741488709db4b2
> compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f98405580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148ea515580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/08a28cd722c6/disk-a8c591ed.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/e1c983b28f94/vmlinux-a8c591ed.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ff7b15260591/bzImage-a8c591ed.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/3e937ffb1f11/mount_0.gz
>    fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=16029405580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+dfcbc1741488709db4b2@syzkaller.appspotmail.com
> 
> loop0: detected capacity change from 0 to 40427
> ------------[ cut here ]------------
> UBSAN: shift-out-of-bounds in fs/f2fs/super.c:3950:27
> shift exponent 4294967287 is too large for 64-bit type 'sector_t' (aka 'unsigned long long')
> CPU: 1 UID: 0 PID: 5622 Comm: syz-executor329 Not tainted syzkaller #0 PREEMPT(full)
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
> Call Trace:
>   <TASK>
>   dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
>   ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
>   __ubsan_handle_shift_out_of_bounds+0x36d/0x400 lib/ubsan.c:494
>   __f2fs_commit_super+0x43e/0x4d0 fs/f2fs/super.c:3950
>   sanity_check_area_boundary+0x7c5/0xe20 fs/f2fs/super.c:4040
>   sanity_check_raw_super fs/f2fs/super.c:4215 [inline]
>   read_raw_super_block fs/f2fs/super.c:4625 [inline]
>   f2fs_fill_super+0x1920/0x7fa0 fs/f2fs/super.c:5160
>   get_tree_bdev_flags+0x430/0x4f0 fs/super.c:1872
>   vfs_get_tree+0x92/0x2a0 fs/super.c:1932
>   fc_mount fs/namespace.c:1198 [inline]
>   do_new_mount_fc fs/namespace.c:3772 [inline]
>   do_new_mount+0x319/0xdc0 fs/namespace.c:3848
>   do_mount fs/namespace.c:4181 [inline]
>   __do_sys_mount fs/namespace.c:4394 [inline]
>   __se_sys_mount+0x31d/0x420 fs/namespace.c:4371
>   do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
>   do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
>   entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f2eb02deeaa
> Code: 56 53 b8 9d 00 00 00 0f 05 83 f8 ea 75 a2 c7 05 e4 5b 09 00 00 00 00 00 eb 96 e8 51 05 00 00 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007ffcaf01ba78 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
> RAX: ffffffffffffffda RBX: 00007ffcaf01ba90 RCX: 00007f2eb02deeaa
> RDX: 0000200000000080 RSI: 0000200000000000 RDI: 00007ffcaf01ba90
> RBP: 0000200000000000 R08: 00007ffcaf01bad0 R09: 0000000000000000
> R10: 0000000000200000 R11: 0000000000000286 R12: 0000200000000080
> R13: 00007ffcaf01bad0 R14: 0000000000000003 R15: 0000000000200000
>   </TASK>
> ---[ end trace ]---
> 
> 
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
> 
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
> 
> If the report is already addressed, let syzbot know by replying with:
> #syz fix: exact-commit-title
> 
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.
> 
> If you want to overwrite report's subsystems, reply with:
> #syz set subsystems: new-subsystem
> (See the list of subsystem names on the web dashboard)
> 
> If the report is a duplicate of another one, reply with:
> #syz dup: exact-subject-of-another-report
> 
> If you want to undo deduplication, reply with:
> #syz undup



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
