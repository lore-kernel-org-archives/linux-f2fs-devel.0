Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D0A2CD4F54
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 20 May 2026 12:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=P4xUkyZK5kSOvCd30bWcqaET/555vHQwHpuZK2mu18I=; b=YAmeXwKyC2J/sE2+stTj4/gq6a
	a6UVSGSrYjdN86cWqXfxbzgXZaF8B7W6bkOw0OFblmyfOV7yIal0u2iUgSJMC8cXaLpSZyDSVC8q1
	PXeHGh7ga4d9TSuVHk6JsuhU0X7ZfoZsfB2fKcPc+PBANxKGWnmzebRLpxelexTcy3tQ=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wPgSQ-0002Bw-2x;
	Wed, 20 May 2026 12:55:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <aalbersh@kernel.org>) id 1wPgS0-0002BX-DV
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 May 2026 12:55:04 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=G9nYrlVDfcGiD+sy6zZ3kUqNfgbrUZ/GdYElP70bpsQ=; b=Of4P0iSjzydlPzJ0UEcxn/6EAO
 3ExKhCwhtTokofChVGIl2co2GTHER/iU5d5RLgzgwchV8N8BOA60HcbpHhj8ZbLplF/hWx95eOIpK
 MuJPRMNUQVBFuxnbyRAkgBTCbKHSCap8kknUI64c2Ci+lMVDDDTCboQr7hQ9EGhfQW3k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=G9nYrlVDfcGiD+sy6zZ3kUqNfgbrUZ/GdYElP70bpsQ=; b=I4uoz6jrVlqQgxjfsxOQ25fUFL
 Rfk4Rzg16EBKHNtbxjGqDUtOmySDAmJpSTfcYkDumLSPfkbFHZrXchkLrqzQAvOW4Dgj1dCUcZ0DU
 bxVnRyj071PM6v82p9jlTAXk+9lmJENdfQWK74MdiBto0fKmCmEH71053a69iwbBv67E=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wPgRy-0007ps-Eg for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 20 May 2026 12:55:04 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1D76160120;
 Wed, 20 May 2026 12:54:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8869D1F00893;
 Wed, 20 May 2026 12:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779281691;
 bh=G9nYrlVDfcGiD+sy6zZ3kUqNfgbrUZ/GdYElP70bpsQ=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=RACqazUEHQ8Slq6nlyU0UVLPFHU9J+KWMeLWgJXnewYt51G9Yu+KqGk5XPRzgle0R
 1Tld1WNgPRYlPiVbWmEIeu5nbdAnc0XMvI+LKd+/Nb8pJwtQ3MoMxSoIcWiGGW2vlK
 vAyEkl3i3pL8pMRf66NQ5pdnJFe2MhaWn2wIWikcxxHp2QItZXa56chnP2UuimDhry
 SROL33rOMog40z3JdYwDRjsn7Z7R9rWshRJjwFHXeADUxK/4Ijy3Donq/y96Aa6xng
 w1YrB/jXYeYnThPwpt42idHL6lYYTnuw8d2rjvIaTx0kIVUd6Abq3+OUpaEe4v9oix
 NaAPDHsO5NUAg==
Date: Wed, 20 May 2026 14:54:47 +0200
To: linux-xfs@vger.kernel.org, fsverity@lists.linux.dev, 
 linux-fsdevel@vger.kernel.org, ebiggers@kernel.org, amir73il@gmail.com
Message-ID: <n67pde3prjxt2c2u2pvjytfw7uzwbeij2yljlrwh7fixcgnzhp@piqsltgpcc4v>
References: <20260520123722.405752-1-aalbersh@kernel.org>
 <20260520123722.405752-4-aalbersh@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260520123722.405752-4-aalbersh@kernel.org>
X-Headers-End: 1wPgRy-0007ps-Eg
Subject: Re: [f2fs-dev] [PATCH v10 03/22] ovl: use core fsverity ensure info
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
From: Andrey Albershteyn via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Andrey Albershteyn <aalbersh@kernel.org>
Cc: djwong@kernel.org, Amir Goldstein <amir73il@gmail.com>,
 linux-unionfs@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 linux-ext4@vger.kernel.org, hch@lst.de, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2026-05-20 14:37:01, Andrey Albershteyn wrote:
> fsverity now exposes fsverity_ensure_verity_info() which could be used
> instead of opening file to ensure that fsverity info is loaded and
> attached to inode.
> 
> Signed-off-by: Andrey Albershteyn <aalbersh@kernel.org>
> Acked-by: Amir Goldstein <amir73il@gmail.com>

Amir, Eric, this is the last patch missing a review. Could one of
you have a look at it. Not sure who should review this.

-- 
- Andrey


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
