Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A3ADC3DA4A
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 16 Aug 2024 19:58:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sf35o-0002TQ-4v;
	Fri, 16 Aug 2024 19:58:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3X6-_ZgkbAPgx34pfqqjwfuuni.lttlqjzxjwhtsyjsy.htr@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1sf35m-0002TA-K1 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Aug 2024 19:58:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=78+dl5LGKnr8YKWEYJeUtFp/Rrz0LOgHrhdp2PPMKtk=; b=VouOnox/+9N0zXuZMC2azztMpD
 wYiCaX0WD8X/skB8Vvkv/FDFYLfl40j8XldFz85VNX/Zvl5GtRT2hH8JLMh0hYNQfdldsARuLIrDP
 7JtD5Tlvp1xTtFdU4o8wy2wlCQ22IMNWP0b5DYq+LKxi1FIZnhNW3Qszbh9D6X6TfxWw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=78+dl5LGKnr8YKWEYJeUtFp/Rrz0LOgHrhdp2PPMKtk=; b=m
 LcaUqBv+Asi3WHvru0z2923GknhF02O3+9EnC1UPc1v1PMfhVGl82Boow0UUSp+e70KfmfXQOBwQ0
 YqRzor8cDl2Ah9F3aLqe1LKnFk9+vL5Mi89eQFXMjyJWc/59jY0CFJPO0YXhusDWtQUxcAwpwVjc5
 g8BkNaJpnD+aR/vs=;
Received: from mail-io1-f69.google.com ([209.85.166.69])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1sf35l-0001BC-VG for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 16 Aug 2024 19:58:34 +0000
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-81f81da0972so244918339f.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 16 Aug 2024 12:58:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723838303; x=1724443103;
 h=to:from:subject:message-id:date:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=78+dl5LGKnr8YKWEYJeUtFp/Rrz0LOgHrhdp2PPMKtk=;
 b=wKVE164itQnVecgnI2GTuxcU7xLJMzxwyVE66g2J1xOLXMAKK/fnZPoUAFXXOdUQSV
 ZU3XD7/MHxzKJY05D57E2G+uHmur/svkDEqneuZvGezHOqg7RySdnk6bn++WXOOeowUY
 QPw0EsE+wAHRtwHifxoFUw1gm/aQKq5H3a0EMFSkzwV/r9J57XfMXje8ypinWUTskqGQ
 4ZTAJ8x/ihUwE6BvmjpsIgvZz2EB9p4W8GseKivp+x9D70/UIauBi5IR/EcwkDUtzGT0
 uhVu9QOiEYYugrf9/vDi7iTGoGUCHnqKVeZlf8mJjuUTp8Fc+KWqP5IqMdgeOdYtfuMp
 sWUQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrkS+bNA2f1xZuwpyvm31IUUHxhykc8fn/qhLFUHNYfBqh9iuL/evmjtC+zx5Vwfu1LkmG9ywPWhSfHpKkB6Th1TYJm7YczBhGQL/Dcgs4zCu3j3ZN/g==
X-Gm-Message-State: AOJu0YyoiHA7Y4+mKXSZdEIlzs1PPrC2EgMh05s/XxGa06AqzAR5pM/Z
 8scWLxPvuJHkfr2QW86lqrRw0DDFgun380T6HfDxeN7X6NPwxNIL7tzR3qYNhJl83dxcsTT2cjg
 KvRFrbujYn3BNdzOp1w4fOEcRoY2ikaC7dxdqfe49UiOISvNUcukwAhg=
X-Google-Smtp-Source: AGHT+IEYuBTX7J/y0FAC61YM9mkan072gL+b5sT9Go3Rw8chVu/WRGx6V7S4j3onrXKfKLfK9LK3zv7EMr4JvatxldbIplXB+pxj
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35a7:b0:4c8:d4bb:a0e with SMTP id
 8926c6da1cb9f-4cce168963emr168595173.3.1723838303182; Fri, 16 Aug 2024
 12:58:23 -0700 (PDT)
Date: Fri, 16 Aug 2024 12:58:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000b62ec7061fd26144@google.com>
From: syzbot <syzbot+list2a48befeb90fd7d88a54@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1sf35l-0001BC-VG
Subject: [f2fs-dev] [syzbot] Monthly f2fs report (Aug 2024)
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

During the period, 4 new issues were detected and 0 were fixed.
In total, 9 issues are still open and 40 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 663     Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<2> 108     Yes   WARNING in rcu_sync_dtor
                  https://syzkaller.appspot.com/bug?extid=20d7e439f76bbbd863a7
<3> 4       Yes   KASAN: null-ptr-deref Write in f2fs_stop_gc_thread
                  https://syzkaller.appspot.com/bug?extid=1a8e2b31f2ac9bd3d148

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
