Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B064DC4321E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 28 Nov 2022 22:02:14 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ozmCa-0007cK-BK;
	Mon, 28 Nov 2022 22:02:12 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <jaegeuk@kernel.org>) id 1ozmCZ-0007cE-0D
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Nov 2022 22:02:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=GiI63A+mxmy3Y5f/xYyMN2jOCfzm+d+rLFqbkW99y7s=; b=IsJXdXf/ecTakovW2Y/xidzqd9
 AdWLLfI5MjHewH3lr/8qkCZvuu4N3RdFbdLeGCjh+Mgtqlnr4KqT7puiOk85SBn1qkaEku4gowOK8
 K4Pwk/JZJ8VN/yQjwVfXxU6T06zYn7ik67/hjhY2oYVHF+GUKinWSkZOaePjNvgOMAwQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=GiI63A+mxmy3Y5f/xYyMN2jOCfzm+d+rLFqbkW99y7s=; b=gdIlK6vUqSv+dOTtZE+eaIO8zr
 g6Yxr25UhwWqsNQLxIMeGuNIJ2d6CEcwbmGPep/+bF+VTLgbtS794QPHvKvl3yI9rVqbPYpFmNJtB
 hmD2N69fhJ48/3FP1RxRiXZWXU6VUlTeUfWvI4T9u5+LoQpUdcWggmRM/I7Agl0yWD7o=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ozmCY-0006a6-CQ for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 28 Nov 2022 22:02:10 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0364C61210;
 Mon, 28 Nov 2022 22:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47BB5C433D7;
 Mon, 28 Nov 2022 22:02:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1669672924;
 bh=pl9ZG4quKKMMXfDxoF/Izq6FMKP7JPEKUG99JP6uVp8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=QMwIWUzh33F0tItOAKKNud+vIZ/TFaaOEr9p2xZOGog50kPo0/MnTexm/MIUV7oMU
 9mdfVmVNEGhlYjhsxVx3YA7V2P2J2OAiPZiG4leZdGQYmuWycv0gPejHF1QlVIEGJv
 yBFmVt3alG8DnC96k016aY2HGsMMBaeTDrcOY/HZBTwA6N13/+ZTsYW5OMi5KVzrmW
 jIbx9ktczqHB2zAHlm7T9Tzve2HWfKGpFR92Jm/P//ybN4Nkh9XqimD976CQ5c22ZN
 JQr+vpJ6vxV3pMLEMS0162WVykkBjf3MZI9yYD/haVNoc9ovjTKO2fHpwHt+d2VKdD
 IW/04PsAK1ZQw==
Date: Mon, 28 Nov 2022 14:02:02 -0800
From: Jaegeuk Kim <jaegeuk@kernel.org>
To: Yangtao Li <frank.li@vivo.com>
Message-ID: <Y4Uv2tuHerLvJdLl@google.com>
References: <20221128035150.30787-1-frank.li@vivo.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221128035150.30787-1-frank.li@vivo.com>
X-Headers-End: 1ozmCY-0006a6-CQ
Subject: Re: [f2fs-dev] [PATCH] f2fs: Add f2fs bug tracker link
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

If you don't mind, let me merge this patch into Chao's patch, since both
are same topic.

On 11/28, Yangtao Li wrote:
> It's better to use bugzilla.kernel.org for reporting bugs.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>
> ---
>  Documentation/filesystems/f2fs.rst | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/f2fs.rst b/Documentation/filesystems/f2fs.rst
> index 6e67c5e6c7c3..67e1f3e86f32 100644
> --- a/Documentation/filesystems/f2fs.rst
> +++ b/Documentation/filesystems/f2fs.rst
> @@ -25,10 +25,14 @@ a consistency checking tool (fsck.f2fs), and a debugging tool (dump.f2fs).
>  
>  - git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs-tools.git
>  
> -For reporting bugs and sending patches, please use the following mailing list:
> +For sending patches, please use the following mailing list:
>  
>  - linux-f2fs-devel@lists.sourceforge.net
>  
> +For reporting bugs, please use the following f2fs bug tracker link:
> +
> +- https://bugzilla.kernel.org/enter_bug.cgi?product=File%20System&component=f2fs
> +
>  Background and Design issues
>  ============================
>  
> -- 
> 2.25.1


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
