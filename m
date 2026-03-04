Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06EF2EB7EA3
	for <linux-f2fs-devel@archiver.kernel.org>; Wed,  4 Mar 2026 08:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:From:Message-ID:In-Reply-To:Date:MIME-Version:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=JEpKxCRBpcTtuSd1PrrqtUabpBF7JqCm+r7C1cr07sE=; b=cGvZf+IE6/4fQ/v0fWTwRYXUQV
	j3DDlS+Asb7+83/7/l4jleySQplNRQfTyAf8bjqFVbnG7+/j028xjf4XrPuamdM0cFA9rKjRhWm3o
	hbxNlnNPvP2ghFiMvtE3U8HUu9CGtzirel/7NRaAbaqJU3KbG3a2OHS4NedOqersAQHM=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vxhPu-0007cm-Jk;
	Wed, 04 Mar 2026 08:17:14 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <3feqnaQkbAEY067sittmzixxql.owwotm20mzkwv1mv1.kwu@M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com>)
 id 1vxhPt-0007cg-LM for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 08:17:13 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:To:From:Subject:Message-ID:In-Reply-To
 :Date:MIME-Version:Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=BjrWURK71SeP1mZA+fyGcBQJ4Fnq0aIU73n4Nn6FsVA=; b=aGveCn/O148PQO+vIQee8vulMW
 aHVZY+XwcI+DbW8n14A8HOINpreMvXr+KvtO+AStBOsRaP2+027lvBXUgGv2dy9ywGT/86MCaZC8J
 rh1VlH55Lyiu4UUZJNGBblNhgN+UzvkCQPYGoUCGvNVn89Azn39g4ZG0M+w4yFonujJE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:To:From:Subject:Message-ID:In-Reply-To:Date:MIME-Version:
 Sender:Reply-To:Cc:Content-Transfer-Encoding:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=BjrWURK71SeP1mZA+fyGcBQJ4Fnq0aIU73n4Nn6FsVA=; b=k
 AoeBSbbXYQbE0sBesA7UDb6UDZgULw/o9fMqa4ofcEiN4A05HK0pY3iOnwm9RQN5JOgP6duct5AiA
 HKxhJS/N2TvuIJufL8C+JiKs7UQIz7HnmC9qZGrEqlamN4NFob2LB9+zBpZITMg90+P9PDT/dopGn
 FTL/RNzl8i16pQuI=;
Received: from mail-oo1-f70.google.com ([209.85.161.70])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vxhPs-0001Jq-G9 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 04 Mar 2026 08:17:13 +0000
Received: by mail-oo1-f70.google.com with SMTP id
 006d021491bc7-67999893008so56511633eaf.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 04 Mar 2026 00:17:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772612222; x=1773217022;
 h=to:from:subject:message-id:in-reply-to:date:mime-version
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BjrWURK71SeP1mZA+fyGcBQJ4Fnq0aIU73n4Nn6FsVA=;
 b=m/1I4XSTolIUMaEZvs6LS7TsmiuBKUfTxonHPj6BvAJKuHrKE5y02CXg0wIRsAYQlK
 EfDYE93KxTvAYzS13ILxaW9fFa1mbe0DVXRit6Eu2gNHFfBHp1oK5m4Kqj+vZV+0tiNU
 yo6I7GvU6zxge0bM+O7aHCEc0ZRL8dXCeH3qlPL1td9aOlQM0GGJy5rq8m/KiPA260vb
 /K1cFwHBhVCPioWHth7avPdSZ2KL6XiiX4KRrHWXC8xutli0DyMX1XOtIU9SY8seeXTT
 hk/n/R8T5MlJvG9En8PGpJt7h1nj4uSPkisbW8An0oNztAFun8hMKXdCbcZy3VvTj5vq
 1kLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcQeB/mfo3excuF/giYXpVuHK5376WlcjErETwawb0HW4ViXz/6GiH3kS72hXT/W2abGKlyKmnutO4Tk1MrOe3@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxgG+AzuEceiJWqSBy+BvlVjMv1TWawlGERRAqokbSn8y4QdTCH
 y8jP4VPIg7pwHewPyivpunljrjb4Jutn500bDKgMVOdWDXNkUNW2MIzE6Xzi+68ZnUOpHv1bZL+
 duFn7j/MCklHF0HAafZ4PyqwIMQf/vfiZCLnmeDD9QGWzkoUJq95ej7EVD9U=
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1c9e:b0:679:e595:ff30 with SMTP id
 006d021491bc7-67b17750586mr873178eaf.36.1772612221934; Wed, 04 Mar 2026
 00:17:01 -0800 (PST)
Date: Wed, 04 Mar 2026 00:17:01 -0800
In-Reply-To: <efdfa39e-78f5-47df-9de5-a5d8ae8841b2@kernel.org>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a7ea7d.050a0220.21ae90.0015.GAE@google.com>
From: syzbot <syzbot+cf7946ab25b21abc4b66@syzkaller.appspotmail.com>
To: chao@kernel.org, ebiggers@kernel.org, jaegeuk@kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org, 
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tytso@mit.edu
X-Headers-End: 1vxhPs-0001Jq-G9
Subject: Re: [f2fs-dev] [syzbot] [fscrypt?] [f2fs?] memory leak in
 fscrypt_setup_filename
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

Reported-by: syzbot+cf7946ab25b21abc4b66@syzkaller.appspotmail.com
Tested-by: syzbot+cf7946ab25b21abc4b66@syzkaller.appspotmail.com

Tested on:

commit:         be41931c f2fs: fix to avoid memory leak in f2fs_rename()
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/chao/linux.git bugfix/syzbot
console output: https://syzkaller.appspot.com/x/log.txt?x=135fb006580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9d985797319d4da8
dashboard link: https://syzkaller.appspot.com/bug?extid=cf7946ab25b21abc4b66
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Note: no patches were applied.
Note: testing is done by a robot and is best-effort only.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
