Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17090C46467
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Jan 2023 13:05:43 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pFanX-0007mb-7c;
	Wed, 11 Jan 2023 13:05:42 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pFanS-0007mQ-7o
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 13:05:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=dRhhFkKzeuoMIJJOjiSzjt1+wOw1xk6kFlKSJG6ZxHg=; b=LJGOqy+BEvTZGcIGK6ILQxPXoW
 YVJCmJQ3/ImIotDHtP1zwofWRZBMyyfeAtG54p+2VCxRbSfbrgi1xGmoKlPn6eS4P3pOFhTnFged5
 Wo65IZTv+jCCdDPGy/JkEGVJbxksuPGaACOXAPBZMwdHtLMora0EfvgRalgKeDfqiymo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=dRhhFkKzeuoMIJJOjiSzjt1+wOw1xk6kFlKSJG6ZxHg=; b=dY+5evzYf7dfXlQ63SXUs8kfJM
 aVG4zJjPDWMAuIPQglXaBTG3oPRk9scJC9jBDa2Tn55jdY1MRywfCn+HFUAnyJFmCXUKipfv/uv8r
 Ay6uBHpRGqSfYhghbZ0TVRTh9vxEM0M2Mtka+kb/JhgA2H9sfGPIPZPDDosNbfbek/iA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pFanP-0002Xn-96 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Jan 2023 13:05:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id CAABB61CE0;
 Wed, 11 Jan 2023 13:05:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65091C433EF;
 Wed, 11 Jan 2023 13:05:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1673442329;
 bh=wxL95L9kM3pNjTro7surwIWNv94zXXrKJe215fkwbdc=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=h3C5ZmsqQxn+bH8Mm7lWt4wTFKxe8HU9euwxp2vqUHOxQfZgcLCQb9GpERfSKCHuH
 3vbQ+iNKQ79BpLeYtDcvq66xtR6RsFLOAMlk6+TlEJjS6MpvHQahcDHGq6BrCHNjcN
 kAjExlfSYtzld94sV3k6+R7lbr0d3F/dejSK797NfmaEc6BXEMY+cFbkYZeWSYRkHp
 gEYEbNVGyqmZSTzTaRAU6T8KeSlQJl4h4cJjKLqaDeo1TYHOyBE29tR+UaszRLpEYi
 1W3Ujv4wokboCTuzhCaQ0Ra0TKV0bTfCeq07CFScVGSVbFVNO3ARtOm9iTqvYDLnrf
 IGw0k/4hU+yOQ==
Message-ID: <77048eb8-d482-26cf-73ac-7b0f1094e816@kernel.org>
Date: Wed, 11 Jan 2023 21:05:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20221229131828.59116-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221229131828.59116-1-frank.li@vivo.com>
X-Headers-End: 1pFanP-0002Xn-96
Subject: Re: [f2fs-dev] [PATCH] f2fs: mark f2fs_init_compress_mempool w/
 __init
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

On 2022/12/29 21:18, Yangtao Li wrote:
> f2fs_init_compress_mempool() only initializes the memory pool during
> the f2fs module init phase. Let's mark it as __init like any other
> function.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
