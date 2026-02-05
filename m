Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0430AEC1EA5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  5 Feb 2026 12:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=S8ExhgcAy2JDCYe8pdqmN6pFIt5OSmfmn7yoAyQom0o=; b=H49y4dvxBUvy3s5E5Dsb/1ZkIb
	eudsoWa4KROUCwKYum2VtYMzDnAuwHVOztlI4NJPw3J/tFh7J0PBNlPVpyg4Tmv8ZcIYM3d5WjQdf
	zsgohCjFzEf7YIGfYwv3hMH+mjEtMq8oDz4us3KKXbLKspEMAlpTZtuR1vkkTGoLfT6U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vnyZA-00071y-3L;
	Thu, 05 Feb 2026 12:34:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3T46EaQkbANAEKL6w770DwBB4z.2AA270GE0DyA9F09F.yA8@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1vnyZ8-00071s-JI for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Feb 2026 12:34:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FcfvDljY3acd7hIpi4WHccCegIthwUwLfJxJtltlxW0=; b=E6Gc0vQ2CQLLB4zVoyU+qTtZvk
 Wv6GkkyxLkBI4DsqHo4ZX8m27P1l+d2l3kZjn8anG3XhigX4Lbsuro0Z4b8O8MDeKkNF3emby8T8w
 1H0ucCyKz4LORnmQt20G60y+KT8aJ5WGg/4A8VtKw19KNhD2gVKX96SrkTysz1XL8NgE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=FcfvDljY3acd7hIpi4WHccCegIthwUwLfJxJtltlxW0=; b=g
 XxdsoAEmv7xppINaODh80PhnSYO2gI+ckEWkwfNDO7WFKNWzR3a1wp7r7iYndHQSbLkD9VdfBuqqQ
 irwjeddZqSfb2a2KUAd83T042EvVnMLy2Fd3Pfkiih7iWDJUhiMLORyMHEGnBHgxXd5EAHxgCe7bf
 QBx8Mj+m7Qt+qjjk=;
Received: from mail-oo1-f69.google.com ([209.85.161.69])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vnyZ8-0004JX-1r for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 05 Feb 2026 12:34:34 +0000
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-66304fd62ebso3666475eaf.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 05 Feb 2026 04:34:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770294863; x=1770899663;
 h=to:from:subject:message-id:date:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FcfvDljY3acd7hIpi4WHccCegIthwUwLfJxJtltlxW0=;
 b=UDd8XVfJiFPcaqjEtYERHJDQCP+288cJJmXlBJ0+Sv/YEIYO/fmYfqC+28LP0TTK+4
 GA/2guPsE08uDxkO/7hf28G+t9D+o7s8wVFFypBZ6e2hVyau4KO/V/8mRmDTJXU9Ci+b
 bIC/Bm6+mYvNK923t0GndCMOtnHAvHzddGo2Sqsb30Oe28oJ2UNuZWPqKbsgAEk89w1l
 k66TivNIVmmeqnIow6bKZmPBCp0rj22bU4i04hsxx/7UL2k3+IWpqhiB70Dzmh8nH0Zf
 CS+vl+CINxQldm1Zt8++UQ8PGC6m6N/mXBomSi+Hv/yp7l+Qryxe9aEuU/sZEy8BNu72
 Eo4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcQAcqkE4G35hMnG9aiBwJ1GDTsIzSyTf7p1Z7zvhmQVn4JKr1u/MggWgvongTAU4p2cB/2XSjq0p1+Eez5dlf@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw3xR5O1ggq+b6d/x87uxvIY8ky6z/QC0eWQGSps+fcs5oOIa4d
 PNIU/AkyNzm0BqeN/CzV01ZEftqpyjAy/dh6Uv66BAWSDTfSJXgym11LxNdUL1V9f+OgppyzyoF
 0pL+DH7GqSpcSm7w/o2GdXDWmQnIm/Cm8IGbjoABM9XrfI4t2aBILI8IBDko=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:134c:b0:663:13ab:b80a with SMTP id
 006d021491bc7-66a23df1fc1mr2682134eaf.84.1770294863468; Thu, 05 Feb 2026
 04:34:23 -0800 (PST)
Date: Thu, 05 Feb 2026 04:34:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69848e4f.050a0220.3b3015.0020.GAE@google.com>
From: syzbot <syzbot+list47152ade7c935067cff8@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1vnyZ8-0004JX-1r
Subject: [f2fs-dev] [syzbot] Monthly f2fs report (Feb 2026)
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

During the period, 3 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 73 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1714    Yes   kernel BUG in f2fs_evict_inode (4)
                  https://syzkaller.appspot.com/bug?extid=5c81eb8c0a380fa578b5
<2> 1358    Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<3> 226     Yes   INFO: task hung in f2fs_issue_checkpoint (2)
                  https://syzkaller.appspot.com/bug?extid=8a7eea50810efde15b0a
<4> 2       Yes   INFO: task hung in f2fs_llseek
                  https://syzkaller.appspot.com/bug?extid=942fb6ce3ac2843a1420

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
