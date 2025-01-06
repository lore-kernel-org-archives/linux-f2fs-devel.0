Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96C78E77188
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  6 Jan 2025 21:18:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tUuUd-0003XT-FX;
	Mon, 06 Jan 2025 21:18:35 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1tUuUc-0003XH-NE
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Jan 2025 21:18:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=JGBFC2N9csMUolDzs+X6YnC1EX6aR9uG0ApE8rUd7Ok=; b=BFYroq+nN9OfvImRKFL8HA+BIn
 G55tcfLuGLajmS1UGYOlb781LJxEVPSSg2BbGEW4wVW+Xu7JW/41J/szEtRGGW8lY/5nRq4TvlYyt
 odZ8wwEah6fa6Qy3RzL7BxMWrVuza6n4c7HekCpccDPV3x61+IApPic+dCM2F3ZZimqw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=JGBFC2N9csMUolDzs+X6YnC1EX6aR9uG0ApE8rUd7Ok=; b=lq7MUnZ32/t4tGBKHXOrA3UJCx
 XIbdc9eoTMQPrLyINBTh0jG7GnB3956MwxHAwlJ2llP8UOVLGofFuaaR0v3IgWjmEggGNsWgrydwE
 HM69vofEv+aMFs2TaqjeKvc9xHdgRkdDVAuY30GiKANKlML4vDEvl0P0OIiqYRhd0bQc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tUuUc-00080n-5O for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 06 Jan 2025 21:18:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id AAF5C5C41CA;
 Mon,  6 Jan 2025 21:17:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B983C4CED2;
 Mon,  6 Jan 2025 21:18:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1736198308;
 bh=R8cjwFD4KkgYdBXkteN978ebXomInOYBCFtzyQpNdiU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=gmTr9apRd/Xr1QBsyBE4q/yWG0J2R62jCvv08VLmeu2nTLPL8NxI612nl1Jc/xGxj
 CHAxCy9PoNraVP3dVeOB8+pAXI0gnGstNX9tM+Yr3Ie+IMt16ng1+422FNyaO4o5U8
 MhyUfucKcxa6PXANtygz6AvAwyoyPe54/cghMlg8Msu0K0nSh+fh1v/60pu4FADHzD
 qgn+yzXRgIzi6Ry0mQxixx1mPbD1BNt74JlFQBvZTJYJSCAzlsU0ediB7ArZn+dksJ
 BueXA3DDMgr9jGUFugu01/v2lIN5FzCoRdfoYAjmfU1Hf3HkR2ckceppeIa46HXe2Y
 8sLBfm820iqDA==
Date: Mon, 6 Jan 2025 21:18:26 +0000
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <Z3xIojPamtc5-dUd@google.com>
References: <20241220172136.1028811-1-chullee@google.com>
 <Z2ketmZiWmUVddpt@infradead.org> <Z2mWf-pghAlHYJ8o@google.com>
 <Z3eswqllW9LX2XMh@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Z3eswqllW9LX2XMh@infradead.org>
X-Headers-End: 1tUuUc-00080n-5O
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: Introduce linear search for dentries
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
From: Jaegeuk Kim via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 01/03, Christoph Hellwig wrote:
> On Mon, Dec 23, 2024 at 04:57:35PM +0000, Jaegeuk Kim wrote:
> > > That means you have really bad worst case behavior for negative lookups.
> > > I don' think this is in any way a good idea.
> > 
> > No surprise. Please check:
> > https://lore.kernel.org/lkml/Z1mzu4Eg6CPURra3@google.com/
> 
> Well, I think Linus finally gave in to revert the offending commit
> after the usual case insensitivity rants?

In any ways, we need a way to give the files back for customers, which is only
doable by the linear search, whether it sucks or not. :( 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
