Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01AAEE7718B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 23 Dec 2024 07:52:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tPdEe-0001a3-Fn;
	Mon, 23 Dec 2024 07:52:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3oxZpZwkbALYouvgWhhanWlleZ.ckkchaqoanYkjpajp.Yki@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1tPdEd-0001Zx-7U for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Dec 2024 07:52:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=sleVAUhpasds4QGd4zUIxcsQR3NJ9sqRbFfDob06pCI=; b=KcEvdqFgmrPi5oCaqmfBxht56w
 h3QIegGnjPzl5AlknCn6oVldWmVHnFS9jrQMsqFl/JldCkpDycibNenrjlItuWuXBj7lwAFKPu+ap
 HIzHZ95TaydK5+hffvncm5R1jp/47NwNvDXFeCUEi0xWMFe62DRypGnKlSVbQpuydM7o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=sleVAUhpasds4QGd4zUIxcsQR3NJ9sqRbFfDob06pCI=; b=L
 Fg6Wru9JyV9Nn32NozHrsd9gA6ld7ff3ak4vWSYnnpajAO4zaoxE5nV8omLYTUnyGmHs9Kxb6Opg5
 19Xct0iphs5FegPSqT3eNd643+qIXHmVzrX7HE9O7XaqIV/Pd8tjbzytc/edbNWQE6Bef79BDtc+R
 zAiU+uh0CUFRM0y8=;
Received: from mail-il1-f198.google.com ([209.85.166.198])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1tPdEc-0005XI-0s for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 23 Dec 2024 07:52:14 +0000
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3a9cc5c246bso36097735ab.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 22 Dec 2024 23:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734940323; x=1735545123;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sleVAUhpasds4QGd4zUIxcsQR3NJ9sqRbFfDob06pCI=;
 b=V5mbqAYk5KFQQ7AHM8Da2pZI8wgFVWracar2J1kkWwluelWC+7hIjTDuUB3TOgFyM+
 lYryexPmT5c2xZskH6x6+i8BucgtuuMsmWXsS6tvB7DWLyA33OJNB9fIYBKyIxX1zI6T
 UK+C3CjyTOMobiK2hg8RBwt6NsPSGhFCxhziXWLt5MujYYflr0medwkTbu4lQpA6F4Zw
 zh6OLkZ+ZF3Iu4fsp/Nii7bAALZ5jjmiN0sijwkaK09GI06yyIdHtRtLhu+17xsmOv+j
 Rx4aG4jWH+etfKPcijfvE/zPxF/ALfl0g+jxcCRO9FEtW6fYbI2vFqKJXvN4QM7ZDJCP
 KLhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUR/jgAZml5MgmoVEBM0yXclp7vGFJHmKilDsjOCEUHHcSZb1iZKwA1abD9PIBB5d50JaG1lh4+Uy9P4D5tY5+N@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw0fUkGLUdim4UuzCrK1QSpqahy+VVnHEQD53qSG1QcZi5qpEBy
 VNOms3x7CHClCwZAxK8R9CJiunTKiqRW3/WU6mBzq18+6VMgXYoP5PeJ/h7VJyeib4bl1MXoNmi
 y5Wh5KsNBbEp+Lubal1DGHy8eXJ6o4flubmtO2IONofhv0NZ67q58LeQ=
X-Google-Smtp-Source: AGHT+IHX4qgZ9VCAKzyv+Tjqo9ZE5cNdeBTF8QcsIGd2NcpDWrkGf46uW81hhKH4Idd0m7ztppJb3grOatzen3JcPYNVj1s45tmq
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3a10:b0:3a7:e0c0:5f0d with SMTP id
 e9e14a558f8ab-3c2d1b9b8c6mr124941705ab.3.1734940323336; Sun, 22 Dec 2024
 23:52:03 -0800 (PST)
Date: Sun, 22 Dec 2024 23:52:03 -0800
In-Reply-To: <674f4e7d.050a0220.17bd51.004f.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <676916a3.050a0220.2f3838.0017.GAE@google.com>
From: syzbot <syzbot+69f5379a1717a0b982a1@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1tPdEc-0005XI-0s
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] UBSAN: array-index-out-of-bounds in
 read_inline_xattr
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

commit 388a2a0640e16a8887f0d47dab207f344fbdb913
Author: Chao Yu <chao@kernel.org>
Date:   Thu Jun 6 09:55:51 2024 +0000

    f2fs: remove redundant sanity check in sanity_check_inode()

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14bffcf8580000
start commit:   bcde95ce32b6 Merge tag 'devicetree-fixes-for-6.13-1' of gi..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16bffcf8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=12bffcf8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1234f097ee657d8b
dashboard link: https://syzkaller.appspot.com/bug?extid=69f5379a1717a0b982a1
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=112b98c4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16fd7cf8580000

Reported-by: syzbot+69f5379a1717a0b982a1@syzkaller.appspotmail.com
Fixes: 388a2a0640e1 ("f2fs: remove redundant sanity check in sanity_check_inode()")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
