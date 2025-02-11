Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1629FC021A4
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Feb 2025 13:14:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1thq5e-00068M-2b;
	Tue, 11 Feb 2025 13:14:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3G02rZwkbAKYYefQGRRKXGVVOJ.MUUMRKaYKXIUTZKTZ.IUS@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1thq5Z-00068E-NY for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Feb 2025 13:14:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=O+/hjFbIbDZDUYX/OfL0lWGNCNhr1qzEp6Ype0nGE1g=; b=AjSekC4oMyE14rf1+33werC4qV
 7sGviyp6MjjjJ0UkoFb93kj09ZjSmGsK/cdbvcpKBZ0wiL3cXq1lrSPtcQlrXB/R5VEHhyjrAsvjL
 Yujg7vAIlQJzmLVVVN42TpyoOchufxMphm7JugkMo/SDe33hCFZCzInlSXFPBZwpctFs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=O+/hjFbIbDZDUYX/OfL0lWGNCNhr1qzEp6Ype0nGE1g=; b=R
 5/ILwUB9zsAOc23vBtszem6ETNURg6HepRUC1JvrTuB3rBoiP1rilyup7T3ekg0AzFwtyCc1gdquq
 fMdY5XvNbJwQaFaEU+OGYuXABeA7ubjpPv65qewQRJeuMZNeKpLEhFsGlYTVLfcFerbpjEmZT+v1v
 btEiBjAVx0FzOn5o=;
Received: from mail-il1-f199.google.com ([209.85.166.199])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1thq5Y-0005v8-VW for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Feb 2025 13:14:09 +0000
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3cfba354f79so124039565ab.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Feb 2025 05:14:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739279643; x=1739884443;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O+/hjFbIbDZDUYX/OfL0lWGNCNhr1qzEp6Ype0nGE1g=;
 b=SFFEIVw91NcBO2FWXQ4gCg2rP5I29Dy5Q5ao6WFXd8QXN0RsQ2dwPodKt73tQRT9Qg
 LmPnXMwh2YgSelMWz14fKh89D3nEQyv6mRYGTqtGjwJpwL0oacs96COu3hBlZXC8OE1y
 Gh8jHfG3sB/45ECxZ9QdDD+iedNMdH/e3LRQ1s9dKfRWs57fmBP/FVfIpxwnjxFt0aOh
 VIPQbNMkEVORiGv8Gv3Z2dxhGyOQ6l9cAN6M+PVDjqh0rVsd0Fs84QAUntzKt9LFm54S
 AtxsIjrcE5mU7tgb0uC5c0APHBlErAIBLkShNKo8VNfup9qILtUZ92vH7/iWS/diaCD2
 2HvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXXZvd8jNSQjigD1f0qC3dJ2mRkeB/HfCGx7oY960pJQOz4PJXB+jwb0S8GllWqwyXNsd50Bwmxcm2xIztv7ox@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw1awBdSb9XzkwbT/X41CJ6ng8P/YNI4yPEekcKbSuo9HXe6CQO
 53jHZ5KkVL9eWTwZ64D6uko6G+YmeaTxVGSdeJm2i4yphqzLsRi6MppGcdJe+9p237z0UQfDjcm
 NS9qbb8CANJUXlhRUuw9XArV1WMEv95xjunB2bYxOIb2P4fK8wOVGd/Q=
X-Google-Smtp-Source: AGHT+IGAe6MaJHPV8anOOeIw8oHt1JE2+5WbmLcaINK+9XLwc/8FkldtSJMIPqZUy9e98TQbFhKfNf73jVTvbWU+s8JcxSpUuL0E
MIME-Version: 1.0
X-Received: by 2002:a92:c263:0:b0:3cf:f88b:b51a with SMTP id
 e9e14a558f8ab-3d13dcfce6cmr137737045ab.2.1739279643323; Tue, 11 Feb 2025
 05:14:03 -0800 (PST)
Date: Tue, 11 Feb 2025 05:14:03 -0800
In-Reply-To: <675cd64e.050a0220.37aaf.00bb.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ab4d1b.050a0220.3d72c.0062.GAE@google.com>
From: syzbot <syzbot+15669ec8c35ddf6c3d43@syzkaller.appspotmail.com>
To: chao@kernel.org, hanqi@vivo.com, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1thq5Y-0005v8-VW
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] kernel BUG in new_curseg (2)
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

commit 84b5bb8bf0f6a78c232a20c2eecdbb8112ac2703
Author: Qi Han <hanqi@vivo.com>
Date:   Fri Oct 25 09:18:23 2024 +0000

    f2fs: modify f2fs_is_checkpoint_ready logic to allow more data to be written with the CP disable

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11d1f1b0580000
start commit:   a64dcfb451e2 Linux 6.14-rc2
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=13d1f1b0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=15d1f1b0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4b1ef007dfb9422f
dashboard link: https://syzkaller.appspot.com/bug?extid=15669ec8c35ddf6c3d43
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=166931b0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12be72a4580000

Reported-by: syzbot+15669ec8c35ddf6c3d43@syzkaller.appspotmail.com
Fixes: 84b5bb8bf0f6 ("f2fs: modify f2fs_is_checkpoint_ready logic to allow more data to be written with the CP disable")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
