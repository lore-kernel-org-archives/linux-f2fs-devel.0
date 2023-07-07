Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C88BEB64D9
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  7 Jul 2023 08:55:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qHhEy-0002KY-VJ;
	Fri, 07 Jul 2023 08:55:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <33NKnZAkbAE07DEzp00t6p44xs.v33v0t97t6r328t28.r31@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1qHhEw-0002KS-Vj for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Jul 2023 08:54:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MQ6fgIhDLVZg04LxsAC2t0anmvaYhwdWlDV+pQJ8Auc=; b=X/bz2U79huyVkFyzmQVXM+kI1W
 FCcFnX3EaNBNArWpGoywMbv91HBxbW6MLNXOlJSJGdYtKJlUyQyyuNET1BWIbK1SYmVsBG1kUUdVR
 t9cmUDSk2CWq3k2UGqC2Nb1pMsUxcTJCE2DGe+8sFzsqbCWk+GXm9nWIDn9DvnPn6YlI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=MQ6fgIhDLVZg04LxsAC2t0anmvaYhwdWlDV+pQJ8Auc=; b=e
 +JSl3xlc+GcW5SsKDrKAkc2PLLv0aWhmmfcyZJZCQ3PEk0jupqgDVIOMYCF2wAzCoBUaqw7xETkoa
 o/0F7c5BlvNd1TR8LecEuql37ffOUw+uq260hzRUt8RILNZRrgy1IICIBccjbAjdDiBP1OsAPadHd
 zYfaQaNCjCl8FhI4=;
Received: from mail-pl1-f197.google.com ([209.85.214.197])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1qHhEy-0007nk-UT for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 07 Jul 2023 08:54:59 +0000
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-1b8c8bd3f7dso14033205ad.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 07 Jul 2023 01:54:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688720092; x=1691312092;
 h=to:from:subject:message-id:date:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MQ6fgIhDLVZg04LxsAC2t0anmvaYhwdWlDV+pQJ8Auc=;
 b=il91dRnIeHOzwdvY0mkTLFWyiEZiINO6N5XE6M2K8+9GgOE1aYipC9XMrfVxHIb02u
 1y6wBqZECmSBRjYqchjrPbydtZfNbi5o3hsDHyUk2NWJJsXllS6uedLUfZxb8jFhJCbh
 45RrqV5YAZSouGb6MafDLydqrFEjWEmx3Ztihw/ZNXwgZIR+QXPFYf4cLyAirjI59jg4
 wXxszPOM1uBfuIVv5OjoQRzc/77eOizCdmo6CQE0Ya84ffLFuw39nXLJ9VkMeG1LI7Up
 8wldXRxuVpqyuUijX7HplY2FtLtppR/vz12BLS1yY/HOPSewoslHuIZGKgVkRHiQIaxU
 kTkA==
X-Gm-Message-State: ABy/qLaVQpwV5jgfxuN1e79zK6IrvAJfZgfOevMV2taMElc8VMnnWjjE
 TsU22gXAbDbpL6dE7B6hg3jave9yGxjQJgUD5+aX+ZgV7Hor
X-Google-Smtp-Source: APBJJlH/6XUTd0vo2I6hYGqtjOXqugsdmlRs6OPKCWMF8oV9KCJpoI4Z+pjsIwuyh/eCQHgzTDqetM2K4JyPrJ5qEez8b5WEP5dr
MIME-Version: 1.0
X-Received: by 2002:a17:902:e843:b0:1b8:a70e:dd00 with SMTP id
 t3-20020a170902e84300b001b8a70edd00mr4150807plg.6.1688720092614; Fri, 07 Jul
 2023 01:54:52 -0700 (PDT)
Date: Fri, 07 Jul 2023 01:54:52 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003ed80905ffe1c97e@google.com>
From: syzbot <syzbot+listcf7fbb62c045af90dfd2@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
X-Headers-End: 1qHhEy-0007nk-UT
Subject: [f2fs-dev] [syzbot] Monthly f2fs report (Jul 2023)
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

Hello f2fs maintainers/developers,

This is a 31-day syzbot report for the f2fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/f2fs

During the period, 4 new issues were detected and 1 were fixed.
In total, 11 issues are still open and 29 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 212     Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<2> 96      Yes   kernel BUG in f2fs_evict_inode
                  https://syzkaller.appspot.com/bug?extid=e1246909d526a9d470fa
<3> 49      Yes   possible deadlock in f2fs_file_mmap
                  https://syzkaller.appspot.com/bug?extid=c0e3db4f9cd6e05cadd3
<4> 4       Yes   WARNING: lock held when returning to user space in f2fs_write_single_data_page
                  https://syzkaller.appspot.com/bug?extid=eb6201248f684e99b9f8
<5> 1       Yes   general protection fault in f2fs_drop_extent_tree
                  https://syzkaller.appspot.com/bug?extid=f4649be1be739e030111

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
