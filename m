Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59528CD3427
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  4 May 2026 20:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:In-Reply-To:Date:MIME-Version:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=W9hcyki3xORF9EkncYAw4IASMJtSrLOXNnQlYK9o5SA=; b=FV8ZTuhyXE1PTUUxZ7vchbW9I9
	O0zhF0k4bQtta1hCkbxHdH7ye1MSG5WKdwtbrzTfb5a9u/x2qS5kTdA0iBfl7U6FLJg44JMYfULbO
	0TrmM/BsoQ7fvIg3frBuBl+X8DYKcKHWp5L8c0elyCyd8HQ/eg77EZ4ouDiKW4QIzkY4=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wK0G5-0007FQ-LC;
	Mon, 04 May 2026 20:51:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3tQb5aQkbAPww23oeppivettmh.ksskpiywivgsrxirx.gsq@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1wK0G3-0007FI-Lf for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 May 2026 20:51:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=bCjj8G05TtBZLOd7zrH44gm7HPyOQ+hR+PG268x3BGk=; b=Q1azqEBvlxSV59OYsHWiDB575/
 ealBAu+yZzKzfsVghaYE3va3MNbkTScegP4VFe5JL0RBEJjA5/I5hzzquYTrj/8J5ufDdu7L0syZh
 k25rQv6sk7zeUQM5qYdb7bBUCjifesL134jy6HkgIJKsqcNJ3cOkJLtrpKyOAZjNLU8k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=bCjj8G05TtBZLOd7zrH44gm7HPyOQ+hR+PG268x3BGk=; b=V
 TQvX989tpQNqXO07/uBY+2g7+Cn4BjYUK0cJ2yCoryi0Jg3B/YHacWylvFPxin8TldlcMD4GXI6W5
 fWc6Mw4EHV7Ssygf5xpF+Ra/02Bs/m/tM3ZsqTbv6+sx9wor8c+J4TsPjh4D+16KpNZl/zGhWCjFx
 NzqdlImupaxaRkwE=;
Received: from mail-oo1-f72.google.com ([209.85.161.72])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wK0G0-0000W3-L5 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 04 May 2026 20:51:13 +0000
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-6853c2438b9so8871687eaf.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 04 May 2026 13:51:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777927862; x=1778532662;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bCjj8G05TtBZLOd7zrH44gm7HPyOQ+hR+PG268x3BGk=;
 b=Lh+lUeeqNpG7QK0Ov+f8pv2YO3K62ViwnDONWIaVVmM+K8r/unJhLk/6e3JKbNi4ey
 zscaSEH37HBc3iLfSePeJSRX1+CMIRtCJ2IRhYvwKPddwz5dYTOhEdSIJxdxM/4HDiuQ
 ym30pC2iqPP44hSqsiYRQW0fYlZdK8Z+cAWK2arxryMJAyNzRHWtRsfmSR1fcFzK93uy
 Qh05JyVcTMJh664Hm4SWI+LPXNEqN1g02ztjPiWscTJKk0ai2uiU75dfwgD8TukJi21C
 /jqkNE+datjr71uxRWAML0dS6wtQT+2MTsXAto5oftH8LV1tbMQyxToZn0HeMzxdE+uY
 rzBQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+uRSY9tLojkiSpO0kdE6wSZ3hWqFxAtYrPdI5gjNRI3QywEt3O1lsy+ApbTw774dO9W1puUJFeCIm9d0gYcqlB@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwVZQkNsQGmyvN2p+qAWyPGjBsFeq1CdP+IaA5ZrP7XidSjHQQg
 tLEQLApceeQlVGQoUYm5wd0WtQVsOkZxPrgXm5EbINrJakKwgUiE6JJSmcTwU2f+6KGhMZc55CV
 FY5aBDrjq+dGW6JDShP98v6n42cX6gzKKRIuFs+lVQTuzzbaI6ZT17OdvW8U=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:60f:b0:696:8c3f:d7d8 with SMTP id
 006d021491bc7-6998d225e63mr109559eaf.37.1777927861903; Mon, 04 May 2026
 13:51:01 -0700 (PDT)
Date: Mon, 04 May 2026 13:51:01 -0700
In-Reply-To: <2956b248-c79f-4eae-8bfc-81178b5899af@dev.snart.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69f906b5.050a0220.892e9.00d7.GAE@google.com>
From: syzbot <syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com>
To: dxdt@dev.snart.me, linux-f2fs-devel@lists.sourceforge.net, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-mm@kvack.org, syzkaller-bugs@googlegroups.com
X-Headers-End: 1wK0G0-0000W3-L5
Subject: Re: [f2fs-dev] [syzbot] [mm?] [exfat?] [f2fs?] memory leak in
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
kernel panic: !!! sbi at ADDR used after freeing !!!

F2FS-fs (loop1): f2fs_record_error_work()
Kernel panic - not syncing: !!! sbi at ffff888129322000 used after freeing !!!
CPU: 1 UID: 0 PID: 6598 Comm: kworker/1:5 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Workqueue: events f2fs_record_error_work
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x97/0xe0 lib/dump_stack.c:120
 vpanic+0x383/0x6d0 kernel/panic.c:650
 panic+0x6e/0x70 kernel/panic.c:787
 f2fs_record_error_work.cold+0x14/0x14 fs/f2fs/super.c:4747
 process_one_work+0x277/0x5b0 kernel/workqueue.c:3302
 process_scheduled_works kernel/workqueue.c:3385 [inline]
 worker_thread+0x255/0x4a0 kernel/workqueue.c:3466
 kthread+0x14e/0x1a0 kernel/kthread.c:436
 ret_from_fork+0x219/0x490 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Kernel Offset: disabled


Tested on:

commit:         6d35786d Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17a63a36580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9645c21cfd1d3e8f
dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
patch:          https://syzkaller.appspot.com/x/patch.diff?x=172b8ad2580000



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
