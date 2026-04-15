Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4005EFA0C2B
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 15 Apr 2026 05:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=oO2sr78m+Cr3v2ptPuobVGFJTTlpNPtJDHGb2dCyjN0=; b=Al7JA5tPN0edHFB47+sZyiUfDQ
	ckCXb8kx1stqhA9ceReYYsW8LRVhivovXzc8xdG2o4WXP2hbjCBQrSCYCIcfEMYS7QMrR8bkfuJxc
	wfLOeTeBU0v/+9r5M+M7tNXKtdat8r+NKLxkDhaFp2LVmqrZLlcnuLExc2UoMElsfJvo=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wCsic-0000AL-Br;
	Wed, 15 Apr 2026 05:23:18 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wCsia-0000A6-JJ
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Apr 2026 05:23:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=nvBF+bv7bRGfiSZKt+QBZYsK39iswEWToCU9qQvZdWw=; b=dnIVf3HBykQUJ+3ffMvQp492yl
 4sHeGcAHmTZnToLq3QLXyAZjfi6U9K5VC6e4IKD0+JpYRQGJx99y9kEOMZkEixwa0S+us2Tis7n7c
 Qg8DFyw/zp1t5gjk0i9FKl/NJfT6g45MRlbM/yJ1AHG3EUG/OQaaAnLHOXvQgm6Avz9s=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nvBF+bv7bRGfiSZKt+QBZYsK39iswEWToCU9qQvZdWw=; b=fqPRXUhHc9CL0BR5/AEP+4+xzU
 iJOBT1OyrH18gvMoaz7R/Wjv2wUexA14OwofJNWR5rIQcMlcNGA6+oqO5nYoq4Auj2DlpYWT5I2rl
 Bfy4wjp48MbvO022xPTBr+gUNut1idITQwG8S2k2Z6SHBDQSo3lCImmcZeEb+awFuXUE=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wCsiZ-0003VM-TX for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 15 Apr 2026 05:23:16 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 9D94F68C4E; Wed, 15 Apr 2026 07:23:03 +0200 (CEST)
Date: Wed, 15 Apr 2026 07:23:03 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@redhat.com>
Message-ID: <20260415052303.GB26559@lst.de>
References: <20260409131404.1545834-1-aalbersh@kernel.org>
 <20260409131404.1545834-4-aalbersh@kernel.org>
 <20260414081301.GB11138@lst.de>
 <u3szxuhjrv7vyxwyrepuflwhzeucss7xj3cxj73mnpm5kal2da@jck24ig4oxxa>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <u3szxuhjrv7vyxwyrepuflwhzeucss7xj3cxj73mnpm5kal2da@jck24ig4oxxa>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wCsiZ-0003VM-TX
Subject: Re: [f2fs-dev] [PATCH v7 03/22] ovl: use core fsverity ensure info
 interface
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
Cc: fsverity@lists.linux.dev, ebiggers@kernel.org,
 Andrey Albershteyn <aalbersh@kernel.org>, djwong@kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
 Christoph Hellwig <hch@lst.de>, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Tue, Apr 14, 2026 at 03:53:36PM +0200, Andrey Albershteyn wrote:
> > > +	if (fsverity_active(inode))
> > > +		fsverity_ensure_verity_info(inode);
> > 
> > fsverity_ensure_verity_info already is a no-op for !fsverity_active,
> > so the check could be remove.
> 
> I don't think it is. For non-fsverity inodes it will try to call into
> descriptor reading callback and fail.

You're right, sorry for the noise.



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
