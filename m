Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54AD6C79F89
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 06:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pWP1BP9htFMXzG63dm6ejlo+Eax9/HIy8r95Pwr5whI=; b=V4FLHY/xSSpBrsfabOk+J+jvBo
	WKiR/GF/V2NNF7AtY5Z7Dbff9aG4ZezVuky1tO08lM9zZyQwMEXg0N1Q5Q2PRI1OnvSh0BqvKGL1l
	KPo47XFeR7yxv2A5wU0I28FAteazNUFlI+zey3t0Q22WQJU49YjzAnRhv6O5nO03y7OA=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3TKa-0004oJ-TP;
	Mon, 07 Sep 2026 06:59:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x3TKZ-0004oB-Ez
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 06:59:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IU5MvjFKRNVNY+OOFB3bdI4Sq6alXb1rFOLEPZAt2ek=; b=mK1NOmjyI8EViiAvu0bXjxIGxO
 8CJeun0Ckfgmhn3TbO6pmLUv98INZInmPEE8as86HGIrCehMeo3pnY+62BtFsdUM9nCwjZ3iMMbXk
 AXZBU7yZ663bhVd775cE0zA8tWv2cLnDPI6j/hQxXEc6NvmnZFuZBx/TVy7oYumRzyzE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IU5MvjFKRNVNY+OOFB3bdI4Sq6alXb1rFOLEPZAt2ek=; b=UYI+HobAL5rH5x1wkm90L1T8Ag
 rqTJ3lbhWvzDRhr3VCXHK89QZ351ijte88AJsKjrGbPxg61oR3iMBwCs1or0Xwr1BvKqV/h1Gzbu0
 45wUmHxfE0obxrVCaREh4X1Ub5IPFGJ5zlahThvCnqCRXmln2hWwd8+BIJeZ4ReqJDec=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x3TKY-00030r-1m for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 06:59:51 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6618B60D87;
 Mon,  7 Sep 2026 06:59:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62901F00A3A;
 Mon,  7 Sep 2026 06:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788764384;
 bh=IU5MvjFKRNVNY+OOFB3bdI4Sq6alXb1rFOLEPZAt2ek=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=PxmP+nFtiVFb2H5FtGfrDrYvaQ8L3Lto7cHUT2s86n4WigaBzRCakbNVS8xnrS5wa
 kO4mBqcNIPuQ0qm2AVpL8qKVFvXjzdPKPsSo7LzKaHutRbYVJBrasrfWv7rgXriufL
 kRz/xFwk9dbvCeZ4w9eWWC0s/aoMaQpp0wtQLAiR+cp+hWl7iYC3HU+ibZgkihLOS1
 1WYbUiIxIQHzcMbtHf7CN8zl3IQgPHdGukGlPkdhwejoPnJSczyjrhhg8ytN9tTorx
 ek+NvDNLXmHTAvNLakgoXIVPblftDi0TOwp4wkd6f5+PNHbMTtNTqpTz1iIynPesvY
 TxsAuZc7UxEFA==
Message-ID: <5b8e5e22-5847-4097-b3ab-e9ee0b74cbd6@kernel.org>
Date: Mon, 7 Sep 2026 14:59:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>
References: <83fe187e-e3e8-4328-bbbf-a6751873b9e0@kernel.org>
 <20260907035139.2183535-1-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260907035139.2183535-1-zhaonanzhe@xiaomi.com>
X-Headers-End: 1x3TKY-00030r-1m
Subject: Re: [f2fs-dev] [PATCH 03/14] f2fs: support regular file buffered
 writes
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/7/26 11:51, Nanzhe Zhao wrote:
> On Thu, 27 Aug 2026 16:56:53 +0800, Chao Yu wrote:
>> It detaches from fault injection, why we need to change to use
>> __filemap_get_folio()?
> 
> Thanks. I missed that.
> 
> diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
> @@ f2fs_write_begin()
>   	fgp |= fgf_set_order(len);
> -	folio = __filemap_get_folio(mapping, index, fgp,
> -				    mapping_gfp_mask(mapping));
> +	folio = f2fs_filemap_get_folio(mapping, index, fgp,
> +				       mapping_gfp_mask(mapping));
> 
> Could you take a look?

Fine to me.

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
