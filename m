Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22333CA9ED0
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 12 Oct 2026 12:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=C3OBp60SJ+ctt/nvoA1cqLCHNaLBOUNj6AALAIX1WNk=; b=iH8hbM7isHGC9U5NtBQkQnIoNE
	GZRSMSmLCidFhh6wCNi1uiciuU4iEjL39DMDXIiWB5swr9/oCf8TXNkORF8gfzom9NCz5mdDjgOWQ
	Mrf/ubUVsbAvpOkQyrRR6lrYXOqZx81Tg20as4inw7T9JPJnlRbgGEz3rneO/BfLq93M=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xGFDx-0006tt-OD;
	Mon, 12 Oct 2026 12:33:49 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3otPMagkbANkNTUF5GG9M5KKD8.BJJBG9PN9M7JIO9IO.7JH@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1xGFDw-0006tm-5j for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 12:33:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=M/AkdDECDi+uo+Cdtuf/U1SnbWxVE22e3DrnPYbcqHI=; b=K7M0dyxljOIVG0GFaeEJ8BAnrt
 1YrhOfZ191ZnHVSTyt8+azLdgXEKp2ysoXquB0hc+NRuYipH8/HmOCB8onew5lTgo6HRWSHNttqWR
 SyaByZKXuSB4F3qBcUflp+0C1db/mK9kQ2OZggqZsBvlJ8NEEtlcQeeDah43u98Iaxfg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=M/AkdDECDi+uo+Cdtuf/U1SnbWxVE22e3DrnPYbcqHI=; b=a
 sc51Etq0MjgMNZC+Nkj5Pc48u7MSWisMt54T/MblwvVLJmqmS69dctzdrHYB62IQYUH8AkoTYvmrT
 jkAtz1PwwunTnT4vdypkopLEbsvH7qwhi2dGtM2yrUJ7l84X31owc/LkLmEIJJ49WeEqG2Vmtdkk9
 myMOkV/jn22pOIWA=;
Received: from mail-oi1-f199.google.com ([209.85.167.199])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xGFDs-0003SJ-6E for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 12 Oct 2026 12:33:48 +0000
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4d2f0f77124so2559290b6e.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 12 Oct 2026 05:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791808418; x=1792413218;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=M/AkdDECDi+uo+Cdtuf/U1SnbWxVE22e3DrnPYbcqHI=;
 b=VsaTcNe+hsb9EUUUyvFSfRimqXSArvXiEmE8R5s4sEATmRVhT+ojQJgAsHlBunIbGg
 bKDyGmvd2jC4r5YU0PNIzrNFRJtBjhA4M0hKIHyovmFPSd+u1bD9AwSlJ/4tXL/krzvH
 XWHYaZYVfBvVJ43gsY7VemlTHimV/ZfCCQlG/VbKHYejN/gn9Yyvla3nSpk+hPt55Bjp
 czL5cfQSzXlz6ClBYQWOik3QYibXIFUpIOFL3+F4PjrXDP1E0u4PGLt4cXAJl4nP6Ru8
 UzHYf+gMZXAqBq7PFRf/ionkWgizeyeN6EMDoHFAMa5gcjP0pwbkC3meUrd/CEUujVhn
 tebw==
X-Forwarded-Encrypted: i=1;
 AKwUvBxV5uCMij/bSwSAanZkqFKqK/ELOHNCxwykUIpWVVR/gVRDJJBBJhP2+PmBF7t3Kxf1xlk7rgHeMCK2GqRD84lN@lists.sourceforge.net
X-Gm-Message-State: AFq9FYL3L1ZWvSfako8fl9j6BKO0kl86lo7ZqduETUNYfAONeF+N3WET
 Uh6+ksEiCtJafIoS11L7GLSBoOfpfLvzOlleDmsT3afw+Uvz1f821qQPzYh31S3CZQnmIW89Un8
 O6Wkxbgn3R2sAyPYthZ2vgTfcKQQCr1LvLWys3WqKWAzsk8BFBVzYrrbDgKY=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:199b:b0:4dd:18c7:5448 with SMTP id
 5614622812f47-50c56de25dbmr10500216b6e.56.1791808418618; Mon, 12 Oct 2026
 05:33:38 -0700 (PDT)
Date: Mon, 12 Oct 2026 05:33:38 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6accd3a2.0e5b5d80.2c029c.0574.GAE@google.com>
From: syzbot <syzbot+listcde74ed375b6fae34bba@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1xGFDs-0003SJ-6E
Subject: [f2fs-dev] [syzbot] Monthly f2fs report (Oct 2026)
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

During the period, 2 new issues were detected and 0 were fixed.
In total, 12 issues are still open and 82 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2538    Yes   kernel BUG in f2fs_evict_inode (4)
                  https://syzkaller.appspot.com/bug?extid=5c81eb8c0a380fa578b5
<2> 1367    Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<3> 302     Yes   INFO: task hung in f2fs_issue_checkpoint (2)
                  https://syzkaller.appspot.com/bug?extid=8a7eea50810efde15b0a
<4> 6       Yes   kernel BUG in clear_inode (5)
                  https://syzkaller.appspot.com/bug?extid=fc026e87558558f75c00
<5> 2       No    kernel BUG in f2fs_write_end_bio
                  https://syzkaller.appspot.com/bug?extid=eae639926b1c1ac725d5

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
