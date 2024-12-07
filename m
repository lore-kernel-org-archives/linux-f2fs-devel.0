Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC32DE7717D
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  7 Dec 2024 22:59:17 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tK3lb-0002Pn-4X;
	Sat, 07 Dec 2024 22:59:15 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3NtNUZwkbAHEhnoZPaaTgPeeXS.VddVaTjhTgRdciTci.Rdb@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1tK3lZ-0002Ph-HX for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 07 Dec 2024 22:59:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=R/VmBNzolQEI+3BQ4hjo9q3nxk8T9gmXnBExH9+rR2g=; b=QAXNnu68yiAV5A/VGlWaaNmJRy
 5Aew6Xeg+zBRC2AfngZkUvpna4ZT5l5JMBHQHGqMCqs6+/vnU618vv5RPG5B5gJV67uVqkFHmUO7R
 aWMsAGa2aeqUIuCBIppbUuWUebGUCsmLnBN8PZBGzw2Adyeiyykd5w9fFQ08a6Jeap7Y=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=R/VmBNzolQEI+3BQ4hjo9q3nxk8T9gmXnBExH9+rR2g=; b=X
 KAZyLYEu4/79OJjKdMCNifO6oQsC8UVIdU+qib1aAqQFLWzJ0HHU6w6SVoNkCOG6/Pha7KQiDfawC
 5Csv9MxXfgG8gbIsef7ho3l2XcJVogi6Y1entHFGEozfpP3UBShV5wek0sf66MVNzw8jWJj7bf+oB
 0lRfBMxN8XggLkSU=;
Received: from mail-il1-f198.google.com ([209.85.166.198])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1tK3lZ-0007Zm-JL for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 07 Dec 2024 22:59:14 +0000
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3a9cbe8fea1so3817555ab.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sat, 07 Dec 2024 14:59:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733612343; x=1734217143;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=R/VmBNzolQEI+3BQ4hjo9q3nxk8T9gmXnBExH9+rR2g=;
 b=VjigdJ/jHGjnXfi8atPeYNDjKfslBF0SGK4O5rWuJsHz033zMewCzAcn3DxM+TGfoN
 GHAvd3gX9bXf8sMKlhOSy3ehAYaGlmgXPugbtSvj5BMySXwtSkZEOePqsHOPmvytRCW4
 SMOJWBJfyDTBcwjqV+30q71Jse0WN3BAKgBV2cu0kpIksfAIBe7o/upwVZCPrqlAZQFY
 A7qZk8OL50nrkwgwh2Kxe3L6b0/A7yWj+yp7e1nt5ovvM74FcEGQBkjFs6/5yoTmS2ZS
 KYP1ezM0Pqv42sBS84D1bW5PIlXMJ6v1pVn9jkoYcte+Q41M+oPy3u1cJhpDtE+KcQyy
 7QJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW94yhmMrdvH8/MmcqLhNn/f16J1kD9MUDTK3aRGP4MewQga5FwdknZ9ibuu1kzURcVMeImoud63WPaBkfkNi2H@lists.sourceforge.net
X-Gm-Message-State: AOJu0Yy5NS9xg5Zdvp+RqdSbVvJM72LhN36RCerC6aoqAJQbTMGdcghi
 k1oVW6tTAuC6gwjpEZbjFGYdWWuccdCzSM4t6E+3Ikz8bBDb7KTeOWV61S7iDV5UgMHTDgM2uKX
 ZaQFT9ZrR0zLyapS/8qX8ISg7qAm2YmXvoU+8dXnYzvh29O/Ujb2lLM8=
X-Google-Smtp-Source: AGHT+IGlJLJ9elp4FLJhcyLSM6CNErXuufBhJOtN9fIxLINJ1c1Ag+4uv70DCO8ksH4V205lktYKJPZIPvzSVZfJhizmWkXy9fvC
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4a:b0:3a7:e67f:3c5b with SMTP id
 e9e14a558f8ab-3a811d775dfmr78128785ab.2.1733612342844; Sat, 07 Dec 2024
 14:59:02 -0800 (PST)
Date: Sat, 07 Dec 2024 14:59:02 -0800
In-Reply-To: <67388dcc.050a0220.bb738.0008.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6754d336.050a0220.2477f.0021.GAE@google.com>
From: syzbot <syzbot+5c81eb8c0a380fa578b5@syzkaller.appspotmail.com>
To: chao@kernel.org, drosen@google.com, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, 
 syzkaller-bugs@googlegroups.com
X-Headers-End: 1tK3lZ-0007Zm-JL
Subject: Re: [f2fs-dev] [syzbot] [f2fs?] kernel BUG in f2fs_evict_inode (4)
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

commit acff9409dd40beaca2bd982678d222e2740ad84b
Author: Jaegeuk Kim <jaegeuk@kernel.org>
Date:   Tue Nov 12 01:04:58 2024 +0000

    Revert "f2fs: remove unreachable lazytime mount option parsing"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=130903e8580000
start commit:   b8f52214c61a Merge tag 'audit-pr-20241205' of git://git.ke..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=108903e8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=170903e8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=335e39020523e2ed
dashboard link: https://syzkaller.appspot.com/bug?extid=5c81eb8c0a380fa578b5
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=155bd0f8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13cad330580000

Reported-by: syzbot+5c81eb8c0a380fa578b5@syzkaller.appspotmail.com
Fixes: acff9409dd40 ("Revert "f2fs: remove unreachable lazytime mount option parsing"")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
