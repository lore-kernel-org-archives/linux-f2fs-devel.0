Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8200CCD8CB9
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 10 Jun 2026 04:32:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:Date:MIME-Version:Sender:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wM8iU7VxEwY7N5UFbe++1BkBdt0wmyEqxdBBQOh+E7Q=; b=RDvtBxolCHdji+/ON6tEwehcn9
	FMvThWxNEc62gc7PRIXRS74opUqdy+GQdDARIRrQDsOzOcYmDZI2QImOmgEt7Sea6HwpMEzcKtim6
	PAsoegecpcOjlf0Y1mQjzFKwkvOckhXV8NjVCY68ROnpPYJdw8xVIW0RX9aG9fy19hps=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wXAcF-0004xn-QJ;
	Wed, 10 Jun 2026 04:32:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <32ugoagkbAKcZfgRHSSLYHWWPK.NVVNSLbZLYJVUaLUa.JVT@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1wXAcD-0004xf-Q4 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 04:32:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:Date:
 MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Os+MNnyth82RHUIReApK/KO/1Ll3bJWAHgPacjAGuAs=; b=ZelxrZNUbRyHDSmV+z1wBAAbgM
 d/hpLp4KOmJ2Aq2s0ye1DduPt/2gpT34aCwMzu15WZaeQIqfCCu4cjF8Oa/ANJ6R19BappJ2U+7dG
 UukioZPd1Iaucxv3aipix/6WD1s0r30cDWgEJ2BLpsr3AZoEVafQBD4KCNN/AxUuuCU8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:Date:MIME-Version:Sender:Reply-To
 :Cc:Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=Os+MNnyth82RHUIReApK/KO/1Ll3bJWAHgPacjAGuAs=; b=f
 Jp/G0ndB2FPeyK1x07rUuZXtuRdtGFHcAE4Km4eTN0Zo5Qb608eX0sk4KNtsF9tilSe8YC7eXs/lR
 quFnzWrztDN+xUVJIOV2FlveFplibBiNIAfyeT70cG7oxJbKTO3dzSWSIHG0e+gXwqIjpGdGoBAVs
 03vw+LTX02N4Eo9E=;
Received: from mail-ot1-f70.google.com ([209.85.210.70])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wXAcB-0001q6-E3 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 10 Jun 2026 04:32:34 +0000
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7e6eeff3b75so3016585a34.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 09 Jun 2026 21:32:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781065946; x=1781670746;
 h=to:from:subject:message-id:date:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Os+MNnyth82RHUIReApK/KO/1Ll3bJWAHgPacjAGuAs=;
 b=lxDz4i5IzQ+UkYkrqJM24DV0oxDRxolz1qkB0+mviVM+ZJZzwNVXiXJd6p84/LFTq0
 YHlqsz7PQSJn4/q5k7gB4+5WfWIWLlpsTdpBki+ER2T+l3QF5utIWgBkx7nEqTx8eDED
 csPIpMmd10iPxe4ygGvoD1nD+hE0rLZe6or1sF1TOw969ZBmu+ezhBBpRGQjx5ZryuP8
 qutuX9eMXzcX6rQdygBhGY/bQ5i2oaD86f57680znOJI5GlNtSKW4nOmLnUix+NwhF6h
 +faUs2uKJZNEHYMnvxfskQpuVIL32KePnMaFV/KhJvTy/5PnwJAaUBlNX5ermSMRFN1v
 XOaQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8mP3oAcixbe8Mu0bVLeAsS6tlHbflaXYuTQBnaNygLP61EsUUfAnxmYyejavMeFje4K9IkRo4lMPZOCbGaTOqc@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxpcIY5aCsVoAnF734P3zUE02PgN8AlQTyBJ7+HsioCMRAkbHX7
 +cyT71KIsgzLYrhFQVhoVnI1d5g4cIgDIUUGFDBEpFt8b5kmyeoouqwv4C6oDoGQzUGJA+df/Tq
 fKm8N1380VVANuW0X1S/bpYxIJ9OXYFufpz/3UQcCILoVMaQVvdX7ttGpRsE=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:80c7:b0:69e:2e0a:58dd with SMTP id
 006d021491bc7-69e68c25334mr16770195eaf.38.1781065946176; Tue, 09 Jun 2026
 21:32:26 -0700 (PDT)
Date: Tue, 09 Jun 2026 21:32:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a28e8da.39669fcc.33b062.00ae.GAE@google.com>
From: syzbot <syzbot+list22eddce392573bf6372f@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1wXAcB-0001q6-E3
Subject: [f2fs-dev] [syzbot] Monthly f2fs report (Jun 2026)
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

During the period, 1 new issues were detected and 0 were fixed.
In total, 12 issues are still open and 80 have already been fixed.
There is also 1 low-priority issue.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 2147    Yes   kernel BUG in f2fs_evict_inode (4)
                  https://syzkaller.appspot.com/bug?extid=5c81eb8c0a380fa578b5
<2> 1364    Yes   INFO: task hung in f2fs_balance_fs
                  https://syzkaller.appspot.com/bug?extid=8b85865808c8908a0d8c
<3> 271     Yes   INFO: task hung in f2fs_issue_checkpoint (2)
                  https://syzkaller.appspot.com/bug?extid=8a7eea50810efde15b0a
<4> 34      Yes   kernel BUG in f2fs_write_end_io (2)
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
