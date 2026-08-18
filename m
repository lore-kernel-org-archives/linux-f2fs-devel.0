Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6FF25C5DF7D
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 18 Aug 2026 12:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:In-Reply-To:Date:MIME-Version:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=BUpMcGM3rgmVC3MdbHU1LSf0X1LflY2Y7Kr/DFrr2LA=; b=DIc3yzO8NbJxx54MnUAaZo5ekL
	A1+zWHQBEUvHvdQ/otk/5fxOROPmKKj9SeeKkS8/2WCiz2tVjDGYroJqsXkUA/ntlBUVBGRX+AG2Z
	CAyl3AvD5YLytGUXxBh0yhz2F/yWdNB0O+FBzu1SIYkd/nqG2nP4Z3cDp7l6bDpvCrDE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wwJ82-0008BE-QT;
	Tue, 18 Aug 2026 12:41:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <34VKEagkbAPImsteUffYlUjjcX.aiiafYomYlWihnYhn.Wig@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1wwJ81-0008B8-Fd for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 12:41:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kH7UH8h86JxaxcMoryMYEv63KEU4vUkp/X3fNrJi4+0=; b=hTaN7pgtkCf1VkwF2UQf+Vr9TE
 JdD5oObg+kYpm9MTGcdH54eH1JeW/UKrgEvZIaNffbi+kGzI1Lr9VPAgdCg3NOv4/48AitFfc82eV
 SOzG/pxEEK7FmyGKdRnxaX1vxrXMSzpJ1r1snV0prQvlzqU89vwABK92ePeN4Y7cGgDU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kH7UH8h86JxaxcMoryMYEv63KEU4vUkp/X3fNrJi4+0=; b=k
 DxKTCNpYQNcLpA3KkRlEcPX7XvryDNy9I3Xu/brHKr4Pw2vB3sMkQC0/g81NLYgLsFUCEq1vZypAo
 2qZg6v+MX994IBdn0GGGmPyCDyIkHqQfMuPCCDQ/hoqfbnMBKjWCAqW1bU2UMYZR2rAoYxiPEowV+
 mbj3JZ/4Ii0tqdJ8=;
Received: from mail-ot1-f70.google.com ([209.85.210.70])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wwJ7y-0004ou-9l for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 18 Aug 2026 12:41:14 +0000
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e9f6f0240eso5714245a34.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 18 Aug 2026 05:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787056865; x=1787661665;
 h=content-type:to:from:subject:message-id:in-reply-to:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=kH7UH8h86JxaxcMoryMYEv63KEU4vUkp/X3fNrJi4+0=;
 b=kc08NZOPubQnY8eoe+NjLJ3qNg6PFcIXPxqMdjnKMED5pqHBsCefWySwX18Kyqf1GX
 NpZQPRQQTD+T94t0DMkrpAA2zXlnR6PeG93Ia4Fu0Y/lbjW3EyWtCL8JI1a+01DvzugY
 OecKPNHSMOvZq7Jytz7cjUY2ZQ4vjDUXGCge9yaKcg5GcY6A86KtSERv/IPSvRqIo3aH
 zWS1qjPFVt0riES2musUlO+xFmrkvDN1Aax4u0Y2uB37MEk+hb/7MxAoX3UZr6nnPhF4
 r9MPhQSiGDAL3uJijGP1ebyDwZvgd7iEz0JWoVxAkVTA0gDrPOcPaY51vngObe5ipBPl
 pERw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rp2PtGN4/WF6NpkVDDiXr1VPdsOTbCUHGI+Wj8+3sTDxyiVAAwjSrmGaX7XsxymXh3WoBeN00ja4YOBeBEFVoov@lists.sourceforge.net
X-Gm-Message-State: AOJu0YzTR6ALGbSBB3Xhc0l7ZzuAP9vEYi6yXDRfrbe9CgQ6hFURaE4F
 0lYCF3lyPQgNMU2GuNp4fL2dr9aViWbwqqDPAEs3MBUd4BBbNIcoY5kbvRvKu0fulrLHj3AZJKE
 w0fchw4Jfjbm1tBtN+eYs1SPfQGOM9ZKAkxoFu4MWXLZTfY6tu7c2Drbs768=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2017:b0:6ae:4be6:64ee with SMTP id
 006d021491bc7-6b0d693e720mr27361609eaf.34.1787056865181; Tue, 18 Aug 2026
 05:41:05 -0700 (PDT)
Date: Tue, 18 Aug 2026 05:41:05 -0700
In-Reply-To: <40fef665-0a29-4c44-9ce0-e02e6dc8d07b@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a8452e1.dcb60774.13163.0003.GAE@google.com>
From: syzbot <syzbot+014a7b70788139e6196d@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1wwJ7y-0004ou-9l
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] WARNING: suspicious RCU usage in
 __f2fs_add_ino_entry
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

Reported-by: syzbot+014a7b70788139e6196d@syzkaller.appspotmail.com
Tested-by: syzbot+014a7b70788139e6196d@syzkaller.appspotmail.com

Tested on:

commit:         2a927e92 f2fs: use f2fs_{down,up}_(read,write}_trace()..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/common
console output: https://syzkaller.appspot.com/x/log.txt?x=10c61679580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d1b4d5e594ef260
dashboard link: https://syzkaller.appspot.com/bug?extid=014a7b70788139e6196d
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
