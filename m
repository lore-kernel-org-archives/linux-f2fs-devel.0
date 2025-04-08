Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C159EC369A1
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  8 Apr 2025 10:21:31 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1u265D-0006zT-TX;
	Tue, 08 Apr 2025 10:21:31 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3jvj0ZwkbAJkLRSD3EE7K3IIB6.9HH9E7NL7K5HGM7GM.5HF@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1u265C-0006zN-Mv for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Apr 2025 10:21:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q65NMRwklu4Gg3M1RkU6U6i/X1ktlPqElkxLT6HbIrY=; b=K8Yjugo1dRzqH7jvn50urA6W9Q
 aB8JuSuWLie7P55AgItceK2lfsxyOmFh1aYm9htv4PmlqVVcvQYJhubEvKMaVOC3xCzODRPaM+tp7
 isvle+2s5ejwOHZ2fRzzK8UcFoYmYkWKWx6FN5Y197LlEVzPjJuJgmXCjG3wVCoXIQTM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=q65NMRwklu4Gg3M1RkU6U6i/X1ktlPqElkxLT6HbIrY=; b=c
 dc7Hi/rmLZzXKGRH01LSL39Hc99wTHmyhI04bTjZEblkbCrumC1+LtSSd9ZWx4xBVRL7jEkT4Logd
 ECzPXGAibh5p/H17y1eS7B+Bol7GRHIpEvGjpTot0SgIkaduSnHOBoPn8P35S0Z/8rIBsEusqsMGx
 +jvTreCITxYc4gcc=;
Received: from mail-io1-f70.google.com ([209.85.166.70])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1u264v-0006fx-B2 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 08 Apr 2025 10:21:30 +0000
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-85b3a6c37e2so620574739f.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 08 Apr 2025 03:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744107662; x=1744712462;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q65NMRwklu4Gg3M1RkU6U6i/X1ktlPqElkxLT6HbIrY=;
 b=QCUXsKIAZ5tWuWA/htHrUXxt2/7/omjDwx+Xw77RyYsClGt1DGius96owDFeP8jkXe
 QQeKnAg1rQQDpp6M1TzjZQHy15ykUKYlh4JO4HF+UzMFtiOEibE1ocDuqyKy8MJx7db6
 lM+wi+/mS38EyqtzzX+Dz+J9wghkurzVg10VbVhDsVvFN6yx0mlZ7z6xfq/Cvb0rDBI6
 +U6JsO/bmJM8knuFje3zQdqQ1icjRxj4IAju2QaPAw9wHt3Jp3ZV3Ro4Tp1RPfIFl7nv
 tilTzeRXjwXhgj/Ig+1AoWh0IBejODu064ZdCnTbhwqdzAPns3INe6Es9SgmsVyvtp7q
 MFTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWLwrcUsSE319hGI3aRUKICDOZ/FzexuwQg37hG+3zx4vhEDJeAgEg3ntHTXlDcCvIXbo9p236BBPGrHYznk16G@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxIbKfV7PJfW0NU836oJJ4n7EVj6OTDQBPu/gZpD4fq0AcZaKtA
 Zo0q0DpSv5yStUD2gGkbEMvDMF+I98ci3vqmY0bx7oeNFDQES9f5M0ItuUNY8uT0S4MMQC03QeC
 UBMdRNsw31+e3MOsDzqCTScqY7j/uqRbXo2FkL9DHIsl2cET1gbMUJS8=
X-Google-Smtp-Source: AGHT+IHxZcubI+jQ+FURFG9su4Qr2QFqm4SZ2ZNjrGO5WQ1exgC+lcHYdJCgjb6Dxx3lMax8x1QVTcVouQ8CKIGuRdWBkrdugLjH
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:160d:b0:3d3:dd32:73d5 with SMTP id
 e9e14a558f8ab-3d6e52f63c8mr165088285ab.4.1744107662646; Tue, 08 Apr 2025
 03:21:02 -0700 (PDT)
Date: Tue, 08 Apr 2025 03:21:02 -0700
In-Reply-To: <9cef1559-43a6-4968-9b86-1077a833c7a3@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f4f88e.050a0220.396535.055e.GAE@google.com>
From: syzbot <syzbot+8b376a77b2f364097fbe@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1u264v-0006fx-B2
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] kernel BUG in dec_valid_block_count
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

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
unregister_netdevice: waiting for DEV to become free

unregister_netdevice: waiting for batadv0 to become free. Usage count = 3


Tested on:

commit:         ba0c5f18 f2fs: fix to do sanity check on sbi->total_va..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/syzbot
console output: https://syzkaller.appspot.com/x/log.txt?x=17616d78580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66996a2350ef05e0
dashboard link: https://syzkaller.appspot.com/bug?extid=8b376a77b2f364097fbe
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
