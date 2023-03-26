Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBA0DC74A5B
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 26 Mar 2023 16:58:32 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pgThN-0006bD-NU;
	Sun, 26 Mar 2023 16:58:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3r3kgZAkbAEw6CDyozzs5o33wr.u22uzs86s5q217s17.q20@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1pgThM-0006b7-LA for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 26 Mar 2023 16:58:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vq3vDhPKDyeaes7/yEj7BE2fi8mRxBSHslw2Y4HzVzo=; b=NcqJlietNrQU14Is82mWCUdRa6
 tRjXVp1MKEheaHw+Ro16I5M0twvwD1/VfEIpPhoYq367WiC0qvsPEA9YceExxVuKX3+kPwKZUlaum
 Qhlm3XZlIiuoRk9do8M55ZtZUz0euYVoxJneDeeY+qAO0o3WYoscLTWABLUboAY2WVKw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vq3vDhPKDyeaes7/yEj7BE2fi8mRxBSHslw2Y4HzVzo=; b=D
 v3J5KPlAfRH2a4D7xzaDqnTvhRtj7UFc3wGbMyrRP0ExIqEUQNM+3TAfu679uTrbgNeLtcYwCMbP/
 ZFduAls8tr2PgjIJEJXqEuqucxg/yBfh8qZ4IejbvImn9h7HJzmXKDCsgj+Vz8XfYKl/RVNQfNScA
 3FF6ku/YQ/Iz/uUE=;
Received: from mail-io1-f70.google.com ([209.85.166.70])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1pgThM-004UES-U7 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 26 Mar 2023 16:58:29 +0000
Received: by mail-io1-f70.google.com with SMTP id
 b26-20020a5d805a000000b0074cfe3a44aeso4184627ior.10
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 26 Mar 2023 09:58:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679849903;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vq3vDhPKDyeaes7/yEj7BE2fi8mRxBSHslw2Y4HzVzo=;
 b=IfZZCI0ukDiXWdinRitv4KeJ3nBaVkkV7s+idEGsiN+IGrUO9ZBf9NALmvIA45mAty
 9oYLpSu7FQR/YNGbRr3bdikMkf7LpJsEVl7EjoVBkn1mpoqMT2CN9I3JrF9vvTiT1rYx
 0eVS2S2E3Ai99bjOr8xBpZd+08a7ktATfbDSUcxbOrbuS0OBZ9rncgawuF4F1y78qowE
 O0pUptEupNCp7idOCB7B0SfJx9x59SlBlnYgG7kaTM6wdtqDN/kCRWEmjwO1/3Q2G/te
 uNmlXj2N5zqDMmQVnjvTcVyO+hG+RJnety4lgffBd2wMqVKYhYO/GxRuXq2sR+BUEEn1
 i7Kg==
X-Gm-Message-State: AAQBX9cH1MtjAjrNV+hkj/0muymffqjVUUXDyEMxlkqtfoNubZPF6nqA
 uirrJVDW1/RQM3cEzIfBCQ3QB+eItYmXcZF+6OUgM8pKsLdI
X-Google-Smtp-Source: AKy350ZxaK9M2hsWGjTlFcnGNf6JQhjgwxQU0n7BtyFmcs5MnBJvxa5UgxtQAcQDiPhBHQRlms4xXz3PeQsI3QP/1gxw83C0O+GA
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a4d:b0:315:3821:b56b with SMTP id
 u13-20020a056e021a4d00b003153821b56bmr5010047ilv.6.1679849903389; Sun, 26 Mar
 2023 09:58:23 -0700 (PDT)
Date: Sun, 26 Mar 2023 09:58:23 -0700
In-Reply-To: <0000000000000ac4cc05f6e7f12b@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c4832e05f7d088c6@google.com>
From: syzbot <syzbot+8b85865808c8908a0d8c@syzkaller.appspotmail.com>
To: chao@kernel.org, hdanton@sina.com, jaegeuk@kernel.org, jiayang5@huawei.com,
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
X-Headers-End: 1pgThM-004UES-U7
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] INFO: task hung in f2fs_balance_fs
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

commit 10d0786b39b3b91c4fbf8c2926e97ab456a4eea1
Author: Jia Yang <jiayang5@huawei.com>
Date:   Wed Jul 14 07:46:06 2021 +0000

    f2fs: Revert "f2fs: Fix indefinite loop in f2fs_gc() v1"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13426789c80000
start commit:   4bdec23f971b Merge tag 'hwmon-for-v6.3-rc4' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10c26789c80000
console output: https://syzkaller.appspot.com/x/log.txt?x=17426789c80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea09b0836073ee4
dashboard link: https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1320ef41c80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100b561ec80000

Reported-by: syzbot+8b85865808c8908a0d8c@syzkaller.appspotmail.com
Fixes: 10d0786b39b3 ("f2fs: Revert "f2fs: Fix indefinite loop in f2fs_gc() v1"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
