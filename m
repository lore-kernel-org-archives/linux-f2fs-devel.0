Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1B6AD1CA0E
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  5 Nov 2024 01:34:44 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1t88Sw-0001l4-4f;
	Tue, 05 Nov 2024 01:34:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1t88Sv-0001kx-CM
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Nov 2024 01:34:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=NHOy9HMfGZsNYCZrwLCSvIFDt8NcrmF4jHCNX3GgtvM=; b=bcsta4BV00HJ4B4EdpAyg2xs9m
 8HWz731h4lhi+eDyePWDbgb7EEWh+biNQKE3uW+FVHw7Y/iSP2Dp5O0gMGQjup4emiOvyww12oqIQ
 PQfs2FP0XqEwTxrv5zl1PsDDM3uScqKulk8Sz61Nc+7JTld4skOFmJ/Xj6Mb86WlwGR4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=NHOy9HMfGZsNYCZrwLCSvIFDt8NcrmF4jHCNX3GgtvM=; b=Gta5M/uWFcbikDPfK2z6mCNSiI
 tnTZ0csMMqW13We9a4t5qLmay6Ndhxn+At7jaMarCo1CupILJzXc3OeohlYKmUM0zf3D4gNo+abNP
 /k71wLkFUAwPy7loUrv+SlX6dnaPEHQswc0jyefGvpnyLB567+DTAc3RHvoSN9wRsEnY=;
Received: from nyc.source.kernel.org ([147.75.193.91])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1t88Su-0006HP-IL for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 05 Nov 2024 01:34:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by nyc.source.kernel.org (Postfix) with ESMTP id BD667A41C59;
 Tue,  5 Nov 2024 01:32:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D0B7C4CECE;
 Tue,  5 Nov 2024 01:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1730770469;
 bh=pZqyeDU4Z0xb82ka1rqo9zPh5E+ZbwXvL5ApzcS2al4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=cilUS0qQCFaxNF3zH63qgUIqVpBsK5ZAO2+Mc4CrXmk6QZIa3ZA/1eyWd894pH2td
 p6DeOBI4b44PBAllxDSwZ+pvc/5OEkcYzKgLtcgnvluIpjNagN96SxdO1hq1RTBHL4
 IsHQ3dUtDassq5aGIJOJqxs+MkAOhLYww1/sRgfew7akFKeqGOT8zYLFCTpqAtJETh
 hetvPOAoOKDF42PLByagmL9JEdRSFvR3DT2TRaUD4mTfYhVrokbWecXm5y2cdsb4O7
 uykYoTN0CALyatfk7dtT2vPJ/mDxiOvw5DHvt59QcW4RICZcRPoNv9l/f+5h04HOGk
 wE3h4ii4bPJsw==
Message-ID: <43d8b52e-5e5b-4a37-9a18-6ac392048d92@kernel.org>
Date: Tue, 5 Nov 2024 09:34:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Eric Biggers <ebiggers@kernel.org>, linux-kernel@vger.kernel.org
References: <20241103223154.136127-1-ebiggers@kernel.org>
 <20241103223154.136127-18-ebiggers@kernel.org>
Content-Language: en-US
In-Reply-To: <20241103223154.136127-18-ebiggers@kernel.org>
X-Headers-End: 1t88Su-0006HP-IL
Subject: Re: [f2fs-dev] [PATCH v3 17/18] f2fs: switch to using the crc32
 library
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
Cc: linux-arch@vger.kernel.org, linux-s390@vger.kernel.org, x86@kernel.org,
 linux-scsi@vger.kernel.org, linux-mips@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-crypto@vger.kernel.org,
 loongarch@lists.linux.dev, sparclinux@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-ext4@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ard Biesheuvel <ardb@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/11/4 6:31, Eric Biggers via Linux-f2fs-devel wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Now that the crc32() library function takes advantage of
> architecture-specific optimizations, it is unnecessary to go through the
> crypto API.  Just use crc32().  This is much simpler, and it improves
> performance due to eliminating the crypto API overhead.
> 
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Acked-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
