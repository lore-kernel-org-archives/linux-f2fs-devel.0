Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0331606A32E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Nov 2026 02:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=MlwwfMo4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=TPbAZwGB;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=O2KDCvvk;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Qzuhl24/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=5Su0+AJd91GH8rb/CyhW6akLJCAEKDHjs/eKz/SYqaI=; b=MlwwfMo4Cl1/W9
	TpDYsbF629XUoRYsSU2IOWEtQOZSYSkldhaO92ojo8P+A2i+j8nstGaN7JvpLlrHfU0eHcX1pqoBU
	lKQYbULZbA7CQSKmt67KpEAhiuvBlMm9TNlcRI5WKMu+DJx4SUZ2Fs70XP4MKqKqhyy2V1dDLYKBM
	d3w=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xNhzR-000000006N8-3x5Z;
	Mon, 02 Nov 2026 02:41:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xNhzR-000000006N2-1780
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 02:41:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=horsUIAVxPOqgImLFlZZE276m8/SkX8ZSP/898/qyM0=; b=TPbAZwGBraq7xEkrPOJJbayYIN
 MX5M7d1MpWN9LZoo99Ii7Mk7hUbMQeFyk0asTSTBt5whG8OXaHelGWVZ0KqNkISH+nh+4WhWzOZe0
 7depZD8BP7ezYVopfe74kWaolGL56Yih8CCwpiaf4IsgEDV1Szh8X56uB/cCSpV640wM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=horsUIAVxPOqgImLFlZZE276m8/SkX8ZSP/898/qyM0=; b=O2KDCvvkrp0AmxMH9/2l4wkNPo
 mhngf6TwZIQhspG52Dik4/lR++5oR60wUNw8xQcXhlWKqq+co0EuJzI9VJQaR981ruoP5X1Dhx6u5
 kRlEmfF+BSmc75QrzN4zOzuOIx80NUkauXViLi6yrZjvUYU2RAtm+/dzPuIlWxcCPcfY=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xNhzQ-0000000085C-3KWt
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Nov 2026 02:41:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 227A460098;
 Mon,  2 Nov 2026 02:41:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A20FE1F000C1;
 Mon,  2 Nov 2026 02:41:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793587294;
 bh=horsUIAVxPOqgImLFlZZE276m8/SkX8ZSP/898/qyM0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Qzuhl24/t7qV/YgmpdJHsVJd1MJUAbZ1jBipxP2Xlvr7xYkiogzmtvuf6ENAu2Ga5
 +O8c4GXFAJqkFCZUNiop5W9z0fyJpMMW9Mm2TYKMjMPsjvNEIoj3S9YUqvrcjipM3n
 n+5DdMjjAtL/gxDUDkWK2r1NvPDZiHs4FrmT0b58hYYR0n0/2cGfR31qRnKJgkWDVK
 cKqoodFvJVnS+fUz8hAnoe07sya4NcHkdcnLwLJgkWv1fa4BSDTeUEnqq4zEYmd4bK
 bQQuU2jGpkq6vgOA9BCNMhhNL72XpVqTHGl0W5AHbPKMM1EWbYHiUC3eG3G3GXgcPf
 HtGhw9kKjGgMg==
Message-ID: <614279f1-4306-44ea-bdfb-30f62459bafb@kernel.org>
Date: Mon, 2 Nov 2026 10:41:31 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Hungyu Lin <dennylin0707@gmail.com>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261102004742.55105-1-dennylin0707@gmail.com>
Content-Language: en-US
In-Reply-To: <20261102004742.55105-1-dennylin0707@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xNhzQ-0000000085C-3KWt
Subject: Re: [f2fs-dev] [PATCH] f2fs: update inode ctime on exchange rename
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/2/26 08:47, Hungyu Lin wrote:
> When two regular files are exchanged with renameat2(RENAME_EXCHANGE),
> their ctimes remain unchanged. f2fs_cross_rename() applies its explicit
> ctime updates and dirty marking to old_dir and new_dir, which have
> already been updated by f2fs_set_link().
> 
> Update old_inode and new_inode instead, matching the ordinary rename
> path. Keep the existing parent link-count handling, which dirties the
> parents through f2fs_i_links_write().
> 

Cc: stable@vger.kernel.org

> Fixes: 32f9bc25cbda ("f2fs: support ->rename2()")
> Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
