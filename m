Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65948C624DB
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  5 Sep 2026 14:26:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:In-Reply-To:Date:MIME-Version:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=Hm7i7NiAchRbsMRgklMu91WGPFH/0cT1I4OW49U5zI4=; b=X/iDWT93HzgYmaB2pZGydM0a63
	5Buu95EUs9PJmyD2NO9eEN1W1o5vdvMAfYe8VYp/yAyWcY6VIQlonXpkfChaPiWBzuzaTJVTle4oP
	qmQPMEizKqSfvJMm3p4ykhuKv5meV37JoY0PW9p1eH459CWGuFWkIAVJOpFtTQe/l+A4=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2rLi-0000Jt-Re;
	Sat, 05 Sep 2026 14:26:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3jyacagkbAKgaghSITTMZIXXQL.OWWOTMcaMZKWVbMVb.KWU@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1x2rLh-0000J1-NK for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 14:26:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:From:Subject:Message-ID:
 In-Reply-To:Date:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:References:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1ETkXqycGRjohhEM+siMcRzRNo0ykM9QCfZj8kTd0Fk=; b=PYL7RAhtV7nPxlERcXSNXegF0e
 5GWxyNCCvPNlB34xYJijIOQyEfUjCgvX4i3ItJYn25OfJZMhMjg/FlkX5PXajHYmWra4caLEc8qar
 q9IWtHo5tz+Vebqyw2zgHm7BKHarupjSCPLyGq1jt2PyW5bNaXBqYz0kYENdx7r83iew=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=1ETkXqycGRjohhEM+siMcRzRNo0ykM9QCfZj8kTd0Fk=; b=X
 EY5b2l5J4WBtaDwI8TdS2KL4CuiiF+jMemKLU7GQWVxbC367c9g/jwlaMNVenq+XPZ6tcsb27BCeo
 95cRipM1WNlT5vg+xxiD9eXqJ5sFxFExK2fCF9HBI/TMBfyHiS3iVbIPFP3CNqUnBJFVc2Cqbcjqn
 b7wFDlIhdJRcw5xY=;
Received: from mail-ot1-f70.google.com ([209.85.210.70])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x2rLh-0007rd-4k for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 05 Sep 2026 14:26:29 +0000
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7f8931a803cso1842294a34.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 05 Sep 2026 07:26:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788618383; x=1789223183;
 h=content-type:cc:to:from:subject:message-id:in-reply-to:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=1ETkXqycGRjohhEM+siMcRzRNo0ykM9QCfZj8kTd0Fk=;
 b=iP+sICQZsNXf/2aDLOt7YTRF0ctvxe4bzg5zRGUASANDFxwoOia78FRbuK44zmQKEv
 YoeO2P71YXmsRcS/bj/0WZPNuBcgB3LKRjEy0SAVDplmz3Iauc8n/NVa/gL+Q+8Znu7Z
 HyrJsn/UYFH5ZqZEK25HfsUNya7iaveWM4f/4f6obBH/YnRW8SyyVBxrllhk8WmFusrk
 zYYIxObhPfW2V3AJn2VFaYoZNzk1s5zE+xOJvPMVR+sB6NSXvdRVsovfi3XZ7K5x5OTH
 346vUoAomqYJkjsulb7bQht87dfM6XNvBYo1fDU+ojwLTc3nuK2Y9McP1pC82hwniYm0
 K8Yg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzQUtJ42ACv9WAkZLnyAWpvBYS4rP2xmZRIVo0NYVlHwt4i8eABO42x1prfm8sS5XKtY+VjX6Y7JyMIh6kaXls7@lists.sourceforge.net
X-Gm-Message-State: AFuF++n16VTPaJoSyC6U///suvjvF6EKfoaMS0S+NdPIlDGySLghxu+b
 qrr8/6UHTbi5OEbhVfzXRGWhaNhd9GnYo/4Fe0DBa12XxPjRh98XfcPh7q0fFRurngcBiEVTAMT
 CoR3MhbflipWcrzReijiPD91kOzAmPDKDJW/VM1rorvLeKmFDVeNZkj3df8A=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:617:b0:6b3:506e:b484 with SMTP id
 006d021491bc7-6b6fc9d0782mr8242414eaf.16.1788618383574; Sat, 05 Sep 2026
 07:26:23 -0700 (PDT)
Date: Sat, 05 Sep 2026 07:26:23 -0700
In-Reply-To: <5fdd4d960a6b47ab7cfa6ef0f44fb575fc45d1ca.1788611415.git.qiwenjie@xiaomi.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a9c268f.a6639fcc.23b8b0.0003.GAE@google.com>
From: syzbot ci <syzbot+ci2f6618cc34ef3809@syzkaller.appspotmail.com>
To: qwjhust@gmail.com, axboe@kernel.dk, baohua@kernel.org, chao@kernel.org, 
 hch@lst.de, jack@suse.cz, jaegeuk@kernel.org, linux-block@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, qiwenjie@xiaomi.com, 
 syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com, tz2294@columbia.edu
X-Headers-End: 1x2rLh-0007rd-4k
Subject: [f2fs-dev] [syzbot ci] Re: f2fs: enable buffered RWF_DONTCACHE
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
Cc: syzbot@lists.linux.dev, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

syzbot ci has tested the suggested fix patch on top of the following series:

[v4] f2fs: enable buffered RWF_DONTCACHE
https://lore.kernel.org/all/cover.1788438786.git.qiwenjie@xiaomi.com

Patch: https://ci.syzbot.org/jobs/279baf88-89a3-4cb8-93c2-4bd86aa5092e/patch
Testing results:
* [build 0] Build Patched: passed
* [build 0] Boot test: Patched: passed
* [build 0] Previous reproducers: passed
  - general protection fault in f2fs_write_begin (patched) - passed

Full report is available here:
https://ci.syzbot.org/session/7e05d54c-8b9e-4e22-a746-48153ea42a60

---
This report is generated by a bot. It may contain errors.
syzbot ci engineers can be reached at syzkaller@googlegroups.com.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
