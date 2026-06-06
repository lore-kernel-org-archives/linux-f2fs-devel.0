Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7322CD6E7D
	for <linux-f2fs-devel@archiver.kernel.org>; Sat,  6 Jun 2026 00:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IPVPRxzsQsowPkmltQiFqhYUkoxjDWXBZC5+XUofXrw=; b=W6KumCVnvHoeQCt8xmX/Ntmhph
	5DXszlIU6XRWu8/009QZup1oWxCyoaYFdjRHNo06deMNhXQvY8ns3N2qdwLL5y/d4VYW8VzQD7fBV
	1G6e0x1W9RJLDJgdfNxmzQrXaJ+B84+bMHucPl+ytf9OdrH5Ton0OttcjrYnNMCuguTA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wVey1-0005P9-Se;
	Sat, 06 Jun 2026 00:32:50 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wVey0-0005P3-Mr
 for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 06 Jun 2026 00:32:49 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=5zuZa+y8C4pOL20xk/8SVshbqVXoS7fTVVqM+ginZmg=; b=jGwHwgJvV6mD3epMwVyN+ikRLX
 +xDwUGWEQJ1HhR9Us+NFjElhzWpog9TglpPeN6ylCdtVigR6A0Ze9cDw5tBc4YMpOmFBphdS2LB1q
 zTQYrEweePcJCdSgAdNyFbWdJ14g7rJBaP4scPgu3tNwzUTyCHbvJBL3M45c7WFcytFc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=5zuZa+y8C4pOL20xk/8SVshbqVXoS7fTVVqM+ginZmg=; b=hhuug4Xyf5BTaG/bCjym+9ZhCm
 e3Z6U4gv8X3IibviztWKvgA9S6PVPdtGM4jTz7foE/7WzvjWI67mrTicPB4B3ltk6SQLaN438r9T4
 wrgElZqLd5YTTBcRlUTRrZya9bRQVkqfOWpspndICEpC9I95d5OLkrDfuDDjdBUACS/8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wVexz-0000Pn-EJ for linux-f2fs-devel@lists.sourceforge.net;
 Sat, 06 Jun 2026 00:32:49 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 39FD8600AE;
 Sat,  6 Jun 2026 00:32:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6F611F00893;
 Sat,  6 Jun 2026 00:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780705961;
 bh=5zuZa+y8C4pOL20xk/8SVshbqVXoS7fTVVqM+ginZmg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=AkoQvq4B13quYGScJqkAwm8RnHOTpaxZTQFoh7AHFBX5LwloiT1c61ZVzWU1AeUdc
 H8pH3QQaNy+xJFvN5zX0JkcFUtzxMex8CxTr4Z6TZHUcljETyIuQ78M9BK0yatiFKK
 XpdwKyrz5YfHtENQUxhKym3Bqvm7Eu0ck/j7dvMo4aupKmKNOrzcD+qG/jLdxhneTq
 uNZmaP/cydmHJ+IXJFqiuWOTq2KYqZy5co8yqDpac1AKOig2xtofSK7/00qtfDpz5a
 s/P70KfY12T8mL/TtPf6PYT4uzusfPInAmQrmNcHRCvtlwYxjCxmX0d9sHROt1znI/
 /DuVffkMHAdbg==
Date: Sat, 6 Jun 2026 00:32:40 +0000
To: Daeho Jeong <daeho43@gmail.com>
Message-ID: <20260606003240.GB2312230@google.com>
References: <20260605212504.1080138-1-daeho43@gmail.com>
 <20260605221027.GA2312230@google.com>
 <CACOAw_xrMij0pXjFkS4gY0kt5buvfZ0gmzbcP+zx4-ox7n+_3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACOAw_xrMij0pXjFkS4gY0kt5buvfZ0gmzbcP+zx4-ox7n+_3Q@mail.gmail.com>
X-Headers-End: 1wVexz-0000Pn-EJ
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: support dynamic include/exclude for
 device aliasing
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
From: Eric Biggers via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Eric Biggers <ebiggers@kernel.org>
Cc: Daeho Jeong <daehojeong@google.com>, kernel-team@android.com,
 linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jun 05, 2026 at 04:51:34PM -0700, Daeho Jeong wrote:
> - Access Control: The F2FS_IOC_EXCLUDE_DEV_ALIAS ioctl strictly
> requires CAP_SYS_ADMIN. Unprivileged users cannot trigger this
> transition.

No, it doesn't.

How much of this been reviewed by a human?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
