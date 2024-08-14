Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E60FEC52D7C
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 14 Aug 2024 03:21:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1se4ZX-00027y-17;
	Wed, 14 Aug 2024 03:21:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3niK8ZgkbABE9FG1r22v8r66zu.x55x2vB9v8t54Av4A.t53@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1se4ZV-00027q-A3 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Aug 2024 03:21:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WeOzwsxqi4uut10yzktkikUuXeNCFeLLytVzbuzAQVc=; b=m+jsO6/vuz2t2HrEQiQbeWLyUi
 Uhknm2YzopHAFw9lO5YdWAQIwwmDkd2R/FJK/5masc1HpPXwHxUDoblzkVYsyiGGYbWY0DeYskD/J
 +dvOCjg9ESsluc3cCSIkqmaGx135SgqBNxhYC4yetC9L16Ufebg1cJvjJv96DLIIwCpA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=WeOzwsxqi4uut10yzktkikUuXeNCFeLLytVzbuzAQVc=; b=m
 aGZjkMDsYYVerCaxPB8iERgUEI2dMFbmSXL0ofjIA9sgQDEGa7yCDfG26Wff2iZ/Rq9sP32zeFZC3
 2G3lrW9hQ1G2vmVYZL4WJ0CWKYqLyN/s39oro6ZwKqufLyGdQ4YSoh3reRQO+K5KEKloVh7nNVCjK
 oTghvHIzMkRZoeMQ=;
Received: from mail-io1-f70.google.com ([209.85.166.70])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1se4ZV-0007Yj-DP for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 14 Aug 2024 03:21:13 +0000
Received: by mail-io1-f70.google.com with SMTP id
 ca18e2360f4ac-8223c3509a9so864288939f.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 13 Aug 2024 20:21:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723605662; x=1724210462;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WeOzwsxqi4uut10yzktkikUuXeNCFeLLytVzbuzAQVc=;
 b=AEjTWBrodYApIsN/12VEEXPeFbB4B6dOGZJ6REXFzptzT0fYCypnWvtI6HFXSXXY2k
 Yphd9h6FPmeaae0Uo5EauR+zdswQnIrpmD08ntgTS08wu9kfJ3hj8n3b674C1wShxT8B
 v7Xyu/L5aLe0HqHNP4OERy2bloaCEkL2u/dZj0N/+oeDeOgPvnYg3a8uToRJ+ulVvTtj
 5vout3YBW755z1gkgWJjbE3jdA1LBo34+N8oGgelRaxBKG1EjjthMp3CjhMxJVBCNSSK
 YO6Ssqtlys//Pa2KAa4y8edLWDgDVbB6r68PnB1JxAc8A/oUjxihVTGe1AcEfBTzn+sJ
 Z/Rw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQZz65hdojiyxcHN7K2uoX3pl882SbWs18k7JwKjgxQcRbiGHhrQ9Dy0+6gMgJRyEkyRMzFs9rha1Sy+Ke/LYT6kGqYmNJGAhZaGTKU8ZChV9nA/ZC6A==
X-Gm-Message-State: AOJu0Yw1TJWA8ys7xru0WhgZFUmzKitw+EVcs2bHT9ZDXKrNTB+tW2/E
 esh4/L8tHK20Ahf5NO8SfOH6S1ah+n+oFn9pqNNTCuSdfDIg2/cH+py0GTtdXOVOU5wh75d1gPg
 tBXOa7QOsbXrXsxszzI/oMD5p0WWw8zP4ISoxePYul4FtipN+wmClQJI=
X-Google-Smtp-Source: AGHT+IFxkSO3aZTNJt8hWQTD3LoqkCKnVNyDTj/OWSvEOT8GzebrqSfd43uiKYo16jcstJ3dEOq2saHmdnj4TPPKy6dnZ0iDaJm7
MIME-Version: 1.0
X-Received: by 2002:a05:6638:9827:b0:4c2:8e08:f588 with SMTP id
 8926c6da1cb9f-4cab08327e2mr67442173.2.1723605662600; Tue, 13 Aug 2024
 20:21:02 -0700 (PDT)
Date: Tue, 13 Aug 2024 20:21:02 -0700
In-Reply-To: <tencent_E51B7925E5BAF4BBCF33739E5E1BFA4B9F08@qq.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000409ec1061f9c376a@google.com>
From: syzbot <syzbot+78ff2855f26377625419@syzkaller.appspotmail.com>
To: chao@kernel.org, eadavis@qq.com, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1se4ZV-0007Yj-DP
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] WARNING: lock held when returning
 to user space in f2fs_commit_atomic_write
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

failed to checkout kernel repo git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git on commit 9e6869691724: failed to run ["git" "checkout" "9e6869691724"]: exit status 1
error: pathspec '9e6869691724' did not match any file(s) known to git



Tested on:

commit:         [unknown 
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/davem/net-next.git 9e6869691724
kernel config:  https://syzkaller.appspot.com/x/.config?x=61ba6f3b22ee5467
dashboard link: https://syzkaller.appspot.com/bug?extid=78ff2855f26377625419
compiler:       
patch:          https://syzkaller.appspot.com/x/patch.diff?x=13f2af7d980000



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
