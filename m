Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F7DC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:55:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p1HldQKg1FGWH3GG9xetv5XVAvEeUt4b/5rwcVvxlcM=; b=cC0xrzp/HUj/IYGOavrAzFkDQd
	QG/IukMiOBkdKAZm4Qsfw2p2nqBnFJI6AqL6GibiVfKuzniNaqQCkP2UPOr9ZnDH0oVyWONZZ7WcU
	1Gk0bYt+KLTWErnfUjBlUeOv0nz8rwVm6Unx9neP0qCZxPJ2jJkW5iqHq0fnksCgvdzQ=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wgirD-0004qy-57;
	Mon, 06 Jul 2026 12:55:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <willy@infradead.org>) id 1wgir9-0004qs-Ck
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 12:55:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8uV13KyCkvJnob7UOl+qzuzbQFV69D0rPpVgKghEOkY=; b=axRMGcL2tXBylnY4lX97O2OJ4L
 8UJ72udPmgq3ymhAsZBlGXMR3bVde1auvFO4Im4yg5MbrE4UPMAUPIbRL5FBMeonG8O/g7bOOJVb4
 4NsLO61w//gIXKblpDKAn7hM0BhtHAEGQX/QfXvvSm+ZXQJxlLG5QgWFvUb9om5ZJlGk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=8uV13KyCkvJnob7UOl+qzuzbQFV69D0rPpVgKghEOkY=; b=jaen7WqM/94AiUcmCT7T2Wa5bI
 Ms/srZe8Ec4LVb83bPAi4UBG7656PL2nylwNI6cV32Fl6GljGXZb2Q+XJb9WnLPeKXNDi2XKkUEJQ
 GJgo3xxWDK4aYtPmViyVuJyxzFfPs2YvPK3eqQiq6ixSg6PM9SvunGP/QjgTj3l9LCHo=;
Received: from casper.infradead.org ([90.155.50.34])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wgir5-0005Nx-Jr for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Jul 2026 12:55:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
 References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=8uV13KyCkvJnob7UOl+qzuzbQFV69D0rPpVgKghEOkY=; b=RYDSQ4BtHsBYVgc+X33ozhYGrt
 Cb+VUsVavjXWFZ0G1REZCF5k9Lo/FtW1PdfiCia91MGEJmUOAsKJHh2cmt49jfmRLOiJHYG9uZ8wA
 HbhZPPNnALZmquTan1jSJOoy7JzDbU+PW1xoTLCArwQTDouJ9vEQk9Nk/IYMojKoR9SxdeZku2r4g
 nMEJDaQow+2RTCUJjMwDAbtvryriyVZhFEAvQHdJc8BkDaJ+o98os6NoC//NTFELdAeETt3BwPm0D
 Yr9Ya0RIhRPkaIsXJ+9LPdrs+DQ+OM8MzKafJStX/wcXc+TiCKTL/dsTBVFmKKkl9xffSw1W8YV/p
 MPFUMV/w==;
Received: from willy by casper.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wgiqt-0000000FuQB-2Vlw;
 Mon, 06 Jul 2026 12:55:11 +0000
Date: Mon, 6 Jul 2026 13:55:11 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Chao Yu <chao@kernel.org>
Message-ID: <akulrzxMUbI5Kr3D@casper.infradead.org>
References: <20260706095943.2560208-1-chao@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260706095943.2560208-1-chao@kernel.org>
X-Headers-End: 1wgir5-0005Nx-Jr
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: quota: do not use GFP_NOFS in
 f2fs_quota_read()
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
Cc: jaegeuk@kernel.org, Jan Kara <jack@suse.cz>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Jul 06, 2026 at 05:59:42PM +0800, Chao Yu wrote:
> -		folio = mapping_read_folio_gfp(mapping, off >> PAGE_SHIFT,
> -				GFP_NOFS);
> +		folio = mapping_read_folio_gfp(mapping, off >> PAGE_SHIFT, 0);

0?  Surely you mean GFP_KERNEL?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
