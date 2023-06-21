Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AB9EB64D7
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 21 Jun 2023 13:41:30 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1qBy5Q-0001mO-EY;
	Wed, 21 Jun 2023 13:41:28 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1qBy5J-0001m7-Ab
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Jun 2023 13:41:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LBLcigh17Ixf2NPWDAViCT92TcalXkV1Ah18SFdamDs=; b=O+zvcQdZUSLl/cxqsf8w2nkKPB
 NLeNSkP1RZEkatoSdbt6+m6e+fWrmj6iFd6eSyUoPqEOYdC9SsEkG2B3/Woczz1u8Ynb8MDx5XCI9
 hua3B9sQHrfh8x3DbIOQCeh5lPaM7i/BeeN6pRZPLq403d1Ml/MkGy5h97SvnGEZdmgE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LBLcigh17Ixf2NPWDAViCT92TcalXkV1Ah18SFdamDs=; b=IWUjkLFF4oeRUtV25+Jk4FwgTW
 frAZWo8785JGPDM8VMfiG1BfEfma3s9by1XazI/cRm929BQ3ZLfWJVKhaCVfoM6WeVD6R1pJ3OCt+
 KVViiZlNAZpf33lriV6HNe78ljtl4AW5EwHkJ90s3HuCQbZOmIz6yunhcvZ2sVAdTWns=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1qBy5H-00AgD4-77 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 21 Jun 2023 13:41:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CF28D6150E;
 Wed, 21 Jun 2023 13:41:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49D53C433C0;
 Wed, 21 Jun 2023 13:41:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1687354873;
 bh=0dX2S+X5v7h2CEtaF++zubk0bfXZPTqmNrEkBPz9kOw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=ur3wx91LpnznFdO9eE4HfIIobhYmThDA8LSHPKEqfUVWqpah1Itr9c5aFyksRX+vH
 PlyteH02oTp+v0qIfuIGT+C2F0SG543rp7IAZw80J9UNj0aahmklvcATRVU/9GF/W1
 bvrzhWSppY8Gj3USxjQeQgPP5c4Pu3OFfobsYe5nemHBpIiqSU5sHD9B0IOCwchWTq
 gHkhTewSAT9YgwZD4rA8FdKqPCVPeCtLcGd4nfN39xLe3+WVnuJn5iWuqn/jGGZ+H0
 yO87wUgGJH+i+9d+zssq6c4SFryNaRqWT1FnNMTn5LRVZjxrwRp71hyVKxFq/M3GzV
 vLErrWqZeHtpQ==
Message-ID: <421c602b-9838-a9b4-1b7d-59d169825c52@kernel.org>
Date: Wed, 21 Jun 2023 21:41:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Content-Language: en-US
To: Yunlei He <heyunlei@oppo.com>, jaegeuk@kernel.org
References: <20230621094359.3827832-1-heyunlei@oppo.com>
 <20230621094359.3827832-2-heyunlei@oppo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230621094359.3827832-2-heyunlei@oppo.com>
X-Headers-End: 1qBy5H-00AgD4-77
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: truncate pages if move file range
 success
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/6/21 17:43, Yunlei He wrote:
> If move file range success, it should remove old data from
> src and dst page cache.
> 
> Signed-off-by: Yunlei He <heyunlei@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
