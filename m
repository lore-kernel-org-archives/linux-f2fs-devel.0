Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ED28CA5FBB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:53:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:In-Reply-To:Date:MIME-Version:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=xf2Tg9sXIF9dFJK4Nkjq/TK9xL5Rs6wtoea/OCVo5AU=; b=b4uVoGotAYqrXLPZESEe/GPPeg
	WrcOBsx+3wTF7kzsTljGWt5rYNVvCY4iom9YkLYFyUmTCm9lrvUY+wV6ENq6ocDgQGAGw8DAXFK9V
	1bT2fjcisqcV8t8SgAXzMjbek7uTwA/Ckb7Wyy6yq0fiilq/vE2iNJUefwO164IwqbR0=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xBukB-0000Uv-0U;
	Wed, 30 Sep 2026 13:53:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3PhS9agkbALcpvwhXiiboXmmfa.dlldibrpboZlkqbkq.Zlj@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1xBuk9-0000Up-HO for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 13:53:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=H0onscU5fvyN7BYkWTQW0c+6+hHIAQ3Uiw/oq/ubFgs=; b=iZT+7LuTPd7SYbWTWex8+zLNsO
 gUWvTAjyCPE/HOgdg060RDuNqyVekZn+IRdwVO1FUuI25zM8URMEcJnDG56+i5PZz+1KLKIvQrOR3
 VBNvAykuDS2z7EJP8VXk6XRvRKUTAthC6rAPpZXSEBGPzpt7EeWRbJBZYlw/mYeg22sc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=H0onscU5fvyN7BYkWTQW0c+6+hHIAQ3Uiw/oq/ubFgs=; b=N
 J6d/huO8IL7Mcl3hl8lLdpunlEAeHI1pqUfBsOrmBn59aS/0gC1TnNXZy4cOHn+8WFFDHadat4kBu
 y3gt8R3LvbPQTJsYwBsEkWIs/IDW+EXXybeDIjMu2ZmAqLmWkHOhhOEmal7m+i4IcN0nU+KO3bGYn
 mZwXIybBHNYTu1CE=;
Received: from mail-ot1-f71.google.com ([209.85.210.71])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1xBuk7-0005fI-PE for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 30 Sep 2026 13:53:09 +0000
Received: by mail-ot1-f71.google.com with SMTP id
 46e09a7af769-81b5ae9d488so5469942a34.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 30 Sep 2026 06:53:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790776382; x=1791381182;
 h=content-type:to:from:subject:message-id:in-reply-to:date
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=H0onscU5fvyN7BYkWTQW0c+6+hHIAQ3Uiw/oq/ubFgs=;
 b=jWCxFIg30k7IJzGPP2fy9FpxRxJpJgUJu68mrh6BMsn8yThXKXgfMaUkccxbH9Fo/h
 wDuNmO513i3tjlDHYieFxKbpYmj0deHV1O75VuzEELAbBrdNOdxbzpFM1d2TjqRs83Ai
 65aj7sjyIyiAlrQhyHJW2UlharPU2/VjOiQ0azvnWvVv7naNjiZLmG2spB5AnsVxOvaV
 uNJVvJ1ek1cxbmSU1lvhKI4WoM3ztrbbXyFosdiPBGaigU7psRUpdN9zn0rxXl3GBEgS
 4wsCMGsqfZ1tvLWuHQh+RhtnspJl77SSCmhUCblXZL2sQ7rkHf8C44AXFivCVLISuDnv
 z1gQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxRIyoWrmLlYnUbxQELeXJuEu/ZLT5pXaSzmYRvy0nOkYMLMoVaReoZy7g7LjVu9dDpUP0Qj+aFLSlzon7X743w@lists.sourceforge.net
X-Gm-Message-State: AFuF++mPe1VK/1nyckcZMfxOPnIMJ7/YJYyU1rFyGvNcV6KpBrmAMm9t
 bdBZkqralXqAAgjMUQEh6ozRhX36hfgcFxWYLBlBpI2NwtPTUcbII1zZptpA/FOlwvsJSJmnVa/
 0FZxwIkKK0rEIKSnSlpc250sX/Dxdj+Dsw3PDEH9Lgw6SQpfpBQGUvZ4/Oys=
MIME-Version: 1.0
X-Received: by 2002:a05:6808:eca:b0:4e6:fdeb:934e with SMTP id
 5614622812f47-4f1b0d0b5d0mr1304153b6e.6.1790776382127; Wed, 30 Sep 2026
 06:53:02 -0700 (PDT)
Date: Wed, 30 Sep 2026 06:53:02 -0700
In-Reply-To: <784ebcc3-2d37-4640-88fa-3385a646c2d5@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6abd143e.fac9d4e5.17396.0003.GAE@google.com>
From: syzbot <syzbot+dfcbc1741488709db4b2@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1xBuk7-0005fI-PE
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] UBSAN: shift-out-of-bounds in
 __f2fs_commit_super
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

Reported-by: syzbot+dfcbc1741488709db4b2@syzkaller.appspotmail.com
Tested-by: syzbot+dfcbc1741488709db4b2@syzkaller.appspotmail.com

Tested on:

commit:         7d114d27 f2fs: fix to set sbi->log_blocksize in advance
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/common
console output: https://syzkaller.appspot.com/x/log.txt?x=17652b15580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=40ee55a747aeff44
dashboard link: https://syzkaller.appspot.com/bug?extid=dfcbc1741488709db4b2
compiler:       Debian clang version 22.1.8 (++20260613092233+e80beda6e255-1~exp1~20260613092250.77), Debian LLD 22.1.8

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
