Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7D2D606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=PnY5EHTU;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Dry/oy1r;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=d4NjbU4e;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RbyCPu5J
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=SoTqq+9WGa9P+4NvdW+tsHEggATSvPfbaqNUc1u/nZ8=; b=PnY5EHTU75PUqw
	B5db9QMqhBOvrrE+A1TBUdaApk8h5AyJWvJyGe5AuSv0EUkMr4HNZbKz4cGRORoRoKOJFcsAfDVeI
	p39yFUKol3h6FGU6oRUOiwoSgIL3rqQiwtWpg31fjMxGQ64t0zewPAKkoMEiUwGQ8/4/TcAHNuSYC
	RXQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMF2M-000000004ap-2oiL;
	Thu, 29 Oct 2026 01:34:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xMF23-000000004YU-3HSx
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:34:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g3i67qdTmeI4QwtWjq2CBi54hJqSscZ9bcsHrw5POxY=; b=Dry/oy1rzo6ly9/04Ia5RKNbgY
 t8iH9eba7MxH+cmgyXGU12hJI1OTSzUBwgE8to2fgqD9lXVuYVgeVO8VH9kiEnCjlR1kmlxQGghim
 vyQNoPE2KAi1AgTKTsHsXB2bIKCSEVepnyjRQupsjX1HPAeVQ84iDejZF0e5lbYQ05k4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g3i67qdTmeI4QwtWjq2CBi54hJqSscZ9bcsHrw5POxY=; b=d4NjbU4e4VqeRDEHOgTYCwVdD6
 bRc/RYHNkBp/ZpHDA7VkU6oc8Gt80Ixa+oh3NzS3dPA5K6+UIRFY7kwhFum/wraVVmocrcyFnO6co
 BXGEn+Gqfn12S4QFcImv3CU32BJvKvWLh/KefAhSTKQfseK6/NQLHS8nGbwc0OnN99Pg=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMF22-000000001cS-0uIj
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:34:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C968A40322;
 Thu, 29 Oct 2026 01:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52BE21F01825;
 Thu, 29 Oct 2026 01:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793237652;
 bh=g3i67qdTmeI4QwtWjq2CBi54hJqSscZ9bcsHrw5POxY=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=RbyCPu5JUZ/Se4TXJsHTpuXrqIakttrPppgqJXRlN+RxfWJxvR20youROmC10w5hW
 OQJ/2XZPIrrlWbXpmSS3S3+x55pqoFBbdhFiBZfwDcL54TksyimIcLzCR+wUMhFx5l
 4tkgOAosO5USzMobFWOr6lQR2F7NRkDdSzT9gWWMPe9coLO1w2ix5yHNMH4TVp5x3j
 wOTjj6JWTCqjRNUQV28QD/RU85UcuYhLgg2P3PNFf2fCWEmyDpR7q/8jRJ3gWljQQ+
 GSYuXnQJptNmG4DLURK7BaO/DFsA7XtYZmqhAPkDZBiH8qFB/OeUxcmv06n1xqeWQL
 +nxVMnArhBJsw==
Message-ID: <a6cac17e-d66c-43f0-8e4e-cf00a6213b68@kernel.org>
Date: Thu, 29 Oct 2026 09:34:08 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
 <20261028154407.1601430-12-nzzhao.sigma@gmail.com>
Content-Language: en-US
In-Reply-To: <20261028154407.1601430-12-nzzhao.sigma@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMF22-000000001cS-0uIj
Subject: Re: [f2fs-dev] [PATCH v8 11/15] f2fs: handle partial truncate of
 large folio dirty subpages
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

On 10/28/26 23:44, Nanzhe Zhao wrote:
> From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> 
> A large folio can be partial truncated and stays in folio mapping, we
> need to clear the subrange dirty bits and uptodate bits that the partial
> truncate covers. If this partial truncate happens to clear the last
> subrange dirty bits, then cancel the whole folio dirty state.
> 
> Also add a guard in f2fs_write_folio_dirty_range() so a large folio
> subpage whose disk block was already truncated (NULL_ADDR) is skipped
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
