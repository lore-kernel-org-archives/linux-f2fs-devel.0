Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B13D3F433CD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Apr 2026 22:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=C7nPDeGBsy0VRcJtnPUT1inZ0xrnBamNWu/rCniZ0ro=; b=iCUeiNQ6hwKu1rTm0paee9jGZs
	4PJfaRXcdpe3xtyBT3lV7whgw9GynfwSdeqA9GyppIPNSeQmYFDyuissfy0MfaNL1BtALfUXOyYs9
	brpL+Fe0mt7eXIY6krWMV1wQUuLI1hcO0n15OeIU8lQN/BrNHgsisTlqCX/92IPFrqdw=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wD8Jk-0006YX-7M;
	Wed, 15 Apr 2026 22:02:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wD8Ji-0006YK-Rl
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Apr 2026 22:02:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=OzqPrVDLfuLoABCJCVUbre9ZmRQQgnVkvmFiEAl6tSg=; b=cpSczxPVbHkiGm+bQP661v2X0g
 M9ac4ROXYVQcozEJI9poz5LR3oHLvJ6fTc6HjpCcXGQILoXeHXSiSJJU6RQ/bswdeOA8Wanq7Z06t
 Dz6nF5hf8ENw7+Pxkj+Kf4BiCBUvpfnhISNGLRgIWtOIoAITfcxiwyxqWPUgnJE3KBnw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=OzqPrVDLfuLoABCJCVUbre9ZmRQQgnVkvmFiEAl6tSg=; b=NICHYOzEwEqzhp0vcT23uRoS1d
 rJQDJHW93ve2y/lldNNReE2tOrt6CFfPD97bFFX0da8Za9dTj5bO3h3HrQ0ISdRXO35SmOD4nnFwm
 5qGqfuYUfaUZqySfjxD3x2Wio9CMY5eMhEPWnRzXYhM2q2+ap247Oks8LTM7t1JoVFDI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wD8Jj-0007IA-8x for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Apr 2026 22:02:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id E3BDF4171B;
 Wed, 15 Apr 2026 22:02:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 773D5C2BCB3;
 Wed, 15 Apr 2026 22:02:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1776290548;
 bh=eHdW8R6LaWTSjbq77BW1DvuiaGuL6ZDV4aigbLwLhpI=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=XoV9YXsYNN1CZkDb1byLNi8Jdbd5s38Km7seKFLW4DLj3vnRMIQOQsLhTidaONb7k
 h6lA5oaxu83UbcKwfOVzsb/k+YYXaI2es+iopGc2xVDzivpEy1IRExVTOUlPviLUKx
 LU2rshy6iMXQmvz2FxUOz5W4N6hUhSFRigxwqv7yr8ILO4n3QAJrU8uqLGDrGs4iyJ
 tN+j/zQ2h047VuVLzhzkpoaactyEXnC0jVAlS+WhivRekSM1mXKacK4qKEg5XZFmyQ
 +oJQIR8hkIg7IPb+BTQYL2/yLU/+owgjjQd15Si2Bo0xflVuMu1XWVbbL6Dh9dah18
 PD0KpqchWh6qg==
Date: Wed, 15 Apr 2026 22:02:26 +0000
To: Matthew Wilcox <willy@infradead.org>
Message-ID: <aeAK8mFxzgMOepmZ@google.com>
References: <20260409134538.3692605-1-jaegeuk@kernel.org>
 <adhPZxtbZxgU-37v@google.com> <ad30g9xMs9wNJhFb@infradead.org>
 <ad_AVHe7RMnGrGTb@google.com>
 <ad_HwhzlNPUEKQi6@casper.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <ad_HwhzlNPUEKQi6@casper.infradead.org>
X-Headers-End: 1wD8Jj-0007IA-8x
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: another way to set large folio by
 remembering inode number
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
Cc: linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
 Akilesh Kailash <akailash@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 04/15, Matthew Wilcox wrote:
> On Wed, Apr 15, 2026 at 04:44:04PM +0000, Jaegeuk Kim wrote:
> > On 04/14, Christoph Hellwig wrote:
> > > Please add the relevant mailing lists when adding new user interfaces.
> > > 
> > > And I'm not sure hacks working around the proper large folio
> > > implementation are something that should be merged upstream.
> > 
> > Cc'ed linux-api and linux-fsdevel onto the patch thread with a proposal that
> > I'm not sure it's acceptable or not. 
> 
> You haven't sent a proposal.  This is a reply to a reply to a reply of a
> patch.  There's no justification for why f2fs is so special that it
> needs this.  What the hell is going on?  You know this is not the way to
> get code merged into Linux.

I added two ideas in that email. Have you even tried to understand?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
