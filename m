Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB214C982FF
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v7J8BIH+omFnK5ZQaKYFMBiOiXPjDRh6P3tYOXnzaOA=; b=OIrd8GQ75gL9dXmJi+PFConjTQ
	sWSfyqa4qjbGcygLbljRFQO1Z4zy7/76n2JkT+pZH1xnw/E5XyalDl+3r4cWiZtS5EzStDgLAboe3
	yI4MqvOnUq/77KnLZEmYrttzOzw9Ax1fPwOV6BIsP3mxF9vxpMoZAP4JTykew2/ElgEI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x90Nk-00013p-Kz;
	Tue, 22 Sep 2026 13:18:00 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1x90Ni-00013j-Fn
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:17:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=y0TF6dZ0xnYCANhgcMjOAc6HW+EA3FufymkDE0+X2Zs=; b=K5OfIIVfEMNIqxaY4V4cclaUPr
 eZhVLRuhMMcAcHy6azmhhoPpVGfi+ftxdijvLhVyYMnenbzOELPUDm+BN01+X8Q5/x4KwdUv3ouaA
 Fp+PwRGGNipMA6IqCwb7Z+AYMvxlZRfs8L+X4jdyq3LOPt5YLNnq1wNnasHwJGRqaC64=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=y0TF6dZ0xnYCANhgcMjOAc6HW+EA3FufymkDE0+X2Zs=; b=g4fOXTzi1N8a5h3EOhDahrVcMF
 4tuc2mnTx6E8G0hy0t1HVLng/BD5Yd6r9GCXAuXgZWJAQtgu/LCKOxlOucA5zvkwO/6LVDinykVbc
 0aXPW8e3M5igBMd01PKDgX6NlhWQLWuIZb+qEU/uqTuT3lk/pcsBlCcSVO1QnijgEdmM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x90Ni-0000o2-3I for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Sep 2026 13:17:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C0E3B432ED;
 Tue, 22 Sep 2026 13:17:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 853CA1F000FF;
 Tue, 22 Sep 2026 13:17:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790083072;
 bh=y0TF6dZ0xnYCANhgcMjOAc6HW+EA3FufymkDE0+X2Zs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=LItG2pLh3KPQ/p+d7a4wOA0boFie1ob3IDRcXzH6ioMezFCCOsUG1gZ2on/oWtkvx
 83UOFHHkfLa0FTNOImhUjAA3igZOKxLk/c/ck25MUmiuHXiO9MFD1HMM3X7EcFrK5M
 +aUQnNpphmiRk4rFyDPfioCQs43V7E75XDmS4NMs7o5Ny9anolntzasNASolpxsnhm
 Mm2REZ4Ku0cmd2J6oxh8TYoQDZTxDS4QQjcc+9sgiXKzvtg9eXqvFdHz6BujDSMxDx
 n01AhHf9uZHkgyfNC5pBpylVv/XqCfhE8NQwE7I47cbCt2NJuLKCQXzb8xE8MoR0av
 b2yz04pVuWGhw==
Date: Tue, 22 Sep 2026 15:17:46 +0200
To: Christoph Hellwig <hch@infradead.org>
Message-ID: <arJ_y1LCSrYFgOeh@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
References: <20260918111539.1003439-1-aalbersh@kernel.org>
 <20260918111539.1003439-13-aalbersh@kernel.org>
 <arIrtgZ3-9zNuru_@infradead.org>
 <arJFUV3WDkY6zmfD@aalbersh-thinkpadx1carbongen13.rmtcz.csb>
 <arJ1KAvP-4fWVvzW@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <arJ1KAvP-4fWVvzW@infradead.org>
X-Headers-End: 1x90Ni-0000o2-3I
Subject: Re: [f2fs-dev] [PATCH v16 12/21] xfs: use read ioend for fsverity
 data verification
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: fsverity@lists.linux.dev, linux-xfs@vger.kernel.org, djwong@kernel.org,
 Andrey Albershteyn <aalbersh@redhat.com>, david@fromorbit.com,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ebiggers@kernel.org, linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Carlos Maiolino <cem@kernel.org>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-09-22 05:31:36, Christoph Hellwig wrote:
> On Tue, Sep 22, 2026 at 11:13:57AM +0200, Andrey Albershteyn wrote:
> > > And I think you always need to do the offload because fsverity can
> > > synchronously read metadata.
> > > 
> > 
> > hmmm not sure what case you see here.
> > 
> > Without integrity:
> > For data reads we get here. Here, while verifing data page, fsverity
> > requests reads of merkle tree pages which WILL NOT go through this
> > path as no read completion is done for them.
> > 
> > With integrity:
> > For data reads we get here. Here, while verifing data page, fsverity
> > requests reads of merkle tree pages which WILL go through this
> > path as they need integrity verification on the read completion.
> > Therefore, to use this workqueue for merkle tree pages integrity
> > verification we offload data block verification to fsverity
> > workqueue.
> 
> Yes, but we want to be able to use the bio defer path for other
> things including iomap error handling (I'm about to send a series
> for that).  So please always make fsverity do it's thing so that
> we don't add really complicated dependency chains.

ah ok, I see, I will change that

-- 
- Andrey


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
