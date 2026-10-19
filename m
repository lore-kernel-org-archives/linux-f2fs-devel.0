Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77021CCF2D3
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 19 Oct 2026 11:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=a+5+pgG+Cf6sIiVTuCvEZSsfuG4wTD3F5atxqqfsmXY=; b=D5Cqs5TtzbS4acO7zIefYks7a9
	TwRELwgzOFTzT5hT3jQSoiy0zKQaCS9Fli/YaaYFVSM5IZejzBhUV7lbx2c8tOnWFgc5uYHnFPqgH
	4sh38PFL07yetjoSbCbAHMzwWNwj++qwNxcaf8EJiBl/9cvII7MGIBKKez6QSFaMMUgE=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xIlFI-0003e5-OF;
	Mon, 19 Oct 2026 11:09:37 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1xIlFH-0003dw-Rz
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 11:09:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=/HHsrhMZL6uF7oMdrWjCL4GY6W29/wq0pzaKjLWhw5Q=; b=bjEpiDBLVAufl2W9XWtvDOVaSD
 AWVnmlCyxliJov4fmsqmrZOyO6p1uBfuCGWf6WwMOswji0FO+ENEqNOV6Rv82U6RHeuL4+5fdmNmK
 5BcogeQ9oMztk03yp4G5JcTQQ0YJd2rZXRQzmwxjwpIRCSdfdnS6w2YfS/hTNUQUZK90=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=/HHsrhMZL6uF7oMdrWjCL4GY6W29/wq0pzaKjLWhw5Q=; b=bJ43aHLT95yS71waN1vgcTNRcs
 e6koKhdspV7A/exGvM2/yqgYoSHVSPVAI1YWFwYUK8p2IcEStBM2POlADyF0I/jcwzQ7cL9Z6//Ls
 1NY4X7U09EcPFHuC0+3Z5Jp0K32HObVXI6cizsG+BVcGkwDU1vpeGen5hKbJj8cX2pnA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xIlFH-0007sB-8M for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 19 Oct 2026 11:09:36 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E98944530;
 Mon, 19 Oct 2026 11:09:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 998981F000C4;
 Mon, 19 Oct 2026 11:09:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792408169;
 bh=/HHsrhMZL6uF7oMdrWjCL4GY6W29/wq0pzaKjLWhw5Q=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=HLO4yck0sfA1Dc2Axu9Qpd+8qknBvutqF+8W81beeHiIgS7sZoI4o/S4MqCQ6oBvT
 we8+Xop+9IE7HnyeePgzmdXeK+9kJYZEdpQfOlX66FYfV/sL/ExV1mGlEXS1uJ6kw/
 hn5x58AI9hhnOeKPtHz+NlLdFJDvoFkpYqaL/2XsLTKcKZ8WDmgXoE/swn5YeifWUP
 /A7akVF+wbGAJ7GA0xcZgI2SgKpJclInnxl1zn/eHjBmEo2ZroSR5IJnxEg+j1LN6V
 k8ksyqoFygDGUze75YA1yx0zxNtObZ/rQI2o1BLzfzTfhepRJN34Y+WFFj5f9SAw7O
 KrzyfXsLyaaVQ==
Message-ID: <d1236f9a-b5ec-434d-9293-54cf9f6364ef@kernel.org>
Date: Mon, 19 Oct 2026 19:09:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Seongjae Jeong <jsjlee1020@gmail.com>, jaegeuk@kernel.org
References: <20261014112629.59861-1-jsjlee1020@gmail.com>
Content-Language: en-US
In-Reply-To: <20261014112629.59861-1-jsjlee1020@gmail.com>
X-Headers-End: 1xIlFH-0007sB-8M
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix submit accounting for IPU writeback
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 10/14/26 19:26, Seongjae Jeong wrote:
> f2fs_write_cache_pages() uses the submitted count, which is set to
> fio.submitted in f2fs_write_single_data_page(), to update nwritten
> and decrement wbc->nr_to_write.
> 
> In the OPU path, f2fs_submit_page_write() sets fio->submitted to 1.
> However, in the IPU path, fio->submitted is never set and remains zero.
> As a result, successful IPU writes are not accounted for.
> This can cause asynchronous writeback to continue beyond its budget.
> 
> Set fio->submitted in f2fs_inplace_write_data() after a page is
> successfully merged into a bio or submitted, so that successful
> IPU writes are included in the writeback accounting.
> 

Missing Fixes and Cc stable line?

> Signed-off-by: Seongjae Jeong <jsjlee1020@gmail.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
