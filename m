Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F0CC5AC67
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 11 Aug 2026 12:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CWCninr5u+wChmvo0rXO7EEOt6XkubbMzIdUlFUkrww=; b=KtRo9rxUpOzlgs5syHSsjX51jX
	vjse/HR6fDaInXJacEADCve2XIHy3yfD/X/JoAMgCuP/3AwAIr/fOpn7ZGvZzlRC7LjAkEb0rb9Cn
	J5Or14c4DPXxl0p7waZ7AOzDYjpHEzRqXKqha/UTXSYnBb92Gbj05rMqly4sJM75Svrg=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wtler-0006ZK-4E;
	Tue, 11 Aug 2026 12:32:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3YhZ7agkbANUJPQB1CC5I1GG94.7FF7C5LJ5I3FEK5EK.3FD@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1wtleq-0006ZE-1z for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 12:32:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wT8vD1ZL+2JkQh6kjH7KUAfTe6K6+UONTVCfDtDIMno=; b=UfsKKvk2/L1+mkYvgIlsCUtCZg
 nJ702iyYmolHna97uJevrfKU3GofCzZGD28DdSYPocAvT2ZbCnIR5Pn9n1k8E8Huk2s1QsGUXbFmC
 XCIrNT2kTpGH51xsW8se1on/mohSHmzs9whlD+IiqYUcQbBF1JWIsKf5+Qe+cMo9APMc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=wT8vD1ZL+2JkQh6kjH7KUAfTe6K6+UONTVCfDtDIMno=; b=e
 ksa1u8Z5m0eRFsclqdRZc7XGBUa8Ne8JDVGC9k3pR4lcSYT4BE+W9/aA0zYgiKvoG2HN1ToMHaMi5
 mQNhSOQlMHVcJ0fkZe7lTeBoOGH+/VvFryCuOyFBLNX0h/V5PbPthysRujt3P84VRXiCWNpkrjwQl
 mxe/IiET4YVXH2Dc=;
Received: from mail-oo1-f71.google.com ([209.85.161.71])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wtlet-0007tp-PB for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 11 Aug 2026 12:32:40 +0000
Received: by mail-oo1-f71.google.com with SMTP id
 006d021491bc7-6ae34317b7eso1035196eaf.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 11 Aug 2026 05:32:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786451554; x=1787056354;
 h=content-type:to:from:subject:message-id:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wT8vD1ZL+2JkQh6kjH7KUAfTe6K6+UONTVCfDtDIMno=;
 b=KipRND/1QWjXCqAFr7WFfrBhAsmp8LU5r0p20wPKoynDUAx6vcgNhgUQKbEr35vXi/
 flCgGQbilKpYBDiI4eZ/pYA9fDyOUm2eEG5mUqa1SBnXerRbTEY7hNDAxHXZN4vjcNqP
 45gFtw98kC7v3uHzJowTugtKdHnJhvsX+0+sdtkdbabL6/1IKPwlvagUjl1mCf0hZi43
 7Dat0HQfpYfDDg/caDVIsaDJRf7+/2Dnn5ApHDzA0d7sKG955K+5jLQxOo+h+Z3gRNQA
 tDfYzhMNb999Xqz9O8eBxEQqhWYuju8uN29znEvUPTsb77ZISjlpx+XC9upZ+jpHNEAN
 eLgw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnhtCwW+ILr9wVYSD4rWcxW9Ze5ryYWUhEGdYtjUWrj8m3dz+zAIvwT4UA76yH4trvtOjFDQHsZGqwpnWFbkcK@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyFFXQhfHjZ1M6cAFEebrq4cBRY4F2l4TgkH+9LTteOXdyEh7yD
 qPbURMIKptjXbkH5ctgXWqV5o5i0bUMOmqI3efYiACMZEaBrk5hHGysLXxkh24m4QScacKI6V8F
 DtF1THpxIibdmmA5ABGHuZINwMDxmj/6DudDgc4UDglspE/+ULt6nfYmXLQY=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2219:b0:6aa:da04:b581 with SMTP id
 006d021491bc7-6b0a322a290mr1463561eaf.27.1786451554541; Tue, 11 Aug 2026
 05:32:34 -0700 (PDT)
Date: Tue, 11 Aug 2026 05:32:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a7b1662.01d0871a.3a0d52.00c9.GAE@google.com>
From: syzbot <syzbot+listecaa6c340cd05aa08419@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1wtlet-0007tp-PB
Subject: [f2fs-dev] [syzbot] Monthly f2fs report (Aug 2026)
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
In total, 9 issues are still open and 81 have already been fixed.
There is also 1 low-priority issue.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2378    Yes   kernel BUG in f2fs_evict_inode (4)
                  https://syzkaller.appspot.com/bug?extid=5c81eb8c0a380fa578b5
<2> 1367    Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<3> 65      Yes   kernel BUG in f2fs_write_end_io (2)
                  https://syzkaller.appspot.com/bug?extid=4af46ee83100e99bce09

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
