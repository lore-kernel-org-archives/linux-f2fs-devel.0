Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C417D74EDA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Jan 2026 14:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TI0MBGJibOeOzFcIETiBKoNMHXSgLjLQtA829ir2fY0=; b=QObvHjQ+x5tDys+XXHgJlplwnj
	qUR7f6ZSRQXZtJgT+VxBBiqVaIviT06q/oh06p1eWYiT5R/8bqufJ9yGqRjSHmM5ynWGqmJdR5UEG
	kFsxW8bFf0lWEAaxA/3yv0dFv/L9YfOPxZorIJULWCQ3o/B/8HcrYA0UIWcrJe8dWbkA=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vjI7R-0005x6-2g;
	Fri, 23 Jan 2026 14:26:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3EIVzaQkbADspvwhXiiboXmmfa.dlldibrpboZlkqbkq.Zlj@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1vjI7P-0005wz-I9 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 14:26:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nSCHXwJQOcwpevfa2kZqOE4k+V89IdBgUah22xame8c=; b=GYdsScPzi8oFJqUNlyryI+ynq+
 9xKD27V3P7DdQttYGHgCOz2f6PabFohnO1Q0VXmyy05GwxeA6Vi5KvyggUll2lExaDPHRAWzhiR3y
 gUPwk6zBJJJNJVSFUlkg83Fd8BlLaDtNIA6AufTUsqStffdhKiRjpnFPexF1HbkEips0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=nSCHXwJQOcwpevfa2kZqOE4k+V89IdBgUah22xame8c=; b=Y
 ixMqbhV4/s3QOxsPip4DfoljtcNcL65qGLkrpC3CLmwqfMUGO9/6oFRFMZOXiREMZnETnnYLAyPeT
 houxXiNTuaQlXxrRrhRG550k2kidHCvHmZEkcDVyUNdwXqymCVPzXTU35/Vci/TdM2aH5Zcmru0AI
 oAyDViz/tjkPKQXk=;
Received: from mail-oo1-f78.google.com ([209.85.161.78])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vjI7P-0007AN-2h for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 14:26:35 +0000
Received: by mail-oo1-f78.google.com with SMTP id
 006d021491bc7-662c0f7c3c0so6615008eaf.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 23 Jan 2026 06:26:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769178384; x=1769783184;
 h=to:from:subject:message-id:date:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nSCHXwJQOcwpevfa2kZqOE4k+V89IdBgUah22xame8c=;
 b=PrzXeuKenTS0kkUzjopxxjYrEIHAbIfeLRlP2k6aCwQuBZW6CFerzmsMFcRfPWTEyE
 SfP1fV0adgsiTfZJx71GKQ3/gzsuhxBzQtMv4f1UNpTqIf3TgPbaGULNIpcqlNvj8ERK
 Pn3MH44KQE2L69nh7y2kcRmcAsYJhJl/LoFdKaSGFzE5IS9hkYUS3GWB9Le0Y2z1Pquc
 DOAeznTxwSLFW2nrFjc0bwcXhcin5gLHsK5hPQGOMjygx/7/2+VMC7owPiwKgk1+8LtN
 yOTXe8ej9XZokNm475Uojk9USlazd8AmTsf8+0AduILHNwh4djWfeNg/BAXqIZViQK8d
 h9DA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVg1aDMlOfvtnoGB/qeEPcHQ5dClRp26bm+y6r8HnTCfgeYNTX5UFu9JrqnaGUywSH4viM5d6K1EXCP6J/FpAoX@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxcxB1LJnd0N6MyFOKRijIDIhFvgxqcDpDw+TL0xtGmtCSofLWN
 JjHqLZL36c5XszVuOkVTSC6CgjrlLLsIyjcOb9ZsxOT6eLGFplhDMWgiaeoRvH/voEr5IDJoJkZ
 c3AcYwlqVILzHnuPXgn6750dOkmziShRTH6sQxMYpqudXc4B/+S7YX8TLAU8=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1898:b0:65d:1e7:953e with SMTP id
 006d021491bc7-662cab429fbmr1479243eaf.48.1769178384484; Fri, 23 Jan 2026
 06:26:24 -0800 (PST)
Date: Fri, 23 Jan 2026 06:26:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69738510.050a0220.1ad174.033b.GAE@google.com>
From: syzbot <syzbot+ffb43ecff88cb2a47dd3@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1vjI7P-0007AN-2h
Subject: [f2fs-dev] [syzbot] [f2fs?] INFO: task hung in f2fs_write_inode
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

HEAD commit:    59e4d31a0470 Merge branches 'for-next/core' and 'for-next/..
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=11b73b9a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a8594efdc14f07a
dashboard link: https://syzkaller.appspot.com/bug?extid=ffb43ecff88cb2a47dd3
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c8cb9a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e88d22580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/746a1d5c4188/disk-59e4d31a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2eefade79f10/vmlinux-59e4d31a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/140624ef24ed/Image-59e4d31a.gz.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/e4b7b1d47128/mount_0.gz
  fsck result: failed (log: https://syzkaller.appspot.com/x/fsck.log?x=16b73b9a580000)

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ffb43ecff88cb2a47dd3@syzkaller.appspotmail.com

INFO: task kworker/u8:14:4087 blocked for more than 143 seconds.
Call trace:
 f2fs_write_inode+0x3b0/0x68c fs/f2fs/inode.c:826
 kthread+0x5fc/0x75c kernel/kthread.c:463
 #0: ffff0000c1ff2948 ((wq_completion)writeback){+.+.}-{0:0}, at: process_one_work+0x63c/0x1558 kernel/workqueue.c:3231
3 locks held by syz-executor142/6594:


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
