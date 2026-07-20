Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18548C4451B
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 20 Jul 2026 09:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HkO1Ymmb33dJhHKSeqnHCtmAa8ACBDbLNGwXmphujCI=; b=AnyRQUqAN9nBek41KhEfbdEiBj
	qdJoXwBjsd/pTbUOdPnrTNJ7X6PdmJg+OttGP9812z4QP9sMUnwzzPr7BqWqNX2+zwhz7B8iDuOD9
	mZGlOMeKe3x3f+l+Yfm22nV7knkoefYvE31bN0x8HPDw5xdS+HFHCxDBW3LLWXSjgv9A=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wlkDu-0007MA-Pp;
	Mon, 20 Jul 2026 09:23:43 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95) (envelope-from
 <BATV+e0905d82d93001400e43+8366+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1wlkDs-0007M2-Dr for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:23:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=U50y68bE6mM95Q76lwCVRdyL71et9l/CyD0ewFiY1mc=; b=a2f5w3PUxzvUh+uOrPAaFyoxP5
 6ki2eGKTSi0bR5C8QrHVqKZeFp5KHtM6/hWtEtRmfBSybdSvv2CX1+5LPz/r3lDOWAFHakCCPkDPq
 LfR3J7jo92MVer9NrYM28PpiNENOLFJLq8nQN2oQ7C49jEf9gulLczjJ9WJRHso5kofo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=U50y68bE6mM95Q76lwCVRdyL71et9l/CyD0ewFiY1mc=; b=VC28e4jdhROzMjj5dUnVrFSV2L
 OGOU9I9eVQrngFOcUy1ez0RlW91PM4KqbDWaB4l7q/0rv3/oHAtlzFd4CZVewqF21d70IClw/CAqN
 szTBzK1uhTkmIXfWQWELuBrQH3Fxo3dLKqJvPy56wRTHRu5sQBra7TTmA3PLoXzUGcDA=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wlkDr-0000hs-Nv for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 20 Jul 2026 09:23:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=U50y68bE6mM95Q76lwCVRdyL71et9l/CyD0ewFiY1mc=; b=BZS9VwBq52Cxtlrie89Dr4SDRI
 gNmP+FzpbP5IDQpgjKZG9X1lVWwjuVucJ1sJhHDkplpUWll2v0srZ7UPp24MFl4H8nGXnSj1XtyaI
 tLJmZy+uj97j10UU4zNvtAR3TmDzvFHWEqSgV6VJ8B3ClavoVg0/+AosngfoAW0+t31tYlj/zqRMi
 0V2HiIfElwiObGeJuZzZm8HujShHfKJH0QKXq+XZfN212l63ZNKSeuCS7PZndpJInclZqbmmoSS+D
 ZKAF5EP6E1mcCN/Xh9d9p/MO6TPFSXP6E39gFje/pq1Ni/XM4YsZCNpKswl4Y6DQk6TUZbDQwkXpn
 5XzOO3NA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red
 Hat Linux)) id 1wlkDm-00000006IPw-0Ftn;
 Mon, 20 Jul 2026 09:23:34 +0000
Date: Mon, 20 Jul 2026 02:23:34 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <al3pFrj8eAV0MSSO@infradead.org>
References: <20260719055602.78828-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260719055602.78828-1-ebiggers@kernel.org>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1wlkDr-0000hs-Nv
Subject: Re: [f2fs-dev] [PATCH] fscrypt: Avoid dynamic allocation in
 fscrypt_get_devices()
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
Cc: linux-fsdevel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Sat, Jul 18, 2026 at 10:56:02PM -0700, Eric Biggers wrote:
> For now, let's fix this in the straightforward and easily-backportable
> way by switching to an on-stack array.  Currently the fscrypt
> multi-device functionality is used only by f2fs, which has a hardcoded
> limit of 8 block devices.  An on-stack array works fine for that.

Looks fine as a quick fix:

Reviewed-by: Christoph Hellwig <hch@lst.de>

> (Of course, this solution won't scale up to large number of block
> devices.  For that we'd need a different solution, like moving the block
> device iteration into the filesystem.

I'd love to see this happen rather sooner than later, as that's a much
better architecture.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
