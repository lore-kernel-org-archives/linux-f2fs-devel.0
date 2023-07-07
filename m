Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 626E9EB64DA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Jul 2023 14:45:42 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qHmiK-0000v1-Mu;
	Fri, 07 Jul 2023 14:45:41 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3CCWoZAkbAB8NTUF5GG9M5KKD8.BJJBG9PN9M7JIO9IO.7JH@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1qHmiH-0000uu-96 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Jul 2023 14:45:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=faKZ0VTkrZreCkMMkV/w1MPosNwfKMr16O7H/usv77c=; b=cO56GLwKzW2vlGKkQ7Up8W11UQ
 xhMwSAo7HxLyZGEULdAPwEqweYNi1pjQgzzo3hhqLOlpI7jKXjwu8ZMXglyxCOYYrxKxEt/CP6qhp
 ydTdliYr1CFEgW/ik6ngTJg21qZ1YZrIL1aDLHDe7dScsHezhC9WGcW4joZbNd99qVRg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=faKZ0VTkrZreCkMMkV/w1MPosNwfKMr16O7H/usv77c=; b=L
 Ep9MZUd0vUVl5HyWmoW/rUmtfYeuxsgXQJq/uNfd/eSOcc+y8Lpd0S8njwzGpUcegXvbjSM9YO98y
 RXlCnbxmo9zHKZMh+5Ay/D6H7mk/5isXM+abmf3kc03F4cQrZmeE1rHWl0v/FPqnEKmc9vomhbW/M
 l267Q/akDRYJKfzY=;
Received: from mail-pl1-f200.google.com ([209.85.214.200])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qHmiD-000i70-HF for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Jul 2023 14:45:37 +0000
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1b855dc0f0cso30364865ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 07 Jul 2023 07:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688741128; x=1691333128;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=faKZ0VTkrZreCkMMkV/w1MPosNwfKMr16O7H/usv77c=;
 b=WuALK6Z/aFeACdZdeCJgLgLjrX4VjLXcm1dqAWbeO5Vs3rtLkv4PFIm9NQdaKrrIyj
 JfwgnOUmNtiDKsYYSgT8K3UtIKUiybVRzad+Ezhkd5sF9Ir+tIj9seXmEaXbCGUARUpP
 S1x1Q7PvzdyvM3ZNvZmn5wQvgLLFimUYXzre77yIFVpqnsLN85+OW23j25rpK1R5lkaN
 KLvHV7D5v5Bj0sUUmVrVu1rTm9T6xqFY+YlUYzynu/BkvavmrhMIg18THJTHHwc/5XDI
 7Dbb4gNvtCyaYRLVOuNK8ruyQSx0QJQQJSZBZQFPtXEJMmw6zLydrZQXeoBtEVzqhsA5
 Kj5g==
X-Gm-Message-State: ABy/qLaxEqfWWmWvN9ayT+0gX4Q2T8FRCX7WcqwyzmMGonPMvFpPjrWO
 d9f5U4nAenDtOCXWlv6Ec2q6cXRy8S4xrgJhrsJv5j3u9yAo
X-Google-Smtp-Source: APBJJlGcoqmtq9dZ2KJii6DburbTcLjXYhE/WlTYXTej235pqTl7vDbZOS50awBLW5giYdO8BGKF+iPVXKutQjDtW/j39Ci5SfBp
MIME-Version: 1.0
X-Received: by 2002:a17:903:2149:b0:1b6:a2e4:c8f8 with SMTP id
 s9-20020a170903214900b001b6a2e4c8f8mr5275199ple.2.1688741128024; Fri, 07 Jul
 2023 07:45:28 -0700 (PDT)
Date: Fri, 07 Jul 2023 07:45:27 -0700
In-Reply-To: <ZKgfG5yE+VoMiVsZ@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000db85105ffe6af2c@google.com>
From: syzbot <syzbot+e1246909d526a9d470fa@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chao@kernel.org, hughd@google.com, 
 jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1qHmiD-000i70-HF
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] kernel BUG in f2fs_evict_inode
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

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-and-tested-by: syzbot+e1246909d526a9d470fa@syzkaller.appspotmail.com

Tested on:

commit:         14245406 f2fs: flush inode if atomic file is aborted
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git dev-test
console output: https://syzkaller.appspot.com/x/log.txt?x=16961190a80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=20a954c5f553cc85
dashboard link: https://syzkaller.appspot.com/bug?extid=e1246909d526a9d470fa
compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.2

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
