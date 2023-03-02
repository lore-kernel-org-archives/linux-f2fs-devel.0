Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CBD6C678D4
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  2 Mar 2023 06:09:21 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pXc81-0004hO-7K;
	Thu, 02 Mar 2023 06:09:20 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <rdunlap@infradead.org>) id 1pXc7z-0004hI-Ey
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Mar 2023 06:09:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=cksF2J1GHVCqfD2mhu+eRf6JBEUYvRS+b/lAVg5OY4k=; b=bAXAxLjsZMlAR5uUhvVwVbAuOF
 +gD/yVMeAa4NWNIubDxKEq8raSW6FSk0c1ENZsUWMI5s6m+zP78sixwb0qinRbu0l2P9RffltWmSe
 EKLylzG+VpS3ty9m2nYPJYi5y4WZz/NHwxwjKRVzf7PFYU2dn4A9DbmrWTjrZOfvddvs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=cksF2J1GHVCqfD2mhu+eRf6JBEUYvRS+b/lAVg5OY4k=; b=WZCGsa64HRnmLrvvaOJSNzf5Li
 KZeyuy4jKueY1kGHrO/5bJADPv9EySDkmznfeaBreD71VYdG8xcR0muBOOrv1uh/nBR3OSEFtR7lL
 S33E09TVX7YNx8WKDG8UEml3AVhN+EMqx3cvqozKnHY3HTkTTdXVi1t3utVK+cbbxH38=;
Received: from bombadil.infradead.org ([198.137.202.133])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pXc7t-0007cJ-Kr for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 02 Mar 2023 06:09:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
 Message-ID:Sender:Reply-To:Content-ID:Content-Description;
 bh=cksF2J1GHVCqfD2mhu+eRf6JBEUYvRS+b/lAVg5OY4k=; b=xhP5RydDw5msBMoWeLL3EK67tk
 9/bF94WaOLMjcRxAtvS9n2MSPDYOjga7H1qJ/V6Wp96Ccoj0D5rQQwYBmT7WfMHh6PlgpiEGLJK63
 7DvU7v9eh+YGl6h879mLwhIcjLqcRS70AeMEx6LFvgiX/qPBG2+wxvpWAcfx29/+mqCf5z0dVSuWX
 08jg7UGHDgXhQD9F40YV7JMYGv4NAceuoMK8GQ3OaZtFfuoWGlop3sb7ff7DdNOlV+/Y4wKswXIM4
 ldu4FZH/IMrEl2BBs3VEH9UVaNFiVjLiBxjFPF5adPf+8Xs6sxmTFksRLo+i+En+PtIWUJ4mLWwjb
 CYZmqXvw==;
Received: from [2601:1c2:980:9ec0::df2f]
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1pXc7h-000z5k-O2; Thu, 02 Mar 2023 06:09:01 +0000
Message-ID: <ae2ff44a-8165-b8c6-8094-c5d337c5f68d@infradead.org>
Date: Wed, 1 Mar 2023 22:09:00 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org, chao@kernel.org
References: <20230302055103.60116-1-frank.li@vivo.com>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230302055103.60116-1-frank.li@vivo.com>
X-Headers-End: 1pXc7t-0007cJ-Kr
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: introduce discard_cpuset mount opt
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



On 3/1/23 21:51, Yangtao Li wrote:
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 2055e72871fe..dc005f3b784a 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -351,6 +351,8 @@ age_extent_cache	 Enable an age extent cache based on rb-tree. It records
>  			 data block update frequency of the extent per inode, in
>  			 order to provide better temperature hints for data block
>  			 allocation.
> +discard_cpuset=%u		 Set the cpumask of dicard thread, it makes the discard

				                 of discard

> +			 process run faster on a more powerful CPU, or not.
>  ======================== ============================================================

-- 
~Randy


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
