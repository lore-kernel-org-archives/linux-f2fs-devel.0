Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45826C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  4 Aug 2026 17:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:In-Reply-To:MIME-Version:References:Message-ID:To:From:Date:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k0YV2BR2/Z3pWlzDnLu3zkU3sNYb55g99XlMvRxMt78=; b=EtRKmrV/y/5IZ+5Wp3a3aUpAyE
	gHnFd0ibCQGO14hPRQhBRmrSnEa0jPekneysrffPGf4o+Yi8hJG0BoTKHWMsGHQA7KqsrFsarQnoX
	1D6rbvDO1gYrvHZK2JkWeKYgbts8z43QnCQj06aB8/gVPDB/PnsJERKglUcB33v1eoxY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wrJ7W-0006Pt-Ec;
	Tue, 04 Aug 2026 17:40:03 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <hch@lst.de>) id 1wrJ7U-0006Pc-ON
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 17:40:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=uRWuvIdnw5Xs4qO6QIZ6DtEuYHVb045l8RzlJ4qk1vI=; b=FNYv+qZLq733MXC5t8F95v6zfo
 cUoCdkkt1yK63KoRrYVwZ9CL0v+oti5Doc2E0T8mVJq4leTY2el+Pm0I5ET/2L2MlMsKuhUlH+ee0
 L4m8WIeaTscXmOsuEXPqGvR1mdroZe7t2mWemPwLef7j0QDsf592e+AepWXkZSh3gd+A=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=uRWuvIdnw5Xs4qO6QIZ6DtEuYHVb045l8RzlJ4qk1vI=; b=GKcuYQTHk+miJNWMvAnixadReB
 VDAVDXbTmGTG7wLM5egn/zAqDHqMMa3W7cRrXWyjQEwKXzfImtlwohIuvTqGmuKEMzy8fU/31aBQH
 XFnJ+j/fcndg3zrxTQrWeLnVHpW/QFPYx3w7XaGYl2LrM42XCM8xUnAIVx2JVxc4Vaa0=;
Received: from verein.lst.de ([213.95.11.211])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wrJ7Q-0000kL-KA for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 04 Aug 2026 17:40:02 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 3CE6E68C4E; Tue,  4 Aug 2026 19:39:50 +0200 (CEST)
Date: Tue, 4 Aug 2026 19:39:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andrey Albershteyn <aalbersh@kernel.org>
Message-ID: <20260804173950.GA14046@lst.de>
References: <20260803200820.393203-1-aalbersh@kernel.org>
 <20260803200820.393203-8-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260803200820.393203-8-aalbersh@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Headers-End: 1wrJ7Q-0000kL-KA
Subject: Re: [f2fs-dev] [PATCH v14 07/21] fsverity: hoist statx reporting of
 fs-verity flag
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
 stable@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-ext4@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Mon, Aug 03, 2026 at 10:07:57PM +0200, Andrey Albershteyn wrote:
> All filesystems, supporting fsverity, report this status by checking
> inode flag. Also, BTRFS was missing stat->attributes_mask, which is
> fixed now.

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
