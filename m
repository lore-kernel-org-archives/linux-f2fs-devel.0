Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB6CC5AD49
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 26 May 2025 17:42:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:In-Reply-To:Date:MIME-Version:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=XswVOVM4GhofSnU3JXOIacarq3nMvWoxVTy+Sc+tBlQ=; b=dmQxaJujl1HVjJh0c+HkXDZ++W
	CEtS4+Oty18KjzilzRyVuev9AQR4nxnJT6vOml2MP1QTqhdOs09rH/g/vj7w3UthaaCSHTKQK0+aE
	JGTtboeETZ5YiIMq++r0vQD55PqZusdxMfjb0309gCh3cKezHHmSxuCQG8epdMp1Sk6E=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uJbpx-00063Z-TV;
	Mon, 26 May 2025 17:42:09 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <36ac0aAkbAFQEKL6w770DwBB4z.2AA270GE0DyA9F09F.yA8@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1uJbpx-00063T-7I for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 May 2025 17:42:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vDa4r2UIITW3CKirp15kcp5LjQTEjKXa4eV4qUzX3VU=; b=JF4VE5b4yrtjK+oc05sQ1Md2pw
 keayLlRn03R6xeB2Nh8/LxzoSfFBdjT9cLiHnKFWJ0FabhEWFtc43dU9UR6Y0AGHfLc1dzYC1i9IE
 0EIvFTyNtorlq0/ZgJnzfFbFqLL6zi3NM5sLR47YHeLPz937GX1Ns1tg1ozq9pQN2LW4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=vDa4r2UIITW3CKirp15kcp5LjQTEjKXa4eV4qUzX3VU=; b=Z
 XhGrg1GdAJrjJLPwwE8cuZSeLBunB6xHV4QDLcmUfGm8HtSY1P7WcHM6B3mS0avUIw2aFYeu7JhFF
 CP0cKnls5wemL2+ViJUDDAoMbPB/32yNz/JxkQb10CpzVbO6F/LiFhThe20kZ60jqDFyocMonpV5F
 4Vm04GoSl5Cptzls=;
Received: from mail-io1-f70.google.com ([209.85.166.70])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1uJbpv-0006ei-CW for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 26 May 2025 17:42:09 +0000
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-85b5e46a526so211906039f.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 26 May 2025 10:42:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748281321; x=1748886121;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vDa4r2UIITW3CKirp15kcp5LjQTEjKXa4eV4qUzX3VU=;
 b=mQvm/HGB2fU5jfJ4d3FbycduxLLyRd21tPIYY4fZYDEPLvXtc3j3ln13qU0zbR/ab6
 FAWKJss0F3s7qMg5zmXoCyYXnep10zla8svrUSVwsDAthb3SuWecv5Jgok+QAN6w0W3n
 Xx30Z+IPlZUUtNPKH9fPTFW1OhHajwwF1dmfFrgfaoDlfGqwZUz0XHioo7DZMofk9ZIg
 psjkf+nPu9u1sGdV7F6VgsJ6mKTtG2vDeN3GscmSFvxHmjl1k89oplxzKXVv0THfPYyQ
 Yv/hiNOoXt8CAUVvXv5pY8oNtQf9/fKaZKOg1O+ojFgS5D/RWx8bjoPNfjBXiqf7d3Va
 IM8w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBVP9lN7RQx3wjU52qqgs+nOk3OP4cdLdFiuJ1GTmOa8/pYwsj/Hm7y69wOqF7XY0Kis+8/t2DetqqQY/OP9hf@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yw/H9I1V4e+iWc5YvUK+qEnhoclEfWQszl2LRKmU6qGJOeXXnhT
 YEj7veLh1VpK46LU+KHBlTbRPhz22Y2zcatiDLlRwA1p0exj8MXhGdd2vq5x0iy0pYMR0LvxlAG
 CCpnWVIa0pvhtoJCUTk2NwaMsabZ7Ihob7Bi/0cxej14A01figtmjwhC49jw=
X-Google-Smtp-Source: AGHT+IEAyj1VK2Fwn3QLgOkgAammua0W4udoOnfejJRdVwp9sM1ozDO5RLocjw8jnKcSS5UeYZXHqCiLgbPj9WmCGOp1UxSqwwRT
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3810:b0:86a:84f:7a45 with SMTP id
 ca18e2360f4ac-86cbb82c8b7mr1182397239f.8.1748281321730; Mon, 26 May 2025
 10:42:01 -0700 (PDT)
Date: Mon, 26 May 2025 10:42:01 -0700
In-Reply-To: <68345c8d.a70a0220.253bc2.0097.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6834a7e9.a70a0220.29d4a0.0807.GAE@google.com>
From: syzbot <syzbot+1fa48dc6faf1ff972d7d@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com, yohan.joung@sk.com
X-Headers-End: 1uJbpv-0006ei-CW
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] KASAN: slab-out-of-bounds Read in
 build_sit_entries
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

commit 313d10d79a82358bd8c3ee7ecda6356b1f7cde55
Author: yohan.joung <yohan.joung@sk.com>
Date:   Mon May 12 07:36:10 2025 +0000

    f2fs: add ckpt_valid_blocks to the section entry

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1300d170580000
start commit:   176e917e010c Add linux-next specific files for 20250523
git tree:       linux-next
final oops:     https://syzkaller.appspot.com/x/report.txt?x=1080d170580000
console output: https://syzkaller.appspot.com/x/log.txt?x=1700d170580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7902c752bef748
dashboard link: https://syzkaller.appspot.com/bug?extid=1fa48dc6faf1ff972d7d
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=128bead4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=100288e8580000

Reported-by: syzbot+1fa48dc6faf1ff972d7d@syzkaller.appspotmail.com
Fixes: 313d10d79a82 ("f2fs: add ckpt_valid_blocks to the section entry")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
