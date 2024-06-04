Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9350AC25B78
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Jun 2024 15:10:16 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sEVni-0004md-KJ;
	Tue, 04 Jun 2024 15:10:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3Si5fZgkbAF0NTUF5GG9M5KKD8.BJJBG9PN9M7JIO9IO.7JH@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1sEVng-0004mT-MC for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Jun 2024 15:10:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=kkSWCLUC3Z5zZI+v8VL/vR1g1iAlgwx4yL/ydA03F9s=; b=ieYJiFy4g6YEGdjztg7yeiXfiB
 rNgEfzoRnCGQVEQ1wxpD3Mp4feBauRCjeDFJX52EmIfbVbOGWTxZrpDGpAHsKjKT0jRJMQ3Cnr0qB
 NQPVvbfC6lahnCQGeUqtc1LSnJ2WlquSxJPiXZ2uCFqicmxoPPu75Qqz5ELbCoXpBeVI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=kkSWCLUC3Z5zZI+v8VL/vR1g1iAlgwx4yL/ydA03F9s=; b=H
 +jdJQdeWjAu5CFv/7wVSI9kQNd3b5/7bBhdV3t31ib1loxMytiuiQ5kh8V3b0JQSqUD1669o3umHP
 /62I9ICgbi5GE8Csp/hPXDgKuieGAlYwphxWN3+RDnI2ZDwCdBh33cNFFjdaShvRosW7cefWwCSYy
 ixKwu+1w9O/WvaVs=;
Received: from mail-il1-f198.google.com ([209.85.166.198])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1sEVni-0004o5-28 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Jun 2024 15:10:13 +0000
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-374968174f8so30226685ab.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 04 Jun 2024 08:10:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717513802; x=1718118602;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kkSWCLUC3Z5zZI+v8VL/vR1g1iAlgwx4yL/ydA03F9s=;
 b=IITCpiWV/mjTO4Pjvtzjlo9BgnHrV3J2NKxp+gL7pPPqrLEMD7N7nIlNpM3ClGgTHR
 4RwbHpDx8vwwt8OUWpPpSHQ5j8tGRZaNSVZKZfqvf8S/bE6XDuwmNZR9TAlTzZPr7BnC
 elfUdv/T2uj1UKo4joKMZEPLzk1WdQrlHTNlK+PqtFxykM/UmygqDkUz9fAPIVCRuaFv
 O3UOzSHl3Jk8ZOjuZUmtB6BTqyW9zrz2d9UpteyEe0zzIi+YfyGfQKq8KlTr5Qfe622g
 Bvtc5NXvRwqod1BY7rCVgnNkMxbWXzSEceQZt3xV1fpx7cjBTY4gdN0d4VkLCY96YUbU
 j7jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU/AlCC1SiGwlIF+3qQXvy+IkK/TCqhdIx1w0g2DAdyB9B89GkAG3xxneo5CMKbE22Ae7nUuGl9pa5RG6SqjHndB7wenRLushxMJkYSE52EiuHd3Ponsg==
X-Gm-Message-State: AOJu0Yxq1Wg7bF8g1m+dXY9U2+hQ2PWcSJEXqHIsSSqrb7DXxyPGmGQx
 gIPXokpfW/lrkAs2Bu+knC5w3eYCaasqYuL0JXlsQyPhmnGnoC6I5yVN1ow5bfmRFKbMfJ6kxag
 CD22uaUoBn8nhmHlrx5lxuMVUZTm04f4s7bkM7Zi3ac+l+XcTDMyilKo=
X-Google-Smtp-Source: AGHT+IE76CJ+LLRsvygb6B1IMZFAirzuRPp9Osu7vnH6Gg/0Ka8ZM9cU532pf4uWHpLGjHKlut+XzzpYCOiZVmQk5K76Vnz92ZG5
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b27:b0:36d:d06c:5c10 with SMTP id
 e9e14a558f8ab-3748b9e5b86mr9243325ab.4.1717513802615; Tue, 04 Jun 2024
 08:10:02 -0700 (PDT)
Date: Tue, 04 Jun 2024 08:10:02 -0700
In-Reply-To: <a67e82fc-4658-4784-8d5b-e8a048e749e2@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000001a2419061a11d885@google.com>
From: syzbot <syzbot+31e4659a3fe953aec2f4@syzkaller.appspotmail.com>
To: chao@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
X-Headers-End: 1sEVni-0004o5-28
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] kernel BUG in f2fs_evict_inode (2)
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

Reported-and-tested-by: syzbot+31e4659a3fe953aec2f4@syzkaller.appspotmail.com

Tested on:

commit:         4d419837 f2fs: fix to don't dirty inode for readonly f..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git wip
console output: https://syzkaller.appspot.com/x/log.txt?x=17a597d6980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eab577c7808ea52b
dashboard link: https://syzkaller.appspot.com/bug?extid=31e4659a3fe953aec2f4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
