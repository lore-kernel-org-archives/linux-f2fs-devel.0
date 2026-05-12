Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31AD5CD4855
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 12 May 2026 07:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MhyIGnlS2bqG6ZCo+4w2xIFZEl36sycLm5Hq1jIlSIM=; b=XKl/nqlavUzR7MGM3Q9HtZwr/y
	d+pAtAIabYHjpnw+Rm58Q9PaT5vZbnQmDdVeeMuqP/VErhkOBIV1lyX6ZEZ4nhoeXBuNJPYGdLlaO
	13K8XU4veOJ32D4694NGbmYRfHRIOOzoc587Oe6ERcOi4oSwbkSLqE2FFudgSyQItqmE=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wMhPr-0006sD-Ay;
	Tue, 12 May 2026 07:20:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1wMhPp-0006s5-9I
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:20:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=hOK7f6ec2LsMgcWQRwIq/1n3zq7AV3Tu58DuoNcWJL8=; b=lNbtP0VtZuTkXIQV9CN+HXLhB9
 7Fxlz5zWIuPvodVESDxa5O+4xS9TdHX1qLTQJSiEg21cTF4fHbn5HJG20xgiLsj30MAUkLac/luFG
 EakmWYgA0GyD7j++E5B8k9uXRz/PHXh9+iDNe5pm87P2MeDcsrvYeAqlwOKwaSZAelWI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=hOK7f6ec2LsMgcWQRwIq/1n3zq7AV3Tu58DuoNcWJL8=; b=JkQFj83hP8+QMDFYRLt+Ndtxir
 B25ywRRytLGTLhrhWJZSu6jANPRATQMONzBpPYlWXWRTb2fSril3Ownma61RGPx8UetOh13hQq4x1
 a+6FoKuC2aWapW3e4kbdfuz1/mwGP7bTvkVSfcPcP2y8PROEwBwq0MWRnyKRdlZ0PFCA=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wMhPi-0001bT-3e for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 12 May 2026 07:20:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 33E7A43F30;
 Tue, 12 May 2026 07:20:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06282C2BCB0;
 Tue, 12 May 2026 07:20:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1778570412;
 bh=gFxSwQ2vwNGN7Wy+a57I0BqMT4+uCuIw9JWDuf1wsoY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=soJoZRoMxJtn9BFF3dpQwvk0xi820TNJfptJMtJX/cP/qNW+teYamRrcMVyhtuIf2
 iR30YL5xnlEO3jTCx2tpM77XOC5OsxBpMB1POJFpEuFKTdBQGIEvxGGPmqeJ32yTYY
 UA2xlPqKw+9LfjJN4MQdMcexmE51BlA+EqPHlH5f+sN6l+N2Pb4HNurNsKuKugTIio
 ole6921MHwRdIF7HBTc7tpfjCL6KBtD6BTBQ1Q6GwaBCiWuHWUGJB5v8Me5Q8cQ3NI
 Tq43OhBP9tdm5zD08MqoxYDF0J0eeB07AIqRJJSRbCGW+bEl8POIDqcxOUAfOS/yGy
 b9paE8zlD9+yw==
Message-ID: <f157c318-790d-4931-bcc2-7b3c95c8c2b0@kernel.org>
Date: Tue, 12 May 2026 16:20:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Christoph Hellwig <hch@lst.de>, Andrew Morton
 <akpm@linux-foundation.org>, Chris Li <chrisl@kernel.org>,
 Kairui Song <kasong@tencent.com>
References: <20260512053625.2950900-1-hch@lst.de>
 <20260512053625.2950900-7-hch@lst.de>
Content-Language: en-US
Organization: Western Digital Research
In-Reply-To: <20260512053625.2950900-7-hch@lst.de>
X-Headers-End: 1wMhPi-0001bT-3e
Subject: Re: [f2fs-dev] [PATCH 06/12] swap,
 block: move the block device swapon code into block/fops.c
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
From: Damien Le Moal via Linux-f2fs-devel
 <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Damien Le Moal <dlemoal@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.org>, linux-doc@vger.kernel.org,
 "Darrick J . Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
 Hyunchul Lee <hyc.lee@gmail.com>, linux-mm@kvack.org,
 Naohiro Aota <naohiro.aota@wdc.com>, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, Namjae Jeon <linkinjeon@kernel.org>,
 linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
 linux-block@vger.kernel.org, David Sterba <dsterba@suse.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Christian Brauner <brauner@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
 linux-f2fs-devel@lists.sourceforge.net, Steve French <sfrench@samba.org>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/12/26 14:35, Christoph Hellwig wrote:
> Make use of the abstractions we have.  This is a preparation for
> moving more special casing down into block/.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
