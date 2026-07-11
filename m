Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD476C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 11 Jul 2026 12:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HyQGtGgVROWZjdg7wh4CaKMjt6kG9ECPiizbKkHLTVA=; b=CQ+LNht1viV60jYatbfnhC/Au0
	d2TrSInTUMezQMT3UEwBWs3+34HsXcTq4bsRPky6jTT5f6GHc4dPvC7V/Y0P6n4FzG9AIXwIpjtko
	YbPczkkqCba0nK/BloOPOeGxGwb+bVujvfPSLhZJNcMacYOnBdgXx1XW6IoXiFfoHviE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wiWsw-0005vz-VM;
	Sat, 11 Jul 2026 12:32:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <34jdSagkbAPMntufVggZmVkkdY.bjjbgZpnZmXjioZio.Xjh@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1wiWsu-0005vi-SE for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 Jul 2026 12:32:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SkSMtDXDKcM9TBgQNHoKTs9whDWqOwpKoo+SrhI+VZ8=; b=TgkyScBVMKOFanj15Bo+lOz5H/
 rpb0BK6YNI+wYmVuiMs0maUkCrUroVkGrX1qy7dQlGY18Oux2VhtdIWXf7VfHJpZRao/hAskBObv7
 RJaKr7SETahFUgD7570geuwEAh7ZM5uK85dMX2sDbKZfBJvgv8thU7QBaCoICZImm9cs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=SkSMtDXDKcM9TBgQNHoKTs9whDWqOwpKoo+SrhI+VZ8=; b=i
 b2vfJJCMEQBlK3srpeP9/IUG9YaoEUp8vY7j8qFspHOiMquB2wazcmRvA5ks7yXNFiBAgIm73aY4b
 rKUShlcOkqvcaq5z61POA5ykDbCF5XwhOqLJ/TCwoYHtL0lvZtBc9Ff4LOvBkYvBaegybU7X5Bsur
 NdzPExG/8V/MUi/U=;
Received: from mail-oi1-f198.google.com ([209.85.167.198])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wiWsv-000426-1m for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 11 Jul 2026 12:32:45 +0000
Received: by mail-oi1-f198.google.com with SMTP id
 5614622812f47-49aa4525b82so2034565b6e.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 11 Jul 2026 05:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783773154; x=1784377954;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=SkSMtDXDKcM9TBgQNHoKTs9whDWqOwpKoo+SrhI+VZ8=;
 b=fDBCc3OVUzv4AhjP7HWU/HMNSEH7AIZ2EmQM1VbZ+azijZkxiKOUX5dP/juwLzerrz
 +VUVNHNrc3dHbUF70N6c9rS8E9XqDqYdhdD8pxGksbC5kXZIFZbjRAXPLHzwIw2S/QLu
 HmBDjEIF8F/A89tgw7Aj0qeQEqL/XMDqm13cR7U5Nr2F5DNpisFSNAnDOzbe9hLDcSj8
 5pyBtn01SPSagWaHT3fn2IlbqOIzX/UDMEH4Bz1FWfExoFaarEnzaQMY0BwjmNu55jDB
 QNLgHsaeFljFQt9E+BymSWAyP8LRf07GmQfKk73vkDso1QETXTtXanvbIHU3iR/s2RRJ
 lCrg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/8xhRKgB1efnZ0pytJRM0fy5aph7HRQfqwDMetDVmRjhC47N6VYIQUFF9d6yrBKUOHntDVOBiEetsFwMj1N/dt@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzgHW44AnR5oMQEytKoBO4AQzScdbbJmmDmheHmQLu5F6AQb2Zw
 633d2AK17ugJlmS6/UP80wJpvDOTsYHOacW6Ucneo3rrblDTZei6ErZJ+GLK/e0v7BLHk+rwsrB
 NUxLHdclkVegjNbUOqADzCXaKNNOCzywDd+tCjgRBUCIvDX13pM+c+ha8XDU=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:1521:b0:489:b7d1:db7b with SMTP id
 5614622812f47-4a42ae84656mr1646317b6e.22.1783773154478; Sat, 11 Jul 2026
 05:32:34 -0700 (PDT)
Date: Sat, 11 Jul 2026 05:32:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a5237e2.278cdcd2.e885.0013.GAE@google.com>
From: syzbot <syzbot+listed17a4d940ffa203906a@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1wiWsv-000426-1m
Subject: [f2fs-dev] [syzbot] Monthly f2fs report (Jul 2026)
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

During the period, 0 new issues were detected and 0 were fixed.
In total, 10 issues are still open and 81 have already been fixed.
There is also 1 low-priority issue.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2252    Yes   kernel BUG in f2fs_evict_inode (4)
                  https://syzkaller.appspot.com/bug?extid=5c81eb8c0a380fa578b5
<2> 1367    Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<3> 298     Yes   INFO: task hung in f2fs_issue_checkpoint (2)
                  https://syzkaller.appspot.com/bug?extid=8a7eea50810efde15b0a
<4> 53      Yes   kernel BUG in f2fs_write_end_io (2)
                  https://syzkaller.appspot.com/bug?extid=4af46ee83100e99bce09
<5> 6       Yes   kernel BUG in clear_inode (5)
                  https://syzkaller.appspot.com/bug?extid=fc026e87558558f75c00

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
