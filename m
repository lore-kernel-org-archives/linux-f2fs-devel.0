Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC556606A334
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  3 Nov 2026 07:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=g/LTKTtj;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NRec0+e3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=XIwOT58O;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TG9AqJwj
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=e5uB0SagxuCc4d9mlg8Xs+NdEAjjowtZLWwLiEWexzs=; b=g/LTKTtju9Xrk6
	wkejibeVpPFIA/OZHTLmT61SS3eRFbF8agtKfbcMIBfhqJOSUI5zs8y6WNTPkdWiqOZMgoPs1Avq9
	uO+R3gayQbrBj827v++P/uTvC4awRK8rLCngcK3K1qFyTFySRco7jrRT/HtmmXxS6eKi/IYOqjYAR
	us0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xO8Zh-000000004CO-1SLU;
	Tue, 03 Nov 2026 07:04:53 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xO8Zg-000000004CI-1TJG
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 07:04:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qnKFWaTMlKg8cnc365pJfluJbbcRNfyQiKe0ltMyRy0=; b=NRec0+e3YZE+D1ea4S28YTRlxc
 nUZ1ImHtvXtI8rmZu/6Er+3thlYNg4c8ct32fFIbh3lBF5o6xw3HuSFRc80uNcr9IyXCwFumkIjSQ
 ZtJArpMk3vBtyHWyOqsy05it+fz/LQ+DUd8WxHdWdOa7c+QDGZA/SyU8MrSsPzx/kk5k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=qnKFWaTMlKg8cnc365pJfluJbbcRNfyQiKe0ltMyRy0=; b=XIwOT58OpKHDHGuyAr2ZjZ2xsx
 XTprVaehz5LHOCCs6Vv/SzqgA0vbTj/MyHxNhuLxe/dOnlPNwzifWXPF1XsqwiCd7C7YDCU8Cuzgk
 iLtW21qwjbdDNms+S2YeNcpaxiITlmZx0LSoOzbYznY8twpwN2cAeGpxsRqZpJMeru8k=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xO8Ze-000000000wl-3vCi
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 03 Nov 2026 07:04:52 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4E00460142;
 Tue,  3 Nov 2026 07:04:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7121F00A17;
 Tue,  3 Nov 2026 07:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793689485;
 bh=qnKFWaTMlKg8cnc365pJfluJbbcRNfyQiKe0ltMyRy0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=TG9AqJwjIf3mk9M+xf0FEcLn97U3fKCOSBYeGlcMJzI55nkpEierH2rRieb4IHfV1
 mRLjPIfdBu0GKBMiRTi4LzRvP6pQhR+Ftq8mY5W5DopvLQKsx5mPtAlcAqVPTA59w0
 OFkhlj14/oYTeVPJtFBcXGSQFE1Lmu9dJjKt3rSCbIsckOoFjIWcQl9yozjDCApHos
 HQVFF1QDetcndzdz53Tcscg/6semEOZzBT3vV6JhbFhma62wYM5APQJ09DyzrajjBx
 sMjN+GJtAqNK/3KvWlBM/r9nX37mm4kgJ3Bjl6egqO+7gfzDadx/h16w3BqsKhJh8a
 +L2YE+NlWFKzQ==
Message-ID: <6d951ed3-2d4f-4bf6-9243-ee392e423744@kernel.org>
Date: Tue, 3 Nov 2026 15:04:42 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261102193952.3002018-1-daeho43@gmail.com>
 <20261102193952.3002018-2-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261102193952.3002018-2-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xO8Ze-000000000wl-3vCi
Subject: Re: [f2fs-dev] [PATCH 01/20] f2fs: use block-based index and size
 calculations in remaining paths
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/3/26 03:39, Daeho Jeong wrote:
>  static unsigned long dir_blocks(struct inode *inode)
>  {
> -	return ((unsigned long long) (i_size_read(inode) + PAGE_SIZE - 1))
> -							>> PAGE_SHIFT;
> +	return F2FS_BYTES_TO_BLK(F2FS_I_SB(inode),
> +			i_size_read(inode) + F2FS_BLKSIZE_MASK(F2FS_I_SB(inode)));

Equals to F2FS_BLK_ALIGN(F2FS_I_SB(inode), i_size_read(inode))?


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
