Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD75EC3600B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 31 Mar 2025 13:08:40 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tzEsZ-0005GF-HM;
	Mon, 31 Mar 2025 13:08:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3xZPqZwkbANwQWXI8JJCP8NNGB.EMMEJCSQCPAMLRCLR.AMK@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1tzEsT-0005G5-Mf for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 13:08:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HQm97m3F2hf17H9sSC0zFvTaV5xTq5eG+zcc0Ysc7gY=; b=R1NJDyXhC36Idf2n7YKZTWwFT9
 7Fzuf06R1gt4KKbD1R0oqVqYAEXGv1YbhunPkBuY2yzl8ebWnzO2UeWdxX8FXdjggidzQbk5ITKEc
 +aqOEoN5Dotsbbw4L92aVRqsbCeXQ+jDwY0rPJS9L4DSuQULGzJfRUn9xqE9jYOWUMG4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=HQm97m3F2hf17H9sSC0zFvTaV5xTq5eG+zcc0Ysc7gY=; b=N
 Ob2rhxnFJUClP8zcSYMIpwk91GW+TH5Ca7GDeSOkl8NM3weuazTvRBA9ACvSDC8Sy6uOmhMu3eBwI
 4ZoOk/DcDV+1WMkqK5rCaKH0UKjanhDvCNP3ORNcRFtBOihSbPt7EnbJNO36Ek6dGtSrgVcgRJPLR
 hRrQriTqbIa8dZik=;
Received: from mail-io1-f69.google.com ([209.85.166.69])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1tzEsR-0003M5-T9 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 31 Mar 2025 13:08:32 +0000
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-849d26dd331so516585039f.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 31 Mar 2025 06:08:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743426501; x=1744031301;
 h=to:from:subject:message-id:date:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HQm97m3F2hf17H9sSC0zFvTaV5xTq5eG+zcc0Ysc7gY=;
 b=oMYu//80WdJlj0gGGaRlmvYz3TnQRXEruCwvJtVFWpZJmmWZMAwTZlqrKiXQ4xNTHh
 DL1r3pOoLku4X1ZkbMP1FNTpmDnjCOhigmMpxQdsoBEkUlhbLEAXntneo34qFK5BRWCA
 cHF2mn9bJOp9xBpuFS+r6kO1U44WTtcdpDzuo9pVmiyP0TOXyRgKuVpaGYNIc1tUOeTH
 CH439W/aAocz8DsNPqD8+s5Jpu8XVEQvpdbiG2y4prJbVINKPEJs2OMsOio/3/Z/RIBB
 QaBH04xgmsGTd8o9u3yPBFRH6Qa15qaBdfCCbL1QbENbsTTOGyOd7GR1T1/jg8C6x+Hx
 ds9A==
X-Forwarded-Encrypted: i=1;
 AJvYcCXT4O1Hb9gnje7usgHr2rgnS/vjupbv2HpMtiWD5lFd+jnMfiS5Aq0WHFqspOSGVv10bLvyo5DOgpYRt1/uc6dV@lists.sourceforge.net
X-Gm-Message-State: AOJu0YwCkz52K1dQqAszv6ocmZAUloggq51j/up7cP03iPV51ZAH7/hH
 P0sN8G5nmDsUPAtivBR0iJ1+YVCaFpAtQ1cuuFIFjMjP1sp/wJUv2AteryphYj4x6kYN6S4mzRS
 3EW3mJk3GMXh27yFMzsxzmlO7c3bOc526MwITEWSbsulqg4jg5OiVM4c=
X-Google-Smtp-Source: AGHT+IHIaGFv45CH9yP1SffeoWvG2028p1ktltDelf5T5UC2qndIIoinYo63hKIwG71cL4xQRElrEOk1KdPJWahGv071nX2vW6XE
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1988:b0:3d2:ed3c:67a8 with SMTP id
 e9e14a558f8ab-3d5d6c8346amr107275575ab.4.1743426501208; Mon, 31 Mar 2025
 06:08:21 -0700 (PDT)
Date: Mon, 31 Mar 2025 06:08:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ea93c5.050a0220.1547ec.0142.GAE@google.com>
From: syzbot <syzbot+listcca4438a6792bfb39532@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1tzEsR-0003M5-T9
Subject: [f2fs-dev] [syzbot] Monthly f2fs report (Mar 2025)
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

During the period, 1 new issues were detected and 1 were fixed.
In total, 9 issues are still open and 57 have already been fixed.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1246    Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<2> 59      Yes   kernel BUG in f2fs_evict_inode (4)
                  https://syzkaller.appspot.com/bug?extid=5c81eb8c0a380fa578b5
<3> 11      No    WARNING: locking bug in f2fs_getxattr (2)
                  https://syzkaller.appspot.com/bug?extid=44090b62afaabafe828a

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
