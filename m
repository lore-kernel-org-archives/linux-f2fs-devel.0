Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8D3C3A5A7
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Dec 2022 13:55:22 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p3HMt-0004cl-Rs;
	Thu, 08 Dec 2022 13:55:19 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1p3HMl-0004cH-Of
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Dec 2022 13:55:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=jQmwI7OeNf3TH3VoHB+bmGvU+8ilO63oyfn0YjB9PrQ=; b=dOWhl5x0oU7t/AK9n29aHXXYhU
 ahutZPisNIwsi6ZFPq1fke5iHghPLozeiutBKJpNfuyt09QnCkbW3myR5V6nN1dG1GrnS1NccaobT
 Ml1NUw9Tc8z6yYKwVl1/gp+Sraa+BZugYF6Lb7gCk1+ZYo8Ruclv36kAEm7zAkWOuVIo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=jQmwI7OeNf3TH3VoHB+bmGvU+8ilO63oyfn0YjB9PrQ=; b=B1kE3+l18qNN7IhOiX8h3kGb1Q
 XFUn5VgOJVwkl6QKE2DL/p/g+HqZmjCX45GdZPxNWofEt1P6PWCW/TKPrgvexQEk032kQoKUTaG7Y
 8ZYFAzv4KVbgsB2tjpuTGQzuMpkL3QcJ8ypi4lFnbjBzApELhiiTbtRmqS63RsuD2Ia8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p3HMk-00AIHG-GN for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Dec 2022 13:55:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 1B79561F1D;
 Thu,  8 Dec 2022 13:55:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D4C7C433D6;
 Thu,  8 Dec 2022 13:55:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670507704;
 bh=GHOGNOBSyKVpEh7qANe1UUgQ2OKfIlbKScD58JvBbr0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=U3OZmd7yI3ChHq29PHWrM6Iic01lcnKdGD/k9zXYPAgRZBMYlSrIS6oUOOcOOYxv4
 al35IGRkEkxalEZIm4+PC+zgHS1BzK8H+R2m0exSDgJ06WQuFBXT4hNko2ExYOMbk+
 tc3THp+Fb2+oDdIYZ0bmtHQ3qr0tpl0SWWx+dmcXhGpB1jwIhuHsUeieAtuI+IlVZz
 Hj+JuyeqfzTlsZl6yLCIKsCp+xIcVRIlpAlCsHV/2boX5/b3oQmuh32oQSIMsMvh7k
 FRjFDBbqc6eJcHFhttSFATSzrOEluVDAF1NX7/FJKBG0uZIb7Le0g+bACy550P2Ql0
 +lI3lTSL+JN5Q==
Message-ID: <0b8b26a0-ffbc-6c1d-a191-47c4eb9c6115@kernel.org>
Date: Thu, 8 Dec 2022 21:55:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
To: Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20221128094346.1256688-1-hch@lst.de>
 <20221128094346.1256688-2-hch@lst.de>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221128094346.1256688-2-hch@lst.de>
X-Headers-End: 1p3HMk-00AIHG-GN
Subject: Re: [f2fs-dev] [PATCH 1/3] f2fs: remove struct segment_allocation
 default_salloc_ops
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/11/28 17:43, Christoph Hellwig wrote:
> There is only  single instance of these ops, so remove the indirection
> and call allocate_segment_by_default directly.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
