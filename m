Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83BA5EDEC1E
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Mar 2026 07:37:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+z6yuDYjTU8MQ1SMoG3yCaqt6jmActwkD5tvpqLckXY=; b=IrIXjTEAe8St4X/x+Is1DgfYIx
	AddBKsXMbfVmCWz7pcg6k16FoOgXLMT5lder9pdryFc5we316yI1jrm3L+WiyyhXbsQsi0RJa173w
	Xjdwrq3XcrtmMmWFl0nME4GVyD2T9SV2mg6s0dCyoJqyscljDaS4RURu4zatIIiGeMwo=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxgns-0006o3-QZ;
	Wed, 04 Mar 2026 07:37:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vxgnr-0006nX-5p
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 07:37:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Io/ZNpXldFq4cIniZf5vjSaZ/qNfgf+LE8TMntbbJtc=; b=TP3dRM9TGxr018bxXJdZVfXsin
 oLH6n8bKsjn8pkqJHLbHENWBbqOiK3gByTN4KBW7m61UuK/iJP/muUPedzzfxg3ECX7e8AgjmLbe0
 R9O/OF2R/Mc4J200vVToCcF+w8Qa5AmF6Dwh+h0RAd//i4dkYE0JKUSj1Z5MA8ZeI9hk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Io/ZNpXldFq4cIniZf5vjSaZ/qNfgf+LE8TMntbbJtc=; b=ZHyByG8X9wyaAGvl1Tvr2Pdt2f
 hPI83PYShRbz2jqKs1444Q5KA2Oi4F6qgl+TPvVKY0FRClRIKpS3zOWJe8Tzj47//S+sdcKeIlAGZ
 HEdrjgyROwc8ZnybnRgl1CStDDmxXcdu56hma9DTe9wY2QWg2MF3y0pfD0ySQie3zo/w=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vxgnq-0007o7-GD for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 07:37:55 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id D0BF260097;
 Wed,  4 Mar 2026 07:37:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12461C19423;
 Wed,  4 Mar 2026 07:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1772609868;
 bh=2ZQD1N2O5StB08VmKqUsZuO7vnRQfo5Om7tixlyuwQc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=e/Yi143U/D/fifsEf1zhGTOR5752tLI6dOu7lRYyFfmeRiuugxC8znnWBi70vlJvq
 Z0L6h32MbeHFGZn35G37S6Yh1nR3zo1uHm9UpWD/5eF6kfhVuRaendjlgO/0VBekzg
 Ydj2/dsg7FFsOvDm+uJhLyN1P6OM4Be2codPM/E7EHeCuGkyw56yBoD2iJfyayl8Kf
 zFM4acXckJPJdBSN/nMfXeyKJ98yJNhaBYoRI4FSylS/eAVV8444X8jGODT/50GL7t
 BKB16nuQSaeA+z9v1lF/fHFIniyH0aL3lQGos1saiOJoKHR0EJxrfKZFHkbNvj+EfT
 IQBXjMPjY6KSQ==
Message-ID: <efdfa39e-78f5-47df-9de5-a5d8ae8841b2@kernel.org>
Date: Wed, 4 Mar 2026 15:37:43 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: syzbot <syzbot+cf7946ab25b21abc4b66@syzkaller.appspotmail.com>,
 ebiggers@kernel.org, jaegeuk@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
References: <69a75fe1.a70a0220.b118c.0014.GAE@google.com>
Content-Language: en-US
In-Reply-To: <69a75fe1.a70a0220.b118c.0014.GAE@google.com>
X-Headers-End: 1vxgnq-0007o7-GD
Subject: Re: [f2fs-dev] [syzbot] [fscrypt?] [f2fs?] memory leak in
 fscrypt_setup_filename
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

#syz test: https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/syzbot

On 2026/3/4 06:25, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    af4e9ef3d784 uaccess: Fix scoped_user_read_access() for 'p..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=12506d5a580000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=2c6ad6fefffa76b1
> dashboard link: https://syzkaller.appspot.com/bug?extid=cf7946ab25b21abc4b66
> compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=160a18d6580000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14e2b0ba580000
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/70cb2ebe1e6e/disk-af4e9ef3.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/945fea3c8a6d/vmlinux-af4e9ef3.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/fa6a6a5cbcc8/bzImage-af4e9ef3.xz
> mounted in repro: https://storage.googleapis.com/syzbot-assets/c12ae92fa9b6/mount_0.gz
>    fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=10e1d202580000)
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+cf7946ab25b21abc4b66@syzkaller.appspotmail.com
> 
> BUG: memory leak
> unreferenced object 0xffff888127f70830 (size 16):
>    comm "syz.0.23", pid 6144, jiffies 4294943712
>    hex dump (first 16 bytes):
>      3c af 57 72 5b e6 8f ad 6e 8e fd 33 42 39 03 ff  <.Wr[...n..3B9..
>    backtrace (crc 925f8a80):
>      kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
>      slab_post_alloc_hook mm/slub.c:4520 [inline]
>      slab_alloc_node mm/slub.c:4844 [inline]
>      __do_kmalloc_node mm/slub.c:5237 [inline]
>      __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5250
>      kmalloc_noprof include/linux/slab.h:954 [inline]
>      fscrypt_setup_filename+0x15e/0x3b0 fs/crypto/fname.c:364
>      f2fs_setup_filename+0x52/0xb0 fs/f2fs/dir.c:143
>      f2fs_rename+0x159/0xca0 fs/f2fs/namei.c:961
>      f2fs_rename2+0xd5/0xf20 fs/f2fs/namei.c:1308
>      vfs_rename+0x7ff/0x1250 fs/namei.c:6026
>      filename_renameat2+0x4f4/0x660 fs/namei.c:6144
>      __do_sys_renameat2 fs/namei.c:6173 [inline]
>      __se_sys_renameat2 fs/namei.c:6168 [inline]
>      __x64_sys_renameat2+0x59/0x80 fs/namei.c:6168
>      do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
>      do_syscall_64+0xe2/0xf80 arch/x86/entry/syscall_64.c:94
>      entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF
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
