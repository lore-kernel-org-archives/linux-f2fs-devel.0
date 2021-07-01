Return-Path: <SRS0=edr7=LZ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82591C11F64
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  1 Jul 2021 14:41:59 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491E36140C;
	Thu,  1 Jul 2021 14:41:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491E36140C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lyxt7-0005e7-T4; Thu, 01 Jul 2021 14:41:57 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <chao@kernel.org>) id 1lyxt6-0005bV-Ic
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Jul 2021 14:41:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Sp7mzO1FAEYMYGTtCMj4FNG6AcC0QoG15D2FuvcLVyE=; b=ARUDQ3zu+QW3t+/u8Ph6E/Vmiu
 reFfrdKC8szi5UuVfoQJi2hpPEUq6tYyK2eDFqvhuBM6hISg660XkvIx/d8aLItsmZCSWX80VQbvi
 g0Cg9gRVRXLghI/q5SemOoLUvcVSrabYUy0M0fQTl41PMbUc14KUtbHQfj4kDl3pbLsY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:Cc:References:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Sp7mzO1FAEYMYGTtCMj4FNG6AcC0QoG15D2FuvcLVyE=; b=ZWqKFmfnoKkEjQ1lUS6sr37Ful
 wEQ+X5i5SmyAplQhA2XbRMZrY+o/tuiWb2k+DVOIBjlQW6bxxmOEUzAbqkG6s+xmAczTQgN9M9rNo
 DAcFKOeq1vpUHl2x2cNGQS6clbjnYu4vd3aO8/6IkN1LrlZ26Ogkj/9rMeBMGFIp2RJY=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lyxsp-00062x-7X
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 01 Jul 2021 14:41:43 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id F0B8361414;
 Thu,  1 Jul 2021 14:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1625150493;
 bh=N9LvBZmSN+Wmht/RZU9ESnqNi4gD3FpdAoKEyaqLOi0=;
 h=Subject:To:References:Cc:From:Date:In-Reply-To:From;
 b=JVAmUqApWYaNKcGwOsOlGbsNHOjHvNQHASi6mfeCdcYt4U81Jr5RUPu5JqHVC91DA
 RBqxbaO8QQ9sFeisGOOE0lH7pc7w3ilXTSuABLlxmkOOr+mHCW7EH+BTdsVAWPylhx
 lG8To1/ai11YS8q/l0Dtya5+WxhOIvUr/tfnx2vY1crNSRNXwCwzdcUZ7Y3a6yhfaz
 xG8hm7dueRkjgokgmMFRQXlx9JHDRGeIvpOffRL7yl1wbVoJiwCidNyMSu4/SKzKhe
 vAIc3PkhH/v0NvQMFkynNsq10Ks6uRUhNLb9Aox0ufehnaE4F3AmAZJVuNDGRQQ5kn
 kVtTP+95S7uaA==
To: Sun Ke <sunke32@huawei.com>, fstests@vger.kernel.org
References: <20210630113736.551843-1-sunke32@huawei.com>
 <20210630113736.551843-4-sunke32@huawei.com>
From: Chao Yu <chao@kernel.org>
Message-ID: <acb98dad-931a-12b3-37f7-6ef57f4ec38e@kernel.org>
Date: Thu, 1 Jul 2021 22:41:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210630113736.551843-4-sunke32@huawei.com>
Content-Language: en-US
X-Headers-End: 1lyxsp-00062x-7X
Subject: Re: [f2fs-dev] [PATCH v3 3/3] generic/260: f2fs is also special
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
Cc: guan@eryu.me, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/6/30 19:37, Sun Ke wrote:
> It fail on f2fs:
> 
>   [+] Default length with start set (should succeed)
>   [+] Length beyond the end of fs (should succeed)
>   [+] Length beyond the end of fs with start set (should succeed)
> +After the full fs discard 0 bytes were discarded however the file system is 12882804736 bytes long.
> +It seems that fs logic handling len argument overflows
> 
> The root cause is f2fs can tag a special flag TRIMMED_FLAG to indicate
> the whole filesystem is trimmed, so after mkfs/fstrim(), following
> fstrim() won't trim any block.
> 
> Suggested-by: Chao Yu <yuchao0@huawei.com>
> Signed-off-by: Sun Ke <sunke32@huawei.com>
> ---

Reviewed-by: Chao Yu <chao@kernel.org>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
