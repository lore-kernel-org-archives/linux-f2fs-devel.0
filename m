Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A769C55182
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 00:03:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uzn4TLs/WaylXs3N29+kIdj6p1nHxot9sdJMvmQxwRM=; b=Kbnjuru24RuDgTqqs9Y2xc/mB8
	0+LGSPtFZnhsE5yQ4wh9DXxCOYgu0um6IejsYhoqFIlbhDR4e3kFW1rIQC9QxbD2c1S9fEzAb7dhq
	STQ1dAdvkNWl+u7CB/JKyNwVllelF07oS6gZaUxQFDwtsy3hM0qOBmI9P8s17d6Jy8cs=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wr2cz-0004I6-53;
	Tue, 04 Aug 2026 00:03:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wr2cx-0004I0-Pe
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 00:03:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=1TXFHbmRwQJfdbgkVjvPjcA8Q5xydQ9Bv7Wi5QTUyS4=; b=S1nmoCpaLmzO66xmdLvrm7Y77H
 wV5xiAHYA39SK1fm67wy78NXhH60+vQKzmyntQDmVagdh3wY0QwcdAEX/N0k48IrO7UoPlFVT1Yev
 /F2nS1k+y/iSMMsdHVP1pPMO/RXh6bvM6+dqUwtVju40w0lmt/+OJRqTEmaMda0MpcwE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=1TXFHbmRwQJfdbgkVjvPjcA8Q5xydQ9Bv7Wi5QTUyS4=; b=lZCTa/Iewgug8eEn4maiJizH+z
 VP2v8tnKNkTLKI+U44A2XeBRgJjcD7H6cFhE/glmub/jUuTXpek/j1vPlLP1LtCz63L4/g/NGoZoJ
 Rt6zIZL3DWf+D2j9Uv2/bieXmAlK5TwYhi/U5xdqFhD4YbiAPFeRCupXk3zXzs/eXV/4=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wr2d1-0000or-Im for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 00:03:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 44D5460A60;
 Tue,  4 Aug 2026 00:03:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76841F000E9;
 Tue,  4 Aug 2026 00:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785801802;
 bh=1TXFHbmRwQJfdbgkVjvPjcA8Q5xydQ9Bv7Wi5QTUyS4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=VdxUSWC9yVSFUNLJlsT3XPDpa/hRew44xUJZ1g5aww9MdauTFiBKFDs0D7GWudVPN
 /QiD05eJpH6sG3EAbVJtPvBtkjvaN1pKi/MNMuesInylCVDwtoZB3IOt63UkOJc+gB
 yaDYBe42n6ix5i8Yc0PoYVkHnTZ7hmLASwWsRz/Xab3FLjWHCPddoH36JWgTjiJuB6
 FqSijOJEraN0mKtVZQ7gjYvwvaXUEEE5IKjUAoBvu9XXR4jWybIjW/vNJ5v8o/63jT
 bNKdFCfEDtO0uXXshwQlbDJLGcRXYhAAdbzFh+38YDtjRFvz+OUoAgOd35pbzYhHIH
 +vZxuePudirLQ==
Message-ID: <eaed5dc9-62db-48fc-9340-0cd477436911@kernel.org>
Date: Tue, 4 Aug 2026 08:03:18 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>, jaegeuk@kernel.org
References: <20260803114153.1499527-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260803114153.1499527-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wr2d1-0000or-Im
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: reject invalid recovered filename
 lengths
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: qiwenjie@xiaomi.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/3/26 19:41, Wenjie Qi wrote:
> Recovery uses raw_inode->i_namelen directly when rebuilding fsynced
> dentries. A zero-length name uses no dentry slots, so recovery can
> report success without recreating the dentry.
> 
> Treat zero-length and oversized recovered names as corruption, mark
> NEED_FSCK, and stop recovery with -EFSCORRUPTED.
> 
> Signed-off-by: Wenjie Qi <qiwenjie@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
