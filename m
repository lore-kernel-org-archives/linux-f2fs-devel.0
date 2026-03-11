Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98D501049527
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Mar 2026 10:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:In-Reply-To:Date:MIME-Version:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=wzDatHcRgUFycJ2Aoe1yGlZWVms1urdK2t5McLvg+/0=; b=C2tmZkCT5cnuVpF77A46vzWnv3
	u+kaF/7zwcXpCiBi4If0uVPJG0r2WwfdOpML8Q6b9U2R8SY9ly0TOh+bUN4QkJtYVGm41gW0+gqd5
	a17+2IsStzXd/jVtrht1vLlqs9w71bLdZg7G1yEwwuICTkWU8fOGl+PIrf+ukcIH4cyA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1w0Gcu-0005NO-IG;
	Wed, 11 Mar 2026 10:17:16 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3H0GxaQkbALox34pfqqjwfuuni.lttlqjzxjwhtsyjsy.htr@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1w0Gcs-0005NI-M4 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Mar 2026 10:17:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UnHGnobw61SFIXjoQkpFSTWAD2vDTpEuCDpynbfiFco=; b=Czwhsbx6l+kTJjrbUCAUzbS+HG
 lFbW7Fd0ii7xuWf7d5zeSPEKcuQtMstgWqrIXmAc0fEeQWW5qka8ZSWD8soMk6639NOVfJbKcIpsJ
 iOFIMX0uvHNd2b26DbvSIU0yDGrFPpKXBn6u2avV2209QRjRAe0g7fL/HRrqEmUEujZY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=UnHGnobw61SFIXjoQkpFSTWAD2vDTpEuCDpynbfiFco=; b=S
 wJcwmQD+1RcfKXvGQqagPpkhMeD8+pHMnh6FjGFl00Tdev/mt0kqHB3QcIX6EFNeI3fcLcM5Ey8RH
 y7iNt3pnd0T25FsB7XhGh9Ts4V0ZerlQoMSsMNeiLl0F4+KVdrx0w1qs9WxOu2sTmz5+lXj44R5uQ
 DIjLbm1eQd83wGk0=;
Received: from mail-oo1-f69.google.com ([209.85.161.69])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1w0Gcs-0003cX-7n for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Mar 2026 10:17:14 +0000
Received: by mail-oo1-f69.google.com with SMTP id
 006d021491bc7-672c40f3873so235236820eaf.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 11 Mar 2026 03:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773224223; x=1773829023;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UnHGnobw61SFIXjoQkpFSTWAD2vDTpEuCDpynbfiFco=;
 b=k8F8P2Dv2Y3CJX6Tu8M6MJPwYAFCTqklOQVkWhPTZTHw/MDqDojrDLLAleNsolZGd5
 4Q/aOBTt8RSAFGVgS+jz6qhQGmtRgQHyUsl4mLke4OTKSPEfPTI36TR7QmUyqzjFTI+c
 U9IUUMyBuDwVQfyf0jBud+7cltSX91QXg0XoBDp3VUlFogcxgEe6+ruUxfNixGUPbIq+
 4zOuuC3PDh0RGP5RRa9EPKdUcd8x/UHQVSsony4C13X8s0BpRm9TqQpJMfckDEfRXOvE
 oY4wIgiK15MkP7PHTKxP5N0OMHmK8sOgQaPfPIEj7Ah1Ehm6V/KUAbaJ2HlEa4sHf83k
 0ziw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWll0WSEXoWikJp5EuOXy3tVySlfjEbDSNjAMvB9cA6qTz1jNY7xi4ShcAx9RzNeT/iDUefqxdNkHL6F4tsLJdZ@lists.sourceforge.net
X-Gm-Message-State: AOJu0YyK7HbY0p691hnxBV6eRgUQu88taxmcoUQu0iEPskvlOvM7UBSw
 hEC9/ni3WRnV9Q4NeuyfYw9XokfbmB5D6IdXNQREbTovbJJEbYZLoy7SxdVKuju06gLJTQre+CB
 dWpnD6dckJmLvoZRCYZNaNRN1rJZxN6ZqcoN3o2M4M47S+S5LCBeXoxygfHU=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c8d:b0:67b:c122:d2a1 with SMTP id
 006d021491bc7-67bc8995cbfmr1247313eaf.37.1773224223623; Wed, 11 Mar 2026
 03:17:03 -0700 (PDT)
Date: Wed, 11 Mar 2026 03:17:03 -0700
In-Reply-To: <20260311095738.4177239-1-wangqing7171@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69b1411f.050a0220.209d0e.0000.GAE@google.com>
From: syzbot <syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, chao@kernel.org, jaegeuk@kernel.org, 
 jannh@google.com, liam.howlett@oracle.com, linkinjeon@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
 pfalcato@suse.de, sj1557.seo@samsung.com, syzkaller-bugs@googlegroups.com, 
 vbabka@suse.cz, wangqing7171@gmail.com
X-Headers-End: 1w0Gcs-0003cX-7n
Subject: Re: [f2fs-dev] [syzbot] [mm?] [f2fs?] [exfat?] memory leak in
 __kfree_rcu_sheaf
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

syzbot tried to test the proposed patch but the build/boot failed:

failed to apply patch:
checking file mm/slub.c
Hunk #1 FAILED at 2629.
Hunk #2 succeeded at 2828 (offset 168 lines).
Hunk #3 FAILED at 2670.
Hunk #4 succeeded at 4624 (offset -404 lines).
2 out of 4 hunks FAILED



Tested on:

commit:         b29fb882 Merge tag 'v7.0-rc3-ksmbd-server-fixes' of gi..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d7d0fbecb37bff8
dashboard link: https://syzkaller.appspot.com/bug?extid=cae7809e9dc1459e4e63
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=14156f5a580000



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
