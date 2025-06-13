Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D088CC71135
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 13 Jun 2025 05:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zIHHjey0U08vMdMOnEyZwKJZIsy5CteZQzZPWIPZpUU=; b=mH1V5MwoE2hJEMwGCPKVZAkdmh
	JkYJQ1mqoVNbIWADlUsxM+Dr8Ur+AUUVNK3RijqbTh5tjNnxUKnvq+7gQ4EusjBZQWO+4ZUsftKCV
	/XV1p8kTCiqlupKWPhPn9ElT+nmBxfbzRvE55a6x9snvacE/WzPpSXGqOSGFysdHj7iI=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uPx7y-00005z-1W;
	Fri, 13 Jun 2025 05:38:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uPx7w-00005i-Gz
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Jun 2025 05:38:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=g2YD6YkA2BPfWCASKq8A0+0o6zf2ITCgn5rZI4rO0O4=; b=GougI10BGJuSTUv/5epV071Azz
 kSRvViivYMD36K/9CxoVjcsj9kD+70WabOgj9dxi7oe3qx/JELFZXJl8S1MgNexhel9n/snNmMs+y
 DxfX6ezow4VW95FBc/UCo0AfhP2tI9DyK3FjioahW8kg3bDKMgGbLQob1PUHS5imOMq4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=g2YD6YkA2BPfWCASKq8A0+0o6zf2ITCgn5rZI4rO0O4=; b=XZrgApFv/eVckdsY9Xls16C3Eq
 rprBxm9l3hGm5GNFCmPKLFNno12EEsWvhV3I9dsmsjlj901NfUa/x9Mesxva07eIwkJMW5ixb51ED
 4SHvDGVoPA8+PQIk3SE1kDNBMUUD609Tuu9NqaqaTyBuO+1ev4eiMwPq3gkmvtdnmT1U=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uPx7w-0000mi-53 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 13 Jun 2025 05:38:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 61B34629D7;
 Fri, 13 Jun 2025 05:38:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50AB4C4CEE3;
 Fri, 13 Jun 2025 05:38:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1749793130;
 bh=rOd4/KK6J7m10xGotXb7C6crXWdrl9XLcSb1EYIPMkc=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=FRIS2iuapAF0JpPVJLBnt5y41GRTlixpKIpsY6wJ1oC7yyrdW+C7OVuYamnkd03bZ
 vawny/sqIj6TdjqsWiro9SExg3bxA3MMvqmP+jEpCIDNrmT0XIB5gK1qHjQf7aUDBx
 K3hAoMeIjRZCaQIDi0MimNZFbTWpm1BdRqaOCFJ7TnIo8+j19s1ESHP3pamY9uWqRy
 hPI23twkRqPnD/lzly+16hyRZaH3svgBlCyADAOTH23aRQ5JePMnjbC2UZ7nPFU6DN
 NuYrR/KN1YE3OaqeKNbOp3h03JQY8F4qMTWLzwbbCeZtpTRTFhl1OUuXS++MkArdwZ
 MDZ1TX+ZZdKHA==
Message-ID: <a5ec2625-5ad4-4ffd-b8bb-00bb0e4e29b6@kernel.org>
Date: Fri, 13 Jun 2025 13:38:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Zhiguo Niu <zhiguo.niu@unisoc.com>, jaegeuk@kernel.org
References: <1749779445-29125-1-git-send-email-zhiguo.niu@unisoc.com>
Content-Language: en-US
In-Reply-To: <1749779445-29125-1-git-send-email-zhiguo.niu@unisoc.com>
X-Headers-End: 1uPx7w-0000mi-53
Subject: Re: [f2fs-dev] [PATCH 1/2] f2fs: compress: change the first
 parameter of page_array_{alloc, free} to sbi
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
 linux-f2fs-devel@lists.sourceforge.net, baocong.liu@unisoc.com,
 Hao_hao.Wang@unisoc.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2025/6/13 9:50, Zhiguo Niu wrote:
> No logic changes, just cleanup and prepare for fixing the UAF issue
> in f2fs_free_dic.
> 
> Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
> Signed-off-by: Baocong Liu <baocong.liu@unisoc.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
