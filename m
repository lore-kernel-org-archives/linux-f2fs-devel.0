Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DE3BC54ED0
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 May 2025 02:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B9QTWh0QDbmxecffveYlI4PEBoZZum+NOiljqt2VRxw=; b=Waowsd3RG+ALMOAkrtGG45mKt0
	fcL4bx4Pmhj9qDlDVXnlhwI3u2hfR2cXTM6LSaavZhidnF55BC3oUhoCpkHk1QCLfb/YR0z+GU5Bt
	kdJjKYbEgXEOACEh8smI5/wQbde3nl72KC23Fm7BHXKuSUDzh0ebHxcCVvwMjDMFmqIs=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uIHt5-0004ep-Ta;
	Fri, 23 May 2025 02:11:55 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uIHt4-0004ej-NL
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 May 2025 02:11:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XxVrsNSZDrm8qvYWk19De0kE0Wze0xRPFpl4YuM7Ll8=; b=CyKSYys3vR79BzhXLkLWaorWaO
 mBF99gJKT5PJKqe0/E2LLjFwTVK9+jIFhEqOd2VaRUml5Ay7cPzdKiKbtEnxkstH94jFXCm64V5bv
 fhxPkEqzGGpgxK8Lc2Sw3JqOKJ5gSvNQzEg0pJQ6sPlyW7pDZpC6HAl9JD3KgPfkAflY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XxVrsNSZDrm8qvYWk19De0kE0Wze0xRPFpl4YuM7Ll8=; b=DtFeaCvHMLCo5U09zW7O2zqnxY
 AsEs4fFadzsg85e44hhkZWN3F+cECkAuE4jYs/kq7Ko9Sre6EYZRbzwfKw5oxzoQaR6cRQ+sYDHlE
 Vm0t5w5Aw8qkhL2W1UEG0uH+MSxJjb8fRxUVJY8pdWRABQ8CnRlceuY3MuW/7VVmDbfs=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uIHt4-0002Wa-8b for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 May 2025 02:11:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id BED715C6C2C;
 Fri, 23 May 2025 02:09:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42F9C4CEE4;
 Fri, 23 May 2025 02:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1747966303;
 bh=MQVQ714Mes4figyzBT1sfYw//srKeIIbh4GJGOjRbQw=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=N1i4e4mctMYZi1snPn+Ejwqi4+AnJKAJDddOX2oEpjoI4t1fJj4dm6sKtyJ6PVdkj
 SZJ31Y7CeSGDlR+OwpcTt3XkcaQB3MXjmGGERYKt8fkbjp9P1vaXjLKl9SgUhTpeMk
 xNfi73pf7dOYjaJhfK3YJFxTFOdQ4Xfc/e7xRuTTLfzosLS2OLUbxmsScrJ4TceLJY
 0HRbnRUbHlMdVQHPRGU64n6EjRPnYO8afgIgnTu6XpU+QFRx/ys3WlZv4sk5tr/W5I
 NwDQsqNB/f2SJPmAGO0gWaPMdBf3KaYbcHs7pLFxIPKdruXq9yVHPzqCk3vwo2mEmH
 JYEkxA48jqlFw==
Message-ID: <4aeeec81-63ec-4991-b6b5-9091c67178eb@kernel.org>
Date: Fri, 23 May 2025 10:11:40 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1747212349-18425-1-git-send-email-zhiguo.niu@unisoc.com>
 <1747212349-18425-2-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
In-Reply-To: <1747212349-18425-2-git-send-email-zhiguo.niu@unisoc.com>
X-Headers-End: 1uIHt4-0002Wa-8b
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: fix to correct check conditions in
 f2fs_cross_rename
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
Cc: ke.wang@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, Hao_hao.Wang@unisoc.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 5/14/25 16:45, Zhiguo Niu wrote:
> Should be "old_dir" here.
> 
> Fixes: 5c57132eaf52 ("f2fs: support project quota")
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
