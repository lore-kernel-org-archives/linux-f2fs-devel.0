Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8EBCD3427
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 10 May 2026 04:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4ButP75AGfhSGbbnvNJaMwcjRrBN6soef0w7zwogNvg=; b=F68cz2jJDZxYOx21iFzbmDgS5j
	3LU/BcqS8cq8Q7DAOMo31hGoYxLnbo3TC+oY4uTSbvk/4+cHx72h2DNKWr4OlrQMVvlLvi+VkvtHu
	HCkUuiMihvGfvUsokiwGjQxG3MKNThin880qZx934owKOEmhgPKbmT4Yp7xSfPVooCXg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wLvqA-0000ru-4k;
	Sun, 10 May 2026 04:32:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3UQoAagkbALwu01mcnngtcrrkf.iqqingwugteqpvgpv.eqo@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1wLvq8-0000rd-FA for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 10 May 2026 04:32:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LaRtowDwSKPVDBEhJMYs9n9Cs3P7tMNwUux1cyPkaXc=; b=i5VepHhfWveDwvgEBKzFldQA/Z
 dFUqeqZsEE/q0s95yopc/BuFYR6YdqUVCyMrQLGsF7s1adGp+iXHA4GIWWQeWhL8rMmWoDBqKTQ8r
 EsQWM7DXn/Rjw5ANDcDo+Fqv/YY957nc5cZIp4uIXqRbtN1e3Kfcta80/s+0bY+ye8P4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=LaRtowDwSKPVDBEhJMYs9n9Cs3P7tMNwUux1cyPkaXc=; b=R
 dGcFOKj8Q9BUKOlhjFXAnFANmu71Skc4tRKQa/OxyMTcPexWyRl5WZcA1Kb99mOkvRO+F9sD4NUQI
 mrP6S9c9KQW8481e19938TSiUvJFdUewLx/8MPXYpz0a451YeU8dUDvCWCRtWaDAooxyjL0FGzSbA
 uMgeBJB4tATziOIs=;
Received: from mail-oo1-f72.google.com ([209.85.161.72])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wLvq8-0002AW-GI for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 10 May 2026 04:32:29 +0000
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-69b3a3c798dso499483eaf.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 09 May 2026 21:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778387538; x=1778992338;
 h=to:from:subject:message-id:date:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LaRtowDwSKPVDBEhJMYs9n9Cs3P7tMNwUux1cyPkaXc=;
 b=fpopYfFSurxStViCJyu1WA06K8NYh/ScdUAwzBUyOR8JUJP/alDOBNAAcojNhcfyqy
 fRczO3u05Bxzvj1kpMzO7i1DO+sdfVhZ6zkslkPI6vlWmWTMOC3rthJW8E7rh2IhJJyI
 Kwoed3kWcX5w/1DuT4z9WybbrDwxpZBOnLXS3Eroj1Rg/+FpX8zUmzPHtdyxQs6VZHWF
 qHe4mWqjTW8NLlHWdxuNdfz7gUUVSZMxe09xZrZBb8f3/s3j4pIWtZjXYY1GkAyZgu52
 Gjb7hFL75fJgKfD/eLsc5PpEEh930YdIYxEfz5dSMDJWpQpUM0cGCJtnynYyjLcKo1b/
 ijUg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8eTzi6hv68ablsqb6D0cDeHE0KtQg+KxZWn11U6LWH3vyOw6lzPUzljn/c+sqfmjkVC2b5qOP03/Flciot5RId@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxmydW/Sa2C4SxVIHKPwU0p+lH401I6WXLunBACEOB8KoJ9SpOV
 TtIWQoZGIcirXKHv4ZDC4d/DsxTBlHMp5nWgvchlwklKbhmBg1t1SqYuQK1tOeAm2H0L3bndcYN
 e0Awan6AUaun9uEjnvKPocLDoxFu9S/saMW0dcMvhWJb2hzunwfDrDRmlk/M=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:3008:b0:69b:3a3c:23d0 with SMTP id
 006d021491bc7-69b3a3c32cdmr1648976eaf.34.1778387537958; Sat, 09 May 2026
 21:32:17 -0700 (PDT)
Date: Sat, 09 May 2026 21:32:17 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a000a51.050a0220.1036b8.000c.GAE@google.com>
From: syzbot <syzbot+list002e6a12d7700b00b821@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1wLvq8-0002AW-GI
Subject: [f2fs-dev] [syzbot] Monthly f2fs report (May 2026)
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
In total, 12 issues are still open and 80 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1       No    kernel BUG in f2fs_do_truncate_blocks (2)
                  https://syzkaller.appspot.com/bug?extid=2488d8d751b27f7ce268
<2> 2094    Yes   kernel BUG in f2fs_evict_inode (4)
                  https://syzkaller.appspot.com/bug?extid=5c81eb8c0a380fa578b5
<3> 1363    Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<4> 258     Yes   INFO: task hung in f2fs_issue_checkpoint (2)
                  https://syzkaller.appspot.com/bug?extid=8a7eea50810efde15b0a

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
