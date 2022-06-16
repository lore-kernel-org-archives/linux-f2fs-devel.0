Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5536C433EF
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 16 Jun 2022 06:29:55 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1o1j0r-00035G-2s; Thu, 16 Jun 2022 06:29:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2) (envelope-from
 <BATV+c9d26d7972d0db0217a7+6871+infradead.org+hch@bombadil.srs.infradead.org>)
 id 1o1j0p-00035A-Dw
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Jun 2022 06:29:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=COuN5Zz+YBR/xeVdeWv1MuY4NtQSVs4UMHwcz0WDnnQ=; b=apGRmQdrLc3bl9Mr3DsMeEpQJL
 Y5G41z0W9tLkAmjW9cgcu3knVp/y7yllPxOXSKRiZfUCyRrW8H+wbMv06y+CwFA38sPtvSfoaf9Zr
 HN1vLUyUveQfRovVdt43PtxvYyX6FOW4+r5h3vRopP+JE7i/DKcah9+6/hy2bzeqlEis=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=COuN5Zz+YBR/xeVdeWv1MuY4NtQSVs4UMHwcz0WDnnQ=; b=YRb36QpVh+IaGtXOGMz1Ysreob
 u9LNQJUU0Y/tL+cTBoy4LWAw2jwYUOe135R0nqO+eruEtuW5QhouoXvaxHBXa95bpT0bRZVXgUpx2
 nozx4WzmcZMOpjBxtjGzjEwPjg/4AfGdGK5e9aAlMbZUsg/lOkW/e7DjafLd8uNeMbag=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1o1j0o-0001jL-6Y
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 16 Jun 2022 06:29:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=COuN5Zz+YBR/xeVdeWv1MuY4NtQSVs4UMHwcz0WDnnQ=; b=26COe9EvreWGEeNT1/sD1d3kfz
 6eiHSoJj3HJNczxIgN6ZNyHhGyF8lkqwkIOL2rgXq98uxDdUx8uC3Lu2IAjIfP6R/f0aliM5EVC6O
 1IhASH35qFwNzseZJ4XUFc3+jdZJ4c7Xluvv7sbbyUQTCbN3yrpBR/WmIvNi7io2ncbPNVRlOnIDy
 hqQ2OPazzRsUwaxn27aCXA9ZVEcHgflQQLkk46TasGiAi8tRAQZfnChJgkw8OGb0eXj325Mwkt6LL
 e0wbU4YbmLMbwRPuPBtRocrTHAynRb7PqFxnUF7o6IDlLRxUJhNefflB5q17jn1tsA4Npc8hfXRTy
 ddSAS+0w==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red
 Hat Linux)) id 1o1j0i-000jIM-EX; Thu, 16 Jun 2022 06:29:44 +0000
Date: Wed, 15 Jun 2022 23:29:44 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Eric Biggers <ebiggers@kernel.org>
Message-ID: <YqrN2J6r4Z+BIN+o@infradead.org>
References: <20220518235011.153058-1-ebiggers@kernel.org>
 <20220518235011.153058-2-ebiggers@kernel.org>
 <YobNXbYnhBiqniTH@magnolia>
 <20220520032739.GB1098723@dread.disaster.area>
 <YqgbuDbdH2OLcbC7@sol.localdomain> <YqnapOLvHDmX/3py@infradead.org>
 <YqpzqZQgu0Zz+vW1@sol.localdomain> <YqrIlVtI85zF9qyO@infradead.org>
 <YqrLdORPM5qm9PC0@sol.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YqrLdORPM5qm9PC0@sol.localdomain>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Headers-End: 1o1j0o-0001jL-6Y
Subject: Re: [f2fs-dev] [RFC PATCH v2 1/7] statx: add I/O alignment
 information
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
Cc: linux-xfs@vger.kernel.org, "Darrick J. Wong" <djwong@kernel.org>,
 Dave Chinner <david@fromorbit.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Christoph Hellwig <hch@infradead.org>,
 Keith Busch <kbusch@kernel.org>, linux-fscrypt@vger.kernel.org,
 linux-block@vger.kernel.org, linux-api@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Wed, Jun 15, 2022 at 11:19:32PM -0700, Eric Biggers wrote:
> Yes I know that.  The issue is that the inode that statx() is operating on is
> the device node, so *all* the other statx fields come from that inode.  Size,
> nlink, uid, gid, mode, timestamps (including btime if the filesystem supports
> it), inode number, device number of the containing filesystem, mount ID, etc.
> If we were to randomly grab one field from the underlying block device instead,
> that would be inconsistent with everything else.

At least on XFS we have a magic hardcoded st_blksize for block devices,
but it seems like the generic doesn't do that.

But I'm really much more worried about an inconsistency where we get
usefull information or some special files rather than where we acquire
this information from.  So I think going to the block device inode, and
also going to it for stx_blksize is the right thing as it actually
makes the interface useful.  We just need a good helper that all
getattr implementations can use to be consistent and/or override these
fields after the call to ->getattr.


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
