Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63963C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 23:39:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=56vmAvzb90NHJD5vX78CYj5i6wZjKCwT2Kxm0T1oeFQ=; b=O851IhxtMBy+H+rhYaFQdgUegV
	kOveGLVltMEifPiwI/Hc/tl3NHRBp+d9KGNl2Xo77amr8aSpZa9UbI7oUZ8W3OwPCf7jgBbyv19G0
	RLBF0W7Fjo3avdQPfqtT2UUe9svsn5xfhCNU7NM4kQpMv+iQIepAYfEhWBn3IlMsXTHc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wr2FS-0003ur-7W;
	Mon, 03 Aug 2026 23:39:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1wr2FK-0003u9-Ln
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 23:39:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ekwf9vCog9sckv/lAiz0aOTW4OCONGVONpGSEWR8L+0=; b=N0sw+8ebQOVeL4YRMfSxgmqOUd
 HTnRBHjRCO5jKP/C8yjYI5F3hAMmoUNw4HXwGiALS3jXJ4dEVCeLNL3C7DJPyUdjotoGNR4EKV+4F
 whZAfeNSHRQMtpG4dUJ8SrvijnJtJzOQCu9u+DO74m6DHxBa64VEKR1mcdQlM1i+6Osw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ekwf9vCog9sckv/lAiz0aOTW4OCONGVONpGSEWR8L+0=; b=hXJak83zOHElui5dxeKioERjSl
 Ksfvt14Gf98ha+NgMo01MU/1nmi+ZfE4Lct5JTxknbD60Tmn0lt9EHpxXNmVG4NxRH4cweQsXqj8N
 GYETZxK6nTShabR3zsxoB8Ee5MambgvL8to+HOKf1RDftM9vQ0PYvsRmqJzNeVvIaOvk=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wr2FK-00017N-SM for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 23:39:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7D38C436DE;
 Mon,  3 Aug 2026 23:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B8AD1F000E9;
 Mon,  3 Aug 2026 23:38:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785800337;
 bh=ekwf9vCog9sckv/lAiz0aOTW4OCONGVONpGSEWR8L+0=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=bVk8VaCZkQ4OLen9UOBp7BqvfWgTpFWsIyoKAK/0p/IvwVqEjfSqq493Js9GBrFLa
 E/QYRz5wrV43Euo/LRZHJTe95p7vJ6gRxBfaPwFsPT/HndELqmAmnOb8pGUctbw78F
 3NoNKtSU9Zv5Zp3ZR7RGbve8KmQUtmapfwnvxIUK5F99MvPJeHe0ZZ3cZa1SyWuNcH
 Vjij4M8mG+3bV0ivXgxEKJttX/zbj3NR7WacgRDXpi6m87FRJ8UV66mkT9086Svfa7
 HhL+/4XCXQwk5CiPEiU3XXi8y1o1tMw4DoHkAagyInr1m6QynDdEr42+gaKed3b8i9
 ACQQ4374fAhLA==
Date: Mon, 3 Aug 2026 23:38:55 +0000
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Message-ID: <anEmjytbni9He124@google.com>
References: <20260729002827.303608-1-zhaonanzhe@xiaomi.com>
 <f1fece0c-6951-4c69-a681-344acfe1f62b@kernel.org>
 <20260731085215.863900-1-zhaonanzhe@xiaomi.com>
 <20260731090714.876795-1-zhaonanzhe@xiaomi.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20260731090714.876795-1-zhaonanzhe@xiaomi.com>
X-Headers-End: 1wr2FK-00017N-SM
Subject: Re: [f2fs-dev] [DISCUSSION] f2fs: compatibility between compressed
 files and large folios
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
Cc: baohua@kernel.org, lipengfei28@xiaomi.com, zhangbo56@xiaomi.com,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 07/31, Nanzhe Zhao via Linux-f2fs-devel wrote:
> The quote part of last email to reply is:
> 
> > Can we call truncate_inode_pages() after mapping_set_folio_order_range()? something
> > like this:
> >
> >                 filemap_invalidate_lock
> >
> >                 mapping_set_folio_order_range(, 0, 0)
> 
> Thanks,
> 
> Nanzhe

From the previous experience, this won't work, as you mentioned it's not allowed
to change the order on the fly. Should set the order in f2fs_iget() only, but
it'd be better to keep supporting compression. :)

> 
> 
> 
> _______________________________________________
> Linux-f2fs-devel mailing list
> Linux-f2fs-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
