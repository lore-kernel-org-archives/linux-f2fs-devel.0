Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E451CD3427
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  7 May 2026 05:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Va1DKnKzoskxeUtfHEV28uPguuwxwrlNoqel3uBMwxo=; b=UUygiROsQHlODWIwK1ybF6cc3s
	iGUHyf7oqSQ4jMgacwjXafFos6prsxQYQCCr1wqtyBhODvYVQYY1agWyIWsCPtRs8Cd4bfzVF6ldA
	bnAt6ZEGogm5RT+mbqsIuwpGAb3MLQQAoDbWc7OZkoVihA/U9Y13nvQz7BOWZgcDRT3E=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wKrex-0002jS-AS;
	Thu, 07 May 2026 05:52:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wKreu-0002jL-V6
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 May 2026 05:52:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=wV1uJgpRPYCwxgRoG0diYUMFIVQ7HMdQM3+P8qY3UO4=; b=L8tFj2BkNgKXQ+U1+jcQnBF2bz
 AEr2RaWEppEk6ZQiTpjwdQEBe8roAp21l4gvEAKefo3C8bduYgI6FPm1k65iHI/2lJfEifrL50jzW
 iTB44A+NZHEh6G+h1VgAMRWAaTO8llgN6qI0zPQPnc1rPQO3aoHHj9YQ9C7uMbyXUxSc=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=wV1uJgpRPYCwxgRoG0diYUMFIVQ7HMdQM3+P8qY3UO4=; b=FM+8acbEzZfAy0vFP+ocG9TMG2
 ztS4L+lQlZvv5U82gJhQTBVTbnxWMCM9dbUPiG9guupZkvugLYXfrLCRxunqb1WelJI74+fokA3gK
 g0+/9rg7NDlBCKXqY45WTpgeWwZi7/mPeSe/QVhIzSflkvesj1Pz7FiJk6cdPzZUg+NQ=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wKrer-0000KT-Ri for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 07 May 2026 05:52:26 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 6C60468BEB; Thu,  7 May 2026 07:52:17 +0200 (CEST)
Date: Thu, 7 May 2026 07:52:17 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260507055217.GA19888@lst.de>
References: <20260428083332.768693-1-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260428083332.768693-1-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wKrer-0000KT-Ri
Subject: Re: [f2fs-dev] [PATCH v9 00/22] fs-verity support for XFS with post
 EOF merkle tree
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org, djwong@kernel.org,
 david@fromorbit.com, linux-unionfs@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org, hch@lst.de,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Apr 28, 2026 at 10:33:06AM +0200, Andrey Albershteyn wrote:
> This series based on v7.0 with Christoph's read ioends patchset [1].

That's not a good baseline.  We'll need it on the -rc that has everything
from the current merge window at least.  It might also interact with
the fsverity fix that just went in.

This might also be time to come up with a merge plan to figure out through
what tree(s) to merge it as there don't seem to be any maintainer
objections.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
