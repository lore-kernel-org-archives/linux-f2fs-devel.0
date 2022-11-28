Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E088DC433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Nov 2022 21:15:04 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ozlSx-0005B8-AT;
	Mon, 28 Nov 2022 21:15:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1ozlSu-0005Al-Fl
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Nov 2022 21:15:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=C/IqBerdBnu661iPk0v4dRj4iYayshF5gBebcBM9p9Y=; b=Fj8M04IbFjJ/TKsMrILU+AM6uU
 j+xTxy6WV9uc0u/1BfGo/XTbNTQfvrrLS/MlIRQuYU6K/E5CxcPwNDIRM03zX23wb4GTpY/Cb9VE0
 53oTlnvXOQ8M6xanDEQEBC8BTHU7kxmIXtRCUoh1spJUW8rslacyMeIS0oLBCqezrblg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=C/IqBerdBnu661iPk0v4dRj4iYayshF5gBebcBM9p9Y=; b=P7oUxo3i5u4jSiboyfjopW+tW/
 qYPy+9UHW7jEbLHGJvpioHravEOe85Tz22WZeMQ/9gHliDqwlIvqhRf8XKF11c9C+IEw29SKs2NC6
 giSFEqqjdSVk5+5yQkJSu47J/IQ7XtX2KoYQtkVpshUK0TjEPlDz4ZaV260p9ApdJnZU=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ozlSt-0004CW-UO for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Nov 2022 21:15:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 874AD61444;
 Mon, 28 Nov 2022 21:14:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBD52C433C1;
 Mon, 28 Nov 2022 21:14:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669670094;
 bh=WEebtS/VB+2cphwwTM1geo4BWud46mfJ9AmRB24poDM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=d53cDAbZXQoM7OExcA4L23bJaehbkZJAnaglaQ0VDz4X0qW8DYpTJKWFdENgCLDa6
 SpJWGZcmsEIbzQFVw9OCof2rifp5vY8mxWp3IJtPiaj7j2633sNFk9QYZGmbTOqAX/
 xEHoML+hsM0KfAQonHWbySml8s4Z7zd64ZCP3+33wfwOG0gQ2aXJrAcVMW71lwUUgJ
 +f68WEN1OdO2dUMdikYCzuz3pYdlep1XGqHObV2zugjPpAbSueLM5DMeEylRCRQhUt
 NAOmD/71oieYgmpa7BMlyuvsgu2Vj3gaSzPD4WdyxaAVugs0rjtGR9dyPjEKSLS4DF
 9u1jC3pVmCPQw==
Date: Mon, 28 Nov 2022 13:14:52 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <Y4UkzM34x9uQqLKG@google.com>
References: <20221128094346.1256688-1-hch@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221128094346.1256688-1-hch@lst.de>
X-Headers-End: 1ozlSt-0004CW-UO
Subject: Re: [f2fs-dev] segment allocation cleanups
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 11/28, Christoph Hellwig wrote:
> Hi Jaegeuk and Chao,
> 
> this series cleans up the segment allocation code a bit.

Thanks, applied for test.

> 
> Diffstat
>  segment.c |   71 ++++++++++++++++++++++++++------------------------------------
>  segment.h |    6 -----
>  2 files changed, 30 insertions(+), 47 deletions(-)


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
