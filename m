Return-Path: <SRS0=0BeM=DQ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FROM_LOCAL_HEX,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D2E2C433DF
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2020 02:40:28 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B83D2206F7
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  9 Oct 2020 02:40:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.b="kA8Y/Kqb";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.b="ihLryik2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B83D2206F7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1kQiKZ-0004eR-6x; Fri, 09 Oct 2020 02:40:27 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from
 <3hM1_XwkbACEPVWH7IIBO7MMFA.DLLDIBRPBO9LKQBKQ.9LJ@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1kQiKW-0004eJ-UA
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Oct 2020 02:40:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/vPsdNPBvKtbX2yFfD1uwNT/06XdsG2XB3HXtY9anCU=; b=kA8Y/KqbQ6+tv50plcIkt1qwfa
 eOSfD67tDXXcazf/tvKiQtW0+irK1HNPX9EVFyf7gr0+ZqzC47OyGXVLoXcuXWywxF6AQyqYzMGZM
 tTv59YpKzJTqENnUaaCszj6pOahiNh52WJ6ccqvGOTvfRidtTUiZgklAgvUSvrj0rdIA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=/vPsdNPBvKtbX2yFfD1uwNT/06XdsG2XB3HXtY9anCU=; b=i
 hLryik2sSE5ohtYVbwNM0PZJbZSq2DUV4B58mb4vdpEMLl41uQP8GWJ4one/okiX3MMaGY5B6ulAE
 0udfHVaqTgcQvHpKA0w0ZwnqTGS1ahBC4RVj/IS3T3ZivwPwEaPLwBdXpkmusQSIEhSfdNnXrk+XZ
 H0Cag71hWAsxW27g=;
Received: from mail-il1-f205.google.com ([209.85.166.205])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.92.2)
 id 1kQiKS-007rx9-83
 for linux-f2fs-devel@lists.sourceforge.net; Fri, 09 Oct 2020 02:40:24 +0000
Received: by mail-il1-f205.google.com with SMTP id x10so5764788ilm.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 08 Oct 2020 19:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
 :from:to;
 bh=/vPsdNPBvKtbX2yFfD1uwNT/06XdsG2XB3HXtY9anCU=;
 b=A4iyl8c4W9+wN92b4xf13h6MluZxmPl9uAd8bP3jwdDJsFFcGjX27AJzB8oZNblfT7
 r/OAVJCtV4FHOw0yXpm24HpZ7YB+ID8Fr1OMuMVCZNKq7k1HIytO9tuQZ1ZFM3+NPMeS
 YXnntjQ9Eg+a0NgbQWM8DcoXpbHViuUj+IjbEP5MkED6U9WavpdRCdz8WzmBP1s4bHQg
 5PSvt7eAudJ9jK7pXib+jTwTJg0vpssF9ZGW698RXgrquqNvs6DOIl76Prnx3J/6H+zL
 746SHJRdNa0rzkxQCal1DBDRjsRqiu+70hJo9rMJB//ujiiW0vdcgu9Slkd5NAd6dfbC
 qEjw==
X-Gm-Message-State: AOAM533ijHoZ93xO0/STYa+QoB00KtTuTGJPGy6REQK6B7cWnNCjxIlF
 RZf+0OgQLlWDAuBNwPCR2MrTa7QxQ7G6b2c2hvIPILvWTb2b
X-Google-Smtp-Source: ABdhPJwtkYMALivaBfrUViip7NgYrqa7K9OXqz214KzVWdtu39kWhABMAytxVEbDrR/IiTJNPDuHyM2I0Jvcf+BF+qyKKnXvhScE
MIME-Version: 1.0
X-Received: by 2002:a92:9a8d:: with SMTP id c13mr9258613ill.233.1602211204976; 
 Thu, 08 Oct 2020 19:40:04 -0700 (PDT)
Date: Thu, 08 Oct 2020 19:40:04 -0700
In-Reply-To: <00000000000085be6f05b12a1366@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bb48fb05b133ddf5@google.com>
From: syzbot <syzbot+05139c4039d0679e19ff@syzkaller.appspotmail.com>
To: Su.Chung@amd.com, alexander.deucher@amd.com, chao@kernel.org, 
 drosen@google.com, ebiggers@kernel.org, jaegeuk@kernel.org, jun.lei@amd.com, 
 krisman@collabora.com, linux-f2fs-devel@lists.sourceforge.net, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, su.chung@amd.com, 
 sunpeng.li@amd.com, syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
 yuchao0@huawei.com
X-Headers-End: 1kQiKS-007rx9-83
Subject: Re: [f2fs-dev] general protection fault in utf8_casefold
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

commit 91db9311945f01901ddb9813ce11364de214a156
Author: Su Sung Chung <Su.Chung@amd.com>
Date:   Mon Jul 8 15:31:39 2019 +0000

    drm/amd/display: refactor gpio to allocate hw_container in constructor

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1012ee8b900000
start commit:   c85fb28b Merge tag 'arm64-fixes' of git://git.kernel.org/p..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1212ee8b900000
console output: https://syzkaller.appspot.com/x/log.txt?x=1412ee8b900000
kernel config:  https://syzkaller.appspot.com/x/.config?x=de7f697da23057c7
dashboard link: https://syzkaller.appspot.com/bug?extid=05139c4039d0679e19ff
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12316e00500000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16e80420500000

Reported-by: syzbot+05139c4039d0679e19ff@syzkaller.appspotmail.com
Fixes: 91db9311945f ("drm/amd/display: refactor gpio to allocate hw_container in constructor")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
