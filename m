Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03555C624DB
	for <linux-f2fs-devel@archiver.kernel.org>; Fri,  4 Sep 2026 02:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DhjUd5FpJlPXnUsk8OMEz2ctXRrQcGkJJ6Jy01J/jog=; b=ISHS+XaAWE3J+6PzkHgqkglwiJ
	t7wnu6Xkni9qHaWZHSQO0gSSqSFsRgAKaYn6B1YhjgNUqd93LXy5FI3tPCYlzg/zl8tneErJLk3E0
	dKCIt6b42iwlgc7RpRQ5UjU6FUXbvOegasC8raIrFMP9+ks6m/Lda0vhANnmVSC+yBA4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x2JUn-0000It-Sd;
	Fri, 04 Sep 2026 02:17:38 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1x2JUm-0000Ig-KG
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 02:17:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=zmzW9Jc2q4GsNO5akc/QprJ0qoZqw0IR6+xzuvi2p1k=; b=fvDrrE+URhdeSIl42xYxsiyfJ2
 XUBpjh6N4LcpUg67y++uXG0ptAxztMqgatVQGZgjR7UFu1HlTF9xuQxdo10+SMi+nFA2yDkmV0lcZ
 Don7af7FlRXeVDk9Y0AeZ7dcMQfiRa9i612Z9YcVBWDXrlj8QoMRJvrG17HK88wIbZNE=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=zmzW9Jc2q4GsNO5akc/QprJ0qoZqw0IR6+xzuvi2p1k=; b=NyBPb8WEVzBUlU0Mz2TdYL8QnH
 L8kyyslksv1JYWHKkPgyMf83lrsAP3fwu4jdrbQSYr8WNVEGSlPqLyELIpeTR/+1emcxA3tZIL+WR
 esVcKRsE21KOXjFuOh5s5SSGzaZA62HY8Vd+r3ybiS/Q7i/HxxVlBDmSBqkln7TR8Udc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x2JUm-0003gT-1S for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 04 Sep 2026 02:17:37 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AF0BB41A9D;
 Fri,  4 Sep 2026 02:17:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CFF1F000E9;
 Fri,  4 Sep 2026 02:17:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788488250;
 bh=zmzW9Jc2q4GsNO5akc/QprJ0qoZqw0IR6+xzuvi2p1k=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=YGXc8VC1ReuOK/q0lW9iyKjjCoMjbiew7Ma/QcxW0w27SXa4GsfWh0HRP5iEP/uwH
 X9eouJrP7jB6u4AKBJVuYKVsD3TTGu87hWp+c74hTMr+Pmq+7IMLSL+XbEqPSg7kah
 P2E58OkoJaO3Di9Rhq8dircjkmRnuqj17lvk3JRYCUdtzLvaar70CbcXhKhk3vX+J4
 2Czbs2sd9QK/iEHFIr7hvh+w+fLJyQQJZtuztADiQ2V7r4ZL56LNtLPDS90P60WxxT
 abVsmOVYHK47hBrQhyjt7fgKSLBKf8NYJQZ96snFjny6XuHZ01NzlSLWcpxzwHXS0h
 fT0dutAN1mARQ==
Message-ID: <601938ee-c5b1-4cac-889a-1b16e1615517@kernel.org>
Date: Fri, 4 Sep 2026 10:17:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Kelvin Zhang <zhangxp1998@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net
References: <cover.1788479509.git.zhangxp1998@gmail.com>
 <7b563b3096652abe81f77edc886ab98c416f189f.1788479509.git.zhangxp1998@gmail.com>
Content-Language: en-US
In-Reply-To: <7b563b3096652abe81f77edc886ab98c416f189f.1788479509.git.zhangxp1998@gmail.com>
X-Headers-End: 1x2JUm-0003gT-1S
Subject: Re: [f2fs-dev] [PATCH v9 09/11] f2fs: parameterize byte and block
 conversion macros
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/4/26 07:56, Kelvin Zhang wrote:
> Byte-to-block and block-to-byte conversion helpers previously relied on
> global PAGE_SIZE, PAGE_SHIFT, or F2FS_BLKSIZE_BITS.
> 
> Parameterize F2FS_BYTES_TO_BLK, F2FS_BLK_TO_BYTES, F2FS_BLK_END_BYTES,
> F2FS_BLK_ALIGN, and max_file_blocks with struct f2fs_sb_info *sbi using
> sbi->log_blocksize.
> 
> Update all call sites across data mapping, file operations, fiemap queries,
> fsverity checks, NAT bitmap allocations, and truncate paths.
> 
> Signed-off-by: Kelvin Zhang <zhangxp1998@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
