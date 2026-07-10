Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 274FBC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2026 21:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6yavVtZDOiNy4fj56I7IhSGe0rCcd0V/4tJW0pdliDk=; b=eFp4OT7ySqtgz68G4+Nq9HDE3l
	ZY70h5OcaKQGrvoEfhQV3TaGkL9ZXldXq0Ovnk7Nh/cwfARCUwxSqBV9AI4E3a8b1TPHC5RlkrJPJ
	sYPOyoX2cwcQY5jxSzS60pciy7OS+q0NUYNO6UGtwiDUa2sBlMxB58Aaf5DyGvTz4XHg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wiIj3-0007RD-2r;
	Fri, 10 Jul 2026 21:25:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <ebiggers@kernel.org>) id 1wiIj2-0007R6-Ja
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 21:25:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nCRZEwnwc3DCYrAKyBomPnUOyKlwf74P8ZoQ5QDerbM=; b=hdQAFl+a3tzXGt4Tss4me6J1aP
 bJGm9t+UH/rnomm9xc47Y4BbHt8i6TxL627jKeITGahiC46zvQL5LNf6jQZmSSPTTFgKyEcH5ZuaN
 rAoWV6Dv6BmS797AG+KA3y+73Kuq1nqJUDJhlJ/HxWBzNGkWuyVlmgwr8zpB+unuDH/s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nCRZEwnwc3DCYrAKyBomPnUOyKlwf74P8ZoQ5QDerbM=; b=ixGGago9iGbQwQ613/99fWK/92
 z7YrYhuw5W9EdkfKG1l4foRV5nsilW0udiy2t1CXIMD+s9kDBVZHSpFN3huaxR04O7jMQMerG+LNu
 ETE6FsxhE3zn04HHEu8bRRGrQLxoob4ZGR5b6VggQVfXRla3XETvXtti9dVSKXyPhUPw=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wiIj1-0007J3-TS for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 21:25:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4B9A160052;
 Fri, 10 Jul 2026 21:25:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B7A41F000E9;
 Fri, 10 Jul 2026 21:25:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783718730;
 bh=nCRZEwnwc3DCYrAKyBomPnUOyKlwf74P8ZoQ5QDerbM=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=QdZNgYnLuX3WmPcbk86j+RBX44eJhGMVjnWYdZ5cAoVk6WD7e8+wPrg7wEgt1JTvf
 iiexRDAXT14IurobE+Cr5WSgDwEpknDyr98j59zha0vbrIRSXN+FdHMYSdjztn/K+t
 xoa2gst+efnITZbHQ+u0elFsOy4XBiX97Aof01wuFSB3PPp3m+y6v5sUSTYFw/uHfk
 fjHvGeNYG5LFgN1ob8iKcoDu8S6lDmzgMwTBkY7zeEo+6i6yMq+aSwRcltYfyY142Z
 6xYcevonlaN/nI27bKg2vZvjDVIl5q9VTFZ18beZjWmGLBSDK7lBFLeAz4KaY09S5x
 TqScozRHKbCeA==
Date: Fri, 10 Jul 2026 17:25:27 -0400
To: Keith Busch <kbusch@meta.com>
Message-ID: <20260710212527.GB1911@quark>
References: <20260708011843.1036846-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260708011843.1036846-1-kbusch@meta.com>
X-Headers-End: 1wiIj1-0007J3-TS
Subject: Re: [f2fs-dev] [PATCH] fs: report direct io constraints through
 file_getattr
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
Cc: axboe@kernel.dk, linux-xfs@vger.kernel.org, brauner@kernel.org,
 aalbersh@kernel.org, cem@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-block@vger.kernel.org, Keith Busch <kbusch@kernel.org>, tytso@mit.edu,
 jaegeuk@kernel.org, linux-fsdevel@vger.kernel.org, jack@suse.cz,
 linux-ext4@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Jul 07, 2026 at 06:18:43PM -0700, Keith Busch via Linux-f2fs-devel wrote:
> From: Keith Busch <kbusch@kernel.org>
> 
> Memory alignment constraints for direct io can vary depending on the
> backing storage hardware. Provide support through file_getattr to report
> the attributes necessary for applications to know how to construct valid
> read and write requests.
> 
> Suggested-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Keith Busch <kbusch@kernel.org>

This seems to be reinventing STATX_DIOALIGN and STATX_DIO_READ_ALIGN.
Any reason for this?

- Eric


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
