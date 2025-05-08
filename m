Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17C94C3ABBE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 May 2025 09:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ymzmU5acFS2IfyUzrPL8LBdMuHjHs3qE8xKZcl8FIaY=; b=YaD0ByLd2x7msZwZF9dfgSdmRt
	7/HpVpwhfxgqNixFGFdXdYL2EAP+Wc+AaUoA8LpUH/6H8+mzNUaN8UsggKA7i0aIsLQejuTgXWLEr
	Rs/uYQ/mJx+F8w08n1tC074F6Pwkc2IDQAwQJHIYbPj8vVPJFNHNSn5da9YsjCXG2oGY=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uCxsN-0008Of-Od;
	Thu, 08 May 2025 09:49:11 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uCxsM-0008OR-64
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 May 2025 09:49:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hUVaQChkcQ9Md3lP2BzH31Nj+XNM9Qz8KD5S4JWkVyI=; b=Mff6Vye4cjfK8R0AClJazIH5p/
 Z9H4Vk8o6MYJvILM0SFiZ+KRHEFr8x0W3TVBZpSQlNdCrODZkaCq7LoWth2dVI63Xj8B+1+ctUeOE
 UTopcpLjj004DcVEkLc2twcNExZGwdqZIjlWamniU8K3dO1/+AmMko3rJkimpJ7w3tR0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hUVaQChkcQ9Md3lP2BzH31Nj+XNM9Qz8KD5S4JWkVyI=; b=F/HpEFX3l/IXJ3472PMiNPkl3x
 fgR0qS3c4U1dLVOKWOvPRWJpFqoKsxI64Qm0K892CMCmsu8iSW2vG3y6jOYzHKHMH/tLqvClUGPEM
 Rx6s4nUjQ9sG/vbi/XeGT4VAw7hvR1NsduvHKKRx+azaGpPzaSDCP8yxADhyHRRZOI1I=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uCxsL-0002zf-I2 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 May 2025 09:49:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id DA3C5629EA;
 Thu,  8 May 2025 09:48:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88714C4CEE7;
 Thu,  8 May 2025 09:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1746697738;
 bh=1M2D0kmPXyrtxUHUqV/QBCgUyN2yFLT+VGEt8oz9Ov4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=q35O//wgeFolfUtGFo2yu7zhlejGy8Sz3V7xZTakPq624qNcrv13dWsvdYbOrowi1
 Kq/TrA7HN26UnMs/TEc+zYaDRim29VwgtNG0drLYUOVDLQRpi85tYGine4NCh8xnz3
 Uj9V25fe6L2gRWvNB/ZzGA9ruBdNFSGWPo2dy6vnudyNy6ADAHwPauqI7LeaUCZ7/a
 O0ia9WJtNPLGATO1b+WzoFUt6+bxODUB4usIsk9NMetmBdjmWM55Jv5yWI/iPGDj/h
 QETbuNc8vS/KjE5WVFbl3pUHBdyt41WVUDEukLAXjV1RhFaiiQH9USJFcbtXWZrLEw
 MDKr8AuVw2E6Q==
Message-ID: <c2d58d5c-54fa-4b50-97cf-bb7876e1bbab@kernel.org>
Date: Thu, 8 May 2025 17:48:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20250508051520.4169795-1-hch@lst.de>
 <20250508051520.4169795-5-hch@lst.de>
Content-Language: en-US
In-Reply-To: <20250508051520.4169795-5-hch@lst.de>
X-Headers-End: 1uCxsL-0002zf-I2
Subject: Re: [f2fs-dev] [PATCH 4/6] f2fs: always unlock the page in
 f2fs_write_single_data_page
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/8/25 13:14, Christoph Hellwig wrote:
> Consolidate the code to unlock the page in f2fs_write_single_data_page
> instead of leaving it to the callers for the AOP_WRITEPAGE_ACTIVATE case.
> Replace AOP_WRITEPAGE_ACTIVATE with a positive return of 1 as this case
> now doesn't match the historic ->writepage special return code that is
> on it's way out now that ->writepage has been removed.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
