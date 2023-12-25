Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 375B6C3DA6E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 25 Dec 2023 22:43:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rHtfI-0002q3-Oc;
	Mon, 25 Dec 2023 22:43:17 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3eAWKZQkbAN0RXYJ9KKDQ9OOHC.FNNFKDTRDQBNMSDMS.BNL@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1rHtfH-0002px-3J for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 Dec 2023 22:43:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=s8rzGGM2S/OWnwe++5O+Ch05F0TdIpzpVypo88YRjSE=; b=OpFWJevqvP/TQN1WKzHQJ/Cwe+
 yljZVgPOzFYax0Q9Fb+icr878hOOvL83VyiZ1pso8yIWA5dNVQ6Sx2kflYhrbpg1gEx4+RQWSQyDS
 KMB4+UN0rrh5vI19+OkBVnDuzbgqLBtCAJjs/Lj5JjZweX3kCHjnTWsS3I9oy0LPxyuU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=s8rzGGM2S/OWnwe++5O+Ch05F0TdIpzpVypo88YRjSE=; b=m
 DQWnJTgSPvemIXAfznnGwz/sNXWwObPHf3zGOhC263YduRa4XpvBagHZhMS2nyDR28+i0wUDmGG1o
 FN1vntM183QwivXuG6a1AbjLuhUGuw1bjo8RTHn8osXT6fgaHG0T738/VxfHxuIb5ZbWPeWLAzaKP
 JNZULkzCtnQSNKUk=;
Received: from mail-il1-f199.google.com ([209.85.166.199])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1rHtfG-0006IJ-RN for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 25 Dec 2023 22:43:15 +0000
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-36000bb7f6fso9581665ab.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 25 Dec 2023 14:43:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1703544184; x=1704148984;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=s8rzGGM2S/OWnwe++5O+Ch05F0TdIpzpVypo88YRjSE=;
 b=p9IwXxEdB4PZU/24UhcqE8m1ZnNgmHZ2ewutOft4AAuMpN6lkCxuVoI2r6D+zpCx3t
 m7dPvHbYbv1xb6BHhISVh/eAaban/dT7jHNMJnXoXZOjQJnqPGdJc0Hb2QKQCbb9o2HW
 JtRxKBdvLmMGqKFgybn2GfkfJVor4B6eBix+/r6Y2Xo/bAUYXcll6uoWEWfjulNLLQ94
 lNccw+qVSrKa1br+pAJRc9HBRohuGKGWET91414KL12WZTop0e8hbQ0bN1K7f1J3Pt2F
 c28LxW7KFOG8g2F8ESLRs+Kj71Rpqe5HMclNwWMh3Izp488evqdqJW2JsVSrDHLLlsfv
 +w3g==
X-Gm-Message-State: AOJu0Yy8XgSeTVoXASlu3m96vIQbq4FRgbCoI5LZrQQrLNMrdvnwC0Un
 I8HBQKZ78KuQMdpDuO5/nMcNn9pfi2f9y9/75Mr1kPb1cY8W
X-Google-Smtp-Source: AGHT+IFhBkqwTv7B+BcCEtyN9Hf+fnEdykai0psDJjz+v5pzAYyo+VjG75vi9WIN/ZNrgS6SmU76yh0W7Fy4KWjDGSULIJd0jACh
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1bad:b0:360:e6b:bc4a with SMTP id
 n13-20020a056e021bad00b003600e6bbc4amr5652ili.2.1703544184228; Mon, 25 Dec
 2023 14:43:04 -0800 (PST)
Date: Mon, 25 Dec 2023 14:43:04 -0800
In-Reply-To: <00000000000052dcf505f6fc93af@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000f5d50e060d5d493b@google.com>
From: syzbot <syzbot+b9c67110e04430822b08@syzkaller.appspotmail.com>
To: daeho43@gmail.com, daehojeong@google.com, jaegeuk@kernel.org, 
 joneslee@google.com, kernel-team@android.com, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 nogikh@google.com, syzkaller-android-bugs@googlegroups.com, 
 tudor.ambarus@linaro.org
X-Headers-End: 1rHtfG-0006IJ-RN
Subject: Re: [f2fs-dev] [Android 5.15] BUG: scheduling while atomic in
 f2fs_register_inmem_page
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

syzbot suspects this issue was fixed by commit:

commit 76ca4a07659a31cc62977664bcf638d6a24af068
Author: Daeho Jeong <daehojeong@google.com>
Date:   Thu Apr 28 18:18:09 2022 +0000

    BACKPORT: f2fs: change the current atomic write way

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=11287ba5e80000
start commit:   61cfd264993d Revert "ipv4/fib: send notify when delete sou..
git tree:       android13-5.15-lts
kernel config:  https://syzkaller.appspot.com/x/.config?x=86febd5cba631f80
dashboard link: https://syzkaller.appspot.com/bug?extid=b9c67110e04430822b08
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=135fe388e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=171ba588e80000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: BACKPORT: f2fs: change the current atomic write way

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
