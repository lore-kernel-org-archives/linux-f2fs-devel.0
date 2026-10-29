Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53B92606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=aQ6WaeGJ;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=mrRY4LhN;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=R2i0n5eZ;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oZjQMdYe
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=me6h7jl2rzcBbNb8sT8XDPC3fXG/WdHvkwF80ZcUo2w=; b=aQ6WaeGJC21zgr
	kCC7hL3lBMyXwqFF7ePtEDCJ4PAw4xK7qlDTNrYD9cunfStNemhthTVzo8TZVLNygSV7I43SNmXoQ
	oOuNe8NuleBxKTR2A1V/Sp1omJ90S9ueMDu6E1nUMeSz2N4UEvKL6w9skmw1aXlFt/rgM4uIf5Tkx
	Guc=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMF0B-000000004kr-09Er;
	Thu, 29 Oct 2026 01:32:23 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xMF09-000000004kj-0XPG
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:32:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qzwd3lqgQUpUIDalWsKHTl4VuC3aenZLyyYKkGDGCsI=; b=mrRY4LhNfwbj0TV76wxt2/s4gp
 sDcLspKd87LodifNt+SIgLWujgEZBCSVrQR2DqIh8MhDwVnwEUxlY/k/H8ky43D4V1v9vQL36DMZn
 y/6riF/AAJAUC9AAOTjQamYotAXHf7Vh7tt3kpSLrAK96thH3ZI9wr659fJTIyl50TJA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Qzwd3lqgQUpUIDalWsKHTl4VuC3aenZLyyYKkGDGCsI=; b=R2i0n5eZz8beNUCbZae1nUH0+F
 0kYzaMt7VNDZguYdFAipsfjJaYfNW8VWsKQoUGt1agGmsBu9vbDqtN0nokEf7SkACBfgh2FNYQDDr
 aDE6UA/XNhRoOHzI/JuIZaqLmBhTaCTzOIJL8p6c82hlkMVVKihxJMi6JVC2APu5oyQA=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMF06-000000008JW-2iTr
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:32:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 16D10600D1;
 Thu, 29 Oct 2026 01:32:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B90D1F01825;
 Thu, 29 Oct 2026 01:32:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793237532;
 bh=Qzwd3lqgQUpUIDalWsKHTl4VuC3aenZLyyYKkGDGCsI=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=oZjQMdYe65ES+Yk66Sw2N7Xx2doNjyd7QyNk/WT/NJT4NT5YtR+5OMU9aVu/LqTJx
 IdRhxVcbpr/kQvWYnL1mcRt3XgahUUrMyn375kztnUI23LDfSMzU63AJOtZVx2ZOV7
 n6XGIzvguTahSJmvAbdOPd3j58d4IEW5074n3qZ+H2koxhJbrZ/ZMTfKRL4Cm5q38f
 0vCNVQaUsTWo7g4hzcuFNnnxkzpIk4JNby4cezD4KXS5hMvLzfIQkrwlawyrvLqbYA
 Oe4ll5l4e3VM3cxHTFxpVRWWxilTEy9IVSFzdDULPpwXVTU5PZ+ftM5SKNc6Kdoojs
 5Qm8AMntwXJFQ==
Message-ID: <95ca4016-84c9-4c4e-8e4a-2b0802f802c0@kernel.org>
Date: Thu, 29 Oct 2026 09:32:08 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
 <20261028154407.1601430-6-nzzhao.sigma@gmail.com>
Content-Language: en-US
In-Reply-To: <20261028154407.1601430-6-nzzhao.sigma@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMF06-000000008JW-2iTr
Subject: Re: [f2fs-dev] [PATCH v8 05/15] f2fs: support large folio writeback
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 23:43, Nanzhe Zhao wrote:
> From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> 
> Large folio can contain multiple dirty ranges.
> Add a folio-based writeback path for large-folio mapping files
> and keep the legacy f2fs_write_cache_pages() path unchanged for
> non large-folio mapping files.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
