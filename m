Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B10C433FE
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 20 Oct 2022 01:14:10 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1olK8N-0001VD-Lv;
	Thu, 20 Oct 2022 01:14:07 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1olK8L-0001V7-PW
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Oct 2022 01:14:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=LJfPZMEyo6shCgyFI9rCSlxmeEmbK7huBnNToJCfE0U=; b=UXHnvulm5Z0zsZBQdSIPe+roJ6
 mzm2fMx4JKG5uKIVYWsYDHV7jteenOmVggAIf66+MojfGLo/9OK3BvcLLmVtgHQaxVnOk0TKBY+Rd
 YUnsX5IisMxynXhHymQda0ZFZpeHvFmQaD/WVL4TK3oF6EtypFgyiRPLLoF/VZEw6EmI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=LJfPZMEyo6shCgyFI9rCSlxmeEmbK7huBnNToJCfE0U=; b=ZOMKu/McARCG1qHezZNJHaTJUV
 jU6P/U23FV45ORJkT7rw8Wa4iwKJ5BSjQgYBCmC1I9FlCxf98n7E7AnxG5dsMiEIVlEeoOcz19IGl
 NaWvcpoQMByJJsLRgok0bvUE0t1wVWr24Ytf+7w5efgj4x94rz4GsJmpHZE9LPoEDZ+s=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1olK8H-00AMbZ-Fm for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 20 Oct 2022 01:14:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 09E98B825A9
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 20 Oct 2022 01:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E67C0C433D6;
 Thu, 20 Oct 2022 01:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1666228430;
 bh=Cw8qrt3ip8gdBceNfL9nXfoDDLcgJOWUQORT9U0OgmY=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=IQUwkQjFOTCfLM8HbhUEy4XKNP9Jua0cFIHTDSKL7E+HSUUU6BqJdrw1o4ABHxkuj
 G/Znji3mQIAyUupvJbUAwgzn36pWrA3yO4/mOAxewL0xcp+9Myzk+ZEahVPCs3rRgD
 SZpoQ6oFys+3LBS0CzU7QPMA2TItQEkrzg23J0EEX2qZlAl4Sfo8lIxPpJLqmSFvUu
 8YtZh5KZS5aZIAYn39v+f+68Sbh1p5ju+KJXDQlUfiai1FnNjAp1qlNtvCcTeGfyt8
 W84XVmKayITrKeTd0O0hxV/Oqr9BxGT8nXCvszXxhYwoFzu0gtQabRd2DVx5G2WVZm
 ROJFg2GzF9TYg==
Message-ID: <b578c945-f695-d505-1e97-fcfbcef6e670@kernel.org>
Date: Thu, 20 Oct 2022 09:13:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20221018005806.892778-1-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20221018005806.892778-1-jaegeuk@kernel.org>
X-Headers-End: 1olK8H-00AMbZ-Fm
Subject: Re: [f2fs-dev] [PATCH] f2fs: let's avoid to get cp_rwsem twice by
 f2fs_evict_inode by d_invalidate
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/10/18 8:58, Jaegeuk Kim wrote:
> f2fs_unlink
>   -> f2fs_lock_op
>   -> d_invalidate
>    -> shrink_dentry_list
>     -> iput_final
>      -> f2fs_evict_inode
>       -> f2fs_lock_op
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
