Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B7C1EE01FA
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Sep 2024 02:12:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1soCq7-0005cQ-9e;
	Wed, 11 Sep 2024 02:12:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3cvzgZgkbAC0bhiTJUUNaJYYRM.PXXPUNdbNaLXWcNWc.LXV@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1soCq4-0005cJ-Sn for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Sep 2024 02:12:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VAb6PrucaF3wYrRP+7jKeLaHRcrUdHKeMrEXsjelCv4=; b=RIAA1NKhIpyvgAjzAQtdN8dRuK
 zkeByvUEcGtB+1P3/lnqu8kTH19LqM909UA9Gy0tYvg1FpF0sudoa5gK4pAHtxzxy0UE0QO913Fxl
 OVPmCcBF75aTiuZ5XyERFanX8zUQB9RkYfILMDeTEG+RdBYA3MgzbIUshtTJmBEmA1js=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=VAb6PrucaF3wYrRP+7jKeLaHRcrUdHKeMrEXsjelCv4=; b=N
 +H08XUTZArd77dWaNE2jBp+JEM4toN//nugz5aioVecTxAO8iROQCLID1GDmDQOAYIdFaF+Be23cP
 f56DPjyaeYMIDwpsk6IE6hZhGtqa5a3eBKWcGYgh7veeaHEmUy8RAwYjkoAMm8Hy9bctPGbv6FoHP
 jrdiueK6PLN4XqwM=;
Received: from mail-io1-f69.google.com ([209.85.166.69])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1soCq4-0004rU-RU for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Sep 2024 02:12:13 +0000
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-82a678fbd0dso197102939f.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 10 Sep 2024 19:12:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726020722; x=1726625522;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VAb6PrucaF3wYrRP+7jKeLaHRcrUdHKeMrEXsjelCv4=;
 b=nVBR8AHBG0kAEVkdLvoLPDOHouWH8iAYtscunW3cAK4ADkkhNHPpCNZv6VCqRNJ9Ge
 TUdzoEVqoBYM0DjTxtdjjZSqAbFJnNFErx9mn3D4X/0pxBhQxV2S59tdZTML9hAUrndP
 yHrQTL/e40rsHz+EBOFgfX0Qj02L8Rq4JBs9hRlbT38AwzlZnn7FUyt4xBP189ciw+YH
 pubcvvI0Dvwyfn5KTGYXaSmeX2yPKFpIkTciex1+jlQh03dvZCZUugrXg1jFszSD5db5
 uFbO3tg9M7VWoV7pT8xm/wWI/1VkIxYFiIoU1VuQOGy/bnh/67zCYMmZR9cw2/kfBiFX
 IF8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtlfZJjmxU4dJHuklpKju3IiMg54mVUXuB4iyInDxiGuM5rWGqZcEEtXkieNx/SnbDuNgkWbH7XQg6f0tbBWv9@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwHFy94bwA23QZ+fbYZ1OInn5YrgR2Aw2UYzzjZ5faw2qIMpZyg
 WaEIGOOTtX2K8YN5SUuHY4AP5CuJs1Gl4oZmHbv+HPu1aW+NuxmeE/y9vBwhgc9V0FjtNr52CjC
 ZC8HFiZ7CNixlXRRU5Z8Gy9vzlIxoHpzNPYakjHqLpMu4jUUfNJxeILw=
X-Google-Smtp-Source: AGHT+IG8OnDxIx8zhynaeNrH9ZWBpxv85d4tUS50j5wGR/JJmwJu4dQH1js3aFIsJEZk1GEdjvAevNdyH7TIe6YwroIGKCIDGD5Y
MIME-Version: 1.0
X-Received: by 2002:a92:cd84:0:b0:3a0:57b5:72e6 with SMTP id
 e9e14a558f8ab-3a057b57348mr49780205ab.7.1726020722026; Tue, 10 Sep 2024
 19:12:02 -0700 (PDT)
Date: Tue, 10 Sep 2024 19:12:02 -0700
In-Reply-To: <2fba030d-bd24-4a3d-852e-e10a484feaaf@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000002f8e20621ce84e3@google.com>
From: syzbot <syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com>
To: brauner@kernel.org, chao@kernel.org, jack@suse.cz, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
 viro@zeniv.linux.org.uk
X-Headers-End: 1soCq4-0004rU-RU
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] WARNING in rcu_sync_dtor
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

Reported-by: syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com
Tested-by: syzbot+20d7e439f76bbbd863a7@syzkaller.appspotmail.com

Tested on:

commit:         f3815bfb f2fs: fix to tag STATX_DIOALIGN only if inode..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip
console output: https://syzkaller.appspot.com/x/log.txt?x=1319e807980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9358cc4a2e37fd30
dashboard link: https://syzkaller.appspot.com/bug?extid=20d7e439f76bbbd863a7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
