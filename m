Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CD33C98304
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 24 Sep 2026 05:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=liQTh5kjtQyEO9HuC9yT0plZMNpwXLwAop+za8G05n4=; b=IPKONKZ1X+C0mgrIvQ/BrAfoMi
	loV2TxKziujvVI6QklMdgYS154gMYkOAVFtUNOzQ6KIXVn37TscFiBPFQgr69WSzkyYebcUanw83q
	7YoC2AUC+Ww+ctQFD7i6mm7GEa5Rwp4qArSKtrj8egXaZL8zWXlWNJ/yt7mpGqXmxDBY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x9c1S-00024f-BJ;
	Thu, 24 Sep 2026 05:29:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3dK60agkbAAEtz0lbmmfsbqqje.hpphmfvtfsdpoufou.dpn@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1x9c1Q-00024R-W1 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 05:29:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uqqgurFUBuh0v3CWe8T+W2CgMloyuUVeURTr7IePVEU=; b=Xcb4vYs0pCqUGL/W0eW9n69AyV
 LP38Y36lZELw0mR89IeVdyik1cdGhovTzEjRT1Gk1Tz2w4dKmIYeE8apKIEylKhhNhd045h4VTUsh
 zkuH/R/eY/cpNhTHUDBsm/fp9oOFEElUC7OsdDtNsVogtB+khYlRiaFxcLZ4qOId2UPY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=uqqgurFUBuh0v3CWe8T+W2CgMloyuUVeURTr7IePVEU=; b=U
 z4XLmx5kTfMe8KVZPsxHKtr7tOSaoddDX1qgYXgWhQCWK9hkivnO37WZFz31oCcBv7XpNrf33lXIG
 4kV6tMX10czuqlNcShx6/6yoDutyJaReNy5Hp0vB90DU0ytWhhIBLnD7B+ddG1eKLIm0/QJBkD8l0
 rtQsr5bldTVndOnw=;
Received: from mail-oi2-f6.google.com ([74.125.231.198])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x9c1Q-0002vi-U0 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 24 Sep 2026 05:29:29 +0000
Received: by mail-oi2-f6.google.com with SMTP id
 46e09a7af769-8049bae1780so711571a34.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 23 Sep 2026 22:29:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790227763; x=1790832563;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=uqqgurFUBuh0v3CWe8T+W2CgMloyuUVeURTr7IePVEU=;
 b=kYwpiK0TkhJWWN0BsH+gdfGbZ+SpaJepAU6DG/58i8jPdpR6S4WiQLC+w0LS0VWAMD
 onkHr3E6Oketmt/NPzT+fkpM3o755Xxew/3NkMeLOA0poqt2uhTsyvFdv65QYuDSS3Ki
 M+f7cFznOKz/GiLzxPaYus+ejl1BOnw/7o+kWpflfShUw7RlpZ/Zfti9ea0e6V5iZvBP
 ITTT64beiDao3qWmqjpW4CucTgzTdTApfy8258L2ZXWav9Z34u6ycOqeOtt9Z+wAkgmF
 XXw0GL7Ygxp58cXOpwJBqgjpTcDVQaeRSTq0Kq1oSJcSlzGLiwYnaMFan1/U7cNa5Dot
 a+vg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzhSic/Yss9b+C7nvnaoqF4eUGBY0ym2X1Bm3TXuiIIZd7wkhjsXbh4IaAbxJEwBLAPd6heDVSHxuTvamsCOx0x@lists.sourceforge.net
X-Gm-Message-State: AFuF++kx0UvtKGdxvBVVK0QnM5E9ZVDLuwkXXpjzCDrWgsJX+vp9vDBB
 SnlOzRSLDZaDxtzENh1iJgvk31j24S/Gpm6egYcA3pyN9fZyo/3pKCxT4TYa90WhmLxgdDhm79B
 0TtUVCHRxHA4BXaGfJXqzObpCq03ovxPb5DirxJw7fVMq63wQJ5sljX9pBjg=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1a06:b0:4c6:7ce9:1bf0 with SMTP id
 5614622812f47-4d72cb3f361mr1448749b6e.20.1790226036854; Wed, 23 Sep 2026
 22:00:36 -0700 (PDT)
Date: Wed, 23 Sep 2026 22:00:36 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6ab4ae74.80e1c6cc.1e8e5f.000c.GAE@google.com>
From: syzbot <syzbot+dfcbc1741488709db4b2@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1x9c1Q-0002vi-U0
Subject: [f2fs-dev] [syzbot] [f2fs?] UBSAN: shift-out-of-bounds in
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hello,

syzbot found the following issue on:

HEAD commit:    a8c591ed6b67 Add linux-next specific files for 20260922
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16f98405580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=19be71c9d7429efd
dashboard link: https://syzkaller.appspot.com/bug?extid=dfcbc1741488709db4b2
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11f98405580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=148ea515580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/08a28cd722c6/disk-a8c591ed.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e1c983b28f94/vmlinux-a8c591ed.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ff7b15260591/bzImage-a8c591ed.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/3e937ffb1f11/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=16029405580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dfcbc1741488709db4b2@syzkaller.appspotmail.com

loop0: detected capacity change from 0 to 40427
------------[ cut here ]------------
UBSAN: shift-out-of-bounds in fs/f2fs/super.c:3950:27
shift exponent 4294967287 is too large for 64-bit type 'sector_t' (aka 'unsigned long long')
CPU: 1 UID: 0 PID: 5622 Comm: syz-executor329 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/24/2026
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x30 lib/ubsan.c:233
 __ubsan_handle_shift_out_of_bounds+0x36d/0x400 lib/ubsan.c:494
 __f2fs_commit_super+0x43e/0x4d0 fs/f2fs/super.c:3950
 sanity_check_area_boundary+0x7c5/0xe20 fs/f2fs/super.c:4040
 sanity_check_raw_super fs/f2fs/super.c:4215 [inline]
 read_raw_super_block fs/f2fs/super.c:4625 [inline]
 f2fs_fill_super+0x1920/0x7fa0 fs/f2fs/super.c:5160
 get_tree_bdev_flags+0x430/0x4f0 fs/super.c:1872
 vfs_get_tree+0x92/0x2a0 fs/super.c:1932
 fc_mount fs/namespace.c:1198 [inline]
 do_new_mount_fc fs/namespace.c:3772 [inline]
 do_new_mount+0x319/0xdc0 fs/namespace.c:3848
 do_mount fs/namespace.c:4181 [inline]
 __do_sys_mount fs/namespace.c:4394 [inline]
 __se_sys_mount+0x31d/0x420 fs/namespace.c:4371
 do_syscall_x64 arch/x86/entry/syscall_64.c:61 [inline]
 do_syscall_64+0x166/0x520 arch/x86/entry/syscall_64.c:84
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2eb02deeaa
Code: 56 53 b8 9d 00 00 00 0f 05 83 f8 ea 75 a2 c7 05 e4 5b 09 00 00 00 00 00 eb 96 e8 51 05 00 00 90 49 89 ca b8 a5 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 d8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffcaf01ba78 EFLAGS: 00000286 ORIG_RAX: 00000000000000a5
RAX: ffffffffffffffda RBX: 00007ffcaf01ba90 RCX: 00007f2eb02deeaa
RDX: 0000200000000080 RSI: 0000200000000000 RDI: 00007ffcaf01ba90
RBP: 0000200000000000 R08: 00007ffcaf01bad0 R09: 0000000000000000
R10: 0000000000200000 R11: 0000000000000286 R12: 0000200000000080
R13: 00007ffcaf01bad0 R14: 0000000000000003 R15: 0000000000200000
 </TASK>
---[ end trace ]---


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
