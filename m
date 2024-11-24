Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93901E6688F
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 24 Nov 2024 01:40:19 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tF1bj-0003Qp-1m;
	Sun, 24 Nov 2024 01:40:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <38oNCZwkbAEUz56rhsslyhwwpk.nvvnsl1zlyjvu0lu0.jvt@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1tF1bh-0003Qb-Bl for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 24 Nov 2024 01:40:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=YjnvTwZRN+j8oGsq1lXAqtFO6kntKG2HSXqADQ2xD/8=; b=IInDvJa497VhZKbbex8Jr9CUUq
 cRcRmrCVmBcDFWp/eyl3KeRumb7dTObJJzZI3v2vAmtp9vpcTyhYr5o/GvBZsDujO2/K4ddFrbbK/
 AAO2VRxksswsoUNU6aIcsNNwO/IiVbBTt3G1+f1nHLpX/DcWOnihudUVhqPcl9b0d4Bk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=YjnvTwZRN+j8oGsq1lXAqtFO6kntKG2HSXqADQ2xD/8=; b=B
 AO7xjMW+xFa5oqHdKQzJxcwEZtZivuhtZnbX1rkX3dN/qkzUpBmjtj7ossJ7bCx8iH5uiBAfbOzxf
 SxdBm7CrEDg3yoHgMThaHCSbbwt5waoRD7Lsb+2mk8hU5IMAv5gzy03gCqBTmtKJznClbWpSvBZ/U
 7lj1OxBDR7Q3Bfn8=;
Received: from mail-io1-f71.google.com ([209.85.166.71])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1tF1bg-0007l5-OV for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 24 Nov 2024 01:40:13 +0000
Received: by mail-io1-f71.google.com with SMTP id
 ca18e2360f4ac-83ab434c629so343745239f.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 23 Nov 2024 17:40:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732412402; x=1733017202;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YjnvTwZRN+j8oGsq1lXAqtFO6kntKG2HSXqADQ2xD/8=;
 b=pI/O94/OaBAg7ZNjIXXy2fyB2aueX+LO0NrjnsNxewr8l0EhqRuOJLzpM4YADCDAT+
 lr5iMW/E0Tez6WvoicTRO7mUKc56cowUdgEQkUgD47YrBngToJhUY47xlW42/YQfkYSM
 JK9gKumOw82oXvD3yjXYooNjKfeLxf7sZz3+Lfxaz20yt2kzg4sHPK0U5WdfHWmSZrSE
 znB8y1w6WL1rVpJJk4y6dPwRPUSEhPYWe4ymjMucoO31Sf9CREEmTfnwZmoSW9SgB+GZ
 dICiGPnjAtKgjb41SM/VS/p7eUhfxbeAcONPGFaParqI76jtHv8Qg2cX7d0j8CK6W45h
 3FRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgEIIYprouO41a8MEuK6jjBWQCbzaNOA/jj7a4Qaa5ER0HxDnh8hkUMLWOOHLLmFMq0WEC3aGqn1NcJ4M3SEMS@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxYJ1Taw6SFOeqdF2Dkpvmb4RPEdNMqYzM6rAECvs7MC39D7uyZ
 BP+eh5c9Suhir6hOeABMGp3kxB7njAOGhOBjklkfhDwGEWXW4/joU99D0jkssZf6v0YcrBgd36C
 HUAcDvqHgG/whYQi3uvtGaOpaKfDWSWV6DJf7mH6NoedZAoEFo6oL324=
X-Google-Smtp-Source: AGHT+IGL5Lf+YBzZT0OpDq0ri6FMKUZTlGhh97G1oG7s/0nxvC8Unlrv+e1eJcQ4MUABqDopfugHmC0fm9gnQOHXJ9u/6om1qQSE
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a41:b0:3a7:820c:180a with SMTP id
 e9e14a558f8ab-3a79af16bbemr83792775ab.19.1732412402028; Sat, 23 Nov 2024
 17:40:02 -0800 (PST)
Date: Sat, 23 Nov 2024 17:40:02 -0800
In-Reply-To: <20241124010459.23283-1-leocstone@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <674283f2.050a0220.1cc393.0028.GAE@google.com>
From: syzbot <syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com>
To: anupnewsmail@gmail.com, chao@kernel.org, jaegeuk@kernel.org, 
 leocstone@gmail.com, linux-f2fs-devel@lists.sourceforge.net, 
 linux-kernel-mentees@lists.linuxfoundation.org, linux-kernel@vger.kernel.org, 
 shuah@kernel.org, syzkaller-bugs@googlegroups.com
X-Headers-End: 1tF1bg-0007l5-OV
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] WARNING in f2fs_unlink
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

Hello,

syzbot has tested the proposed patch and the reproducer did not trigger any issue:

Reported-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com
Tested-by: syzbot+b01a36acd7007e273a83@syzkaller.appspotmail.com

Tested on:

commit:         9f16d5e6 Merge tag 'for-linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14d40778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e92fc420ca55fe33
dashboard link: https://syzkaller.appspot.com/bug?extid=b01a36acd7007e273a83
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
patch:          https://syzkaller.appspot.com/x/patch.diff?x=15dd69c0580000

Note: testing is done by a robot and is best-effort only.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
