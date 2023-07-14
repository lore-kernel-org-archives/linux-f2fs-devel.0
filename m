Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0F75EB64DC
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 14 Jul 2023 15:11:47 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qKKSP-0000S2-2N;
	Fri, 14 Jul 2023 15:11:45 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3pGWxZAkbAGERXYJ9KKDQ9OOHC.FNNFKDTRDQBNMSDMS.BNL@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1qKKSN-0000Rw-II for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Jul 2023 15:11:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CCLOxUsPk9gij7lrd4gl3ju7/pLr9suuyXvJ5OtLAUQ=; b=TueBTun0hldeaW0D92zI8nrTOS
 WOXqxwevwq5eMfp6V0WdDMDeKobukTHZNYaS9/RX2o7bmQDFS3fkX3nm4BTIwfJ9VWgI+JGYYJ5A5
 Fi0qxBtCbhHiIGlPP4vpREeBguI5nYtJqZYDefUj4Hbbl0GHDT5CZTW03Zj+JeAiHVEU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=CCLOxUsPk9gij7lrd4gl3ju7/pLr9suuyXvJ5OtLAUQ=; b=K
 0tnBe+/5CjYfpt6u9Bgd/2NVEkQY0c/GB5PotrUsx7X2fOwe2dGJ0r1Ip2NaBID+l8g4hV8bWWRvM
 sejJeh0TbaO+yvfWa+E9i+e7LTT9Ir2o3KNB6g1X1AWMwKYCPWEjAHR6mBR9LL9KzApJwcVsvDxoh
 GerPbys7FyztC3nU=;
Received: from mail-ot1-f69.google.com ([209.85.210.69])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qKKSJ-0001Bq-M0 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 14 Jul 2023 15:11:41 +0000
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-6b75153caabso3263642a34.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 14 Jul 2023 08:11:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689347492; x=1691939492;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CCLOxUsPk9gij7lrd4gl3ju7/pLr9suuyXvJ5OtLAUQ=;
 b=by7KmGl52HHlIq3kc8YkqRKmV1PxDd8YDWnnl/kSho9j4R0Uzfjx7O3MIoO9QPsRaP
 9H8Xee9T6glPW5t7wov91pKG7P5P5ohP11rtIwFrHdhvoRsHdQdnOk2DNejO6pDwceHf
 juoF+EI9HGk5cw0zMGHD78LL4cujazhvyTmKlwkCDJcqJlaHVSjI//vTuOkgZJILgTIv
 fIgwVPp0F6OxPONc/u+ItYz1emFjkHZhkG1w95UgFoCwBZyS9GPZ5u8Asj9exYmiTHcW
 YcWY/yCdYUQHc+Cr+o7nMRcT4pTYFX+1M4H4PGYEhMVTsa8CewHg7GhvM1VUam1lLjCg
 6C4Q==
X-Gm-Message-State: ABy/qLZ9ZaqqRVETirdT2cPW2jQz3XrjKabK2oucSl0mQNnT3yc0A+BF
 1bUBPf4TVxfskD1oPjQ2QiFFlm2LSoXN/v93hK8zg7ugofwa
X-Google-Smtp-Source: APBJJlE6TyCcdhAUrsmWbb8fvxPE8mWG/ukHNruZoQLsPGdacASBBgg9EA/N2Q99G1L6A2y+bsP1WGM7Wx8B6uHLvOQRaJVtfrE4
MIME-Version: 1.0
X-Received: by 2002:a9d:7488:0:b0:6b8:8894:e4ac with SMTP id
 t8-20020a9d7488000000b006b88894e4acmr4268213otk.3.1689347492003; Fri, 14 Jul
 2023 08:11:32 -0700 (PDT)
Date: Fri, 14 Jul 2023 08:11:31 -0700
In-Reply-To: <0000000000005921ef05ffddc3b7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000029c576060073dd62@google.com>
From: syzbot <syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
X-Headers-End: 1qKKSJ-0001Bq-M0
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] possible deadlock in f2fs_getxattr
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

commit 5eda1ad1aaffdfebdecf7a164e586060a210f74f
Author: Jaegeuk Kim <jaegeuk@kernel.org>
Date:   Wed Jun 28 08:00:56 2023 +0000

    f2fs: fix deadlock in i_xattr_sem and inode page lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1177322aa80000
start commit:   3f01e9fed845 Merge tag 'linux-watchdog-6.5-rc2' of git://w..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1377322aa80000
console output: https://syzkaller.appspot.com/x/log.txt?x=1577322aa80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=29fd3392a08741ef
dashboard link: https://syzkaller.appspot.com/bug?extid=e5600587fa9cbf8e3826
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1336f364a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=130a365aa80000

Reported-by: syzbot+e5600587fa9cbf8e3826@syzkaller.appspotmail.com
Fixes: 5eda1ad1aaff ("f2fs: fix deadlock in i_xattr_sem and inode page lock")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
