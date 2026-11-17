Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CEFF606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=Z29+iIo+;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=kEoESUhf;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=dhe3HDEW;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J90+nQK3
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=ToPITHKcyxC7nB+kObyo32TAFfXw8npe37HzqBjhiz8=; b=Z29+iIo+swn6qy
	0VWolgzYLE7Q0qxb0wbhaLa/ssKzQtkez4u/sGQ3PWMuVkriIUgaG03zjIYpio6raihDl/tnTfApS
	DT3vnAgyhJNIuwDU0dDyfpOMJxGsy/bY50LG0vOUq075cELLVqNKmVMTsV6jK78Sne8ZmNEtYzBvn
	fCU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTEx3-000000007tN-1FBC;
	Tue, 17 Nov 2026 08:54:05 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTEx1-000000007tF-2vy2
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:54:03 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MYMcAvLXgBNRr3ToebNzzBHthrdB8UJbnFEfoZi2/Oc=; b=kEoESUhfy2iobAamryr/10HHB3
 dtRb1dyN73gQmRcnaxGT5kLCZW57OTtGiWfBFNgwKtHLVaDDRcXtzrPv9tWoaFsGATk7MofVPPwUN
 2J8pc7N/mGfoC7guF5xOw5jaH/KCnZotw47kCvswhJjfo9DP80sIp6myxENeysT+aEKQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MYMcAvLXgBNRr3ToebNzzBHthrdB8UJbnFEfoZi2/Oc=; b=dhe3HDEWD3zKaM3JFJNFXT80tJ
 vpfeqLOW69kWZMf1dI8EQT9eqhINtNnyBXCnZAjrJWxKkK7Eiq55tn3+x3PBbj2i92qb7djgY6kca
 QlJEsLwBzV3unrISFkD0htqfcwqqwn+Jy7GUJJqyeRlHr3y5/dpibFWdYj7L89YiSqcc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTEx0-000000002iF-18TV
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:54:03 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B287361260;
 Tue, 17 Nov 2026 08:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56EEE1F000C4;
 Tue, 17 Nov 2026 08:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794905636;
 bh=MYMcAvLXgBNRr3ToebNzzBHthrdB8UJbnFEfoZi2/Oc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=J90+nQK3EyaZyYqUAMBFiYitdUn24Z8yQXniMq3fzR2c8RYh0ForcOzSwUQwtzaA5
 GxMKQb2ZDxCO8Cqaj0BsB0msRXenLtNfolrUw5SsjjmPWZYXkLrXey0yeUXga8SPs8
 P8a6D8pmPLtDhKMVxrywQWDa65qwGQwtz112frOW+DuxvCRV7hEVoCzbFVR82OluJj
 Ina534qmoIKGBylJkt0MnhfsXw5wwQaTsEZ1aBw+6R9ueQywqOpFlSnsT2WsaFpvI7
 uLaX7Wj3Bu7DaQ7EjRNJsi6xlQLYuBWIdntVFMpTeIH83caEuvwcH0/zOaKek6yJ/y
 fOSc1oE/XtLdQ==
Message-ID: <c4100365-9d23-4702-8c1a-204927138738@kernel.org>
Date: Tue, 17 Nov 2026 16:53:53 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-3-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-3-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTEx0-000000002iF-18TV
Subject: Re: [f2fs-dev] [PATCH v2 02/20] f2fs: support subpage block size
 superblock and mount
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 12:08, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Add the infrastructure to mount F2FS with a block size smaller than
> PAGE_SIZE, e.g. 4KB blocks on a 16KB page kernel.
> 
> - Add helpers to convert between block indices, folio indices and
>   offsets within a folio.
> - Take the block size from the 1st superblock, which is at the same
>   offset for every block size. If it is invalid, probe the 2nd
>   superblock with each supported block size from the smallest, and
>   stop at the first one found, even if it is invalid, so that a stale
>   superblock of a larger block size is not picked.
> - Allow log_blocksize up to PAGE_SHIFT, and write back only the target
>   superblock block instead of the whole folio.
> - Bound log_sectorsize by log_blocksize, so that
>   log_sectors_per_block + log_sectorsize cannot wrap around, and remove
>   F2FS_MAX_LOG_SECTOR_SIZE, which has no user left.
> - Check the requested inline_xattr_size, not the current one,
>   against the block size in f2fs_check_opt_consistency().
> - Keep rejecting subpage block sizes, and return -EOPNOTSUPP for the
>   features that do not support them yet. Later patches add the support
>   and lift these restrictions.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
