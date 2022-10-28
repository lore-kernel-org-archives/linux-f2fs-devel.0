Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CB64ECAAA1
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 28 Oct 2022 03:26:38 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ooG0z-0000Uc-5p;
	Fri, 28 Oct 2022 03:26:37 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1ooG0x-0000UV-25
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Oct 2022 03:26:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:
 MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t2gt1A4wo+4JSlaHFQj4OMmefvxP1D0nuobw8LB0M+Y=; b=jUh56oa4zB31dfUOeyrXXRyaVu
 Dt/Pq5Ijb0LliH/OCY/xE3j6FrX+ladwTA+Te9WTKpFGvc0WILBR9KNBnutXUbhDNhk33fgwDJ0TG
 uLo/B2ALIwY74knFfUo0XVYBl7Z8N35dYECEeihhzYC6FaCrBy8RQog/UoLC/Gl6xvh4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=t2gt1A4wo+4JSlaHFQj4OMmefvxP1D0nuobw8LB0M+Y=; b=MtmvsM/nqCJGd/gcX/J67xApu5
 8WELqccPbMTXsYlaw2mY4C3LEBuLSFaDVGkDaTq3PSplU8FDfLDYKjDZ5a6GXVuyBfIzn4Q66+tFG
 gaF/zJBG1tONe0dYtPJZGqCa3CFfNB9HHlNmKIGWdrTH9GUEXcPvPxdCfpSW8xDkXnCw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ooG0s-002xxz-MB for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 28 Oct 2022 03:26:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 45EE8624B7;
 Fri, 28 Oct 2022 03:26:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8EB7CC433D6;
 Fri, 28 Oct 2022 03:26:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666927584;
 bh=aqCjAed5ZXj+mwXg1Bd/xjOdJuP0rGDXPaY9h65P3Ik=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=svoCJb0kOHhHacw06TBJVuL7gMJfPxeJTtpN8xij3i6HWU3oSrkdpzpA/Y86ecE+y
 RVf/LuEQtcyZ3ddXHCER8PeDWFLn74Gbumu6iB7GQpJ9VabjZuH0JMaqG8b+vbFvL9
 UYeT6y2V2U2F4Y8E4oYWJFiaWoVR+DBx7VUszaFhiMYnmC58r62FSRfXesEe3tEoxd
 F7N/v5Qsp+vQ5eZRA07bv5oFXHbjiEV03xmRXZiBeXhdcYvMc4IvsGSAKObnFoOJ2Q
 g7VoLyykZ2Jg3oJMsmlxc503nU5wf+BRw3sLtjb5jLqKwoHA8iQJVTobXmixMukrdW
 +5FJIc6YjZNWA==
Date: Thu, 27 Oct 2022 20:26:22 -0700
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <Y1tL3pG4FAb9IA8o@google.com>
References: <20221018073240.666374-1-yangyingliang@huawei.com>
 <7908686b-9a7c-b754-d312-d689fc28366e@kernel.org>
 <4a58e927-bbcb-6e19-ca50-f2a4445dad3a@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4a58e927-bbcb-6e19-ca50-f2a4445dad3a@kernel.org>
X-Headers-End: 1ooG0s-002xxz-MB
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix possible memory leak in
 f2fs_init_sysfs()
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
Cc: linux-f2fs-devel@lists.sourceforge.net,
 Yang Yingliang <yangyingliang@huawei.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/28, Chao Yu wrote:
> Jaegeuk,
> =

> There is a generic fix [1], let's drop this one...

Ok, thanks.

> =

> https://lore.kernel.org/lkml/20221025071549.1280528-1-yangyingliang@huawe=
i.com/T/
> =

> On 2022/10/20 16:45, Chao Yu wrote:
> > On 2022/10/18 15:32, Yang Yingliang wrote:
> > > Inject fault while probing module, kset_register() may fail,
> > > if it fails, but the refcount of kobject is not decreased to
> > > 0, the name allocated in kobject_set_name() is leaked. Fix
> > > this by calling kset_put(), so that name can be freed in
> > > callback function kobject_cleanup().
> > > =

> > > unreferenced object 0xffff888101b7cc80 (size 8):
> > > =A0=A0 comm "modprobe", pid 252, jiffies 4294691378 (age 31.760s)
> > > =A0=A0 hex dump (first 8 bytes):
> > > =A0=A0=A0=A0 66 32 66 73 00 88 ff ff=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 f2fs....
> > > =A0=A0 backtrace:
> > > =A0=A0=A0=A0 [<000000001db5b408>] __kmalloc_node_track_caller+0x44/0x=
1b0
> > > =A0=A0=A0=A0 [<000000002783a073>] kstrdup+0x3a/0x70
> > > =A0=A0=A0=A0 [<00000000ead2b281>] kstrdup_const+0x63/0x80
> > > =A0=A0=A0=A0 [<000000003e5cf8f7>] kvasprintf_const+0x149/0x180
> > > =A0=A0=A0=A0 [<00000000c4d949ff>] kobject_set_name_vargs+0x56/0x150
> > > =A0=A0=A0=A0 [<0000000044611660>] kobject_set_name+0xab/0xe0
> > > =

> > > Fixes: bf9e697ecd42 ("f2fs: expose features to sysfs entry")
> > > Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> > =

> > Reviewed-by: Chao Yu <chao@kernel.org>
> > =

> > Thanks,
> > =

> > =

> > _______________________________________________
> > Linux-f2fs-devel mailing list
> > Linux-f2fs-devel@lists.sourceforge.net
> > https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
