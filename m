Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AB6FC433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 Apr 2022 12:29:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nhVvy-000554-SO; Thu, 21 Apr 2022 12:29:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from
 <3Fk5hYgkbAFEBHI3t44xAt881w.z77z4xDBxAv76Cx6C.v75@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1nhVvx-00054x-Au
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Apr 2022 12:29:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=2LH/TUAXgyjFg87lmutVH/Zh/Ig4GTObkpnNk61xg+4=; b=YADpA5WI9fOxesV2qMeujy9xE+
 +ebJcwodknG/PRX1pDswRFvJfH0yEwRh/2inFz2pp8XI4NNMnQC2yGkCtoqjLNhB1CFfT835PIce5
 b7AoAQAmhtSxbvtvVLwnFOVQ+1AxHMOll19dhbW75qKrXLoUGnsoLLJ0bRGxbKuw8oSQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=2LH/TUAXgyjFg87lmutVH/Zh/Ig4GTObkpnNk61xg+4=; b=D
 IevKw7xgJmSsSBe/ewOyDmurRfC8AIgNSka9K8AaARD/hPT3gr/FRCkm8gFOxh6iOdIdrNtr0rxQl
 crqIYlIhSuxWe21sP9kjy/gglAwEqiTjnwRZkXJCeLp7qyANPhtepakgKFR9I0XjbtpIGxgrA7Dh6
 oafbcETs9/ZCnVjw=;
Received: from mail-il1-f199.google.com ([209.85.166.199])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.94.2)
 id 1nhVvw-0004tt-GH
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Apr 2022 12:29:18 +0000
Received: by mail-il1-f199.google.com with SMTP id
 x1-20020a056e020f0100b002c98fce9c13so2544276ilj.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 21 Apr 2022 05:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
 :from:to;
 bh=2LH/TUAXgyjFg87lmutVH/Zh/Ig4GTObkpnNk61xg+4=;
 b=fzT5HzJoCJ+tODmxHdzmTQX0+Pc9MvRS2UxvkjkVpRI3vkhu4+a1QDgGrYPMmEfLgb
 4qkquLnTAXjUvE8eZ954yQ6FqALZurHvvO9PhK0cwfT+/FlXlptDRehuF9Bnc8tX/aw6
 YPHUWiPxV6LG7TZLbKus+3aIZHCHMpOkLrxrPh5dxw6iA2pL1vavBGNTYVPm6i9vAPAE
 DvSN8uOf9+XxMDbj968rgMtM1DPmv5l5CXtGEvcA3vdBkAgM5xd4K+YHh+LEQDMHlm1O
 yHSW0qcd6ArNiP3WzFXSc9de+rqh74ZwEcdZ8eSz77q9npDiQfkD8pviqeFRtIjik24f
 74xw==
X-Gm-Message-State: AOAM5302L7L90vnEe505WRVyQlKdf0Uly9Ej+7Gbjug9fs+8neKsRN9p
 cDX26QHI7vc2qxSHgS9LGZ2gsC19VooAspjyCILlVuFN03Z5
X-Google-Smtp-Source: ABdhPJw9cDZEQPn7qRg5XxIXfP++kvVm4Mw1mTgznR6D5YpBs5CrAp8bCEiEqG9rWSv0a5q9ra/l7nk55Ugc5U+QM+RiN92OCC+2
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cab:b0:2ca:b397:a2e0 with SMTP id
 x11-20020a056e021cab00b002cab397a2e0mr10720692ill.104.1650544150570; Thu, 21
 Apr 2022 05:29:10 -0700 (PDT)
Date: Thu, 21 Apr 2022 05:29:10 -0700
In-Reply-To: <000000000000f8b5ef05dd25b963@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c7ede805dd2941b2@google.com>
From: syzbot <syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, chao@kernel.org, 
 davem@davemloft.net, jaegeuk@kernel.org, johan.hedberg@gmail.com, 
 kuba@kernel.org, linux-bluetooth@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 llvm@lists.linux.dev, luiz.dentz@gmail.com, marcel@holtmann.org, 
 nathan@kernel.org, ndesaulniers@google.com, netdev@vger.kernel.org, 
 ntfs3@lists.linux.dev, syzkaller-bugs@googlegroups.com, trix@redhat.com
X-Headers-End: 1nhVvw-0004tt-GH
Subject: Re: [f2fs-dev] [syzbot] UBSAN: shift-out-of-bounds in
 ntfs_fill_super
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

commit adf9ea89c719c1d23794e363f631e376b3ff8cbc
Author: Chao Yu <chao@kernel.org>
Date:   Thu Aug 26 02:03:15 2021 +0000

    f2fs: fix unexpected ENOENT comes from f2fs_map_blocks()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=101dd0fcf00000
start commit:   b253435746d9 Merge tag 'xtensa-20220416' of https://github..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=121dd0fcf00000
console output: https://syzkaller.appspot.com/x/log.txt?x=141dd0fcf00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ff9f8140cbb3af7
dashboard link: https://syzkaller.appspot.com/bug?extid=1631f09646bc214d2e76
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e13cfcf00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=135e3008f00000

Reported-by: syzbot+1631f09646bc214d2e76@syzkaller.appspotmail.com
Fixes: adf9ea89c719 ("f2fs: fix unexpected ENOENT comes from f2fs_map_blocks()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
