Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2046BC4707B
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 13 Jan 2024 06:38:20 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rOXer-0007Zn-Ko;
	Sat, 13 Jan 2024 06:38:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3zC-iZQkbAOcbhiTJUUNaJYYRM.PXXPUNdbNaLXWcNWc.LXV@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1rOXep-0007Zg-HN for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 13 Jan 2024 06:38:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C/sGOHyENyQ7i0bMTzfDcnKoPl21TmOJ32DC/X68Sl4=; b=hW/KdS8UbiKLNg57Frs1DiebV7
 D7QwSjWcrxs8fRcI74FnhQImCU+WNjbJm7vazPAJPOVYPePWP7EuTn5tLYE4TsENkV2ojt5FeaPOG
 uszBxeoDEDaWAShAKAhOTa3BV/aN3VsX7aNDDHylcc1emydWbABGDhyrPEJaqkF2Njfw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=C/sGOHyENyQ7i0bMTzfDcnKoPl21TmOJ32DC/X68Sl4=; b=a
 3AN6bSs1KEjaBLWXtWONNrHvn4l9YmAsxcanmXq6f3nN9ahe9yYKh9FwPLJnf2E5eS8AtmMoFbY4t
 aTBnjNUP7LT5ihREB7CcS/5TvG03VEqf2JIko+2CYyrGWu7G0yXYWD/rvlyLAClSnR3hlu4rriwPp
 xFBIH0U6CcgXjMQI=;
Received: from mail-io1-f71.google.com ([209.85.166.71])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rOXeo-0000up-Au for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 13 Jan 2024 06:38:15 +0000
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-7bc3dd97ddaso646058239f.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 12 Jan 2024 22:38:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1705127884; x=1705732684;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C/sGOHyENyQ7i0bMTzfDcnKoPl21TmOJ32DC/X68Sl4=;
 b=meOp+hXbV/2hM6hjmcf6bAjhW9wmxO4rrn+l549Yoog300NqLudDXhs/G09eaD4j9f
 uJBEinSsfOvvWn54luxs78ekPvKjpDUtZGa6ahLATzwrh4xGYrOA/nMO5kgR7FxXyOB7
 +1g9cYXLVMYZqwk0EQARtsK3Y99/DFNkzL6iwAllzGHv7dYDkLggarjNfz63TOpouhqe
 shrjM8f3gHZrP5ZnSY282xW5wfWz6vhKxPzj3EyHVYrnYbWcV5drmv1JE18tCrPJqLU2
 XDehK5+31d/XofZGZ1LXsLQS1UgixRTVFeMSJqQcgL2nf8Jnt0Q3sIk9dw99rgVhkP4V
 9ktA==
X-Gm-Message-State: AOJu0YwO/On1xizj0de/ImRBCGHgMsbjuYHNAUZ0r4Dyg3PtOQavy9/B
 YLexsFfSjxvkjOE51kLReYKm9FlTYelRwCkQP4dbElzSp86I
X-Google-Smtp-Source: AGHT+IGNM+FdG1AbyUYcw6kxC9URY0S3T+KJqSYkHLA8+jx0v5cOSRLiGSC4NszsTS++2Ts56IlniAXgBLCjDqqD3qjYpWr6CSAN
MIME-Version: 1.0
X-Received: by 2002:a05:6638:130a:b0:46d:1c7:3b12 with SMTP id
 r10-20020a056638130a00b0046d01c73b12mr146543jad.5.1705127884248; Fri, 12 Jan
 2024 22:38:04 -0800 (PST)
Date: Fri, 12 Jan 2024 22:38:04 -0800
In-Reply-To: <0000000000006cb174060ec34502@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000d65af9060ece0537@google.com>
From: syzbot <syzbot+8f477ac014ff5b32d81f@syzkaller.appspotmail.com>
To: chao@kernel.org, ebiggers@google.com, ebiggers@kernel.org, 
 hdanton@sina.com, jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
X-Headers-End: 1rOXeo-0000up-Au
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] KASAN: slab-use-after-free Read in
 kill_f2fs_super
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

syzbot has bisected this issue to:

commit 275dca4630c165edea9abe27113766bc1173f878
Author: Eric Biggers <ebiggers@google.com>
Date:   Wed Dec 27 17:14:28 2023 +0000

    f2fs: move release of block devices to after kill_block_super()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=16071613e80000
start commit:   70d201a40823 Merge tag 'f2fs-for-6.8-rc1' of git://git.ker..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=15071613e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=11071613e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4607bc15d1c4bb90
dashboard link: https://syzkaller.appspot.com/bug?extid=8f477ac014ff5b32d81f
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112b660be80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14c1df5de80000

Reported-by: syzbot+8f477ac014ff5b32d81f@syzkaller.appspotmail.com
Fixes: 275dca4630c1 ("f2fs: move release of block devices to after kill_block_super()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
