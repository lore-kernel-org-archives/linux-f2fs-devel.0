Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08D3CC3065C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  4 Jul 2024 03:39:37 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1sPDJo-0005zb-Qj;
	Thu, 04 Jul 2024 03:39:36 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1sPDJn-0005zS-6U
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 04 Jul 2024 03:39:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=IiDYDgDyUXCHKW6pzXPvi/wzm5zRWsn8csgt2QHvfPU=; b=gsFR5ZFn1gPhkSMFlBYxeSq5Iv
 MdhTqB56a55+XwYg8eI4cZB7V9A03qsjY4w0XIXjAf9pXCL5yPVGWS9UqWsi/XeI5FS4E3RxlmIZj
 HI4pIp7IsAHqPBQaoKS/mIhdWS/xyX4ufaUTtIzdzKJ6XMeqIWuGtOEyVvbyOeISFGCk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=IiDYDgDyUXCHKW6pzXPvi/wzm5zRWsn8csgt2QHvfPU=; b=hcBUg86L8GRzuxGPYLbXK2DIRc
 DUuJ2hjNJ08Dwt4WQbvfOJKq4Lh44g1RUQ1191EEejcyWN549L5hTCptT8Ea4O542q3W5yepFs6LH
 E3QU2fGGK1zxU3dNTZTtaSv43kZ/e/l1ANLehnS9jM/un3SK2chpHYnad03QWtuG4qOA=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1sPDJm-0004CP-Mx for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 04 Jul 2024 03:39:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 9085C62443;
 Thu,  4 Jul 2024 03:39:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F5AC2BD10;
 Thu,  4 Jul 2024 03:39:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1720064363;
 bh=GaLN5YxNT1PZ72BmjoowNEIslt3rtc57z7LXu/HnQ7Q=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FII9uWWezj4DFB1nwySIXp+zRA18bck8uO5arlfw07mJ7lID1c2vCvP1tDlLFDmkn
 uDk2Wd2dS2wKsBkeS50pVduxkF4aoN7v9RpasHrfalAkmqqBy7ws9rFNq5t7qiN+dL
 UcxmY1J0PaIyxD21sakWyQTIuZbR5MrlCPugqN9cxIyhzKlJUn9qaa5HAmeamObJ18
 5aafEnq6NYOMvJAoQtK5gQC0kcvgbBRihk7ElvcwBHsR7pugekZKeRfY0H2Xfh+8SP
 XqdDEG5RXqpK8xmPdSfLYMKQxwX3xZACvz6tEnNq+wku66QLNzMElsgMerTRyjffZH
 Yyehc0tmaSnuQ==
Message-ID: <b081683d-7fb6-46cc-b07f-1c081f70a59a@kernel.org>
Date: Thu, 4 Jul 2024 11:39:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Sheng Yong <shengyong@oppo.com>, jaegeuk@kernel.org
References: <20240704025740.527171-1-shengyong@oppo.com>
 <20240704025740.527171-4-shengyong@oppo.com>
Content-Language: en-US
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20240704025740.527171-4-shengyong@oppo.com>
X-Headers-End: 1sPDJm-0004CP-Mx
Subject: Re: [f2fs-dev] [RCF PATCH v3 03/10] inject.f2fs: add sb injection
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/7/4 10:57, Sheng Yong wrote:
> This patch enables injecting super block.
> 
> The meanings of options are:
>   * sb: means sb is injected, its argument chooses which sb pack to be
>         injected, where 0 means the current valid sb is choosen
>         automatically.
>   * mb: indicates which member in sb is injected, its argument is the
>         member name.
>   * idx: is used when the mb is an array, its argument is the index of
>          the array.
>   * val: is the new value to be set when the type of mb is a number.
>   * str: is the new value to be set when the type of mb is a string.
> 
> The members could be injected in sb contains:
>   * magic: magic number
>   * s_stop_reason: s_stop_reason array
>   * s_errors: s_errors array
>   * devs.path: path in devs array
> 
> Signed-off-by: Sheng Yong <shengyong@oppo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
