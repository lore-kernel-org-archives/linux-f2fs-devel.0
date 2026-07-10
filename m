Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D8A2C43458
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2026 22:58:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=023wf5ebHXckWZx3j475stV7X2Ru9psCZmdS1wDOOek=; b=I+pi2Kd5BzmRXv2pXkK6zahdKH
	h8+tjtiKuv+9y1D3zYzfYqtxQHpTb8gCzORyjhZcHAHPAaM5BexaxX7kt+Pdr4JYyYHKLWicVdgCU
	3/pbEsJJrtOMtR7WH0sWwu8pQ/KTFBSBSu5MxQfzHig/3Eq9fL/bwp9ND8f8+UkWLY18=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wiKAr-0006Vk-RH;
	Fri, 10 Jul 2026 22:58:25 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <kbusch@kernel.org>) id 1wiKAr-0006Ve-2Q
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 22:58:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NkeORe+bO7UNqmqDFJw/AxpC9nvY1tbNbvdLo/yNIQE=; b=mo6xGhJtyV96OVGXbmPTxlDc16
 MWEYySgh18dFDBI2LOckxsvW+DtBNsOVmkeiBvDG6PeSyoG+d9TviK/7betTN01RV04nvOb5vEXhL
 aUQNRp9mOFkA78vdhtQ9gvBv4c30+RXrcnc3/QxpHgLMgAtR3bS8yac5udLGQdyCOxJg=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NkeORe+bO7UNqmqDFJw/AxpC9nvY1tbNbvdLo/yNIQE=; b=Y+82l3ouAGaDe8kiVJWTnIyagB
 YXYeqejlBnX6tLe8t6X7HB+sNBbPmmloOmYe1nJtZIRBejT5DLjof/DZIpcvJo3Hp0PEtgAkT7JA+
 /DAV0FuJjIuuuuL72QH3HMHovzERkCoKXeAdqcB+dSsP77aofxN3Gb8b77UwMHY1TpOI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wiKAq-0002Gw-Ja for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 22:58:25 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4CB4B43B4A;
 Fri, 10 Jul 2026 22:58:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8CCD1F000E9;
 Fri, 10 Jul 2026 22:58:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783724294;
 bh=NkeORe+bO7UNqmqDFJw/AxpC9nvY1tbNbvdLo/yNIQE=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=mQbZWvrMX0flq/z1MA3Kytgtdx6+fyTYu3dK/X7c4oh70mKhm8ZwVnKRtqylnCqv/
 GTDsEKO+4rGVvyaM2mD1j7XtNnoVYfg9A1AOmzG6sclc+zG56GXVsqzxwRSOtvElVu
 um63FKHXWR3AmeCcw/Yg+9uwD1cWn19jV+QkE0c/Jb38Grx3fOYKsz5qarVCVc0AqL
 9qYipa2T4SbgN4sJp+jr6MSgFwVJ4Qe6zclXuIrbIum7ByL4E36JBYGIEEtdqfat/J
 gjmy1hI2SlX0c3whMXkKadmd4vp3erA/l0Z30LVFBF2+NYTlrMfcq5tegUMtBMSvng
 L9Zd8PjyE7LuA==
Date: Fri, 10 Jul 2026 16:58:12 -0600
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <alF5BHEZ5czyJWaY@kbusch-mbp>
References: <20260710210646.3576365-1-kbusch@meta.com>
 <20260710215328.GE1911@quark>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260710215328.GE1911@quark>
X-Headers-End: 1wiKAq-0002Gw-Ja
Subject: Re: [f2fs-dev] [PATCHv2 0/5] direct-io file extended attributes
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
From: Keith Busch via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Keith Busch <kbusch@kernel.org>
Cc: axboe@kernel.dk, linux-xfs@vger.kernel.org, brauner@kernel.org,
 aalbersh@kernel.org, Keith Busch <kbusch@meta.com>, cem@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-block@vger.kernel.org,
 tytso@mit.edu, jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org, jack@suse.cz,
 linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Fri, Jul 10, 2026 at 05:53:28PM -0400, Eric Biggers wrote:
> On Fri, Jul 10, 2026 at 02:06:41PM -0700, Keith Busch via Linux-f2fs-devel wrote:
> > From: Keith Busch <kbusch@kernel.org>
> > 
> > The attributes reported through statx are incomplete for applications to
> > fully know exactly how IO construction is valid or not. The statx call
> > can report minimum memory alignment and total granularity, but it
> > doesn't show the underlying gap boundary requirements or max segments
> > per granule.
> > 
> > This series adds the minimum to the extended file attributes through
> > file_getattr. I hear this is the preferred interface for reporting such
> > things over adding more fields to statx. In order to get everything
> > under a single syscall, some of the attributes are duplicated from
> > statx.
> 
> Okay, in v2 we at least now know that the existing statx UAPI was
> considered.  Could you give a specific real-world example (with the
> actual values of each parameter) where it's not sufficient?  Without
> that there isn't really any way to evaluate this proposal.

Yes, we can consider nvme. This protocol supports two different transfer
modes called PRP and SGL. PRP requires 4k aligned segments, though you
can have an arbitrary 4-byte aligned offset at the start. SGL on the
other hand allows completely arbitrary size and alignments for each
segment.

statx reports information sufficient to know that you can have dword
aligned page offsets for a virtually contiguous buffer, but it doesn't
report PRP's boundary gap requirement, so applications can't tell if the
file follows PRP or SGL rules for direct-io.

And if you have a device using SGL, statx doesn't report the max number
of sub-sector segments you can submit in a single command.

This series provides both limits so user space has the complete picture.

A typical nvme that supports only PRP has a DMA alignment of 4 bytes, a
dio offset alignment of 4k, and a virtual boundary of 4k.

If SGL were supported, there would be no virtual boundary gap, and max
segments is 256.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
