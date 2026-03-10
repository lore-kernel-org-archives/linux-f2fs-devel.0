Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFE58FCC9CC
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 10 Mar 2026 06:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:In-Reply-To:Date:MIME-Version:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=xY/0UD6JFAAwjeTcZrfXlUk/is7uksrcbHCcULE+JSU=; b=SUS0r1zQLTeTk4dmMMUCB+ueB0
	ogtJ+GUYmj70eMk4IBzwtYVF4kKd8PCFohU5Y6P/tGW3HAJQqCDVjHov/5YlsbkeWtcmksqS6o3Ua
	kU7svG7xWny102OJwKGjDCiVpw5l3fP2FHjnklIMOmPdJRrk1VmeR0YL4n4LcZMZLG2I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vzqak-0004nW-1Q;
	Tue, 10 Mar 2026 06:29:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3MrqvaQkbALkrxyjZkkdqZoohc.fnnfkdtrdqbnmsdms.bnl@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1vzqaj-0004nP-72 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Mar 2026 06:29:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=rh1FFgXJWrBr2+Z9D9TX5buPNtwittF7cccRXqbBfsk=; b=Tbosqfi9MWJCD5hCPO17C4H+U2
 jXIwsNqchpj3gdHRs8W3ERyrRcAt9+2aTJmdIlv3JWUh8no1uxOY+aqvaClRfNd6L/zObO++C1GGR
 /w5EU1d+vIiPdPTPJXkubghJKpbsznGgu+Xnj6qw6wfEFXGysDE9se57gBaJU/oXWDAM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=rh1FFgXJWrBr2+Z9D9TX5buPNtwittF7cccRXqbBfsk=; b=M
 fA3WQCBXYI4IESIcbkzaJeE24Z7zmtAWrQP1CxCURIEGoaPegh5/WKhFLuK6NVj6CLIsMiHL1ljHk
 xfBye7shi4IRF/3gTewGQMdlgQoPhl7tD4RR0y6TUpzsupiXlX5rgfyJDJKLdGm3fifzcaeErSD9m
 qJoee2VBle9kJ9XE=;
Received: from mail-oo1-f69.google.com ([209.85.161.69])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vzqai-0001IM-Ot for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 10 Mar 2026 06:29:17 +0000
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-67bbfa324fbso5453142eaf.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 09 Mar 2026 23:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773124146; x=1773728946;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rh1FFgXJWrBr2+Z9D9TX5buPNtwittF7cccRXqbBfsk=;
 b=QXLP7UHeRsoP3X10ZFrfJDiuvZmwmbUbm9NzfvUOyyPZU1LeivKu3Bd8tUSKNzfjqW
 T6cEETLZ2lc7aB/ujeS7eOScfye4tAlfUOjV7pRpIM7yRDrH+vREyueOaQkX5uxr2fji
 gDAaEbTWnzrglIHzsPmG6hMPAg4tiVPf32uaKh4khX826lIXOnJ7Y5V0Rg1HzyU6UPN+
 ZqyqKHnlGSzISFzFh+vWLbiM+UjYigi81WYy4iyfcI+Qrv7/IYJwn20fIak+Ot/du5W0
 3X2aVSJY/Tt/IwvzgugL2hXFbuwehBaoI0rEde/McEpWvAkQZLFgHDc0sflfZnhN0wHF
 4X8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjNr4cBoNoZXV4BmbOfZP2Jimd7+Yec163RjG4BK00IsK7DXUpM8tdEMB8bnmFuvGADpPhWqoRX3frVQzFAnd7@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzlC2FfdoXkUklr+t53t+Bsi/PlPbfJDH7BTGUFn9kji2TvxBIc
 NX0SmwpNQLdImSh52Q3s/CXfljRT9wE1FtV9XnMpeKEXUphc8QdNb1m7RUHyEq05u9pEufYDVbF
 6DmZW7ohmeUKL4hCIQtDO3R2+nFMIsN+UG2E9ubVoSC3OREacLEu2iJG5UOQ=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1ca1:b0:67b:b89e:22af with SMTP id
 006d021491bc7-67bb89e23dbmr2349238eaf.51.1773124146144; Mon, 09 Mar 2026
 23:29:06 -0700 (PDT)
Date: Mon, 09 Mar 2026 23:29:06 -0700
In-Reply-To: <aa-1-Y3v3D1hzPvL@hyeyoo>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69afba32.a00a0220.d013.0002.GAE@google.com>
From: syzbot <syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, catalin.marinas@arm.com, chao@kernel.org, 
 hao.li@linux.dev, harry.yoo@oracle.com, jaegeuk@kernel.org, jannh@google.com, 
 liam.howlett@oracle.com, linkinjeon@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
 pfalcato@suse.de, sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
 vbabka@kernel.org, vbabka@suse.cz, wangqing7171@gmail.com
X-Headers-End: 1vzqai-0001IM-Ot
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
memory leak in copy_process

BUG: memory leak
unreferenced object 0xffff888101799d80 (size 184):
  comm "kthreadd", pid 2, jiffies 4294948049
  hex dump (first 32 bytes):
    01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    0a 21 00 00 00 00 00 00 58 78 fd 01 81 88 ff ff  .!......Xx......
  backtrace (crc e9f8bd9):
    kmemleak_alloc_recursive include/linux/kmemleak.h:45 [inline]
    slab_post_alloc_hook mm/slub.c:4552 [inline]
    slab_alloc_node mm/slub.c:4874 [inline]
    kmem_cache_alloc_noprof+0x372/0x480 mm/slub.c:4881
    alloc_pid+0xe4/0x850 kernel/pid.c:189
    copy_process+0x1a97/0x28c0 kernel/fork.c:2239
    kernel_clone+0xac/0x6e0 kernel/fork.c:2654
    kernel_thread+0x80/0xb0 kernel/fork.c:2715
    create_kthread kernel/kthread.c:459 [inline]
    kthreadd+0x186/0x250 kernel/kthread.c:817
    ret_from_fork+0x23c/0x4b0 arch/x86/kernel/process.c:158
    ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

BUG: memory leak
unreferenced object 0xffff88810b0d7b40 (size 184):
  comm "kthreadd", pid 2, jiffies 4294948049
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
  backtrace (crc ddb1bc35):
    kmemleak_alloc_recursive include/linux/kmemleak.h:45 [inline]
    slab_post_alloc_hook mm/slub.c:4552 [inline]
    slab_alloc_node mm/slub.c:4874 [inline]
    kmem_cache_alloc_noprof+0x372/0x480 mm/slub.c:4881
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
unreferenced object 0xffff88810b91e4a0 (size 32):
  comm "kthreadd", pid 2, jiffies 4294948049
  hex dump (first 32 bytes):
    00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
    f8 6e 0a 00 81 88 ff ff 00 00 00 00 00 00 00 00  .n..............
  backtrace (crc 13ba6aa5):
    kmemleak_alloc_recursive include/linux/kmemleak.h:45 [inline]
    slab_post_alloc_hook mm/slub.c:4552 [inline]
    slab_alloc_node mm/slub.c:4874 [inline]
    __do_kmalloc_node mm/slub.c:5267 [inline]
    __kmalloc_noprof+0x3bd/0x560 mm/slub.c:5280
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

connection error: failed to recv *flatrpc.ExecutorMessageRawT: EOF


Tested on:

commit:         1f318b96 Linux 7.0-rc3
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1224694a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2c6ad6fefffa76b1
dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=110faf5a580000



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
