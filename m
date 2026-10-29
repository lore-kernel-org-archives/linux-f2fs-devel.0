Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAAC606A31F
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:37:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=W0rQB1FW;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=EdUOP9Gq;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=KiJ/ybAN;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTY5nO+x
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=UKTtWofvhEyEeCQdd9qOA3qYC0TxzCoMvWCJqc5wLMs=; b=W0rQB1FWJ8e8hK
	CIShfBs6SpinTjbjIlTZOqvEi0L+zFXxhIG51he9w02qU9l0jH+BJQWt1ZVfo8S6fV5Y4lUA+To7H
	awsAJFI0a9v7cDKIV/wcVXE6Vl4IizspnDi6sIpMTpf/23FUGMf9xsfQyhuvhTGQEapGq2vK/iH+b
	4Gg=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMF58-000000003mw-2pyg;
	Thu, 29 Oct 2026 01:37:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xMF4Z-000000003lq-2gCP
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:36:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pesJ8o4EooFTy8TeAVTnkyycbaj8b9KERG+ouz+svZo=; b=EdUOP9GqCdOe58h7Q5jbHVKwet
 IVTot+BY1Gy03XpOlXZK1jX4Je+nz+Etk+T1zQQETAjku8WCUDpV8UcVFogJEC1BQgCf0FiAbGb0z
 MQluDD/FUmRv0RTE+jygyiRtuRsnMyU1WbytHEC3tZUMdL0QO2OpBGzFvV9EbVlD1Bgw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=pesJ8o4EooFTy8TeAVTnkyycbaj8b9KERG+ouz+svZo=; b=KiJ/ybAN1V5kfsJ3xJxopitMQ8
 u828XAuTafeM50/1MjYXfDx8CcAj9+xYdwwcP1HZFXUzY/IG+Sy4AJOyO3/9e0DO53EuDYSxuNaJN
 1FYC6u+arTZJsxDs7Jdf+CZHnHHXzjLcQ8r13eh53C0fFn1nPyuaGyH250ys1DtGykJE=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMF4Y-000000008TS-01Li
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:36:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6F019600DA;
 Thu, 29 Oct 2026 01:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D10601F01825;
 Thu, 29 Oct 2026 01:36:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793237808;
 bh=pesJ8o4EooFTy8TeAVTnkyycbaj8b9KERG+ouz+svZo=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=iTY5nO+xZq5FIpRm3PNEeKzZTaqT14fYvsy/M+3OA7e6px9NerDL/TKNYKtoqBdgW
 elIeIiS+y8/QsRKGzjJIQefIkr+Nkgk1hIw9VkQG+nPFDGN66zpJU78UOH7SSLLwOY
 XK61tt8466rNkiXKzYwCVj973jYJPozAdg4ECn6lab+37RcQ9euke709gqNkKCNvox
 d8u342wfE21IwP9hmHsOBu1GGrk677ZqUEbojYZDxHecbX+9cfP3WDJhlubAJhEe3j
 SvKugZILCcfB6sFgt1SVFTchczn58itNBrDrJiwEvXz45k7knUNa+JQXJyOYV0XXdH
 eUHxjPP+bnwKg==
Message-ID: <09fa15f8-706f-436b-a333-dca402180fbc@kernel.org>
Date: Thu, 29 Oct 2026 09:36:44 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
 <20261028154407.1601430-16-nzzhao.sigma@gmail.com>
Content-Language: en-US
In-Reply-To: <20261028154407.1601430-16-nzzhao.sigma@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMF4Y-000000008TS-01Li
Subject: Re: [f2fs-dev] [PATCH v8 15/15] f2fs: make compressed files
 compatible with large folio
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
> The compression flag is the hint indicates that the inode can be
> compressed, when the inode is using large folio, we expected it keeps
> using the large folio read/write paths and its data stays uncompressed
> on disk until the inode is evicted and re-read
> 
> Let f2fs_write_begin() skip the compression overwrite preparation for
> such inodes and remove the compressed-file gate in
> f2fs_read_data_large_folio() so the data is simply read/written as
> regular blocks.
> 
> For the same reason, reject F2FS_IOC_COMPRESS_FILE with -EOPNOTSUPP
> once the inode mapping is switched to large folios.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
